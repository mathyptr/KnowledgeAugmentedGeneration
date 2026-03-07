#!/bin/bash

if [ -z "$script_dir" ]
then
    export script_dir="."
fi

$script_dir/startOllama.sh
$script_dir/startKAG.sh
