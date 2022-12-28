package com.example.solana_seed_vault

import android.content.Context
import android.database.ContentObserver
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.util.Log
import com.solana.solana_seed_vault.Api
import com.solanamobile.seedvault.WalletContractV1
import io.flutter.plugin.common.BinaryMessenger

class ChangeNotifier(
    binaryMessenger: BinaryMessenger,
) {
    private val api = Api.SeedVaultFlutterApi(binaryMessenger)
    private lateinit var context: Context

    companion object {
        private val TAG = ChangeNotifier::class.simpleName
    }

    fun init(context: Context) {
        this.context = context
        observeSeedVaultContentChanges()
    }

    private fun observeSeedVaultContentChanges() {
        val application = context.applicationContext
        application.contentResolver.registerContentObserver(
            WalletContractV1.WALLET_PROVIDER_CONTENT_URI_BASE,
            true,
            object : ContentObserver(Handler(application.mainLooper)) {
                override fun onChange(selfChange: Boolean, uris: Collection<Uri>, flags: Int) {
                    Handler(Looper.getMainLooper()).post { api.onChangeNotified(uris.map { it.toString() }, flags.toLong()) {} }
                    Log.d(
                        TAG,
                        "Received change notification for $uris (flags=$flags)"
                    )
                }
            }
        )
    }
}

