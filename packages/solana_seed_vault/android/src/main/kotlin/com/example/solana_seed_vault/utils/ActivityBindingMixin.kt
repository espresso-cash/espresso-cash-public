package com.example.solana_seed_vault.utils

import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import java.util.concurrent.CompletableFuture

interface ActivityBindingMixin {
    fun setActivity(activity: ActivityPluginBinding)

    fun whenBindingReady(callback: (ActivityPluginBinding) -> (Unit))
}

class ActivityBindingMixinImpl : ActivityBindingMixin {

    private var bindingCompletable: CompletableFuture<ActivityPluginBinding> = CompletableFuture()

    override fun setActivity(activity: ActivityPluginBinding) {
        bindingCompletable.complete(activity)
    }

    override fun whenBindingReady(callback: (ActivityPluginBinding) -> (Unit)){
        if (bindingCompletable.isDone){
            callback(bindingCompletable.get())
        } else {
            bindingCompletable.whenComplete{b, _ -> callback(b)}
        }
    }
}
