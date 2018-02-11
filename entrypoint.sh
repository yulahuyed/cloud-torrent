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
rclone mount gdrive:${GDRIVE_PATH} $DLPATH/downloads --allow-other --vfs-cache-mode writes --allow-non-empty --ignore-checksum --ignore-size &
fi

if [ "${OD_PATH}" ]
then

if [ ! -f "/etc/davfs2/davfs2.conf" ]
then 
touch /etc/davfs2/davfs2.conf
fi
chmod 777 /etc/davfs2/davfs2.conf
echo >> /etc/davfs2/davfs2.conf
echo >> /etc/davfs2/davfs2.conf

python /config/od.py ${OD_PATH} ${OD_USER} ${OD_PASS} > cookie.txt
sed -i "s/ //g" cookie.txt
COOKIE=$(cat cookie.txt)
DAVFS_CONFIG=$(grep -i "use_locks 0" /etc/davfs2/davfs2.conf)
if [ "${DAVFS_CONFIG}" == "use_locks 0" ] 
then
  echo "continue..."
else
  echo "use_locks 0" >> /etc/davfs2/davfs2.conf
fi
echo "[$DLPATH/downloads]" >> /etc/davfs2/davfs2.conf
echo "add_header Cookie ${COOKIE}" >> /etc/davfs2/davfs2.conf

rm cookie.txt

/sbin/mount.davfs ${OD_PATH} $DLPATH/downloads

fi

cloud-torrent
