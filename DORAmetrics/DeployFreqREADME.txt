The DeployFreq.cr script provides a basic approach to measuring the frequency of deployments and can be adapted to different environments and requirements.
measure the frequency of deployments by counting the number of times a build release or deployment is created. 
This script will monitor a specific directory for deployment files or logs and count the number of new files created within a specified period.

1. Dependencies:
   - The script uses the `Time` and `FileUtils` modules to handle time calculations and file operations.

2. Counting Deployments:
   - `count_deployments(directory, period)`: This function counts the number of files (representing deployments) created in the specified directory within the given period (`daily`, `weekly`, or `monthly`).
   - Time Calculation: Depending on the period (daily, weekly, or monthly), the script calculates the start time for counting deployments.
   - File Creation Time: The script checks the creation time (`ctime`) of each file in the directory to determine if it was created within the specified period.

3. Monitoring Deployments:
   - `monitor_deployments(directory, period, interval)`: This function continuously monitors the deployment directory and prints the number of deployments at regular intervals (`interval` in seconds, default is once a day).

4. Execution:
   - Main Function: The `main` function sets the directory path and starts the monitoring process. Modify the `deployment_directory` variable to point to your specific directory.

Usage:

1. Set the Directory Path: Replace `"/path/to/deployment/directory"` with the actual path to the directory where deployment files are stored.

2. Run the Script: Execute the script using the Crystal compiler. It will output the number of deployments for the specified period at regular intervals.

3. Customization: You can change the monitoring period to `daily`, `weekly`, or `monthly`, and adjust the interval (in seconds) to control how often the script checks for new deployments.

Example Command to Run:
crystal run DeployFreq.cr



