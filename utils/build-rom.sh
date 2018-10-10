#!/bin/bash

# Colorize and add text parameters
red=$(tput setaf 1)             #  red
grn=$(tput setaf 2)             #  green
blu=$(tput setaf 4)             #  blue
txtbld=$(tput bold)             #  bold
bldred=${txtbld}$(tput setaf 1) #  bold red
bldgrn=${txtbld}$(tput setaf 2) #  bold green
bldblu=${txtbld}$(tput setaf 4) #  bold blue
txtrst=$(tput sgr0)             #  reset

# clear terminal
clear

# Start tracking time
echo -e ${bldblu}
echo -e "---------------------------------------"
echo -e "SCRIPT STARTING AT $(date +"%d/%m/%Y"\ %R)"
echo -e "---------------------------------------"
echo -e ${txtrst}

START=$(date +%s)

# Instruction for build
echo -e ${bldred}
echo -e "###################################################################"
echo -e "######################## Build Instruction ########################"
echo -e "###################################################################"
echo -e "# 1.              Enter codename for your device                  #"
echo -e "# 2.          Select if you want to sync with latest source       #"
echo -e "# 3. Select if you want to do a clean build or just install clean #"
echo -e "# 4.            Select if you want to save build log              #"
echo -e "###################################################################"
echo -e ${txtrst}

echo -e "Enter the device :"
read DEVICE

echo -e "Do you want to sync ? ( 1 for yes | 0 for no)"
read SYNC

echo -e "Do you want clean build ? ( 1 for yes | 0 for no)"
read CLEAN

echo -e "Do you want to save log ? ( 1 for yes | 0 for no)"
read LOG

ROOT_PATH=$PWD
BUILD_PATH="$ROOT_PATH/out/target/product/$DEVICE"

# Sync with latest sources
if [ "$SYNC" == "1" ]
then
   echo -e "${bldblu}Syncing latest sources ${txtrst}"
   repo sync
fi

# Setup environment
echo -e "${bldblu}Setting up build environment ${txtrst}"
. build/envsetup.sh

# Set the device
echo -e "Setting the device... ${txtrst}"
breakfast "$DEVICE"

# Clean out folder
if [ "$CLEAN" == "1" ]
then
  echo -e "${bldblu}Cleaning up the OUT folder with make clobber ${txtrst}"
  make clean;
else
  echo -e "${bldblu}No make clobber so just make installclean ${txtrst}"
  make installclean;
fi

# Start compilation with or without log
if [ "$LOG" == "1" ]
then
   echo -e "${bldblu}Compiling for $DEVICE and saving a build log file ${txtrst}"
   brunch $DEVICE 2>&1 | tee build.log;
else
   echo -e "${bldblu}Compiling for $DEVICE without saving a build log file ${txtrst}"
   brunch $DEVICE;
fi

# If the above was successful
if [ `ls $BUILD_PATH/HashOS-*.zip 2>/dev/null | wc -l` != "0" ]
then
   BUILD_RESULT="Build successful"

    # If the build failed
else
   BUILD_RESULT="Build failed"
fi

# Stop tracking time
END=$(date +%s)
echo -e ${bldblu}
echo -e "-------------------------------------"
echo -e "SCRIPT ENDING AT $(date +"%d/%m/%Y"\ %R)"
echo -e ""
echo -e "${BUILD_RESULT}!"
echo -e "TIME: $(echo $((${END}-${START})) | awk '{print int($1/60)" MINUTES AND "int($1%60)" SECONDS"}')"
echo -e "-------------------------------------"
echo -e ${txtrst}

BUILDTIME="Build time: $(echo $((${END}-${START})) | awk '{print int($1/60)" minutes and "int($1%60)" seconds"}')"
