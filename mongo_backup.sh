# A simple script to take backup of a mongo database

# Setting configuration for mongo backup
mongo_database = "DATABASE NAME"
file_name = "mongo_db_backup" # File name for the backup created
mongo_host = "127.0.0.1"  #Choose your host
mongo_port = "27017"
timestamp = `date +%F-%H%M`
mongodump_path = "/usr/bin/mongodump"     #You have to find where your mongodump is
backups_dir = "PATH WHERE YOU WANT TO PUT BACKUP CREATED"
backup_name = "$file_name-$timestamp"
full_path = "$backups_dir/$backup_name"
log_file = "$backups_dir/"mongo_backup_log_"$(date +'%Y_%m_%d')".txt    # For logging the backup
# Configuration setting done

# Backup Starts here
echo "Backup operation started at $(date +'%d-%m-%Y %H:%M:%S')" >> "$log_file"
echo "Mongodb dump started at $(date +'%d-%m-%Y %H:%M:%S')" >> "$log_file"
$mongodump_path -d $mongo_database
echo "Mongodb dump finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$log_file"
echo "Started moving and compressing backup at $(date +'%d-%m-%Y %H:%M:%S')" >> "$log_file"
#Backup ends here

# Now time to make is accessible
chown YOURUSER "$backups_dir"
chown YOURUSER "$log_file"
mkdir -p $backups_dir
mv dump $backup_name
tar -zcvf $backups_dir/$backup_name.tgz $backup_name
rm -rf $backup_name
echo "Finished moving and compressing backup at $(date +'%d-%m-%Y %H:%M:%S')" >> "$log_file"
echo "Started removing old files at $(date +'%d-%m-%Y %H:%M:%S')" >> "$log_file"
find "$backups_dir" -name mongo_db_backup_* -mtime +15 -exec rm {} \;
find "$backups_dir" -name mongo_backup_log_* -mtime +15 -exec rm {} \;
echo "Finished removing old files at $(date +'%d-%m-%Y %H:%M:%S')" >> "$log_file"
echo "Backup operation finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$log_file"
# Finally made it accessible

# Whoo!!! got the backup of mongo database

exit 0
