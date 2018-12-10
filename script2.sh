#!/bin/bash

targz="./example.tar.gz"
download_dir="./example"
repo="./assignments"

tar -xzf $targz
mkdir -p $repo

files=$(find $dir -type f -name "*.txt")
for i in $files;
do
    while IFS= read -r line
    do
        if [[ $line == *https* ]]; then
            cd $repo
            git clone  -q $line

            ret=$?
            if ! test "$ret" -eq 0
            then
                printf "$line : Cloning FAILED\n"
                cd ..
                break
            fi
            cd ..
            printf "$line : Cloning OK\n"
            break
        fi
    done < $i
done

cd $repo
for i in $(ls);
do
    cd $i
    sh_files=$(find . -type f -name "*.sh" | wc -l)
    other_files=$(($(find . -mindepth 1 | wc -l) - $sh_files))

    printf "$i:\n"
    printf "Number of directories: 1\n"
    printf "Number of script files : $sh_files\n"
    printf "Number of other files : $other_files\n"
    cd ..

done
cd ..
