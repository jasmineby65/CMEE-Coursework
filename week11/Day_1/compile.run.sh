#!/bin/bash

gcc $1 -o $(basename "$1" .c)
./$(basename "$1" .c)