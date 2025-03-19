#include <Windows.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

HHOOK g_keyboardHook;

// Block Alt+F4 and Esc keys
LRESULT CALLBACK LowLevelKeyboardProc(int nCode, WPARAM wParam, LPARAM lParam) {
    KBDLLHOOKSTRUCT *pKey = (KBDLLHOOKSTRUCT *)lParam;

    // Block Alt+F4 and Esc key
    if (pKey->vkCode == VK_ESCAPE || pKey->vkCode == VK_F4) {
        return 1; // Block the key
    }

    // Block Windows key
    if (pKey->vkCode == VK_LWIN || pKey->vkCode == VK_RWIN) {
        return 1; // Block the Windows key
    }

    return CallNextHookEx(g_keyboardHook, nCode, wParam, lParam);
}

// Register the keyboard hook
void SetKeyboardHook() {
    g_keyboardHook = SetWindowsHookEx(WH_KEYBOARD_LL, LowLevelKeyboardProc, NULL, 0);
}

// Unregister the keyboard hook
void RemoveKeyboardHook() {
    UnhookWindowsHookEx(g_keyboardHook);
}

// Disable Win+R (Run dialog)
void DisableRunDialog() {
    HKEY hKey;
    if (RegOpenKeyEx(HKEY_CURRENT_USER, L"Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer", 0, KEY_WRITE, &hKey) == ERROR_SUCCESS) {
        DWORD value = 1;
        RegSetValueEx(hKey, L"NoRun", 0, REG_DWORD, (BYTE*)&value, sizeof(value));
        RegCloseKey(hKey);
    }
}

// Hide Taskbar
void HideTaskbar() {
    HWND hwnd = FindWindow(L"Shell_TrayWnd", NULL);
    if (hwnd) {
        ShowWindow(hwnd, SW_HIDE); // Hide Taskbar
    }
}

void RegisterMethods(flutter::PluginRegistrarWindows *registrar) {
    auto channel = std::make_unique<flutter::MethodChannel<void>>(
            registrar->messenger(), "com.yourapp/nativeMethods",
                    &flutter::StandardMethodCodec::GetInstance());

    channel->SetMethodCallHandler(
            [](const flutter::MethodCall<void>& call, std::unique_ptr<flutter::MethodResult<void>> result) {
                if (call.method_name() == "blockAltF4") {
                    // Block Alt+F4 (close)
                    SetKeyboardHook();
                    result->Success();
                } else if (call.method_name() == "blockEscKey") {
                    SetKeyboardHook();  // Block Esc key
                    result->Success();
                } else if (call.method_name() == "blockWindowsKey") {
                    SetKeyboardHook();  // Block Windows key
                    result->Success();
                } else if (call.method_name() == "blockWinR") {
                    DisableRunDialog();  // Disable Win+R (Run Dialog)
                    result->Success();
                } else if (call.method_name() == "hideTaskbar") {
                    HideTaskbar();  // Hide Taskbar
                    result->Success();
                } else {
                    result->NotImplemented();
                }
            });

    registrar->AddPlugin(std::move(channel));
}