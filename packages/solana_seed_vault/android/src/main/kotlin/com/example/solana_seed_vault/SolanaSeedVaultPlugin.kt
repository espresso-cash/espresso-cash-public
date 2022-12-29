package com.example.solana_seed_vault

import androidx.annotation.NonNull
import com.example.solana_seed_vault.utils.PermissionHandler
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding


/** SolanaSeedVaultPlugin */
class SolanaSeedVaultPlugin : FlutterPlugin, ActivityAware {
    private lateinit var walletApiHost: WalletApiHost;
    private lateinit var permissionHandler: PermissionHandler;

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val context = flutterPluginBinding.applicationContext
        val messenger = flutterPluginBinding.binaryMessenger
        val changeNotifier = ChangeNotifier(messenger)

        walletApiHost = WalletApiHost(context)
        walletApiHost.init(messenger)
        permissionHandler =
            PermissionHandler { changeNotifier.observeSeedVaultContentChanges(context) }

        Bip32ApiHost().init(messenger)
        Bip44ApiHost().init(messenger)
        SeedVaultApiHost(context, permissionHandler).init(messenger)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        walletApiHost.setActivity(binding)
        permissionHandler.setActivity(binding)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        walletApiHost.setActivity(binding)
        permissionHandler.setActivity(binding)
    }

    override fun onDetachedFromActivity() = Unit

    override fun onDetachedFromActivityForConfigChanges() = Unit

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) = Unit
}
