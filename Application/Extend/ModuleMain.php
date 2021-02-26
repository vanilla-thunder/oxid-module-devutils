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

namespace VanillaThunder\DevUtils\Application\Extend;


use Symfony\Component\Console\Input\ArrayInput;
use Webmozart\PathUtil\Path;
use OxidEsales\EshopCommunity\Internal\Framework\Console\CommandsProvider\CommandsProviderInterface;
use OxidEsales\EshopCommunity\Internal\Framework\Console\Executor;
use Symfony\Component\Console\Application;
use Symfony\Component\Console\Output\StreamOutput;

/**
 *  ModuleMain controller extension for vt-DevUtils Module.
 *
 * @mixin \OxidEsales\Eshop\Application\Controller\Admin\ModuleList
 */
class ModuleMain extends ModuleMain_parent
{

    public function render()
    {
        parent::render();
        return "vtdev_module_main.tpl";
    }
    /**
     * @param Application $application
     * @param CommandsProviderInterface $commandsProvider
     * @param $input
     * @return string
     */
    protected function _oeconsole(Application $application, CommandsProviderInterface $commandsProvider, $input)
    {
        $executor = new Executor($application, $commandsProvider);

        $output = new StreamOutput(fopen('php://memory', 'w', false));
        $executor->execute($input, $output);
        $stream = $output->getStream();
        rewind($stream);
        $display = stream_get_contents($stream);

        return $display;
    }

    public function reloadModule()
    {
        $sModuleId = $this->getEditObjectId();
        try {
            $moduleSourcePath = Path::isRelative($path)
                ? Path::makeAbsolute($path, getcwd())
                : $path;;
            $this->validatePath($moduleSourcePath);

            $moduleTargetPath = $this->getModuleTargetPath($input);
            $this->validatePath($moduleTargetPath);

            $this->moduleConfigurationInstaller->install($moduleSourcePath, $moduleTargetPath);
            $output->writeln('<info>' . self::MESSAGE_INSTALLATION_WAS_SUCCESSFUL . '</info>');
        } catch (ModuleTargetPathIsMissingException $exception) {
            $output->writeln('<error>' . self::MESSAGE_TARGET_PATH_IS_REQUIRED . '</error>');
        } catch (\Throwable $throwable) {
            $output->writeln('<error>' . self::MESSAGE_INSTALLATION_FAILED . '</error>');

            throw $throwable;
        }

    }
}