#!/bin/bash

weather=$(curl -s wttr.in/Limerick\?format=3 2> /dev/null | awk '{print $3}')
echo $weather
