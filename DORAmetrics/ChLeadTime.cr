require "time"

# Function to parse the log file and extract commit and deployment events
def parse_log_file(log_file : String) : Tuple(Hash(String, Time), Hash(String, Time))
  commits = Hash(String, Time).new
  deployments = Hash(String, Time).new

  File.each_line(log_file) do |line|
    # Assuming the log has a timestamp in the format 'YYYY-MM-DD HH:MM:SS'
    timestamp_str = line[0..18]
    timestamp = Time.parse(timestamp_str, "%Y-%m-%d %H:%M:%S")

    if line.includes?("commit")
      # Extract commit ID or description
      commit_id = line.split("commit")[1].strip
      commits[commit_id] = timestamp
    elsif line.includes?("deployed")
      # Extract commit ID or description
      commit_id = line.split("deployed")[1].strip
      deployments[commit_id] = timestamp
    end
  end

  {commits, deployments}
end

# Function to calculate the Change Lead Time
def calculate_lead_time(commits : Hash(String, Time), deployments : Hash(String, Time)) : Float64
  total_lead_time = 0.0
  lead_time_count = 0

  commits.each do |commit_id, commit_time|
    if deployments.has_key?(commit_id)
      deploy_time = deployments[commit_id]
      lead_time = (deploy_time - commit_time).total_seconds
      total_lead_time += lead_time
      lead_time_count += 1
    end
  end

  return 0.0 if lead_time_count == 0

  average_lead_time = total_lead_time / lead_time_count
  average_lead_time
end

# Main function to execute the script
def main
  log_file_path = "deployment.log" # Set your log file path here

  commits, deployments = parse_log_file(log_file_path)
  lead_time = calculate_lead_time(commits, deployments)

  if lead_time > 0
    puts "Average Change Lead Time: #{(lead_time / 3600).round(2)} hours"
  else
    puts "No commits or deployments found in the log."
  end
end

main
```
