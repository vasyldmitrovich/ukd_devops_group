#!/bin/bash

echo "=== SHELL INFO ==="
echo $SHELL

NAME="Linux"
echo "Variable: $NAME"

echo "User: $USER"
echo "Home: $HOME"
echo "Path: $PATH"

export MY_VAR="Hello"
echo "Env var: $MY_VAR"

VAR=10
( VAR=20; echo "Subshell VAR: $VAR" )
echo "Main shell VAR: $VAR"

echo "Script name: $0"
echo "Args: $*"
echo "Count: $#"
echo "PID: $$"

A=5
B=3
SUM=$((A + B))
echo "Sum: $SUM"

DATE=$(date)
echo "Date: $DATE"
