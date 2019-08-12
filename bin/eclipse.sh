#!/bin/bash

export JAVA_HOME=~/Tools/jdk1.8.0_131

export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH

~/Tools/eclipse/neon/eclipse 1>>/tmp/eclipse.log 2>&1 &
