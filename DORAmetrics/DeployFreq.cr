measure the frequency of deployments by counting the number of times a build release or deployment is created. 
This script will monitor a specific directory for deployment files or logs and count the number of new files created within a specified period.

### Script: `deployment_frequency.cr`

```crystal
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
```

### Explanation:

1. **Dependencies**:
   - The script uses the `Time` and `FileUtils` modules to handle time calculations and file operations.

2. **Counting Deployments**:
   - **`count_deployments(directory, period)`**: This function counts the number of files (representing deployments) created in the specified directory within the given period (`daily`, `weekly`, or `monthly`).
   - **Time Calculation**: Depending on the period (daily, weekly, or monthly), the script calculates the start time for counting deployments.
   - **File Creation Time**: The script checks the creation time (`ctime`) of each file in the directory to determine if it was created within the specified period.

3. **Monitoring Deployments**:
   - **`monitor_deployments(directory, period, interval)`**: This function continuously monitors the deployment directory and prints the number of deployments at regular intervals (`interval` in seconds, default is once a day).

4. **Execution**:
   - **Main Function**: The `main` function sets the directory path and starts the monitoring process. Modify the `deployment_directory` variable to point to your specific directory.

### Usage:

1. **Set the Directory Path**: Replace `"/path/to/deployment/directory"` with the actual path to the directory where deployment files are stored.

2. **Run the Script**: Execute the script using the Crystal compiler. It will output the number of deployments for the specified period at regular intervals.

3. **Customization**: You can change the monitoring period to `daily`, `weekly`, or `monthly`, and adjust the interval (in seconds) to control how often the script checks for new deployments.

### Example Command to Run:

```bash
crystal run deployment_frequency.cr
```

This script provides a basic approach to measuring the frequency of deployments and can be adapted to different environments and requirements.