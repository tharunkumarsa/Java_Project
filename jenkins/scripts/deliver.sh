#!/usr/bin/env bash

echo 'Installing Maven-built Java application...'
set -x
mvn jar:jar install:install help:evaluate -Dexpression=project.name
set +x

echo 'Extracting project name and version...'
set -x
NAME=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.name)
VERSION=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.version)
set +x

echo "Running Java application: ${NAME}-${VERSION}.jar"
set -x
java -jar target/${NAME}-${VERSION}.jar
set +x
