#!/bin/bash
# Bulk upgrade script based on Drush.
# Author: Konstantin Komelin https://www.drupal.org/u/konstantin.komelin

# Set needed variables by including a script from the same directory.
DIR="$( cd "$( dirname "$0" )" && pwd)"
source $DIR/_settings.sh

echo "Let's do it..."

# Remove all files from the backup directory.
# rm -f $BACKUP_DIR/*.*

# Got to the directory containing all sites.
cd $SITES_DIR

# Perform upgrade for all directories assuming that they contains D6/7.
for i in $(ls -d */); do
  f="${i%%/}"

  echo "Upgrade site: ${f}"

  # You may add additional checks here, for example whether the directory is a Drupal directory or not.

  # Go to the site folder.
  cd $f

  # Create subfolder for backups.
  mkdir -p $BACKUP_DIR/$f

  # Let's backup robots.txt and .htaccess.
  cp -f ./robots.txt $BACKUP_DIR/$f/robots.txt
  # Just in case you use Apache. I don't :)
  cp -f ./.htaccess $BACKUP_DIR/$f/.htaccess

  # Backup database.
  drush sql-dump --result-file="${BACKUP_DIR}/${f}/${f}_${DATE_NOW}.sql"
  # You may create full dump if you wish.
  #drush archive-dump --destination="${BACKUP_DIR}/${f}/${f}_${DATE_NOW}.tgz"

  # Now all we need to do is to upgrade Drupal core.
  drush up drupal -y

  # Revert changes in robots.txt and .htaccess.
  cp -f $BACKUP_DIR/$f/robots.txt ./robots.txt
  cp -f $BACKUP_DIR/$f/.htaccess ./.htaccess

  echo "Upgrade site: ${f}: Completed"

  # Go back to the sites directory.
  cd $SITES_DIR
done

echo "Done"
