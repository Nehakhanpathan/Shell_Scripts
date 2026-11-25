#!/bin/bash

# sometime we get a response like 999 ex linkedin website because to prevent hacking
# to solve this we have to tell that this request is comming form browser

URL=$1

# define log directory
LOG_DIR="$HOME/website_health_log"

# to create log dictory
mkdir -p $LOG_DIR

# to define todays date
TODAY=$(date +"%Y-%m-%d")

# name of log file
LOG_FILE="$LOG_DIR/health_log_$TODAY.log"

# response curl to health check 
response=$(curl -o /dev/null -s -A "Mozilla/5.0" -w "%{http_code} %{time_total}"  $URL)

# to save status code
status_code=$(echo "$response" | awk '{print $1 }')

response_time=$(echo "$response" | awk '{print $2 }')

timestamp=$(date +"%Y-%m-%d %H:%M:%S")

echo "$timestamp | Status: $status_code | Response Time: ${response_time}s" >> "$LOG_FILE"
