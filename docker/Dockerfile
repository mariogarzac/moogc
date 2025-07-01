# Must be the first command
FROM ubuntu:latest AS base

# $src-file $dest-file | $src-file $dest-dir | $src-dir $dest-dir
# * or ? can be used to match characters 
# --chown $user:$group
# --link
COPY . /src

RUN apt -y update && apt -y install curl
