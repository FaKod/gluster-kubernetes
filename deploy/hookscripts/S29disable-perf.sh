#!/bin/bash

PROGNAME="Sdisable-perf"
OPTSPEC="volname:,gd-workdir:"
VOL=
CONFIGFILE=
LOGFILEBASE=
PIDDIR=
GLUSTERD_WORKDIR=

function parse_args () {
        ARGS=$(getopt -l $OPTSPEC  -name $PROGNAME $@)
        eval set -- "$ARGS"


        while true; do
            case $1 in
                --volname)
                    shift
                    VOL=$1
                    ;;
                --gd-workdir)
                    shift
                    GLUSTERD_WORKDIR=$1
                    ;;
                *)
                    shift
                    break
                    ;;
            esac
            shift
        done
}


function disable_perf_xlators () {
        volname=$1
        gluster volume set $volname performance.write-behind off
        echo "executed and return is $?" >> /var/lib/glusterd/hooks/1/create/post/log
}


echo "starting" >> /var/lib/glusterd/hooks/1/create/post/log
parse_args $@
disable_perf_xlators $VOL
