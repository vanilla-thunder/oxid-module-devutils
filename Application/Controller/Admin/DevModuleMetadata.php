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
use OxidEsales\EshopCommunity\Internal\Framework\Module\Configuration\Bridge\ShopConfigurationDaoBridgeInterface;
use OxidEsales\EshopCommunity\Internal\Framework\Module\Configuration\Dao\ModuleConfigurationDaoInterface;
use OxidEsales\EshopCommunity\Internal\Framework\Module\Install\DataObject\OxidEshopPackage;
use OxidEsales\EshopCommunity\Internal\Framework\Module\Install\Service\ModuleConfigurationInstallerInterface;
use OxidEsales\EshopCommunity\Internal\Framework\Module\Setup\Bridge\ModuleActivationBridgeInterface;
use PDO;
use VanillaThunder\DevUtils\Application\Core\DevUtils;

class DevModuleMetadata extends \OxidEsales\Eshop\Application\Controller\Admin\AdminDetailsController
{
    protected $_sThisTemplate = 'devutils_modulemetadata.tpl';

    public function getModule($sModuleId = null)
    {
        $oModule = oxNew(\OxidEsales\Eshop\Core\Module\Module::class);
        $oModule->load($sModuleId ?? $this->getEditObjectId());
        return $oModule;
    }

    public function getMetadataConfiguration()
    {
        $sModuleDir = oxNew(\OxidEsales\Eshop\Core\Module\Module::class)->getModuleFullPath($this->getEditObjectId());

        $aModule = [];
        /** @define "$sModuleDir" "../../.." */
        include($sModuleDir.DIRECTORY_SEPARATOR."metadata.php");

        // path
        $aModule["path"] = basename($sModuleDir);

        // controllers
        /*
        if (array_key_exists("controllers", $aModule)) {
            $sModulesDir = Registry::getConfig()->getModulesDir();
            foreach ($aModule["controllers"] as $cl => $file) {
                $aModule["controllers"][$cl] = [
                    'cl' => $cl,
                    'check' => file_exists($sModulesDir.$file)
                ];
            }
        }*/

        // templates
        if (array_key_exists("templates", $aModule)) {
            $sModulesDir = Registry::getConfig()->getModulesDir();
            foreach ($aModule["templates"] as $tpl => $file) {
                $aModule["templates"][$tpl] = [
                    'file' => $file,
                    'check' => file_exists($sModulesDir.$file)
                ];
            }
        }

        // blocks
        if (array_key_exists("blocks", $aModule)) {
            $blocks = [];
            foreach ($aModule["blocks"] as $var) {
                $blocks[$var["block"]] = [
                    'block' => $var['block'],
                    'template' => $var['template'],
                    'file' => $var['file'],
                    'check' => file_exists($sModuleDir.$var['file'])
                ];
            }
            //ksort($settings);
            $aModule["blocks"] = $blocks;
        }

        // settings
        if (array_key_exists("settings", $aModule)) {
            $settings = [];
            foreach ($aModule["settings"] as $var) {
                //if(!array_key_exists($var["group"],$settings)) $settings[$var["group"]] = [];
                //$settings[$var["group"]][$var["name"]] = $var; //["type"];
                $settings[$var["name"]] = $var; //["type"];
            }
            $aModule["settings"] = $settings;
        }

        return $aModule;
    }

    public function getYamlConfiguration()
    {
        $container = $this->getContainer();
        $shopConfigurationDao = $container->get(ShopConfigurationDaoBridgeInterface::class);
        return $shopConfigurationDao->get(1)->getModuleConfiguration($this->getEditObjectId());
    }

