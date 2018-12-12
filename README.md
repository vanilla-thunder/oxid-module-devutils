# vt-devutils
developer utilities for OXID eShop

**Attention**, this is not my module, you can find the author here: https://github.com/vanilla-thunder/vt-devutils

I just prepared this module to use it in my Oxid 6 installation.

- Logs working
- Mails working
- Metadata working
- Clean up cache working

You have to install it via Composer, as local path repository or via git repo.

## Install

1. Copy `privateSrc` into root directory of your installation (NOT IN `source`).
2. Open composer.json in root directory
3. Add all modules to `repositories`-block or create it, if it not exists
4. Add module/packages name to `require` block

### Add Repositories

  "name": "...",
  "type": "project",
  "description": "...",
  "license": [
    "GPL-3.0-only",
    "proprietary"
  ],
  "minimum-stability": "stable",
  "repositories": [
    {
      "type": "path",
      "url": "privateSrc/VanillaThunder/DevCore"
    },
    {
      "type": "path",
      "url": "privateSrc/VanillaThunder/DevLogs"
    },
    {
      "type": "path",
      "url": "privateSrc/VanillaThunder/DevMails"
    },
    {
      "type": "path",
      "url": "privateSrc/VanillaThunder/DevMetadata"
    }
  ]

### Add Modules/Packages

**Attantion:** No need to add `DevCore`, it will be automatic installed if one of the others will be installed

  "name": "...",
  "type": "project",
  "description": "...",
  "license": [
    "GPL-3.0-only",
    "proprietary"
  ],
  "minimum-stability": "stable",
  "require": {
    "vt-devutils/dev-logs": "*",
    "vt-devutils/dev-mails": "*",
    "vt-devutils/dev-metadata": "*"
  }

### How install now?

Use Composer. Im sure you know what composer is, dont know if its possible to install Oxid 6 without.

So open up your terminal and enter `composer install`.