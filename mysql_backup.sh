# COMMANDS TO TAKE MYSQL DUMP/ BACKUP AND CREATE LOGS WHILE DOING SO

now="$(date +'%d_%m_%Y_%H_%M_%S')"
filename="mysqldb_backup_$now".gz
backupfolder="FOLDER PATH WHERE BACKUP WILL BE STORED"
fullpathbackupfile="$backupfolder/$filename"
logfile="$backupfolder/"mysql_backup_log_"$(date +'%Y_%m_%d')".txt

echo "Backup operation started at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
mysqldump --user= "YOUR USER" --password="YOUR PASSWORD" --default-character-set=utf8 dsp_beta | gzip > "$fullpathbackupfile"
echo "MYSQLDUMP finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"

chown YOUR USER "$fullpathbackupfile"
chown YOUR USER "$logfile"
echo "Files permission changed" >> "$logfile"

echo "Started removing old files at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
# REMOVING OLD DUMPS AND BACKUP LOGS
find "$backupfolder" -name mysql_db_backup_* -mtime +15 -exec rm {} \;
find "$backupfolder" -name mysql_backup_log_* -mtime +15 -exec rm {} \;
#END

echo "Finished removing old files at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
echo "Backup operation finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
exit 0
