#include "usb_detection.h"
#include <windows.h>
#include <setupapi.h>
#include <vector>
#include <string>

std::string ConvertWStringToString(const std::wstring& wstr) {
    int size_needed = WideCharToMultiByte(CP_UTF8, 0, wstr.c_str(), -1, NULL, 0, NULL, NULL);
    std::string str(size_needed, 0);
    WideCharToMultiByte(CP_UTF8, 0, wstr.c_str(), -1, &str[0], size_needed, NULL, NULL);
    return str;
}

std::vector<std::string> GetConnectedUSBDevices() {
    std::vector<std::string> devices;
    HDEVINFO deviceInfo = SetupDiGetClassDevs(NULL, NULL, 0, DIGCF_PRESENT | DIGCF_ALLCLASSES);

    if (deviceInfo == INVALID_HANDLE_VALUE) return devices;

    SP_DEVINFO_DATA deviceData;
    deviceData.cbSize = sizeof(SP_DEVINFO_DATA);

    for (int i = 0; SetupDiEnumDeviceInfo(deviceInfo, i, &deviceData); i++) {
        wchar_t deviceName[256];
        if (SetupDiGetDeviceRegistryPropertyW(deviceInfo, &deviceData, SPDRP_FRIENDLYNAME, NULL, (PBYTE)deviceName, sizeof(deviceName), NULL)) {
            devices.push_back(ConvertWStringToString(deviceName)); // ✅ Safe conversion
        }
    }

    SetupDiDestroyDeviceInfoList(deviceInfo);
    return devices;
}
