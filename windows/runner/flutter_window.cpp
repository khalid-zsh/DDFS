#include "flutter_window.h"
#include <optional>
#include "flutter/generated_plugin_registrant.h"
#include "flutter/dart_project.h"
#include "flutter/flutter_view_controller.h"
#include "flutter/method_channel.h"
#include "flutter/standard_method_codec.h"
#include <windows.h>
#include "usb_detection.h"
#include "teamviewer_plugin.h"

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

    auto teamViewerChannel = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            engine->messenger(), "com.ddfs/teamviewer", &flutter::StandardMethodCodec::GetInstance());

    teamViewerChannel->SetMethodCallHandler([](const flutter::MethodCall<flutter::EncodableValue>& call,
                                               std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
        if (call.method_name().compare("launchTeamViewer") == 0) {
            LaunchTeamViewer();
            result->Success();
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

    // ✅ Set windowed mode size: 1280 × 683
    const int windowWidth = 1280;
    const int windowHeight = 683;

    // ✅ Get screen resolution
    const int screenWidth = GetSystemMetrics(SM_CXSCREEN);
    const int screenHeight = GetSystemMetrics(SM_CYSCREEN);

    // ✅ Center the window
    int posX = (screenWidth - windowWidth) / 2;
    int posY = (screenHeight - windowHeight) / 2;

    flutter_controller_ = std::make_unique<flutter::FlutterViewController>(
            windowWidth, windowHeight, project_);

    if (!flutter_controller_->engine() || !flutter_controller_->view()) {
        return false;
    }

    RegisterPlugins(flutter_controller_->engine());
    RegisterMethodChannels(flutter_controller_->engine());


    HWND flutterWindowHandle = flutter_controller_->view()->GetNativeWindow();  // ✅ Get handle
    if (flutterWindowHandle) {
        SetChildContent(flutterWindowHandle);
    } else {
        std::cerr << "❌ Failed to attach Flutter view!" << std::endl;
        return false;
    }

    // ✅ Set initial window position
    SetWindowPos(GetHandle(), HWND_TOP, posX, posY, windowWidth, windowHeight, SWP_NOZORDER | SWP_FRAMECHANGED);

    flutter_controller_->engine()->SetNextFrameCallback([&]() {
        this->Show();
    });

    flutter_controller_->ForceRedraw();

    EnableFullScreen(); // Ensure EnableFullScreen() is called after setup

    return true;
}

void FlutterWindow::EnableFullScreen() {
    HWND hwnd = GetHandle(); // ✅ Get window handle

    if (hwnd) {
        // ✅ Remove window decorations and make it fixed-size
        SetWindowLong(hwnd, GWL_STYLE, GetWindowLong(hwnd, GWL_STYLE) & ~WS_OVERLAPPEDWINDOW);

        // ✅ Set fixed full-screen size: 1280 × 800
        int posX = (GetSystemMetrics(SM_CXSCREEN) - 1280) / 2;
        int posY = (GetSystemMetrics(SM_CYSCREEN) - 800) / 2;
        SetWindowPos(hwnd, HWND_TOP, posX, posY, 1280, 800, SWP_NOZORDER | SWP_FRAMECHANGED);

        ShowWindow(hwnd, SW_MAXIMIZE);// Force full-screen mode
        SetForegroundWindow(hwnd);
        SetFocus(hwnd);

        std::cout << "✅ Full-screen mode set to 1280 × 800" << std::endl;
    } else {
        std::cout << "❌ Failed to get window handle" << std::endl;
    }
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
