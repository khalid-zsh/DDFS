#include <windows.h>
#include <string>

void LaunchTeamViewer() {
    ShellExecute(0, "open", "C:\\Program Files (x86)\\TeamViewer\\TeamViewer.exe", "", 0, SW_SHOW);
}