    public function getDbConfiguration()
    {
        $sModuleId = $this->getEditObjectId();
        $oConfig = Registry::getConfig();
        $queryBuilderFactoryInterface = $this->getContainer()->get(QueryBuilderFactoryInterface::class);

        $aModule =  [
            "version" => null,
            "path" => null,
            "events" => [],
            "extend" => [],
            "controllers" => [],
            "templates" => [],
            "blocks" => [],
            "settings" => [],
        ];

        // version
        $aModuleVersions = Registry::getConfig()->getConfigParam("aModuleVersions");
        $aModule["version"] = array_key_exists($sModuleId, $aModuleVersions) ? $aModuleVersions[$sModuleId] : "unknown";

        // path
        $aModulePaths = Registry::getConfig()->getConfigParam("aModulePaths");
        $aModule["path"] = array_key_exists($sModuleId, $aModulePaths) ? $aModulePaths[$sModuleId] : "unknown";

        // events
        $aModuleEvents = Registry::getConfig()->getConfigParam("aModuleEvents");
        $aModule["events"] = array_key_exists($sModuleId, $aModuleEvents) ? $aModuleEvents[$sModuleId] : [];

        // extensions
        $aModuleExtensions = Registry::getConfig()->getConfigParam("aModuleExtensions");
        if (array_key_exists($sModuleId, $aModuleExtensions)) {
            $aActiveModuleExtensions = Registry::getConfig()->getConfigParam("aModules");
            foreach ($aModuleExtensions[$sModuleId] as $sModuleExtension) {
                foreach ($aActiveModuleExtensions as $sClass => $sExtension) {
                    $check = strpos($sExtension, $sModuleExtension);
                    if ( $check !== false && $check >= 0) {
                        $aModule["extend"][$sClass] = $sModuleExtension;
                    }
                }
            }
        }

        // controllers
        $aDbControllers = Registry::getConfig()->getConfigParam("aModuleControllers");
        $aModule["controllers"] = array_key_exists($sModuleId, $aDbControllers) ? $aDbControllers[$sModuleId] : [];

        // templates
        $aDbTemplates = Registry::getConfig()->getConfigParam("aModuleTemplates");
        $aModule["templates"] = array_key_exists($sModuleId, $aDbTemplates) ? $aDbTemplates[$sModuleId] : [];

        // blocks
        $queryBuilder = DevUtils::getQueryBuilder();
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

        foreach ($queryBuilder->execute()->fetchAll(\PDO::FETCH_ASSOC) as $var) {
            $aModule["blocks"][$var["OXBLOCKNAME"]] = $var; //["type"];
        }

        // settings
        $queryBuilder = DevUtils::getQueryBuilder();
        $queryBuilder
            ->select('OXVARNAME, OXVARTYPE, DECODE( OXVARVALUE, :configKey) AS OXVARVALUE')
            ->from('oxconfig')
            ->where('oxshopid = :shopId')
            ->andWhere('oxmodule = :oxmodule')
            ->orderBy("OXID")
            ->setParameters([
                'configKey' => $oConfig->getConfigParam("sConfigKey"),
                'shopId' => Registry::getConfig()->getShopId(),
                'oxmodule' => 'module:' . $this->getEditObjectId()
            ]);

        foreach ($queryBuilder->execute()->fetchAll(\PDO::FETCH_ASSOC) as $var) {
            if ($var["OXVARTYPE"] === "arr") {
                $var["OXVARVALUE"] = unserialize($var["OXVARVALUE"]);
            }
            $aModule["settings"][$var["OXVARNAME"]] = $var;
        }
        //ksort($aModule["settings"]);

        return $aModule;
    }

    public function reinstallModule()
    {
        try {
            $sModuleId = $this->getEditObjectId();
            $oModule = $this->getModule($sModuleId);

            $container = $this->getContainer();

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

            $moduleActivationBridge = $container->get(ModuleActivationBridgeInterface::class);
            $moduleActivationBridge->deactivate(
                $this->getEditObjectId(),
                Registry::getConfig()->getShopId()
            );

            $moduleActivationBridge = $container->get(ModuleActivationBridgeInterface::class);
            $moduleActivationBridge->activate(
                $this->getEditObjectId(),
                Registry::getConfig()->getShopId()
            );
        } catch (ModuleTargetPathIsMissingException $exception) {
            var_dump($exception);
            Registry::getUtilsView()->addErrorToDisplay($exception);
            Registry::getLogger()->error($exception->getMessage(), [$exception]);
            //die("MESSAGE_TARGET_PATH_IS_REQUIRED");
        } catch (\Throwable $throwable) {
            var_dump($throwable);
            Registry::getUtilsView()->addErrorToDisplay($throwable);
            Registry::getLogger()->error($throwable->getMessage(), [$throwable]);
            //die("MESSAGE_INSTALLATION_FAILED");
        } catch (\Exception $exception) {
            Registry::getUtilsView()->addErrorToDisplay($exception);
            Registry::getLogger()->error($exception->getMessage(), [$exception]);
            //die("MESSAGE_REACTIVATION_FAILED");
        }
    }
}
