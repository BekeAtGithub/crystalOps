# monitor system resources like CPU and memory usage
# crystalVision.cr
#runs "top" command, can be replaced by "htop" or ps aux | grep whatever application you're specifically looking info for, or any other command you want to use 
def get_cpu_usage
  `top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}'`.strip.to_f
end
#use free -m to get disk swap and memory utilization 
def get_memory_usage
  total = `free -m | awk '/Mem:/ { print $2 }'`.strip.to_i
  used = `free -m | awk '/Mem:/ { print $3 }'`.strip.to_i
  (used.to_f / total * 100).round(2)
end
# repeats above commands once every 5 seconds
loop do
  cpu = get_cpu_usage
  memory = get_memory_usage

  puts "CPU Usage: #{cpu}%"
  puts "Memory Usage: #{memory}%"

  sleep 5
end

# usage: crystal run monitor.cr
