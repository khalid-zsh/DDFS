#include <windows.h>

HHOOK g_keyboardHook; // Declare a global variable to store the hook

LRESULT CALLBACK KeyboardHook(int nCode, WPARAM wParam, LPARAM lParam) {
    if (nCode >= 0 && (wParam == WM_KEYDOWN || wParam == WM_SYSKEYDOWN)) {
        KBDLLHOOKSTRUCT* kbdStruct = (KBDLLHOOKSTRUCT*)lParam;
        if ((kbdStruct->vkCode == VK_ESCAPE) ||
            (kbdStruct->vkCode == VK_F4 && (GetAsyncKeyState(VK_MENU) & 0x8000)) ||
            (kbdStruct->vkCode == VK_LWIN) ||
            (kbdStruct->vkCode == VK_RWIN) ||
            (kbdStruct->vkCode == VK_R && (GetAsyncKeyState(VK_LWIN) & 0x8000))) {
            return 1; // Block the key
        }
    }
    return CallNextHookEx(g_keyboardHook, nCode, wParam, lParam);
}

void InstallHook() {
    g_keyboardHook = SetWindowsHookEx(WH_KEYBOARD_LL, KeyboardHook, NULL, 0); // Store the hook in the global variable
    MSG msg;
    while (GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
}

void Unhook() {
    UnhookWindowsHookEx(g_keyboardHook); // Unhook when needed
}

int main() {
    InstallHook();
    return 0;
}