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
use OxidEsales\EshopCommunity\Internal\Framework\Module\Command\ModuleTargetPathIsMissingException;
use OxidEsales\EshopCommunity\Internal\Framework\Module\Configuration\Dao\ModuleConfigurationDaoInterface;
use OxidEsales\EshopCommunity\Internal\Framework\Module\Install\DataObject\OxidEshopPackage;
use OxidEsales\EshopCommunity\Internal\Framework\Module\Install\Service\ModuleConfigurationInstallerInterface;
use OxidEsales\EshopCommunity\Internal\Framework\Module\Setup\Bridge\ModuleActivationBridgeInterface;
use PDO;

class DevModuleMetadata extends \OxidEsales\Eshop\Application\Controller\Admin\AdminDetailsController
{
    protected $_sThisTemplate = 'devutils_modulemetadata.tpl';

    public function render()
    {
        $sModuleId = $this->getEditObjectId();

        $oModule = $this->getModule($sModuleId);
        $this->addTplParam("oModule", $oModule);

        $aModule = [];
        include($oModule->getMetadataPath());
        if (array_key_exists("settings", $aModule)) {
            /*
            $settings = $aModule["settings"];
            $type = array_column($settings, "type");
            $name = array_column($settings, "name");
            array_multisort($type, SORT_ASC, $name, SORT_ASC,$settings);
            */
            $settings = [];
            foreach ($aModule["settings"] as $var) {
                $settings[$var["name"]] = $var["type"];
            }
            ksort($settings);
            $aModule["settings"] = $settings;
        }
        $this->addTplParam("aModule", $aModule);

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
        try {
            $sModuleId = $this->getEditObjectId();
            $oModule = $this->getModule($sModuleId);

            $container = ContainerFactory::getInstance()->getContainer();

            // update yaml config files
            $moduleConfigurationInstallerService = $container->get(ModuleConfigurationInstallerInterface::class);
            $moduleConfigurationInstallerService->install($oModule->getModuleFullPath(), $oModule->getModuleFullPath());

            // update cached metadata in database
            //$moduleConfigurationDao = $container->get(ModuleConfigurationDaoInterface::class);
            //$moduleConfiguration = $moduleConfigurationDao->get($sModuleId, 1);
            //$moduleConfiguration->setConfigured(true);
            //$moduleConfigurationDao->save($moduleConfiguration, 1);

            //$classExtensionChainService = $container->get(OxidEsales\EshopCommunity\Internal\Framework\Module\Setup\Service::class);
            //$classExtensionChainService->updateChain(1);

            //$this->applyModulesConfigurationForAllShops($output);

        } catch (ModuleTargetPathIsMissingException $exception) {
            die("MESSAGE_TARGET_PATH_IS_REQUIRED");
        } catch (\Throwable $throwable) {
            var_dump($throwable);
            die("MESSAGE_INSTALLATION_FAILED");
        }
    }
    public function reactivateModule()
    {
        try {
            $moduleActivationBridge = $this->getContainer()->get(ModuleActivationBridgeInterface::class);
            $moduleActivationBridge->deactivate(
                $this->getEditObjectId(),
                Registry::getConfig()->getShopId()
            );

            $moduleActivationBridge = $this->getContainer()->get(ModuleActivationBridgeInterface::class);
            $moduleActivationBridge->activate(
                $this->getEditObjectId(),
                Registry::getConfig()->getShopId()
            );
        } catch (\Exception $exception) {
            Registry::getUtilsView()->addErrorToDisplay($exception);
            Registry::getLogger()->error($exception->getMessage(), [$exception]);
        }
    }

    public function getModuleVersion($sModuleId)
    {
        $aModuleVersions = Registry::getConfig()->getConfigParam("aModuleVersions");
        return (array_key_exists($sModuleId, $aModuleVersions) ? $aModuleVersions[$sModuleId] : "x");
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
                'oxmodule' => 'module:' . $this->getEditObjectId()
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
