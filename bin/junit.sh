#!/bin/bash

pat=${1}*Test

mvn test -Dtest=${pat}
