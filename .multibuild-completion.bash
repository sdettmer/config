#_multibuildinfo()
#{
#    # Store current globstar setting and set globstar if necessary
#    local glob_flag
#    if shopt -q globstar; then
#        glob_flag=0
#    else
#        glob_flag=1
#        shopt -s globstar
#    fi
#    local file
#    local cur=${COMP_WORDS[COMP_CWORD]}
#    for file in "$cur"**/multibuild.info; do
#        # If the glob doesn't match, we'll get the glob itself, so make sure
#        # we have an existing file
#        [[ -e $file ]] || continue
#
#        # If it's a directory, add a trailing /
#        if [[ -d $file ]] ; then
#           : # COMPREPLY+=( "$file/" )
#        elif [[ $file == *multibuild.info ]] ; then
#           COMPREPLY+=( "$file" )
#        fi
#    done
#
#    # Set globstar back to previous value if necessary
#    if (( glob_flag == 1 )); then
#        shopt -u globstar
#    fi
#}

#_multibuildinfo()
#{
#    #local cur=${COMP_WORDS[COMP_CWORD]}
#    #echo "cur=$cur"
#    # _filedir -d
#    for d in $(compgen -d -- $cur) ; do
#       COMPREPLY+=( $(compgen  -X '!*multibuild.info' -- $d) )
#    done
#    #compgen -o plusdirs -f -X '!*multibuild.info' --
#    #MULTIBUILDINFOS=$(find . -name multibuild.info )

#    #COMPREPLY=( $(compgen -W "${MULTIBUILDINFOS}" -- $cur) )
#}

_multibuild()
{
  local cur prev
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  prev=${COMP_WORDS[COMP_CWORD-1]}
  # The args that are complete so far (before prev)
  complete_args="${COMP_WORDS[@]::COMP_CWORD-1}"
  case "$prev" in
    -n)
      COMPREPLY=( $( compgen -W "$($complete_args -l|grep '^- '| awk '{print $2}' 2> /dev/null )" -- "${cur}" ) )
      return 0
      ;;
    -p)
      COMPREPLY=( $( compgen -W "$($complete_args -l|grep '^- '| awk '{print $3}' 2> /dev/null )" -- "${cur}" ) )
      return 0
      ;;
    -t)
      COMPREPLY=( $( compgen -W "$($complete_args -l|grep '^- '| awk '{print $5}' 2> /dev/null )" -- "${cur}" ) )
      return 0
      ;;
    -b)
      COMPREPLY=( $( compgen -W "$($complete_args -l|grep '^- '| awk '{print $6}' 2> /dev/null )" -- "${cur}" ) )
      return 0
      ;;
    -L)
      _filedir
      return 0
      ;;
  esac

  if [[ "$cur" == -* ]]; then
    # Opts:
    COMPREPLY=( $(compgen -W '$( _parse_help "$1" --help )' -- ${cur}) )
    [[ $COMPREPLY == *= ]] && compopt -o nospace
    [[ $COMPREPLY ]] && return
  else
    # multibuild.info files
    _filedir info
    # find "$cur" -name multibuild.info
    # _multibuildinfo
  fi
} &&
complete -F _multibuild multibuild.sh
