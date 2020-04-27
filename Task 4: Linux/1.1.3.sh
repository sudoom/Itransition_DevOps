#!/bin/bash

# Объем доступной оперативной памяти (в байтах или МБ)

echo -e "$(grep 'MemTotal' /proc/meminfo | awk '{memory = $2 /1024} END {print memory "Mb"}')\n"
