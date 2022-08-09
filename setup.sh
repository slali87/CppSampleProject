#!/bin/bash
echo "Setup by Bash Shell Script"

./tools/setup/setup_common
error=$?

echo
echo "=============================="
if [ $error -eq 0 ]; then
   echo "Setup successfully finished!"
else
   echo "Setup failed!!!"
fi
echo "=============================="
