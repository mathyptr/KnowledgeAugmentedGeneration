#!/bin/bash

if [ -z "$script_dir" ]
then
    export script_dir="."
fi

$script_dir/stopKAG.sh
$script_dir/stopOllama.sh
