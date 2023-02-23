#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENTS=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements AS e INNER JOIN properties AS p USING(atomic_number) INNER JOIN types AS t USING(type_id) WHERE e.atomic_number = '$1'") 
  else
    ELEMENTS=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements AS e INNER JOIN properties AS p USING(atomic_number) INNER JOIN types AS t USING(type_id) WHERE  e.symbol ='$1' OR e.name = '$1'") 
  fi
  if [[ -z $ELEMENTS ]]
  then
    echo "I could not find that element in the database."
  else
    echo $ELEMENTS | while IFS=\| read ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING BOILING TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi
fi
