#!/bin/bash

pat=$1

emacsclient $(find . -name $pat)
