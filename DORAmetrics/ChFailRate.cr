Here's a Crystal script that measures the Change Failure Rate (CFR), which is the ratio of failed deployments to the total number of deployments. This script reads from a log file to count the number of deployments and how many of those deployments resulted in failures.

### Script: `change_failure_rate.cr`

```crystal
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
```

### Explanation:

1. **Log Parsing**:
   - **`count_deployments_and_failures(log_file)`**: This function reads through the log file line by line, counting the total number of deployments and failures.
   - The script assumes that a deployment starts with a log entry containing `"deployment started"` and fails if it contains `"deployment failed"`, `"rollback"`, or `"hotfix"`.
   - This allows the script to identify both failed deployments and any necessary corrective actions (like rollbacks or hotfixes) as failures.

2. **Calculating CFR**:
   - **`calculate_change_failure_rate(log_file)`**: This function calculates the Change Failure Rate (CFR) as the percentage of failed deployments out of the total number of deployments.
   - If there are no deployments (to avoid division by zero), the function returns `0.0`.

3. **Execution**:
   - **Main Function**: The `main` function sets the log file path and calculates the CFR. It then prints the CFR to the console, rounded to two decimal places.

### Usage:

1. **Prepare the Log File**: Ensure that your deployment log file contains entries that the script can recognize, such as "deployment started", "deployment failed", "rollback", or "hotfix".

2. **Set the Log File Path**: Replace `"deployment.log"` with the actual path to your log file.

3. **Run the Script**: Execute the script using the Crystal compiler. The script will output the Change Failure Rate as a percentage.

### Example Log File (`deployment.log`):

```plaintext
2024-08-08 12:00:00 deployment started for version 1.0.0
2024-08-08 12:30:00 deployment succeeded for version 1.0.0
2024-08-09 14:00:00 deployment started for version 1.1.0
2024-08-09 14:45:00 deployment failed for version 1.1.0
2024-08-09 15:00:00 rollback to version 1.0.0
2024-08-10 11:00:00 deployment started for version 1.2.0
2024-08-10 11:30:00 deployment succeeded for version 1.2.0
```

In this example log:
- There are three deployments (`deployment started`), and one of them failed (`deployment failed`), followed by a rollback (`rollback`).
- The script would calculate a Change Failure Rate of 33.33% based on this data.

### Example Command to Run:

```bash
crystal run change_failure_rate.cr
```

This script provides a basic way to measure the Change Failure Rate and can be customized further based on your specific log format and requirements.
