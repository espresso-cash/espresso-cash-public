package com.example.solana_seed_vault

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.util.Log
import com.solana.solana_seed_vault.Api
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import java.util.concurrent.CompletableFuture

class PermissionHandler : PluginRegistry.RequestPermissionsResultListener {
    private lateinit var context: Context
    private lateinit var binding: ActivityPluginBinding
    private lateinit var completable: CompletableFuture<Boolean>

    companion object {
        private val TAG = PermissionHandler::class.simpleName
        private const val REQUEST_PERMISSION = 98
    }

    fun setActivity(activity: ActivityPluginBinding) {
        this.binding = activity;
        binding.addRequestPermissionsResultListener(this)
    }

    fun checkPermission(context: Context, permission: String, result: Api.Result<Boolean>) {
        this.context = context
        val hasPermission =
            PackageManager.PERMISSION_GRANTED == context.checkSelfPermission(permission)

        setupCompleter(result)

        if (hasPermission) {
            completable.complete(true)
        } else {
            binding.activity.requestPermissions(arrayOf(permission), REQUEST_PERMISSION)
        }
    }


    private fun setupCompleter(result: Api.Result<Boolean>?) {
        completable = CompletableFuture()
        completable.whenComplete { r, e -> if (r != null) result?.success(r) else result?.error(e) }
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
