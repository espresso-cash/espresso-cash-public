package com.pleasecrypto.flutter

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class InstallReferrerReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        installReferrer = intent?.extras?.get("referrer") as? String ?: ""
    }

    companion object {
        var installReferrer: String = ""
            private set
    }
}