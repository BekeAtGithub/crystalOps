the MeanTimeRecover.Cr Crystal script to measure the Mean Time To Recovery (MTTR), which calculates the average time it takes to recover from a failure based on a log file. The script will look for failure and recovery events in the log and calculate the time difference between them.

1. Log Parsing:
   - `parse_log_file(log_file)`: This function reads the log file line by line and extracts timestamps for failures and recoveries.
   - It assumes the log entries begin with a timestamp in the format `YYYY-MM-DD HH:MM:SS`.
   - It looks for entries containing `"deployment failed"` or `"service down"` to identify failures and entries containing `"service restored"` or `"deployment succeeded"` to identify recoveries.

2. MTTR Calculation:
   - `calculate_mttr(failures, recoveries)`: This function calculates the average time it takes to recover from failures.
   - It matches each failure with the nearest recovery time and calculates the time difference.
   - The script accumulates the total recovery time and calculates the average (in seconds).

3. Execution:
   - Main Function: The `main` function sets the log file path, parses the log, and calculates the MTTR. It then prints the MTTR in minutes.

Usage:

1. Prepare the Log File: Ensure that your deployment or incident log file contains entries that the script can recognize, such as timestamps, failure indicators (`"deployment failed"`, `"service down"`), and recovery indicators (`"service restored"`, `"deployment succeeded"`).

2. Set the Log File Path: Replace `"deployment.log"` with the actual path to your log file.

3. Run the Script: Execute the script using the Crystal compiler. The script will output the Mean Time to Recovery in minutes.

Example Log File (`deployment.log`):
~~~
2024-08-08 12:00:00 deployment started for version 1.0.0
2024-08-08 12:30:00 deployment succeeded for version 1.0.0
2024-08-09 14:00:00 deployment started for version 1.1.0
2024-08-09 14:45:00 deployment failed for version 1.1.0
2024-08-09 15:30:00 service restored after rollback to version 1.0.0
2024-08-10 11:00:00 deployment started for version 1.2.0
2024-08-10 11:30:00 deployment succeeded for version 1.2.0
~~~

In this example log:
- A failure occurred on `2024-08-09 14:45:00`, and the service was restored on `2024-08-09 15:30:00`.
- The script would calculate the MTTR as the time between these two events.

Example Command to Run:
crystal run MeanTimeRecover.Cr

This script provides a basic method for calculating the Mean Time To Recovery and can be adapted to different log formats and environments.
