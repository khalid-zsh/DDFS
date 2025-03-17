#include <windows.h>
#include "teamviewer_plugin.h"

void LaunchTeamViewer() {
    ShellExecute(0, L"open", L"C:\\Program Files (x86)\\TeamViewer\\TeamViewer.exe", nullptr, nullptr, SW_SHOW);
}