#pulls code from a branch of a repository, builds it, and restarts the necessary services
##
# specify your url to github or azure devops or wherever , then to your local directory path deployment location
repository_url = "https://dev.azure.com/your-repo/your-app.git"
deploy_directory = "/var/www/your-app"
# runs ad-hoc command onto vm
def run_command(command : String)
  puts "Running: #{command}"
  system(command)
end
# clones url specified earlier
def clone_or_pull_repo(repo_url : String, directory : String)
  if Dir.exists?(directory)
    run_command("cd #{directory} && git pull origin main")
  else
    run_command("git clone #{repo_url} #{directory}")
  end
end
# builds application from repo onto local host
def build_application(directory : String)
  run_command("cd #{directory} && make build")
end
#uses systemctl to restart the service installed
def restart_service(service_name : String)
  run_command("sudo systemctl restart #{service_name}")
end
#execute functions
clone_or_pull_repo(repository_url, deploy_directory)
build_application(deploy_directory)
restart_service("your-app-service")

# usage: crystal run appDeploy.cr 
