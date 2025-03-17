#include "usb_detection.h"
#include <windows.h>
#include <setupapi.h>
#include <devguid.h>
#include <regstr.h>
#include <vector>
#include <iostream>
#include <algorithm>  // Include for std::max
#include <string>     // Include for std::wstring

#pragma comment(lib, "setupapi.lib")

std::string GetDeviceProperty(HDEVINFO deviceInfoSet, SP_DEVINFO_DATA deviceInfoData, DWORD property) {
    DWORD requiredSize = 0;
    DWORD dataType;

    // Get required size first
    if (!SetupDiGetDeviceRegistryProperty(deviceInfoSet, &deviceInfoData, property, &dataType, nullptr, 0, &requiredSize)) {
        if (GetLastError() != ERROR_INSUFFICIENT_BUFFER) {
            std::cout << "Property retrieval failed or size is zero. Property: " << property << " Error: " << GetLastError() << std::endl;
            return "Unknown";
        }
    }

    // Increase buffer size
    DWORD bufferSize = std::max<DWORD>(requiredSize, 1024);  // Set minimum buffer size to 1024
    std::vector<BYTE> buffer(bufferSize);

    if (!SetupDiGetDeviceRegistryProperty(deviceInfoSet, &deviceInfoData, property, &dataType, buffer.data(), bufferSize, &requiredSize)) {
        std::cout << "Failed to retrieve property. Property: " << property << " Error: " << GetLastError() << std::endl;
        return "Unknown";
    }

    if (dataType == REG_SZ) {
        // Convert WCHAR to string and trim trailing null characters
        std::wstring wstr(reinterpret_cast<WCHAR*>(buffer.data()));
        std::string result(wstr.begin(), wstr.end());
        result.erase(std::find(result.begin(), result.end(), '\0'), result.end());  // Remove trailing null characters
        std::cout << "Retrieved Property: " << result << " Property: " << property << std::endl;  // Debug output
        return result;
    } else {
        std::cout << "Property is not a string. Property: " << property << " Data Type: " << dataType << std::endl;
        return "Unknown";
    }
}

std::vector<std::pair<std::string, std::string>> GetConnectedUSBDevices() {
    std::vector<std::pair<std::string, std::string>> devices;

    HDEVINFO deviceInfoSet = SetupDiGetClassDevs(nullptr, L"USB", nullptr, DIGCF_PRESENT | DIGCF_ALLCLASSES);  // Use wide-character string
    if (deviceInfoSet == INVALID_HANDLE_VALUE) {
        std::cout << "Error: Failed to get device info set." << std::endl;
        return devices;
    }

    SP_DEVINFO_DATA deviceInfoData;
    deviceInfoData.cbSize = sizeof(SP_DEVINFO_DATA);

    for (DWORD i = 0; SetupDiEnumDeviceInfo(deviceInfoSet, i, &deviceInfoData); i++) {
        // Try Friendly Name first
        std::string name = GetDeviceProperty(deviceInfoSet, deviceInfoData, SPDRP_FRIENDLYNAME);

        if (name == "Unknown" || name.empty()) {
            // Fallback to Device Description
            name = GetDeviceProperty(deviceInfoSet, deviceInfoData, SPDRP_DEVICEDESC);
        }

        // Always check the type
        std::string type = GetDeviceProperty(deviceInfoSet, deviceInfoData, SPDRP_CLASS);
        if (type.empty()) type = "Unknown";

        // Debug log the values
        std::cout << "DEBUG: Device Name: [" << name << "] Type: [" << type << "]" << std::endl;

        devices.push_back({name, type});
    }

    SetupDiDestroyDeviceInfoList(deviceInfoSet);
    return devices;
}