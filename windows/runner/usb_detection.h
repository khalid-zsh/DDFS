#ifndef USB_DETECTION_H
#define USB_DETECTION_H

#include <vector>
#include <string>

std::vector<std::pair<std::string, std::string>> GetConnectedUSBDevices();

#endif // USB_DETECTION_H
