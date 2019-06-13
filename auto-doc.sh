#!/bin/bash

# Default vars
LANGUAGE="unknown"
FRAMEWORK="unknown"
DOCKER="unknown"
GULP="unknown"
THIRD_PARTIES="unknown"
NPM="unknown"
UNKNOWN=1

# Get path from command param
PROJECT_PATH=$1

if [ -f $PROJECT_PATH/docker-compose.yml ]; then
    DOCKER="Yes"
    UNKNOWN=0
fi

if [ -f $PROJECT_PATH/gulpfile.js ]; then
    GULP="Yes"
    UNKNOWN=0
fi

if [ -d $PROJECT_PATH/node_modules ]; then
    NPM="Yes"
    UNKNOWN=0
fi

# Find out what language project is (PHP/Node JS etc.)
# Check if there is an index.php file to confirm if it is a PHP project
if [ -f $PROJECT_PATH/index.php ] || [ -f $PROJECT_PATH/public/index.php ]; then
    LANGUAGE="PHP"
    UNKNOWN=0
fi

# Check if there is an app.js to confirm if it is a Node project
if [ -f $PROJECT_PATH/app.js ]; then
    LANGUAGE="NodeJS"
    UNKNOWN=0
fi

# Find out if the project has a framework (Laravel, Yii etc.)
if [ $LANGUAGE = "PHP" ] && [ -f $PROJECT_PATH/public/index.php ] && [ "grep -q Laravel "$PROJECT_PATH"/public/index.php" ]; then
    FRAMEWORK="Laravel"
    UNKNOWN=0
fi

if [ $LANGUAGE = "PHP" ] && [ -f $PROJECT_PATH/protected/yiic ]; then
    FRAMEWORK="Yii"
    UNKNOWN=0
fi

# Database in use? Mongo? MySQL?

# Find out if the project uses any sort of third party (Mailtrap, s3 etc.)

# Compile into readable format
if [ $UNKNOWN -eq 1 ]; then
    echo "Technical information could not be automatically detected"
    exit 1
fi
if [ ! $LANGUAGE = unknown ]; then
    echo "Language:" $LANGUAGE 
fi
if [ ! $FRAMEWORK = unknown ]; then
    echo "Framework:" $FRAMEWORK
fi
if [ ! $DOCKER = unknown ]; then
    echo "Docker:" $DOCKER
fi
if [ ! $GULP = unknown ]; then
    echo "Gulp:" $GULP
fi
if [ ! $NPM = unknown ]; then
    echo "NPM:" $NPM
fi
if [ ! "$THIRD_PARTIES" = unknown ]; then
    echo "Third Parties:" $THIRD_PARTIES
fi

# Create/update documentation file
