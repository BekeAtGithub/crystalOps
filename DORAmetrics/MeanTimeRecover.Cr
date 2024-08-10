require "time"

# Function to parse the log file and extract failure and recovery events
def parse_log_file(log_file : String) : Tuple(Array(Time), Array(Time))
  failures = [] of Time
  recoveries = [] of Time

  File.each_line(log_file) do |line|
    # Assuming the log has a timestamp in the format 'YYYY-MM-DD HH:MM:SS'
    timestamp_str = line[0..18]
    timestamp = Time.parse(timestamp_str, "%Y-%m-%d %H:%M:%S")

    if line.includes?("deployment failed") || line.includes?("service down")
      failures << timestamp
    elsif line.includes?("service restored") || line.includes?("deployment succeeded")
      recoveries << timestamp
    end
  end

  {failures, recoveries}
end

# Function to calculate the Mean Time to Recovery (MTTR)
def calculate_mttr(failures : Array(Time), recoveries : Array(Time)) : Float64
  total_recovery_time = 0.0
  recovery_count = 0

  failures.each do |failure_time|
    # Find the nearest recovery time after each failure
    nearest_recovery = recoveries.select { |recovery_time| recovery_time > failure_time }.first

    if nearest_recovery
      recovery_time = nearest_recovery - failure_time
      total_recovery_time += recovery_time.total_seconds
      recovery_count += 1
    end
  end

  return 0.0 if recovery_count == 0

  mttr = total_recovery_time / recovery_count
  mttr
end

# Main function to execute the script
def main
  log_file_path = "deployment.log" # Set your log file path here

  failures, recoveries = parse_log_file(log_file_path)
  mttr = calculate_mttr(failures, recoveries)

  if mttr > 0
    puts "Mean Time to Recovery (MTTR): #{(mttr / 60).round(2)} minutes"
  else
    puts "No failures or recoveries found in the log."
  end
end

main


