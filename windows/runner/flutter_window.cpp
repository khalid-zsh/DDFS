#include "flutter_window.h"
#include <optional>
#include "flutter/generated_plugin_registrant.h"
#include "flutter/dart_project.h"
#include "flutter/flutter_view_controller.h"
#include "flutter/method_channel.h"
#include "flutter/standard_method_codec.h"
#include <windows.h>
#include "usb_detection.h"

void RegisterMethodChannels(flutter::FlutterEngine* engine) {
    auto usbChannel = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            engine->messenger(), "com.ddfs/usb", &flutter::StandardMethodCodec::GetInstance());

    usbChannel->SetMethodCallHandler([](const flutter::MethodCall<flutter::EncodableValue>& call,
                                        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
        if (call.method_name().compare("getUSBDevices") == 0) {
            std::vector<std::pair<std::string, std::string>> usbDevices = GetConnectedUSBDevices();
            std::vector<flutter::EncodableValue> resultList;

            for (const auto& device : usbDevices) {
                flutter::EncodableMap deviceMap;
                deviceMap[flutter::EncodableValue("name")] = flutter::EncodableValue(device.first);
                deviceMap[flutter::EncodableValue("type")] = flutter::EncodableValue(device.second);
                resultList.push_back(flutter::EncodableValue(deviceMap));
            }

            result->Success(flutter::EncodableValue(resultList));
        } else {
            result->NotImplemented();
        }
    });
}

FlutterWindow::FlutterWindow(const flutter::DartProject& project)
        : project_(project) {}

FlutterWindow::~FlutterWindow() {}

bool FlutterWindow::OnCreate() {
    if (!Win32Window::OnCreate()) {
        return false;
    }

    RECT frame = GetClientArea();

    flutter_controller_ = std::make_unique<flutter::FlutterViewController>(
            frame.right - frame.left, frame.bottom - frame.top, project_);

    if (!flutter_controller_->engine() || !flutter_controller_->view()) {
        return false;
    }

    RegisterPlugins(flutter_controller_->engine());
    RegisterMethodChannels(flutter_controller_->engine());

    SetChildContent(flutter_controller_->view()->GetNativeWindow());

    flutter_controller_->engine()->SetNextFrameCallback([&]() {
        this->Show();
    });

    flutter_controller_->ForceRedraw();

    return true;
}

void FlutterWindow::OnDestroy() {
    if (flutter_controller_) {
        flutter_controller_ = nullptr;
    }

    Win32Window::OnDestroy();
}

LRESULT FlutterWindow::MessageHandler(HWND hwnd, UINT message, WPARAM wparam, LPARAM lparam) noexcept {
if (flutter_controller_) {
std::optional<LRESULT> result = flutter_controller_->HandleTopLevelWindowProc(hwnd, message, wparam, lparam);
if (result) {
return *result;
}
}

switch (message) {
case WM_FONTCHANGE:
flutter_controller_->engine()->ReloadSystemFonts();
break;
default:
break;
}

return Win32Window::MessageHandler(hwnd, message, wparam, lparam);
}