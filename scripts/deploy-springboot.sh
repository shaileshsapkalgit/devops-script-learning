#!/bin/bash

echo "==========================================="
echo " Spring Boot Deployment Started"
echo "==========================================="

# Go to Spring Boot project
cd ~/SpringBoot-Form || {
    echo "Project directory not found!"
    exit 1
}

echo ""
echo "Current Directory:"
pwd

echo ""
echo "Pulling latest code from GitHub..."
git pull

echo ""
echo "Building Spring Boot Project..."
mvn clean package

if [ $? -ne 0 ]; then
    echo "Build Failed!"
    exit 1
fi

echo ""
echo "Stopping old application (if running)..."

PID=$(pgrep -f "*.jar")

if [ -n "$PID" ]; then
    echo "Stopping PID: $PID"
    kill -9 $PID
    sleep 5
else
    echo "No running application found."
fi

echo ""
echo "Starting Spring Boot Application..."

JAR_FILE=$(find target -name "*.jar" | head -1)

nohup java -jar "$JAR_FILE" > application.log 2>&1 &

sleep 10

echo ""
echo "Checking Application..."

NEW_PID=$(pgrep -f "$JAR_FILE")

if [ -n "$NEW_PID" ]; then
    echo "Application Started Successfully"
    echo "PID : $NEW_PID"
else
    echo "Application Failed to Start"
    exit 1
fi

echo ""
echo "==========================================="
echo " Deployment Completed Successfully"
echo "==========================================="