#!/bin/bash

echo "=================================================="
echo "      DevOps Tools Installation - Amazon Linux"
echo "=================================================="

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script using sudo."
    echo "Example: sudo ./install-devops-tools.sh"
    exit 1
fi

echo ""
echo "Updating package repository..."
dnf update -y

#########################################################
# Java
#########################################################

echo ""
echo "Installing Java..."

if command -v java &>/dev/null; then
    echo "Java is already installed."
    java -version
else
    dnf install java-21-amazon-corretto -y
    java -version
fi

#########################################################
# Git
#########################################################

echo ""
echo "Installing Git..."

if command -v git &>/dev/null; then
    echo "Git is already installed."
    git --version
else
    dnf install git -y
    git --version
fi

#########################################################
# Maven
#########################################################

echo ""
echo "Installing Maven..."

if command -v mvn &>/dev/null; then
    echo "Maven is already installed."
    mvn -version
else
    dnf install maven -y
    mvn -version
fi

#########################################################
# Docker
#########################################################

echo ""
echo "Installing Docker..."

if command -v docker &>/dev/null; then
    echo "Docker is already installed."
    docker --version
else
    dnf install docker -y
    systemctl enable docker
    systemctl start docker
    docker --version
fi

#########################################################
# Nginx
#########################################################

echo ""
echo "Installing Nginx..."

if command -v nginx &>/dev/null; then
    echo "Nginx is already installed."
    nginx -v
else
    dnf install nginx -y
    systemctl enable nginx
    systemctl start nginx
    nginx -v
fi

#########################################################
# Status
#########################################################

echo ""
echo "=================================================="
echo "Installed Versions"
echo "=================================================="

java -version
git --version
mvn -version
docker --version
nginx -v

echo ""
echo "=================================================="
echo "Service Status"
echo "=================================================="

systemctl status docker --no-pager
systemctl status nginx --no-pager

echo ""
echo "=================================================="
echo "Installation Completed Successfully"
echo "=================================================="