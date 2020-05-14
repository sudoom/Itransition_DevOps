#!/bin/bash

# Написать скрипт, который бы выводил на экран наиболее выгодный курс валют конвертации USD->BYR и EUR->BYR.
# Способ работы скрипта: либо передавать входным параметром "USD" или "EUR" и выводить курс, либо,
# если входных параметров нет - а консольном диалоге запросить на выбор желаемый курс.
# Получать можно с любого сайта (в идеале - с finance.tut.by).

currency=""

function sell() {
  curl -sl https://finance.tut.by/ |
    grep $currency |
    grep buy |
    cut -d\> -f7-8 |
    cut -c4-9
}

if [ -z "$1" ]; then
  echo "Choose USD or EUR"
  echo "USD"
  echo "EUR"
  read curr
  case $curr in
  USD)
    currency="best_usd"
    sell
    ;;
  EUR)
    currency="best_eur"
    sell
    ;;
  esac
elif [ "$1" == "USD" ]; then
  currency="best_usd"
elif [ "$1" == "EUR" ]; then
  currency="best_eur"
else
  echo "Wrong currency, use EUR or USD"
fi

while [ -n "$1" ]; do
  case "$1" in
  USD) sell ;;
  EUR) sell ;;
  esac
  shift
done
