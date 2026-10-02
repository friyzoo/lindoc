#!/bin/bash

# Clear terminal screen
clear

echo -e "\e[1;35m=========================================\e[0m"
echo -e "\e[1;36m       LINUX SYSTEM DOCTOR & CHECK       \e[0m"
echo -e "\e[1;35m=========================================\e[0m"
echo ""

# Function to check if a specific tool is installed
check_tool() {
    if command -v "$1" &> /dev/null; then
        echo -e "  [\e[1;32m✓\e[0m] $1 is installed (Version: $($1 --version 2>&1 | head -n 1 | awk '{print $2, $3}'))"
    else
        echo -e "  [\e[1;31m✗\e[0m] \e[1;31m$1 is missing!\e[0m"
    fi
}

# 1. Checking core dev dependencies
echo -e "\e[1;33m--- Checking Core Dependencies ---\e[0m"
check_tool "git"
check_tool "docker"
check_tool "python3"
check_tool "node"
echo ""

# 2. Check Network Connection
echo -e "\e[1;33m--- Checking Network Status ---\e[0m"
if ping -c 1 8.8.8.8 &> /dev/null; then
    echo -e "  [\e[1;32m✓\e[0m] Internet connection available."
else
    echo -e "  [\e[1;31m✗\e[0m] \e[1;31mNo internet connectivity detected.\e[0m"
fi
echo ""

# 3. Check Resource Pressure
echo -e "\e[1;33m--- Checking Memory Load ---\e[0m"
FREE_MEM=$(free | grep Mem | awk '{print int($4/$2 * 100)}')

if [ "$FREE_MEM" -lt 15 ]; then
    echo -e "  [\e[1;31m⚠\e[0m] \e[1;31mCritical Memory Warning! Only ${FREE_MEM}% RAM left.\e[0m"
else
    echo -e "  [\e[1;32m✓\e[0m] Healthy RAM overhead: ${FREE_MEM}% available."
fi
echo ""
echo -e "\e[1;35m=========================================\e[0m"
