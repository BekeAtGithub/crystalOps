#interacts with system files, running shell commands, or using APIs.

# can run ad-hoc commands on VM
def run_command(command : String)
  puts "Running: #{command}"
  system(command)
end
#can run updates on vm 
def update_system
  run_command("sudo apt-get update")
  run_command("sudo apt-get upgrade -y")
end
#can clean vm
def clean_system
  run_command("sudo apt-get autoremove -y")
  run_command("sudo apt-get clean")
end

update_system
clean_system

# usage: crystal run serverConfig.cr
