<?php
	/**
	 * vt Dev Utils
	 * Copyright (C) 2012-2013  Marat Bedoev
	 *
	 * This program is free software;
	 * you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
	 * either version 3 of the License, or (at your option) any later version.
	 *
	 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
	 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
	 * You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>
	 *
	 * Version:    2.0
	 * Author:     Marat Bedoev <oxid@marat.ws>
	 */

	class vtdu_fe extends oxView
	{
		public function render()
		{
			parent::render();

			// is logged in ?
			$oUser = $this->getUser();
			if ( !$oUser || $oUser->oxuser__oxrights->value != 'malladmin')
			{
				//kein Admin -> raus
				oxRegistry::get("oxUtils")->redirect(oxRegistry::getConfig()->getShopUrl(), false, 302 );
			}

			if (oxRegistry::getConfig()->getRequestParameter("ajax"))
			{
				return "vtdu_ajax.tpl";
			}

			return "vtdu_fe.tpl";
		}

		public function getDebugSettings()
		{
			$vtdu = oxRegistry::get("vtdu");
			return $vtdu->getDebugSettings();
		}


		public function clearTmp()
		{
			$vtdu = oxRegistry::get("vtdu");
			$this->addTplParam("content", $vtdu->clearTmp() );
		}

		public function clearTpl()
		{
			$vtdu = oxRegistry::get("vtdu");
			$this->addTplParam("content", $vtdu->clearTpl() );
		}

		public function clearPhp()
		{
			$vtdu = oxRegistry::get("vtdu");
			$this->addTplParam("content", $vtdu->clearPhp() );
		}

		public function clearLang()
		{
			oxRegistry::get("oxUtils")->resetLanguageCache();
			$this->addTplParam("content", "lang cache clear!");
		}

		public function toggleDebugSetting()
		{
			$cfg = oxRegistry::getConfig();
			$vtdu = oxRegistry::get("vtdu");
			$sVarName = $cfg->getRequestParameter("setting");
			$this->addTplParam("content", $vtdu->toggleDebugSetting($sVarName) );
		}
	}