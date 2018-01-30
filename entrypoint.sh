if [ "${GDRIVE_SECRET}" ]
then
    sed -i "s/gdsecret/${GDRIVE_SECRET}/g" /config/rclone.json
    sed -i "s/gdid/${GDRIVE_ID}/g" /config/rclone.json
    sed -i "s/gatoken/${GDRIVE_ACTOKEN}/g" /config/rclone.json
    rclone --config /config/rclone.json
    rclone mount gdrive: $DLPATH/downloads
fi

cloud-torrent
