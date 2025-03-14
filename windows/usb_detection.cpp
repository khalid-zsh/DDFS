#include "usb_detection.h"
#include <windows.h>
#include <setupapi.h>
#include <vector>
#include <string>

std::vector<std::string> GetConnectedUSBDevices() {
    std::vector<std::string> devices;
    HDEVINFO deviceInfo = SetupDiGetClassDevs(NULL, "USB", 0, DIGCF_PRESENT | DIGCF_ALLCLASSES);

    if (deviceInfo == INVALID_HANDLE_VALUE) return devices;

    SP_DEVINFO_DATA deviceData;
    deviceData.cbSize = sizeof(SP_DEVINFO_DATA);

    for (int i = 0; SetupDiEnumDeviceInfo(deviceInfo, i, &deviceData); i++) {
        char deviceName[256];
        SetupDiGetDeviceRegistryProperty(deviceInfo, &deviceData, SPDRP_FRIENDLYNAME, NULL, (PBYTE)deviceName, sizeof(deviceName), NULL);
        devices.push_back(std::string(deviceName));
    }

    SetupDiDestroyDeviceInfoList(deviceInfo);
    return devices;
}
