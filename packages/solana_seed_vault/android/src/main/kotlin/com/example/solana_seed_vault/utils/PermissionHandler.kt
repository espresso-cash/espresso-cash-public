package com.example.solana_seed_vault.utils

import android.content.Context
import android.content.pm.PackageManager
import android.util.Log
import com.solana.solana_seed_vault.Api
import com.solanamobile.seedvault.WalletContractV1
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import java.util.concurrent.CompletableFuture


class PermissionHandler : PluginRegistry.RequestPermissionsResultListener, ActivityBindingMixin by ActivityBindingMixinImpl() {
    private lateinit var context: Context
    private lateinit var completable: CompletableFuture<Boolean>
    private lateinit var onPermission: () -> Unit

    companion object {
        private val TAG = PermissionHandler::class.simpleName
        private const val permission = WalletContractV1.PERMISSION_ACCESS_SEED_VAULT
        private const val REQUEST_PERMISSION = 98
    }

    fun init(onPermission: () -> Unit) {
        this.onPermission = onPermission
    }


    fun checkPermission(context: Context, result: Api.Result<Boolean>) {
        this.context = context
        whenBindingReady{ checkPermission(result, it)}
    }

    private fun checkPermission(result: Api.Result<Boolean>, binding : ActivityPluginBinding) {
        setupCompleter(result)
        if ( PackageManager.PERMISSION_GRANTED == context.checkSelfPermission(permission)) {
            completable.complete(true)
        } else {
            binding.activity.requestPermissions(arrayOf(permission), REQUEST_PERMISSION)
        }
    }

    private fun setupCompleter(result: Api.Result<Boolean>?) {
        completable = CompletableFuture()
        completable.whenComplete { granted, e ->
            if (granted != null){
                result?.success(granted)
                if (granted) onPermission()
            } else {
                result?.error(e)
            }
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ): Boolean {
        when (requestCode) {
            REQUEST_PERMISSION -> {
                val isGranted = grantResults.contains(PackageManager.PERMISSION_GRANTED)
                Log.d(TAG, "Requested permissions $permissions got $isGranted")
                completable.complete(isGranted)
                return true
            }
        }
        return false
    }

}
