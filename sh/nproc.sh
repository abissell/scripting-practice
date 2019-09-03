#!/bin/sh
echo "You are running $(( $(ps | wc -l) - 1 )) processes"
exit 0
