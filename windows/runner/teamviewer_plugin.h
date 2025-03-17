#ifndef FLUTTER_PLUGIN_TEAMVIEWER_PLUGIN_H_
#define FLUTTER_PLUGIN_TEAMVIEWER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

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

#endif  // FLUTTER_PLUGIN_TEAMVIEWER_PLUGIN_H_