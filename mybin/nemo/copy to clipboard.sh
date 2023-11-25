#/bin/bash

echo -n "'$(realpath "$1")'" |xclip -selection primary
echo -n "'$(realpath "$1")'" |xclip -selection secondary
echo -n "'$(realpath "$1")'" |xclip -selection clipboard