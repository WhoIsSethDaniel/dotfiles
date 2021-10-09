#.bash-functions

function check_for_program () {
  local PROG=$1

  eval unset "${PROG}"
  set_var $PROG $(type -P $PROG)
  if [ -z "${!PROG}" ] ; then
    eval unset "${PROG}"
  fi
}

function unset_var () {
  local NAME=$1

  if [ -n "$NAME" ] ; then
    eval unset "$NAME"
  fi
}

function set_var () {
  local NAME=$1
  local VAL=$2

  if [ -n "$NAME" -a -n "$VAL" ] ; then
    eval $NAME=\"${VAL}\"
  fi
}

function set_prog_var () {
  local NAME=$1
  shift
  local PROGS=$@
  local PROG

  for PROG in $PROGS ; do
    check_for_program $PROG
    if [ -n "${!PROG}" ] ; then
      set_var $NAME "${!PROG}"
      break
    fi
  done
}

function set_path_var () {
  local NAME=$1
  local VAL=$2
  local OPT_PATH=$3

  if [ -n "$OPT_PATH" ] ; then
    if [ -e "$OPT_PATH" ] ; then
      set_var $NAME "$VAL"
    fi
  else
    if [ -e "$VAL" ] ; then
      set_var $NAME "$VAL"
    fi
  fi
}

function set_pre_var () {
  local NAME=$1
  local VAL=$2
  local SEP=${3:-:}
  local CURVAL=${!NAME}

  set_var $NAME "${VAL}${CURVAL:+$SEP}${CURVAL}"
}

function set_post_var () {
  local NAME=$1
  local VAL="$2"
  local SEP=${3:-:}
  local CURVAL=${!NAME}

  set_var $NAME "${CURVAL}${CURVAL:+$SEP}${VAL}"
}

function set_pre_path_var () {
  local NAME=$1
  local VAL=$2
  local OPT_PATH=$3
  local SEP=${4:-:}
  local CURVAL=${!NAME}

  set_path_var $NAME "${VAL}${CURVAL:+$SEP}${CURVAL}" "${OPT_PATH:-$VAL}"
}

function set_post_path_var () {
  local NAME=$1
  local VAL=$2
  local OPT_PATH=$3
  local SEP=${4:-:}
  local CURVAL=${!NAME}

  set_path_var $NAME "${CURVAL}${CURVAL:+$SEP}${VAL}" "${OPT_PATH:-$VAL}"
}

function export_var () {
  local NAME=$1

  if [ -n "${!NAME}" ] ; then
    eval export $NAME
  fi
}

function set_export_var () {
  local NAME=$1
  local VALUE=$2

  set_var $NAME "$VALUE"
  export_var $NAME
}

function set_export_prog_var () {
  local NAME=$1
  shift
  local PROGS=$@

  set_prog_var $NAME $PROGS
  set_export_var $NAME "${!NAME}"
}

function set_export_path_var () {
  local NAME=$1
  local VAL=$2
  local OPT_PATH=$3

  set_path_var $NAME "$VAL" "$OPT_PATH"
  set_export_var $NAME "${!NAME}"
}

set_export_pre_path_var () {
  local NAME=$1
  local VAL=$2
  local OPT_PATH=$3

  set_pre_path_var $NAME "$VAL" "$OPT_PATH"
  set_export_var $NAME "${!NAME}"
}

set_export_post_path_var () {
  local NAME=$1
  local VAL=$2
  local OPT_PATH=$3

  set_post_path_var $NAME "$VAL" "$OPT_PATH"
  set_export_var $NAME "${!NAME}"
}

function set_alias () {
  local NAME=$1
  local VAL=$2

  if [ -n "$NAME" ] ; then
    eval alias $NAME=\"$VAL\"
  fi
}

function set_path_alias () {
  local NAME=$1
  local VAL=$2
  local OPT_PATH=$3

  if [ -n "$OPT_PATH" ] ; then
    if [ -e "$OPT_PATH" ] ; then
      set_alias $NAME "$VAL"
    fi
  else
    if [ -e "$VAL" ] ; then
      set_alias $NAME "$VAL"
    fi
  fi
}

function set_prog_alias () {
  local NAME=$1
  shift
  local PROGS=$@
  local PROG

  for PROG in $PROGS ; do
    check_for_program $PROG
    if [ -n "${!PROG}" ] ; then
      set_alias $NAME "${!PROG}"
      break
    fi
  done
}

function set_path_exist_alias () {
  local NAME=$1
  local VAL=$2
  local PATH=${3:-$VAL}

  if [ -f $PATH -o -d $PATH ] ; then
    set_alias $NAME "$VAL"
  fi
}

function set_prog_exist_alias () {
  local NAME=$1
  local VAL=$2
  local PROG=$3

  check_for_program $PROG
  if [ -n "${!PROG}" ] ; then
    set_alias $NAME "$VAL"
  fi
}

function rm_path () {
  local PATH_NAME=$1
  local BAD_PATH=$2
  local IFS=${3:-:}
  local -a ELEM
  local P

  for P in ${!PATH_NAME} ; do 
    if [ "$P" != "$BAD_PATH" -a "$P" != "${BAD_PATH}/" ] ; then
      ELEM[${#ELEM[*]}]=$P
    fi
  done
  # IFS reverts to default during eval
  eval "IFS=$IFS && $PATH_NAME=\"${ELEM[*]}\""
}

function clean_path () {
  local PATH_NAME=$1
  local IFS=${2:-:}
  local -a ELEM
  local P E MATCH

  for P in ${!PATH_NAME} ; do 
    if [ -e "$P" ] ; then
      local L=$P
      MATCH=1
      for E in "${ELEM[@]}" ; do 
        if [ "$E" == "$L" -o "$E" == "${L}/" ] ; then
          MATCH=0
          break
        fi
      done
      [ $MATCH -eq 1 ] && ELEM[${#ELEM[*]}]=$L
    fi
  done
  # IFS reverts to default during eval
  eval "IFS=$IFS && $PATH_NAME=\"${ELEM[*]}\""
}

function truncated_path_prompt () {
  local COLS=${COLUMNS:-80}
  local MAXLEN=$(($COLS/3))

  MYPWD="${PWD#$HOME}"
  [[ ${#PWD} -gt ${#MYPWD} ]] && MYPWD="~$MYPWD"
  if [ ${#MYPWD} -gt $MAXLEN ]; then
    local OFFSET=$(( ${#MYPWD} - $MAXLEN ))
    MYPWD=".${MYPWD:$OFFSET:$MAXLEN}"
  fi
  echo $MYPWD
}

function mirror () {
  local PRISTINE=$1
  local TARGET=$2

  local TREE=$(find $PRISTINE ! -regex '.*\.svn.*' -a \( -type f -o -type d \))
  if [ -n "$TREE" ] ; then
    for ITEM in $TREE ; do
      BASE_ITEM="${ITEM#$PRISTINE}"
      NEW_ITEM_PATH="${TARGET}${BASE_ITEM}"
      safelink "${PRISTINE}${BASE_ITEM}" "$NEW_ITEM_PATH"
    done
  fi
}

function safelink () {
  local TARGET=$1
  local LINK=$2

  if [ ! -e "$LINK" -o -L "$LINK" ] ; then
    ln -sf "$TARGET" "$LINK"
  fi
}

function safeglob () {
  local NAME=$1
  shift
  local EXPR=$@

  nullglob=$(shopt -p nullglob)
  shopt -s nullglob
  eval "$NAME=\$(echo $EXPR)"
  eval "$nullglob"
}
