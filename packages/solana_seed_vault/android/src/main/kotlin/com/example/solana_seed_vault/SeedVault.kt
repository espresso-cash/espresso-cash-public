package com.example.solana_seed_vault

import android.content.Context
import android.os.Build
import androidx.annotation.RequiresApi
import com.example.solana_seed_vault.utils.PermissionHandler
import com.solana.solana_seed_vault.Api
import com.solanamobile.seedvault.*
import io.flutter.plugin.common.BinaryMessenger


class SeedVaultApiHost(
    private val context: Context,
    private val permissionHandler: PermissionHandler
) : Api.SeedVaultApiHost {

    fun init(binaryMessenger: BinaryMessenger) {
        Api.SeedVaultApiHost.setup(binaryMessenger, this)
    }

    @RequiresApi(Build.VERSION_CODES.M)
    override fun isAvailable(allowSimulated: Boolean): Boolean {
        return SeedVault.isAvailable(context, allowSimulated)
    }

    override fun checkPermission(result: Api.Result<Boolean>?) {
        if (result == null) return
        permissionHandler.checkPermission(context, result)
    }

}
