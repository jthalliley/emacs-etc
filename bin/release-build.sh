#!/bin/bash

mvn release:clean release:prepare release:perform --batch-mode \
    -Dmaven.test.skip=true -DskipTests -Dmaven.javadoc.skip=true \
    -Darguments='-DskipTests -Dmaven.test.skip=true -Dmaven.javadoc.skip=true'
