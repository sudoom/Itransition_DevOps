#!/bin/bash

# Загрузка CPU в %

echo -e "$(grep 'cpu ' /proc/stat | awk '{usage=100-($5)*100/($1+$2+$3+$4+$5+$6+$7+$8)} END {print usage "%"}')\n"
