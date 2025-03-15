#include "usb_detection.h"
#include <windows.h>
#include <setupapi.h>
#include <vector>
#include <string>
#include <iostream>

std::vector<std::string> GetConnectedUSBDevices() {
    std::vector<std::string> deviceList;

    HDEVINFO hDevInfo;
    SP_DEVINFO_DATA DeviceInfoData;
    DWORD i;

    // ✅ FIX: Convert "USB" to wide string (WCHAR)
    hDevInfo = SetupDiGetClassDevs(nullptr, L"USB", nullptr, DIGCF_PRESENT | DIGCF_ALLCLASSES);
    if (hDevInfo == INVALID_HANDLE_VALUE) {
        std::cerr << "❌ Error getting USB devices list." << std::endl;
        return deviceList;
    }

    // Enumerate devices
    DeviceInfoData.cbSize = sizeof(SP_DEVINFO_DATA);
    for (i = 0; SetupDiEnumDeviceInfo(hDevInfo, i, &DeviceInfoData); i++) {
        wchar_t deviceName[256];

        if (SetupDiGetDeviceInstanceIdW(hDevInfo, &DeviceInfoData, deviceName, sizeof(deviceName) / sizeof(wchar_t), nullptr)) {
            std::wstring wstr(deviceName);
            std::string deviceStr(wstr.begin(), wstr.end()); // Convert WideString to std::string

            std::cout << "✅ Found USB Device: " << deviceStr << std::endl;
            deviceList.push_back(deviceStr);
        }
    }

    SetupDiDestroyDeviceInfoList(hDevInfo);
    return deviceList;
}
