#ifndef RUNNER_FLUTTER_WINDOW_H_
#define RUNNER_FLUTTER_WINDOW_H_

#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>

#include <memory>

#include "win32_window.h"

// Function to register method channels
void RegisterMethodChannels(flutter::FlutterEngine* engine);

// A window that hosts a Flutter view.
class FlutterWindow : public Win32Window {
public:
    explicit FlutterWindow(const flutter::DartProject& project);
    virtual ~FlutterWindow();

protected:
    bool OnCreate() override;
    void OnDestroy() override;
    LRESULT MessageHandler(HWND window, UINT message, WPARAM wparam, LPARAM lparam) noexcept override;

private:
    flutter::DartProject project_;
    std::unique_ptr<flutter::FlutterViewController> flutter_controller_;
};

#endif  // RUNNER_FLUTTER_WINDOW_H_
