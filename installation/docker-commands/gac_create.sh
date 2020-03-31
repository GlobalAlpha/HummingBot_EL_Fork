#!/bin/bash
# init
function pause() {
  read -p "$*"
}
# =============================================
# SCRIPT COMMANDS
echo
echo "** ✏️  Creating a new gactrading instance **"
echo
# Specify gactrading version
echo "ℹ️  Press [enter] for default values."
echo
echo "➡️  Enter gactrading version: [latest|development] (default = \"latest\")"
read TAG
if [ "$TAG" == "" ]
then
  TAG="latest"
fi
echo
# Ask the user for the name of the new instance
echo "➡️  Enter a name for your new gactrading instance: (default = \"gactrading-instance\")"
read INSTANCE_NAME
if [ "$INSTANCE_NAME" == "" ];
then
  INSTANCE_NAME="gactrading-instance"
  DEFAULT_FOLDER="gactrading_files"
else
  DEFAULT_FOLDER="${INSTANCE_NAME}_files"
fi
echo
echo "=> Instance name: $INSTANCE_NAME"
echo
# Ask the user for the folder location to save files
echo "➡️  Enter a folder name for your config and log files: (default = \"$DEFAULT_FOLDER\")"
read FOLDER
if [ "$FOLDER" == "" ]
then
  FOLDER=$DEFAULT_FOLDER
fi
echo
echo "Creating your gactrading instance: \"$INSTANCE_NAME\" (eileil1/gactrading:$TAG)"
echo
echo "Your files will be saved to:"
echo "=> instance folder:    $PWD/$FOLDER"
echo "=> config files:       ├── $PWD/$FOLDER/gactrading_conf"
echo "=> log files:          ├── $PWD/$FOLDER/gactrading_logs"
echo "=> data file:          └── $PWD/$FOLDER/gactrading_data"
echo
pause Press [Enter] to continue
#
#
#
# =============================================
# EXECUTE SCRIPT
# 1) Create folder for your new instance
mkdir $FOLDER
# 2) Create folders for log and config files
mkdir $FOLDER/gactrading_conf
mkdir $FOLDER/gactrading_logs
mkdir $FOLDER/gactrading_data
# 3) Launch a new instance of gactrading
docker run -it \
--name $INSTANCE_NAME \
--mount "type=bind,source=$(pwd)/$FOLDER/gactrading_conf,destination=/conf/" \
--mount "type=bind,source=$(pwd)/$FOLDER/gactrading_logs,destination=/logs/" \
--mount "type=bind,source=$(pwd)/$FOLDER/gactrading_data,destination=/data/" \
eileil1/gactrading:$TAG
