package com.solana.solana_mobile_client

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.plugin.common.PluginRegistry

class SolanaMobileClientPlugin : FlutterPlugin, ActivityAware by ApiLocalAssociationScenario,
    PluginRegistry.ActivityResultListener by ApiLocalAssociationScenario {
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Api.ApiLocalAssociationScenario.setup(
            flutterPluginBinding.binaryMessenger,
            ApiLocalAssociationScenario,
        )
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {

    }
}
