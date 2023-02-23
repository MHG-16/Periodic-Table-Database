#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --non-align --tuples-only -C"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument"
else
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    echo "$1 is not number"
  fi
  else

fi
