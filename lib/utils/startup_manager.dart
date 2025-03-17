import 'dart:io';

class StartupManager {
  static const String taskName = "DDFS_AutoStart";

  /// Schedules the app to start at user login using Windows Task Scheduler
  static void enableAutoStart() {
    String appPath = r"C:\Program Files\Corsive\DDFS\ddfs.exe";

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

    Process.runSync('powershell', ['-Command', command], runInShell: true);
    print("✅ Auto-start enabled using Task Scheduler.");
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

    Process.runSync('powershell', ['-Command', command], runInShell: true);
    print("✅ Auto-start disabled.");
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

    ProcessResult result = Process.runSync('powershell', ['-Command', command], runInShell: true);
    return result.exitCode == 0;
  }
}
