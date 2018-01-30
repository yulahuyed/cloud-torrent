if [ "${GDRIVE_SECRET}" ]
then
    sed -i "s/gdsecret/${GDRIVE_SECRET}/g" /config/rclone.conf
    sed -i "s/gdid/${GDRIVE_ID}/g" /config/rclone.conf
    sed -i "s/gatoken/${GDRIVE_ACTOKEN}/g" /config/rclone.conf
    rclone mount gdrive: $DLPATH/downloads --config /config/rclone.conf
fi

cloud-torrent
