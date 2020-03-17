#!/usr/bin/env bash

######################################################################################################
# Dynamically makes a nuget.config file. 
#
# This script's primary purpose is to dynamically supply a nuget configuration file at build time
# so that the file does not have to exist and be version controlled.
#
# SCRIPT: nuget-config.sh
# AUTHOR: aaronlcope
# DATE: 03/17/2020
######################################################################################################

#-----------------------------------------------------------------------------------------------------
#-  ARGUMENT PARSING
#-----------------------------------------------------------------------------------------------------
args=()

# Use > 1 to consume two arguments per pass in the loop (e.g. each
# argument has a corresponding value to go with it).
# Use > 0 to consume one or more arguments per pass in the loop (e.g.
# some arguments don't have a corresponding value to go with it such
# as in the --default example).
# note: if this is set to > 0 the /etc/hosts part is not recognized ( may be a bug )
while [[ $# > 0 ]]
do
key="$1"

case $key in
    --packaging-auth-token)
    PACKAGING_AUTH_TOKEN="$2"
    shift # past argument
    ;;
    --path-to-nuget-file)
    NUGET_FILE_PATH="$2"
    shift # past argument
    ;;
    *)
       #unknown option
       args+=($1)
    ;;
esac
shift # past argument or value
done

function createNugetConfigurationFile {
    nuget_config="<?xml version=\"1.0\" encoding=\"utf-8\"?>
                            <configuration>
                                <packageSources>
                                    <clear />
                                    <add key=\"github\" value=\"https://nuget.pkg.github.com/aaronlcope/index.json\" />
                                    <add key=\"nuget\" value=\"https://api.nuget.org/v3/index.json\" />
                                </packageSources>
                                <packageSourceCredentials>
                                    <github>
                                        <add key=\"Username\" value=\"aaroncope@gmail.com\" />
                                        <add key=\"ClearTextPassword\" value=\"$PACKAGING_AUTH_TOKEN\" />
                                    </github>
                                </packageSourceCredentials>
                            </configuration>"
           echo "$nuget_config" > "$NUGET_FILE_PATH"
}

createNugetConfigurationFile