package com.example.solana_seed_vault

import android.content.Context
import android.net.Uri
import io.flutter.plugin.common.BinaryMessenger
import com.solana.solana_seed_vault.Api
import com.solana.solana_seed_vault.Api.BipLevelDto
import com.solanamobile.seedvault.*

class Bip32ApiHost : Api.Bip32ApiHost {
    private lateinit var context: Context

    fun init(binaryMessenger: BinaryMessenger, context: Context) {
        Api.Bip32ApiHost.setup(binaryMessenger, this)
        this.context = context
    }

    override fun fromUri(uri: String): MutableList<Api.BipLevelDto> {
        return Bip32DerivationPath.fromUri(Uri.parse(uri)).levels.map { convertToDto(it) }.toMutableList()
    }

    override fun toUri(levels: MutableList<Api.BipLevelDto>): String {
        var builder = Bip32DerivationPath.newBuilder()

        for (level in levels) {
            builder.appendLevel(convertToModel(level))
        }

        return builder.build().toUri().toString();
    }
}


class Bip44ApiHost : Api.Bip44ApiHost {
    private lateinit var context: Context

    fun init(binaryMessenger: BinaryMessenger, context: Context) {
        Api.Bip44ApiHost.setup(binaryMessenger, this)
        this.context = context
    }

    override fun fromUri(uri: String): Api.Bip44DerivationDto {
        var path = Bip44DerivationPath.fromUri(Uri.parse(uri))

        return Api.Bip44DerivationDto.Builder()
            .setAccount(convertToDto(path.account))
            .setAddressIndex(path.addressIndex?.let { convertToDto(it) })
            .setChange(path.change?.let { convertToDto(it) })
            .build()
    }

    override fun toUri(levels: Api.Bip44DerivationDto): String {
        return Bip44DerivationPath.newBuilder()
            .setAccount(convertToModel(levels.account!!))
            .setChange(levels.change?.let { convertToModel(it) })
            .setAddressIndex(levels.addressIndex?.let { convertToModel(it) })
            .build().toUri().toString()
    }
}

private fun convertToDto(model : BipLevel) : Api.BipLevelDto {
    return BipLevelDto.Builder().setHardened(model.hardened).setIndex(model.index.toLong()).build()
}

private fun convertToModel(dto : BipLevelDto) : BipLevel {
    return BipLevel(dto.index.toInt(), dto.hardened)
}