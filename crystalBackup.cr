# crystalBackup.cr
#source = what you want to backup
#destination = where you want to backup to
#what time stamp you want to put tag your backup with
backup_source = "/var/www/your-app"
backup_destination = "/backups/your-app"
timestamp = Time.now.format("%Y%m%d%H%M%S")
#runs adhoc command
def run_command(command : String)
  puts "Running: #{command}"
  system(command)
end
#creates backup with source, destination, timestamp with tar to create archive of directory or file 
def create_backup(source : String, destination : String, timestamp : String)
  run_command("tar -czvf #{destination}/backup-#{timestamp}.tar.gz #{source}")
end
#deletes/clears out old backups, modify -1 for how many to clean. 
def clean_old_backups(destination : String, keep : Int32)
  backups = Dir.glob("#{destination}/backup-*.tar.gz").sort.reverse
  backups[keep..-1].each do |backup|
    run_command("rm #{backup}")
  end unless backups.size <= keep
end
# execute functions, put a # infront of "clean_old" backups if you wish to not clean them out
create_backup(backup_source, backup_destination, timestamp)
clean_old_backups(backup_destination, 5)

#usage crystal run crystalBackup.cr
