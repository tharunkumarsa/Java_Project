#!/usr/bin/env bash

echo 'Installing the Maven-built Java application into the local Maven repository...'

# Run Maven to compile, test, and install the project
set -x
mvn clean install
set +x

# Extract the project name from the pom.xml
echo 'Extracting the project name from pom.xml...'
set -x
NAME=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.name)
set +x

# Extract the project version from the pom.xml
echo 'Extracting the project version from pom.xml...'
set -x
VERSION=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.version)
set +x

# Check if the JAR file exists and run it
JAR_PATH="target/${NAME}-${VERSION}.jar"

if [ -f "$JAR_PATH" ]; then
    echo "Running the JAR: ${JAR_PATH}"
    set -x
    java -jar "$JAR_PATH"
    set +x
else
    echo "ERROR: JAR file not found at ${JAR_PATH}. Make sure the build was successful."
    exit 1
fi
