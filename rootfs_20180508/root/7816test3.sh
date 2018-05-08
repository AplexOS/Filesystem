#!/bin/sh

echo "---------start RS232 test -------"
one_ttytest  /dev/ttyO1   500  50000  &
one_ttytest  /dev/ttyO2   500  50000  &
