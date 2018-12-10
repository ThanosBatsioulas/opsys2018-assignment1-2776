#!/bin/bash

diff_file="./diff_cache"
file="./sites"

index () {
  touch $diff_file
  set newdiff=""
  while IFS= read -r n
  do
    if [[ $n != *#* ]]; then
      new_md5sum=$(curl -s $n | md5sum | cut -d ' ' -f1)
      validate_md5sum $diff_file $n $new_md5sum

      newdiff+="$n $new_md5sum \n"
    fi
  done < "$file"

  echo -e $newdiff > $diff_file
}

validate_md5sum() {
  while IFS= read -r line
  do
    site=$(echo "$line" | cut -d ' ' -f1)
    md5sum=$(echo "$line" | cut -d ' ' -f2)

    if [[ $site == $2 ]]; then
      if [[ $md5sum != $3 ]]; then
        printf "$site CHANGED $3 $md5sum"
      fi

      return
    fi
  done < $1

  printf "$2 INIT\n"
}

index 
