require "time"
require "file_utils"

# Function to count deployments within a specified period
def count_deployments(directory : String, period : String = "daily") : Int32
  now = Time.now

  start_time = case period
  when "daily"
    now.beginning_of_day
  when "weekly"
    now - (now.day_of_week - 1).days
  when "monthly"
    Time.new(now.year, now.month, 1)
  else
    raise ArgumentError.new("Unsupported period. Use 'daily', 'weekly', or 'monthly'.")
  end

  deployment_count = 0

  Dir.entries(directory).each do |entry|
    filepath = "#{directory}/#{entry}"
    if File.file?(filepath)
      file_creation_time = File.stat(filepath).ctime
      if file_creation_time >= start_time
        deployment_count += 1
      end
    end
  end

  deployment_count
end

# Function to monitor deployments and print the frequency
def monitor_deployments(directory : String, period : String = "daily", interval : Int32 = 3600)
  loop do
    deployment_count = count_deployments(directory, period)
    puts "Deployments in the last #{period}: #{deployment_count}"

    sleep(interval)
  end
end

# Main function to execute the script
def main
  deployment_directory = "/path/to/deployment/directory" # Set your directory path here
  monitor_deployments(deployment_directory, period: "daily", interval: 86400)
end

main
