To measure the Change Lead Time, which is the time between when a change is committed and when it is deployed, we can write a Crystal script that reads from a log file and calculates the time difference between commit and deployment events. Here's how you can do it:

### Explanation:

1. **Log Parsing**:
   - **`parse_log_file(log_file)`**: This function reads the log file and extracts timestamps for both commit and deployment events.
   - It assumes each log entry begins with a timestamp in the format `YYYY-MM-DD HH:MM:SS`.
   - It looks for lines containing `"commit"` to identify when a change was committed and `"deployed"` to identify when that change was deployed.
   - Commit IDs or descriptions are used as keys in the `Hash` to match commits to their deployments.

2. **Change Lead Time Calculation**:
   - **`calculate_lead_time(commits, deployments)`**: This function calculates the time difference between each commit and its corresponding deployment.
   - It accumulates the total lead time for all commits and calculates the average lead time in seconds.

3. **Execution**:
   - **Main Function**: The `main` function sets the log file path, parses the log, and calculates the average Change Lead Time. The result is printed in hours, rounded to two decimal places.

### Usage:

1. **Prepare the Log File**: Ensure that your log file contains entries that the script can recognize, such as timestamps, commit indicators (`"commit"`), and deployment indicators (`"deployed"`).

2. **Set the Log File Path**: Replace `"deployment.log"` with the actual path to your log file.

3. **Run the Script**: Execute the script using the Crystal compiler. The script will output the average Change Lead Time in hours.

### Example Log File (`deployment.log`):

```plaintext
2024-08-08 12:00:00 commit 123456: Added feature X
2024-08-08 12:30:00 deployed 123456: Added feature X
2024-08-09 14:00:00 commit 789012: Fixed bug Y
2024-08-10 11:00:00 deployed 789012: Fixed bug Y
2024-08-10 11:30:00 commit 345678: Improved performance for Z
2024-08-10 14:00:00 deployed 345678: Improved performance for Z
```

In this example log:
- A commit was made on `2024-08-08 12:00:00`, and it was deployed on `2024-08-08 12:30:00`.
- The script calculates the time difference between these two events to determine the lead time.

### Example Command to Run:
crystal run ChLeadTime.cr


This script provides a basic method for calculating the Change Lead Time and can be customized to fit different log formats and environments.
