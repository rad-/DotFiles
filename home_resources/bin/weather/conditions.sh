#!/bin/bash
curl wttr.in | head -n 3 | tail -n1 | tail --bytes=+31 > /home/sseppal/bin/weather/conditions
sed --in-place 's/[\x01-\x1F\x7F]//g' /home/sseppal/bin/weather/conditions 
sed --in-place 's/\[0m//g'            /home/sseppal/bin/weather/conditions  
