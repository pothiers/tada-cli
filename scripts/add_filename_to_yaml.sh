#!/bin/bash -e
# PURPOSE: 
#   Add minimum personality containing FILENAME next to all FITS files.
#
# EXAMPLE:
#

cmd=`basename $0`
dir=`dirname $0`

SCRIPT=$(readlink -f $0)      #Absolute path to this script
SCRIPTPATH=$(dirname $SCRIPT) #Absolute path this script is in

usage="USAGE: $cmd [options] [reportFile]
OPTIONS:
  -s <smoke>:: Number of progress updates per second (default=0)
  -v <verbosity>:: higher number for more output (default=0)

"

VERBOSE=0
PROGRESS=0
while getopts "hp:v:" opt; do
    echo "opt=<$opt>"
    case $opt in
	    h)
            echo "$usage"
            exit 1
            ;;
        v)
            VERBOSE=$OPTARG
            ;;
        p)
            PROGRESS=$OPTARG # how often to report progress
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;

    esac
done
#echo "OPTIND=$OPTIND"
for (( x=1; x<$OPTIND; x++ )); do shift; done


RAC=1 # Required Argument Count
if [ $# -lt $RAC ]; then
    echo "Not enough non-option arguments. Expect at least $RAC."
    echo >&2 "$usage"
    exit 2
fi


echo "PROGRESS=$PROGRESS"
echo "VERBOSE=$VERBOSE"
echo "Remaining arguments:"
for arg do echo '--> '"\`$arg'" ; done

report=${1:-$HOME/logs/foo.report}

fitsfile=$1

##############################################################################

echo "params: {filename: $fitsfile}" > ${fitsfile}.yaml 


