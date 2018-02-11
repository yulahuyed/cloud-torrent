#!/bin/sh

if [ "${GDRIVE_TOKEN}" ]
then
expect <<END
spawn rclone config
expect "n/s/q>"
send "n\n"
expect "name>"
send "gdrive\n"
expect "Storage>"
send "10\n"
expect "client_id>"
send "${CLIENT_ID}\n"
expect "client_secret>"
send "${CLIENT_SECRET}\n"
expect "service_account_file>"
send "\n"
expect "y/n>"
send "n\n"
expect "Enter verification code>"
send "${GDRIVE_TOKEN}\n"
expect "y/n>"
send "n\n"
expect "y/e/d>"
send "y\n"
expect "e/n/d/r/c/s/q>"
send "q\n"
expect eof
END
rclone mount gdrive:${GDRIVE_PATH} $DLPATH/downloads --allow-other --vfs-cache-mode writes --allow-non-empty --ignore-checksum &
fi

cloud-torrent
