#!/bin/bash
#Stops Gesture Recognition with -SIGTERM (15) to end / terminate the process
STOPPINGPROCESS='8819'
kill $STOPPINGPROCESS
#kill $(ps aux | grep "python3 main.py" | head -n 1 | cut -d ' ' -f 8)
