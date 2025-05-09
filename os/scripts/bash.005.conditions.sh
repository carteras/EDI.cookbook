#!/bin/bash

NAME=$1

if [ -z "$NAME" ]; then
    echo "Name is empty"
else
    echo "Hello, $NAME"
fi