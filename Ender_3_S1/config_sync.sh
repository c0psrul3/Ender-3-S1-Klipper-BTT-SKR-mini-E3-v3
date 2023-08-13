#
# Script to sync "printer_data/config" to/from a defined KLIPPER_HOST
#

typeset -g KLIPPER_HOST LOCAL_BASEDIR LOCAL_PATH

# determine VERBOSE selection
typeset -g VERBOSE=${VERBOSE:-1}
if [[ ${VERBOSE:=1} == 1 ]] ; then
    printf "[INFO] Verbose Mode\n" >&2
else
    unset VERBOSE
fi

# determine DRYRUN selection
typeset -g DRYRUN=${DRYRUN:-1}
if [[ ${DRYRUN:=1} == 0 ]] ; then
    unset DRYRUN
    printf "[WARN] This is NOT a dryrun! will overwrite files!\n" >&2
else
    printf "[INFO] This IS a dryrun! will NOT overwrite files!\n" >&2
fi ; sleep 1

# set default option
typeset _opt="backup"
typeset _files=()
# get option selection from input parameter
if [[ -n $1 ]] ; then
    ##
    #TODO: allow for specific list of files as non-option parameter
    ##
    # check format of option
    [[ "${1#--}" == "$1" ]] && printf "[ERROR] Invalid Parameter, Option must be specified as a flag\n" >&2 && return 1
    _opt="${1#--}"
fi

# hold horses
sleep 1


# usage / help
USAGE="
USAGE:    ./$0 [--backup|--update|--help]

OPTIONS:

    --backup | --receive | --pull

        Retrieve configs from remote host and overwrite local copies for backup.

    --update | --send | --push

        Upload local copies to overwrite remote host configuration.

ENVIRONMENT:

    KLIPPER_HOST

    LOCAL_BASEDIR

        Provide path to location of directory \"printer_data\" (default: \$PWD)

    LOCAL_PATH

        Do Not define this value, it is used internally and only made available for testing.

"


: ${KLIPPER_HOST:=mainsail}
: ${LOCAL_BASEDIR:=${PWD}/}

: ${LOCAL_PATH:=${LOCAL_BASEDIR%/}/./printer_data}

# check if LOCAL_BASEDIR/printer_data exists
if [[ ! -e "${LOCAL_BASEDIR%/}/./printer_data/" ]] || [[ ! -d "${LOCAL_BASEDIR%/}/./printer_data/" ]] ; then
    printf "[ERROR] Directory NOT FOUND: %s\n" "${LOCAL_PATH}" >&2
    return 1
fi
printf "[OK] Found Directory: %s\n" "${LOCAL_PATH}" >&2


#
# Function:  _backup_remote_config()
#
function _backup_remote_config() {
    [[ -z $DRYRUN ]] && printf "${VERBOSE:+\n}[WARN] Performing BACKUP of remote config!\n${VERBOSE:+\n}"   >&2
    [[ -n $DRYRUN ]] && printf "${VERBOSE:+\n}[DRYRUN] Performing BACKUP of remote config!\n${VERBOSE:+\n}" >&2
    rsync ${DRYRUN:+-n} ${VERBOSE:+-v} -R -acb --copy-links \
        --exclude="*.swp" \
        --exclude="*.bkp" \
        --exclude="*.BAK" \
        --exclude="*~" \
        --exclude="printer-$(date +%Y)*.cfg" \
        ${KLIPPER_HOST}:printer_data/./config \
        ${LOCAL_BASEDIR%/}/./printer_data/
}


#
# Function:  _update_remote_config()
#
function _update_remote_config() {
    #[[ -z $DRYRUN ]] && printf "${VERBOSE:+\n}[WARN] Performing UPDATE of remote config!\n${VERBOSE:+\n}"   >&2
    [[ -n $DRYRUN ]] && printf "${VERBOSE:+\n}[DRYRUN] Performing UPDATE of remote config!\n${VERBOSE:+\n}" >&2
    if [[ -n $VERBOSE ]] ; then
        printf "\n*************************************\n"
        printf "\n[INFO] Updating Remote Config Files:\n\n"
        git status --no-renames --short | awk '/^ M/'
        printf "\n*************************************\n\n"
    fi >&2
    rsync ${DRYRUN:+-n} ${VERBOSE:+-v} -R -acb --copy-links \
        --exclude="*.swp" \
        --exclude="*.bkp" \
        --exclude="*.BAK" \
        --exclude="*~" \
        --exclude="printer-$(date +%Y)*.cfg" \
        ${LOCAL_BASEDIR%/}/./printer_data/$(git status --no-renames --short | awk '/^ M/ {print $NF}') \
        ${KLIPPER_HOST}:printer_data/./config
}


#
# Run Sync, backup / update
#
case ${_opt} in

    "backup"|"receive"|"pull" )
        _backup_remote_config "${DRYRUN:+-n}" ;;

    "update"|"send"|"push" )
        _update_remote_config "${DRYRUN:+-n}" ;;

    ""|"help" )
        echo "$USAGE" >&2 && return 0 ;;

esac


# vim: set ft=zsh ts=4 sts=0 sw=4 et nofen :
