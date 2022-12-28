package com.example.solana_seed_vault

import android.content.Context
import android.os.Build
import io.flutter.plugin.common.BinaryMessenger
import androidx.annotation.RequiresApi
import com.example.solana_seed_vault.utils.PermissionHandler
import com.solana.solana_seed_vault.Api
import com.solanamobile.seedvault.*


class SeedVaultApiHost() :  Api.SeedVaultApiHost {
    private lateinit var context: Context
    private lateinit var handler: PermissionHandler

    fun init(binaryMessenger: BinaryMessenger, context: Context, handler: PermissionHandler) {
        Api.SeedVaultApiHost.setup(binaryMessenger, this)
        this.context = context
        this.handler = handler
    }

    @RequiresApi(Build.VERSION_CODES.M)
    override fun isAvailable(allowSimulated: Boolean): Boolean {
        return SeedVault.isAvailable(context, allowSimulated)
    }

    override fun checkPermission(result: Api.Result<Boolean>?) {
        if (result == null) return
        handler.checkPermission(context, result)
    }

}
