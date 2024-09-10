#Change Failure Rate (CFR)
#the ratio of failed deployments to the total number of deployments.  
#Read from a log file to count the number of deployments and how many of those deployments resulted in failures.

require "time"

# Function to parse the log file and count deployments and failures
def count_deployments_and_failures(log_file : String) : Tuple(Int32, Int32)
  deployment_count = 0
  failure_count = 0

  File.each_line(log_file) do |line|
    # Assuming log entries have a consistent format
    if line.includes?("deployment started")
      deployment_count += 1
    elsif line.includes?("deployment failed") || line.includes?("rollback") || line.includes?("hotfix")
      failure_count += 1
    end
  end

  {deployment_count, failure_count}
end

# Function to calculate the Change Failure Rate (CFR)
def calculate_change_failure_rate(log_file : String) : Float64
  deployments, failures = count_deployments_and_failures(log_file)

  return 0.0 if deployments == 0

  cfr = (failures.to_f / deployments.to_f) * 100.0
  cfr
end

# Main function to execute the script
def main
  log_file_path = "deployment.log" # Set your log file path here

  cfr = calculate_change_failure_rate(log_file_path)

  puts "Change Failure Rate (CFR): #{cfr.round(2)}%"
end

main
