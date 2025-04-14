#!/bin/bash
CRON_JOB="*/30 * * * * /usr/local/bin/nethogs-logger.sh"
SCRIPT_CONTENT='#!/bin/bash

LOG_DIR="/var/log/nethogs"
mkdir -p "$LOG_DIR"
chown root:root /var/log/nethogs
LOG_FILE="$LOG_DIR/nethogs_$(date +\%Y\%m\%d).log"

{
  echo "===== $(date '+%Y-%m-%d %H:%M:%S') ====="
  timeout 120 nethogs -t -c 5 eth0  # 2min , 5 iteraties
} >> "$LOG_FILE" 2>&1

find "$LOG_DIR" -name "nethogs_*.log" -type f -mtime +30 -delete
'

echo "Installing..."
echo "$SCRIPT_CONTENT" > /usr/local/bin/nethogs-logger.sh
chmod +x /usr/local/bin/nethogs-logger.sh
chown root:root /usr/local/bin/nethogs-logger.sh #nethog heeft root nodig :( zal vast een daemon probleem zijn?!

echo "Configuring crontab..."
if ! crontab -l | grep -q "nethogs-logger.sh"; then
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
    echo "Added nethogs to crontab (runs every 30 minutes)"
else
    echo "nethogs cron job already exists (skipping)"
fi

echo -e "\nVerification:"
echo "Script installed at: /usr/local/bin/nethogs-logger.sh"
echo "Current crontab:"
crontab -l | grep nethogs

echo -e "\nDone! Logs will be stored in /var/log/nethogs/"