safeglob GIT_CONFIGS '$XDG_CONFIG_HOME/dotfiles/*'
for CFDIR in $GIT_CONFIGS ; do 
    CF="$CFDIR/git/config"
    if [ -f "$CF" ] ; then
        set_export_var GIT_CONFIG_GLOBAL "$CF"
        break
    fi
done
