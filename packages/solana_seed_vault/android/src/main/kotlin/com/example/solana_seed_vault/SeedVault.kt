package com.example.solana_seed_vault

import android.content.Context
import android.content.Intent
import android.database.Cursor
import android.net.Uri
import android.os.Build
import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.BinaryMessenger
import java.lang.IllegalArgumentException
import android.util.Log
import androidx.annotation.RequiresApi
import com.solana.solana_seed_vault.Api
import com.solana.solana_seed_vault.Api.AccountDto
import com.solana.solana_seed_vault.Api.ImplementationLimitsDto
import com.solana.solana_seed_vault.Api.SeedDto
import com.solanamobile.seedvault.*
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.CompletableJob
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.util.concurrent.CompletableFuture

class SeedVaultApiHost :  Api.SeedVaultApiHost {
    private lateinit var context: Context


    fun init(binaryMessenger: BinaryMessenger, context: Context) {
        Api.SeedVaultApiHost.setup(binaryMessenger, this)
        this.context = context
    }


    @RequiresApi(Build.VERSION_CODES.M)
    override fun isAvailable(allowSimulated: Boolean): Boolean {
        return SeedVault.isAvailable(context, allowSimulated)
    }

    override fun checkPermission(): Boolean {
        //TODO: Implement it
        return true;
    }
}
