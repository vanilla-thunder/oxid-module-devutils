<?php

/*
 * vanilla-thunder/oxid-module-devutils
 * developent utilities for OXID eShop V6.2 and newer
 *
 * This program is free software;
 * you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
 * either version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 *  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>
 */

namespace VanillaThunder\DevUtils\Application\Controller\Admin;

use OxidEsales\EshopCommunity\Internal\Container\ContainerFactory;
use OxidEsales\EshopCommunity\Internal\Framework\Database\QueryBuilderFactoryInterface;
use PDO;

class DevConfigViewer extends \OxidEsales\Eshop\Application\Controller\Admin\AdminController
{
    protected $_sThisTemplate = 'devutils_configviewer.tpl';

    /*public function render() {
        parent::render();
        $this->addTplParam("summary",$this->getConfigSummary());
        return $this->_sThisTemplate;
    }*/

    public function getConfigSummary()
    {
        $bullshitContainer = ContainerFactory::getInstance()->getContainer();
        $bullshitFactory = $bullshitContainer->get(QueryBuilderFactoryInterface::class);
        $queryBuilder = $bullshitFactory->create();

        $queryBuilder
            ->select('OXMODULE, OXVARNAME, OXVARTYPE, OCTET_LENGTH(OXVARVALUE) as SIZE, OXTIMESTAMP')
            ->from('oxconfig')
            ->where('oxshopid = :shopId')
            ->orderBy("OXMODULE, OXVARNAME")
            ->setParameters([
                'shopId' => \OxidEsales\Eshop\Core\Registry::getConfig()->getShopId()
            ]);

        $blocksData = $queryBuilder->execute();
        $blocksData = $blocksData->fetchAll(PDO::FETCH_ASSOC);

        $aData = [];
        foreach ($blocksData as $row) {
            $oxmodule = (!empty($row["OXMODULE"]) ? str_replace(["module:","theme:"],"",$row["OXMODULE"]) : "general");
            if (!array_key_exists($oxmodule, $aData)) $aData[$oxmodule] = [];
            $aData[$oxmodule][] = $row;
        }

        echo json_encode(['status' => 'ok', 'summary' => $aData]);
        exit;
    }

    public function getConfigValue ()
    {
        $config = \OxidEsales\EshopCommunity\Core\Registry::getConfig();
        $request = oxNew(\OxidEsales\Eshop\Core\Request::class);
        $oxvarname = $request->getRequestEscapedParameter("oxvarname");
        $oxmodule = $request->getRequestEscapedParameter("oxmodule");

        //$value = \OxidEsales\EshopCommunity\Core\Registry::getConfig()->getConfigParam($oxvarname); // cant halndle multiple oxvarnames with same name but different oxmodule

        $bullshitContainer = ContainerFactory::getInstance()->getContainer();
        $bullshitFactory = $bullshitContainer->get(QueryBuilderFactoryInterface::class);
        $queryBuilder = $bullshitFactory->create();

        $queryBuilder
            ->select("OXVARTYPE", $config->getDecodeValueQuery() . " as OXVARVALUE")
            ->from('oxconfig')
            ->where("oxvarname = :oxvarname")
            ->andWhere("oxmodule = :oxmodule")
            ->andWhere('oxshopid = :oxshopid')
            ->setMaxResults(1)
            ->setParameters([
                'oxvarname' => $oxvarname,
                'oxmodule' => $oxmodule ?? "",
                'oxshopid' => \OxidEsales\Eshop\Core\Registry::getConfig()->getShopId()
            ]);

        $blocksData = $queryBuilder->execute();
        $blocksData = $blocksData->fetchAll();

        $oxvartype = $blocksData[0]["OXVARTYPE"];
        $oxvarvalue = $blocksData[0]["OXVARVALUE"];
        $value = "";

        switch ($oxvartype) {
            case 'arr':
            case 'aarr':
                $value = unserialize($oxvarvalue);
                break;
            case 'bool':
                $value = ($oxvarvalue == 'true' || $oxvarvalue == '1');
                break;
            default:
                $value = $oxvarvalue;
                break;
        }

        echo json_encode(['status' => 'ok', 'value' => $value]);
        exit;
    }

}
