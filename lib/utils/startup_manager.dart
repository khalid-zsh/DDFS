import 'dart:io';

class StartupManager {
  static const String taskName = "DDFS_AutoStart";

  /// Schedules the app to start at user login using Windows Task Scheduler
  static void enableAutoStart() {
    // Ensure the application path is correct
    String appPath = r"C:\Program Files\Corsive\DDFS\ddfs.exe";

    // PowerShell script to create a scheduled task
    String command = '''
    \$taskName = "$taskName"
    \$appPath = "$appPath"
    
    # Check if the task already exists
    if (Get-ScheduledTask -TaskName \$taskName -ErrorAction SilentlyContinue) {
        Write-Host "✅ Task already exists."
    } else {
        # Create a new scheduled task
        \$action = New-ScheduledTaskAction -Execute "\$appPath"
        \$trigger = New-ScheduledTaskTrigger -AtLogOn
        \$principal = New-ScheduledTaskPrincipal -UserId "\$env:UserName" -LogonType InteractiveToken -RunLevel Highest
        \$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
        
        Register-ScheduledTask -TaskName "\$taskName" -Action \$action -Trigger \$trigger -Principal \$principal -Settings \$settings
        
        Write-Host "✅ Auto-start task created successfully."
    }
    ''';

    try {
      // Run PowerShell command to create scheduled task
      ProcessResult result = Process.runSync('powershell', ['-Command', command], runInShell: true);

      if (result.exitCode == 0) {
        print("✅ Auto-start enabled using Task Scheduler.");
      } else {
        print("❌ Error creating scheduled task: ${result.stderr}");
      }
    } catch (e) {
      print("❌ Failed to run PowerShell command: $e");
    }
  }

  /// Removes the scheduled task if the user wants to disable auto-start
  static void disableAutoStart() {
    String command = '''
    \$taskName = "$taskName"
    if (Get-ScheduledTask -TaskName \$taskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName "\$taskName" -Confirm:\$false
        Write-Host "✅ Auto-start disabled."
    } else {
        Write-Host "❌ Task not found."
    }
    ''';

    try {
      // Run PowerShell command to remove scheduled task
      ProcessResult result = Process.runSync('powershell', ['-Command', command], runInShell: true);

      if (result.exitCode == 0) {
        print("✅ Auto-start disabled.");
      } else {
        print("❌ Error disabling scheduled task: ${result.stderr}");
      }
    } catch (e) {
      print("❌ Failed to run PowerShell command: $e");
    }
  }

  /// Checks if the auto-start task exists
  static bool isAutoStartEnabled() {
    String command = '''
    \$taskName = "$taskName"
    if (Get-ScheduledTask -TaskName \$taskName -ErrorAction SilentlyContinue) {
        Write-Host "✅ Auto-start is enabled."
        exit 0
    } else {
        Write-Host "❌ Auto-start is not enabled."
        exit 1
    }
    ''';

    try {
      // Run PowerShell command to check if task exists
      ProcessResult result = Process.runSync('powershell', ['-Command', command], runInShell: true);

      return result.exitCode == 0;
    } catch (e) {
      print("❌ Failed to run PowerShell command: $e");
      return false;
    }
  }
}
