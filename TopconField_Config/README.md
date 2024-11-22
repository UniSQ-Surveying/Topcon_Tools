# UniSQ Topcon Field Config Cleaner

The purpose of this script is to delete old jobs and replace the Topcon Field configuration
with a clean one. The configuration on the controllers tends to drift over time
as settings get changed, so this script can be run to clean it back to a sane default.

## Getting started

1. Download this repository and unzip
2. (optional) Copy the desired Styles.tsstyles (see Survey Styles below) to the unzipped folder
3. Double-click the .bat file and follow the prompts

## Topcon Field

### Survey Styles

Topcon Field stores survey styles in a binary file called Styles.tsstyles,
which is located in the AppData\Roaming\Topcon Field PC directory. This file is actually a sqlite
database.

Topcon Field also loads config styles from all jobs in the Jobs folder.
As a result, all jobs must be deleted in order to only load the desired styles.
This script deletes all Jobs in the Jobs folder.

### Menu items

The Topcon Field menu can be customised by modifying Menu.xml in AppData\Roaming\Topcon Field PC\Menu.
The batch script replaces it with the Menu.xml in this repo.

