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
