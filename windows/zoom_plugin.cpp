#include <windows.h>

void LaunchZoom() {
    ShellExecute(0, "open", "https://zoom.us/join", "", 0, SW_SHOW);
}
