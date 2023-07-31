#
# backup "printer_data/config" from mainsail
#

function _backup_mainsail_config() {
    local DRYRUN=1
    local VERBOSE=1
    [[ ${1} == "-n" ]] || unset DRYRUN
    [[ ${1} == "-n" ]] || unset DRYRUN
    rsync ${DRYRUN:+-n} ${VERBOSE:+-v} -R -acb --copy-links \
        --exclude="*.swp" \
        --exclude="*.bkp" \
        --exclude="*.BAK" \
        --exclude="printer-$(date +%Y)*.cfg" \
        mainsail:printer_data/./config \
        ./printer_data/
}


DRYRUN=${DRYRUN:=1}
if [[ $DRYRUN == 0 ]] ; then
    unset DRYRUN
    printf "[WARN] This is NOT a dryrun! will overwrite files!\n" >&2
else
    printf "[INFO] This IS a dryrun! will NOT overwrite files!\n" >&2
fi
sleep 1


if [[ -e "./printer_data/" ]] ; then
    _backup_mainsail_config "${DRYRUN:+-n}"
else
    printf "[ERROR] Run Command from path containing \"./printer_data/\"\n" >&2
    return 1
fi

#vim: set ft=zsh ts=4 sts=0 sw=4 et nofen :
