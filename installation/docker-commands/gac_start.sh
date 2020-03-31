#!/bin/bash
# init
# =============================================
# SCRIPT COMMANDS
echo
echo "** Load GACTRADING instance **"
echo
echo "=> List of docker instances:"
docker ps -a
echo
echo "➡️  Enter the name for the gactrading instance to connect to:"
echo "   (Press enter for default value: gactrading-instance)"
read INSTANCE_NAME
if [ "$INSTANCE_NAME" == "" ];
then
  INSTANCE_NAME="gactrading-instance"
fi
# =============================================
# EXECUTE SCRIPT
docker start $INSTANCE_NAME && docker attach $INSTANCE_NAME
