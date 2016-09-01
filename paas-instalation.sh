#!/bin/bash

echo -n "Enter installation option "
read option
if [ "$option" = "1" ]; then
    echo "option one."
else
    if [ "$option" = "2" ]; then
        echo "option two."
    else
        if [ "$option" = "3" ]; then
            echo "option three."
        else
            echo "option four"
        fi
    fi
fi
