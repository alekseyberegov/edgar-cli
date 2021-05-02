#!/bin/bash

cat ~/Downloads/company.20210104.idx | awk 'NR > 8 {print $0}' | cut -c 1-60,61-70,71-85,86-95,96-160  | less