import 'dart:io';
import 'dart:ffi';
import 'package:win32/win32.dart';

class PlatformUtils {
  /// Forces full-screen mode (removes Windows UI)
  static void setFullScreen() {
    if (Platform.isWindows) {
      final hwnd = GetForegroundWindow(); // Get active window handle

      if (hwnd != 0) {
        // Remove window border (Set Borderless Fullscreen)
        SetWindowLongPtr(hwnd, GWL_STYLE, GetWindowLongPtr(hwnd, GWL_STYLE) & ~WS_OVERLAPPEDWINDOW);

        // Get screen dimensions
        final int screenWidth = GetSystemMetrics(SM_CXSCREEN);
        final int screenHeight = GetSystemMetrics(SM_CYSCREEN);

        // Move and resize window to full screen
        SetWindowPos(hwnd, NULL, 0, 0, screenWidth, screenHeight, SWP_NOZORDER | SWP_FRAMECHANGED);
        print("✅ App set to full-screen mode.");
      } else {
        print("❌ Failed to get window handle.");
      }
    }
  }

  /// Hides the Windows Taskbar
  static void hideTaskbar() {
    if (Platform.isWindows) {
      final hwnd = FindWindow(TEXT('Shell_TrayWnd'), nullptr);
      ShowWindow(hwnd, SW_HIDE); // Hide taskbar
      print("✅ Windows Taskbar Hidden.");
    }
  }

  /// Disables the close button (Prevents the app from being closed)
  static void disableCloseButton() {
    if (Platform.isWindows) {
      final hwnd = GetForegroundWindow();

      if (hwnd != 0) {
        // Remove the close button
        SetWindowLongPtr(hwnd, GWL_STYLE, GetWindowLongPtr(hwnd, GWL_STYLE) & ~WS_SYSMENU);
        SetWindowPos(hwnd, NULL, 0, 0, 0, 0, SWP_NOSIZE | SWP_NOMOVE | SWP_NOZORDER | SWP_FRAMECHANGED);
        print("✅ Close button disabled.");
      } else {
        print("❌ Failed to disable close button.");
      }
    }
  }
}
