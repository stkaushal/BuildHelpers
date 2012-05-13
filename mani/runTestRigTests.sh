#!/bin/bash

# function to display Usage message
displayUsageMessage() {
  echo ""
  echo "'runTestRigTests' has been invoked with any parameters."
  echo "" 
  echo "Usage: runTestRigTests <group/package name>"
  echo "e.g. runTestRigTests jdk_awt     ----- to run tests on the awt package"
  echo ""

  echo "Below is a list of packages to help with the usage"
  echo "=================================================="
  echo "jdk_default    - run default tests"
  echo "jdk_all        - run all tests"
  echo ""
  echo "jdk_awt        - run awt package tests"
  echo "jdk_beans      - run beans package tests"
  echo "jdk_io         - run io package tests"
  echo "jdk_lang       - run language package tests"
  echo "jdk_management - run management package tests"
  echo "jdk_math       - run math package tests"
  echo "jdk_misc       - run misc package tests"
  echo "jdk_net        - run net package tests"
  echo "jdk_nio        - run nio package tests"
  echo "jdk_sctp       - run sctp package tests"
  echo "jdk_security   - run security package tests"
  echo "jdk_rmi        - run rmi package tests"
  echo "jdk_sound      - run sound package tests"
  echo "jdk_swing      - run swing package tests"
  echo "jdk_text       - run text package tests"
  echo "jdk_tools      - run tools package tests"
  echo "jdk_util       - run util package tests"
  echo ""
}

# funtion to iterate through the list of valid OpenJDK package names and searching for the input package name
function packageNameExists() {
  # Loop through the valid names and compare it with the input string
  for testPackageName in ${openJDKTestPackages[@]}
  do
    echo $testPackageName
    if [[ $testPackageName==$1 ]]
    then
      # if you found a match return 1
      return 1
    fi
    # no match found, return 0
    return 0
  done
}

# Declare an array contain list of valid package names - case sensitive hence they must match any comparison checks  
declare -a openJDKTestPackages=('jdk_default','jdk_all','jdk_awt','jdk_beans','jdk_io','jdk_lang','jdk_management','jdk_math','jdk_misc','jdk_net','jdk_nio','jdk_sctp','jdk_security','jdk_rmi','jdk_sound','jdk_swing','jdk_text','jdk_tools','jdk_util');

# Display usage details if user calls runTestRigTests without any parameter, and exit the script.
if [ $# -eq 0 ]
then
  displayUsageMessage
  exit
fi

# check if the package name check fails validity
if [ $packageNameExists==0 ]
then
   # if no match is found, display error, show the usage message and exit the script
   echo "[$1] is not a valid OpenJDK test package name. Please refer to the usage message below for a list of valid test package names."
   displayUsageMessage 
   exit
fi

# Run this script to setup the environment variables before performing any openJDK activities.
. $HOME/sources/jdk/jdk8-env.sh

# Perform the action by running the test for the inut package name 
echo "Tests for package [$1] are being performed. Results are recorded in the [$1.log] file stored locally..."
make $1 > $1.log