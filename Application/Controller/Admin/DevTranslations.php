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

use OxidEsales\Eshop\Core\ConfigFile;
use OxidEsales\Eshop\Core\Registry;
use OxidEsales\EshopCommunity\Internal\Container\ContainerFactory;
use OxidEsales\EshopCommunity\Internal\Framework\Database\QueryBuilderFactoryInterface;
use OxidEsales\EshopCommunity\Internal\Framework\Module\Install\Service\ModuleInstallerInterface;
use PDO;

class DevTranslations extends \OxidEsales\Eshop\Application\Controller\Admin\AdminDetailsController
{
    protected $_sThisTemplate = 'devutils_translations.tpl';

    public function render()
    {

        return parent::render();
    }

    public function getModule($sModuleId)
    {
        $oModule = oxNew(\OxidEsales\Eshop\Core\Module\Module::class);
        $oModule->load($sModuleId);
        return $oModule;
    }

    public function reinstallModule()
    {
        $sModuleId = $this->getEditObjectId();
        $oModule = $this->getModule($sModuleId);

        $container = ContainerFactory::getInstance()->getContainer();
        $moduleInstallerService = $container->get(ModuleInstallerInterface::class);

        $moduleInstallerService->install($oModule->getModuleFullPath(), $oModule->getModulePath());
    }


    public function getModuleSettings()
    {
        //$oConfig = Registry::getConfig();
        $bullshitContainer = ContainerFactory::getInstance()->getContainer();
        $bullshitFactory = $bullshitContainer->get(QueryBuilderFactoryInterface::class);
        $queryBuilder = $bullshitFactory->create();

        $queryBuilder
            ->select('OXVARNAME, OXVARTYPE ') //, DECODE( oxvarvalue, :configKey) AS oxvarvalue')
            ->from('oxconfig')
            ->where('oxshopid = :shopId')
            ->andWhere('oxmodule = :oxmodule')
            ->orderBy("OXVARNAME")
            ->setParameters([
                //'configKey' => $oConfig->getConfigParam("sConfigKey"),
                'shopId' => Registry::getConfig()->getShopId(),
                'oxmodule' => 'module:'.$this->getEditObjectId()
            ]);

        $blocksData = $queryBuilder->execute();
        return $blocksData->fetchAll(PDO::FETCH_KEY_PAIR);
    }

    public function getModuleBlocks()
    {
        $bullshitContainer = ContainerFactory::getInstance()->getContainer();
        $bullshitFactory = $bullshitContainer->get(QueryBuilderFactoryInterface::class);
        $queryBuilder = $bullshitFactory->create();

        $queryBuilder
            ->select('OXTHEME, OXTEMPLATE, OXBLOCKNAME, OXPOS, OXFILE ')
            ->from('oxtplblocks')
            ->where('oxshopid = :shopId')
            ->andWhere('oxmodule = :oxmodule')
            ->orderBy("OXTEMPLATE, OXBLOCKNAME")
            ->setParameters([
                'shopId' => Registry::getConfig()->getShopId(),
                'oxmodule' => $this->getEditObjectId()
            ]);

        $blocksData = $queryBuilder->execute();
        return $blocksData->fetchAll(PDO::FETCH_ASSOC);
    }
}