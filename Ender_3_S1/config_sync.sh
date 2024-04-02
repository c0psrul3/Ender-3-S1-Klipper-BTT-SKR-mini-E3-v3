##!/usr/bin/env zsh

#
# Script to sync "printer_data/config" to/from a defined KLIPPER_HOST
#

typeset -g KLIPPER_HOST LOCAL_BASEDIR LOCAL_PATH

: ${KLIPPER_HOST:=mainsail}
: ${LOCAL_BASEDIR:=${PWD}/}


# usage / help
function __usage() {
    printf '%s\n' "
USAGE:    ./$(basename $0) {--backup|--update|--help} [[file]..]
"
}
function __help() {
    printf '%s\n' "
OPTIONS:

    NOTE: One of the following options should be provided if a list of specific files to copy is also provided.

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
    exit 0
}
if [[ $1 == "-h" ]] || [[ $1 == "--help" ]] ; then
    __usage >&2 ; __help >&2
elif [[ $1 == "--usage" ]] ; then
    __usage >&2
fi


typeset -g VERBOSE DRYRUN
: ${VERBOSE:=1}
: ${DRYRUN:=1} ## TODO: remove once we are confident in the script
# indicate to user if we will include "--dryrun" rsync flag by default
if [[ -z ${DRYRUN} ]] ; then
    printf "${fg[magenta]}[NOTICE]${fg[reset]} This is NOT a dryrun! will overwrite files!\n" >&2
else
    printf "\n${fg[cyan]}[INFO]${fg[reset]} This IS a dryrun! will NOT overwrite files!\n********\n" >&2
fi

# set default action
typeset _syncAction="backup"
# get option selection from input parameter and check format

if [[ -z $1 ]] ; then
    __usage
elif [[ "${1#--}" == "$1" ]] ; then
    printf "[ERROR] Invalid Parameter, Option must be specified as a flag\n" >&2
    exit 1
else
    _syncAction="${1#--}"
    [[ -n $1 ]] && shift
fi


##
#TODO: allow for specific list of files as non-option parameter
##
typeset -g -a _files=()
if [[ $# > 0 ]] ; then
    for _f in $@ ; do
        if [[ -e "${_f}" ]] ; then
            _files+=(${_f})
        elif [[ -e "printer_data/config/${_f}" ]] ; then
            _files+=(printer_data/config/${_f})
        else
            printf "[ERROR] File NOT FOUND, \"%s\"\n" "${_f}" >&2
        fi
    done
else
    _files=("printer.cfg")
fi


typeset _filesList=""
if [[ -n "$_files" ]] || [[ ${#_files} > 0 ]] ; then
    printf ',%s' ${_files} | read -r _filesList
    _filesList="${_filesList#,}"
else
    _filesList='\*.{cfg,conf}'
fi


# check if LOCAL_BASEDIR/printer_data exists
: ${LOCAL_PATH:=$(realpath ${LOCAL_BASEDIR%/}/./printer_data)}
if [[ ! -e "${LOCAL_PATH}" ]] || [[ ! -d "${LOCAL_PATH}" ]] ; then
    printf "[ERROR] Directory NOT FOUND: %s\n" "${LOCAL_PATH}" >&2
    return 1
fi
printf "[OK] Found Directory: %s\n" "${LOCAL_PATH}" >&2


sleep 1   ## hold our horses

typeset -ag _rsync_default_opts=('--relative' '--archive' '--copy-links')

#
# Function:  _backup_remote_config()
#
function _backup_remote_config() {
    typeset -a _opts=($@)
    printf "${VERBOSE:+\n}[WARN] Performing BACKUP of remote config!\n${VERBOSE:+\n}"   >&2
    [[ -z $DRYRUN ]] || printf "${VERBOSE:+\n********}\n[INFO] THIS IS A DRY RUN!\n\n${VERBOSE:+\n********}" >&2
    #if [[ -n $DRYRUN ]] ; then
    #    _opts+=('--list-only')
    #    printf "${VERBOSE:+\n********}\n[INFO] Listing Files To Sync:\n${VERBOSE:+\n}" >&2
    #fi
    if [[ -n $VERBOSE ]] ; then
        echo ""
        printf "Src: \"%s\"\n" "${KLIPPER_HOST}:printer_data/config/${_filesList}" >&2
        printf "Dst: \"%s\"\n" "${LOCAL_BASEDIR%/}/./" >&2
        printf "Cmd: \"%s\"\n" "rsync ${_opts[*]} ${_rsync_default_opts[*]}" >&2
        echo ""
    fi
    [[ -n $VERBOSE ]] && printf "\n********\n" >&2
    ${VERBOSE:+echo} rsync ${_opts[*]} ${_rsync_default_opts[*]} \
        --exclude="*.swp" \
        --exclude="*.bkp" \
        --exclude="*.BAK" \
        --exclude="*~" \
        --exclude="printer-$(date +%Y)*.cfg" \
        ${KLIPPER_HOST}:printer_data/config/${_filesList} \
        ${LOCAL_BASEDIR%/}/./
}


#
# Function:  _update_remote_config()
#
function _update_remote_config() {
    typeset -a _opts=($@)
    #[[ -z $DRYRUN ]] && printf "${VERBOSE:+\n}[WARN] Performing UPDATE of remote config!\n${VERBOSE:+\n}"   >&2
    [[ -n $DRYRUN ]] && printf "${VERBOSE:+\n}[DRYRUN] Performing UPDATE of remote config!\n${VERBOSE:+\n}" >&2
    #if [[ -n $VERBOSE ]] ; then
    #    printf "\n*************************************\n"
    #    printf "\n[INFO] Updating Remote Config Files:\n\n"
    #    git status --no-renames --short | awk '/^ M/'
    #    printf "\n*************************************\n\n"
    #fi >&2
    rsync ${_opts[*]} ${_rsync_default_opts[*]}\
        --exclude="*.swp" \
        --exclude="*.bkp" \
        --exclude="*.BAK" \
        --exclude="*~" \
        --exclude="printer-$(date +%Y)*.cfg" \
        ${LOCAL_BASEDIR%/}/./printer_data/config/{${_filesList}} \
        ${KLIPPER_HOST}:
}


#
# Run Sync, backup / update
#
## TODO:  add option to pass rsync options from invocation at commandline

# add default options based on DRYRUN, VERBOSE
_rsync_default_opts+=("${DRYRUN:+-n}" "${DRYRUN:+--list-only}" "${VERBOSE:+-v}")

# execute rsync
case ${_syncAction} in

    "backup"|"receive"|"pull" )
        _backup_remote_config ;;

    "update" )
        _update_remote_config '--update' ;;

    "send"|"push" )
        _update_remote_config ;;

    ""|"help" )
        __help >&2 ;;

esac


# done!

# vim: set ft=zsh ts=4 sts=0 sw=4 et nofen :
