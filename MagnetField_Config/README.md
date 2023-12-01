# UniSQ Magnet Field Config Cleaner

The purpose of this script is to replace the Magnet Field configuration
with a clean one. The configuration on the controllers tends to drift over time
as settings get changed, so this script can be run to clean it back to a sane default.

## Getting started

1. Download this repository and unzip
2. Copy the desired Styles.tsstyles (see Survey Styles below) to the unzipped folder
3. Double-click the .bat file and follow the prompts

## Magnet Field

### Survey Styles

Magnet Field stores survey styles in a binary file called Styles.tsstyles,
which is located in the AppData\Roaming\Magnet Field PC directory. This file is actually a sqlite
database.

Magnet Field also loads config styles from all jobs in the Jobs folder.
As a result, all jobs must be deleted in order to only load the desired styles.
Instead of deleting, the jobs are moved to a Backup folder in Documents\Magnet Field PC\Backup.

### Menu items

The Magnet Field menu can be customised by modifying Menu.xml in AppData\Roaming\Magnet Field PC\Menu.
The batch script replaces it with the Menu.xml in this repo.

