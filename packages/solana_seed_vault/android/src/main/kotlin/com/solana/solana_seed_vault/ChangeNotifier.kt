package com.solana.solana_seed_vault

import android.content.Context
import android.database.ContentObserver
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.util.Log
import com.solanamobile.seedvault.WalletContractV1
import io.flutter.plugin.common.BinaryMessenger

class ChangeNotifier(
    binaryMessenger: BinaryMessenger,
) {
    private val api = Api.SeedVaultFlutterApi(binaryMessenger)
    private var initialized = false

    companion object {
        private val TAG = ChangeNotifier::class.simpleName
    }


    fun observeSeedVaultContentChanges(context: Context) {
        if (initialized) return
        val application = context.applicationContext
        application.contentResolver.registerContentObserver(
            WalletContractV1.WALLET_PROVIDER_CONTENT_URI_BASE,
            true,
            object : ContentObserver(Handler(application.mainLooper)) {
                override fun onChange(selfChange: Boolean, uris: Collection<Uri>, flags: Int) {
                    Handler(Looper.getMainLooper()).post {
                        api.onChangeNotified(
                            uris.map { it.toString() },
                            flags.toLong()
                        ) {}
                    }
                    Log.d(
                        TAG,
                        "Received change notification for $uris (flags=$flags)"
                    )
                }
            }
        )
        initialized = true
    }
}

