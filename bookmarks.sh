#!bash
# Source this file!
BOOKMARKSRC="${BOOKMARKSRC:-$HOME/.config/bash-bookmarks.rc}"
declare -A BASHBOOKMARKS

[[ -f $BOOKMARKSRC ]] && BASHBOOKMARKS=( $(cat $BOOKMARKSRC) )

echo "Declaring 'bm' function" >&2
bm() {
  # If there's options it MUST be $1
  if [[ "$1" == -h ]]; then
    echo "Usage:" >&2
    echo "  + bm        - List all stored bookmarks" >&2
    echo "  + bm <name> - Create or update bookmark <name>" >&2
    echo "  + bm .      - Create bookmark with current dir" >&2
    echo "  + bm -d <x> - Delete bookmark <x>" >&2
    echo "  + bm -S     - Save the current bookmark dictionary" >&2
    echo "  + bm -L     - Reload bookmarks dictionary file" >&2

  # -d item  --> Delete an item.
  elif [[ "$1" == -d ]]; then
    if [[ -z "$2" ]]; then
      echo "Expected a bookmark argument" >&2
      return 1
    elif [[ -z ${BASHBOOKMARKS[$2]} ]]; then
      echo "Undefined bookmark '$2'" >&2
      return 1
    fi
    unset BASHBOOKMARKS[$2]
    echo "Deleted: $2 [${BASHBOOKMARKS[$2]}]" >&2

  # -S item --> Save bookmarks to the file
  elif [[ "$1" == -S ]]; then
    echo "Saving bookmarks to: $BOOKMARKSRC" >&2
    echo "# Created: $(date)" > $BOOKMARKSRC
    for k in "${!BASHBOOKMARKS[@]}" ; do
      echo "  [$k]=\"${BASHBOOKMARKS[$k]}\"" >> $BOOKMARKSRC
    done

  elif [[ "$1" == -L ]]; then
    echo "Reloading bookmarks from: $BOOKMARKSRC" >&2
    BASHBOOKMARKS=( $(cat $BOOKMARKSRC) )

  elif [[ "$1" == -* ]]; then
    echo "Unknown option: $1" >&2
    return 1

  # Create bookmark "$1"
  elif [[ "$1" == . ]]; then
    local n=${PWD##*/}
    if [[ ${BASHBOOKMARKS[$n]+_} ]]; then
      echo "Bookmark '$n' already exists" >&2
      return 1
    fi
    echo "Setting bookmark '$n' [$PWD]" >&2
    BASHBOOKMARKS["$n"]="$PWD"

  elif [[ "$1" ]]; then
    if [[ ${BASHBOOKMARKS[$1]+_} ]]; then
      echo "Bookmark '$1' already exists" >&2
      return 1
    fi
    echo "Setting bookmark '$1' [$PWD]" >&2
    BASHBOOKMARKS["$1"]="$PWD"

  # If there are no bookmarks defined, say so
  elif [[ ${#BASHBOOKMARKS[@]} -eq 0 ]]; then
      echo "No bookmarks" >&2
  else
    echo "Bookmarks:" >&2
    for k in "${!BOOKMARKS[@]}" ; do
      echo "  + $k [${BOOKMARKS[$k]}]" >&2
    done
  fi
}

# Finis.
