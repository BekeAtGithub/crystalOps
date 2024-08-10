# containerManager.cr

container_name = "myDockerContainer"

def run_command(command : String)
  puts "Running: #{command}"
  system(command)
end

def start_container(name : String)
  run_command("docker start #{name}")
end

def stop_container(name : String)
  run_command("docker stop #{name}")
end

def container_status(name : String)
  status = `docker inspect -f '{{.State.Status}}' #{name}`.strip
  puts "Container #{name} is #{status}"
end

start_container(container_name)
container_status(container_name)
sleep 5
stop_container(container_name)
container_status(container_name)


#usage : crystal run containerManager.cr
