#!/bin/bash

# Assign the filename
filename='test.txt'
char
match='/mnt/work/yocto/sources/meta-raspberrypi \'
# match='abc'
insert='New Inserted Line'
file='file.txt'

sed -i "s/${match}/${match}\n$insert/" test.txt
