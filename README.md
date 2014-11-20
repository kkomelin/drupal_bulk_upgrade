# Shell script for bulk upgrade of Drupal sites

## Overview

The purpose of this console script is to automate routine operations of upgrading Drupal core of multiple sites.  
The script performs upgrade for all subdirectories of SITES_DIR (see _settings.sh).  

What it does for every site:  

- Backups robots.txt and database  
- Upgrade Drupal core  
- Restore robots.txt  

It's based on [Drush](https://github.com/drush-ops/drush) and was tested with Drush 6.4.0

## Usage

1. Configure the script by changing _settings.sh
1. Give your user permissions to execute bulk_upgrade.sh script
1. Run the script ./bulk_upgrade.sh

## Development

Some features are commented out because the author doesn't need them. 
Feel free to uncomment them or add your own additional steps.

## License

MIT