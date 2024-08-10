This is showing what the ChFailRate.cr file does:
it provides a basic way to measure the Change Failure Rate, can be tweaked to specific log format/requirements.

1. Log Parsing:
   - `count_deployments_and_failures(log_file)`: This function reads the log file line by line, counting the total number of deployments and failures.
   - The script will think deployment starts with a log entry containing `"deployment started"` and fails if it contains common error words like `"deployment failed"`, `"rollback"`, or `"hotfix"`.
   - Allows the script to figure out both failed deployments and any necessary corrective actions (like rollbacks or hotfixes) as failures.

2. Calculating CFR:
   - `calculate_change_failure_rate(log_file)`: This function calculates the Change Failure Rate (CFR) as the percentage of failed deployments out of the total number of deployments.
   - If there are no deployments (to avoid division by zero), the function returns `0.0`.

3. Execution:
   - Main Function: The `main` function sets the log file path and calculates the CFR. It then prints the CFR to the console, rounded to two decimal places.

# Usage:

1. Prepare the Log File: Ensure that your deployment log file contains entries that the script can recognize, such as "deployment started", "deployment failed", "rollback", or "hotfix".

2. Set the Log File Path: Replace `"deployment.log"` with the actual path to your log file.

3. Run the Script: Execute the script using the Crystal compiler. The script will output the Change Failure Rate as a percentage.

# Example Log File (`deployment.log`):

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

# Example Command to Run:

crystal run change_failure_rate.cr


