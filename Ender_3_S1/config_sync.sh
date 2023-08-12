#
# backup "printer_data/config" from ${REMOTE_HOST}
#

typeset -g REMOTE_HOST LOCAL_BASEDIR LOCAL_PATH
typeset DRYRUN=${DRYRUN:-1}
typeset VERBOSE=${VERBOSE:-1}


USAGE="
USAGE:    ./$0 [--backup|--update|--help]

OPTIONS:

    --backup | --receive | --pull

        Retrieve configs from remote host and overwrite local copies for backup.

    --update | --send | --push

        Upload local copies to overwrite remote host configuration.

ENVIRONMENT:

    REMOTE_HOST

    LOCAL_BASEDIR

        Provide path to location of directory \"printer_data\" (default: \$PWD)

    LOCAL_PATH

        Do Not define this value, it is used internally and only made available for testing.

"


: ${REMOTE_HOST:=mainsail}
: ${LOCAL_BASEDIR:=${PWD}/}

: ${LOCAL_PATH:=${LOCAL_BASEDIR%/}/./printer_data}

# check if LOCAL_BASEDIR/printer_data exists
if [[ -e "${LOCAL_BASEDIR%/}/./printer_data/" ]] && [[ -d "${LOCAL_BASEDIR%/}/./printer_data/" ]] ; then
        
else
    printf "[ERROR] Directory NOT FOUND: %s\n" "${LOCAL_PATH}" >&2
    return 1
fi


function _backup_remote_config() {
    local DRYRUN=1
    local VERBOSE=1
    [[ ${1} == "-n" ]] || unset DRYRUN
    [[ ${1} == "-n" ]] || unset DRYRUN
    rsync ${DRYRUN:+-n} ${VERBOSE:+-v} -R -acb --copy-links \
        --exclude="*.swp" \
        --exclude="*.bkp" \
        --exclude="*.BAK" \
        --exclude="printer-$(date +%Y)*.cfg" \
        ${REMOTE_HOST}:printer_data/./config \
        ${LOCAL_BASEDIR%/}/./printer_data/
}


function _update_remote_config() {
    [[ ${1} == "-n" ]] || unset DRYRUN
    [[ ${1} == "-n" ]] || unset DRYRUN
    rsync ${DRYRUN:+-n} ${VERBOSE:+-v} -R -acb --copy-links \
        --exclude="*.swp" \
        --exclude="*.bkp" \
        --exclude="*.BAK" \
        --exclude="printer-$(date +%Y)*.cfg" \
        ${LOCAL_BASEDIR%/}/./printer_data/ \
        ${REMOTE_HOST}:printer_data/./config
}



#
# notify of DRYRUN condition
#
DRYRUN=${DRYRUN:=1}
if [[ $DRYRUN == 0 ]] ; then
    unset DRYRUN
    printf "[WARN] This is NOT a dryrun! will overwrite files!\n" >&2
else
    printf "[INFO] This IS a dryrun! will NOT overwrite files!\n" >&2
fi ; sleep 1


case ${1%--} in

    "backup"|"receive"|"pull" )
        _backup_remote_config "${DRYRUN:+-n}" ;;

    "update"|"send"|"push" )
        _update_remote_config "${DRYRUN:+-n}" ;;

    ""|"help" )
        echo "$USAGE" >&2 && return 0 ;;

esac


# vim: set ft=zsh ts=4 sts=0 sw=4 et nofen :
