#!/bin/bash

case $1 in
    one)
        echo "You chose 1."
        ;;
    two|three)
        echo "You chose 2 or 3."
        ;;
    *)
        echo "You chose other number."
        ;;
esac
