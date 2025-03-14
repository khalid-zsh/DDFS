#include "flutter_window.h"
#include <optional>
#include "flutter/generated_plugin_registrant.h"
#include "flutter/dart_project.h"
#include "flutter/flutter_view_controller.h"
#include "flutter/method_channel.h"
#include "flutter/standard_method_codec.h"
#include <windows.h>
#include "usb_detection.h"

// Function to register method channels
void RegisterMethodChannels(flutter::FlutterEngine* engine) {
    auto channel = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            engine->messenger(), "com.ddfs/teamviewer", &flutter::StandardMethodCodec::GetInstance());

    channel->SetMethodCallHandler([](const flutter::MethodCall<flutter::EncodableValue>& call,
                                     std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
        if (call.method_name().compare("launchTeamViewer") == 0) {
            ShellExecute(0, L"open", L"C:\\Program Files (x86)\\TeamViewer\\TeamViewer.exe", nullptr, nullptr, SW_SHOW);
            result->Success();
        } else {
            result->NotImplemented();
        }
    });

    auto zoomChannel = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            engine->messenger(), "com.ddfs/zoom", &flutter::StandardMethodCodec::GetInstance());

    zoomChannel->SetMethodCallHandler([](const flutter::MethodCall<flutter::EncodableValue>& call,
                                         std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
        if (call.method_name().compare("launchZoom") == 0) {
            ShellExecute(0, L"open", L"https://zoom.us/join", nullptr, nullptr, SW_SHOW);
            result->Success();
        } else {
            result->NotImplemented();
        }
    });

    auto usbChannel = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            engine->messenger(), "com.ddfs/usb", &flutter::StandardMethodCodec::GetInstance());

    usbChannel->SetMethodCallHandler([](const flutter::MethodCall<flutter::EncodableValue>& call,
                                        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
        if (call.method_name().compare("getUSBDevices") == 0) {
            std::vector<std::string> devices = GetConnectedUSBDevices();
            std::vector<flutter::EncodableValue> resultList;
            for (const auto& device : devices) {
                resultList.push_back(flutter::EncodableValue(device));
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

    // The size here must match the window dimensions to avoid unnecessary surface
    // creation / destruction in the startup path.
    flutter_controller_ = std::make_unique<flutter::FlutterViewController>(
            frame.right - frame.left, frame.bottom - frame.top, project_);
    // Ensure that basic setup of the controller was successful.
    if (!flutter_controller_->engine() || !flutter_controller_->view()) {
        return false;
    }

    // Register plugins
    RegisterPlugins(flutter_controller_->engine());

    // Register method channels
    RegisterMethodChannels(flutter_controller_->engine());

    SetChildContent(flutter_controller_->view()->GetNativeWindow());

    flutter_controller_->engine()->SetNextFrameCallback([&]() {
        this->Show();
    });

    // Flutter can complete the first frame before the "show window" callback is
    // registered. The following call ensures a frame is pending to ensure the
    // window is shown. It is a no-op if the first frame hasn't completed yet.
    flutter_controller_->ForceRedraw();

    return true;
}

void FlutterWindow::OnDestroy() {
    if (flutter_controller_) {
        flutter_controller_ = nullptr;
    }

    Win32Window::OnDestroy();
}

LRESULT
FlutterWindow::MessageHandler(HWND hwnd, UINT const message,
                              WPARAM const wparam,
                              LPARAM const lparam) noexcept {
// Give Flutter, including plugins, an opportunity to handle window messages.
if (flutter_controller_) {
std::optional<LRESULT> result =
        flutter_controller_->HandleTopLevelWindowProc(hwnd, message, wparam,
                                                      lparam);
if (result) {
return *result;
}
}

switch (message) {
case WM_FONTCHANGE:
flutter_controller_->engine()->ReloadSystemFonts();
break;
default:
// Handle other messages here.
break;
}

return Win32Window::MessageHandler(hwnd, message, wparam, lparam);
}