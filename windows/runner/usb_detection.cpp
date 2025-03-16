#include "usb_detection.h"
#include <windows.h>
#include <setupapi.h>
#include <vector>
#include <string>
#include <iostream>

std::vector<std::pair<std::string, std::string>> GetConnectedUSBDevices() {
    std::vector<std::pair<std::string, std::string>> deviceList;

    HDEVINFO hDevInfo;
    SP_DEVINFO_DATA DeviceInfoData;
    DWORD i;

    // Get device list
    hDevInfo = SetupDiGetClassDevs(nullptr, L"USB", nullptr, DIGCF_PRESENT | DIGCF_ALLCLASSES);
    if (hDevInfo == INVALID_HANDLE_VALUE) {
        std::cerr << "❌ Error getting USB devices list." << std::endl;
        return deviceList;
    }

    // Enumerate devices
    DeviceInfoData.cbSize = sizeof(SP_DEVINFO_DATA);
    for (i = 0; SetupDiEnumDeviceInfo(hDevInfo, i, &DeviceInfoData); i++) {
        wchar_t deviceName[256];
        wchar_t deviceType[256];

        // Get device name
        if (SetupDiGetDeviceInstanceIdW(hDevInfo, &DeviceInfoData, deviceName, sizeof(deviceName) / sizeof(wchar_t), nullptr)) {
            std::wstring wstr(deviceName);
            std::string deviceStr(wstr.begin(), wstr.end()); // Convert WideString to std::string

            // Get device type
            if (SetupDiGetDeviceRegistryPropertyW(hDevInfo, &DeviceInfoData, SPDRP_CLASS, nullptr, (PBYTE)deviceType, sizeof(deviceType), nullptr)) {
                std::wstring typeWstr(deviceType);
                std::string typeStr(typeWstr.begin(), typeWstr.end());

                std::cout << "✅ Found USB Device: " << deviceStr << " (Type: " << typeStr << ")" << std::endl;
                deviceList.push_back({deviceStr, typeStr});
            } else {
                std::cout << "✅ Found USB Device: " << deviceStr << " (Type: Unknown)" << std::endl;
                deviceList.push_back({deviceStr, "Unknown"});
            }
        }
    }

    SetupDiDestroyDeviceInfoList(hDevInfo);
    return deviceList;
}
