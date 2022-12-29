package com.solana.solana_seed_vault

import android.net.Uri
import com.solana.solana_seed_vault.Api.BipLevelDto
import com.solanamobile.seedvault.Bip32DerivationPath
import com.solanamobile.seedvault.Bip44DerivationPath
import com.solanamobile.seedvault.BipLevel
import io.flutter.plugin.common.BinaryMessenger

class Bip32ApiHost : Api.Bip32ApiHost {

    fun init(binaryMessenger: BinaryMessenger) {
        Api.Bip32ApiHost.setup(binaryMessenger, this)
    }

    override fun fromUri(uri: String): MutableList<BipLevelDto> {
        return Bip32DerivationPath.fromUri(Uri.parse(uri)).levels.map { convertToDto(it) }
            .toMutableList()
    }

    override fun toUri(levels: MutableList<BipLevelDto>): String {
        val builder = Bip32DerivationPath.newBuilder()

        for (level in levels) {
            builder.appendLevel(convertToModel(level))
        }

        return builder.build().toUri().toString();
    }
}


class Bip44ApiHost : Api.Bip44ApiHost {

    fun init(binaryMessenger: BinaryMessenger) {
        Api.Bip44ApiHost.setup(binaryMessenger, this)
    }

    override fun fromUri(uri: String): Api.Bip44DerivationDto {
        val path = Bip44DerivationPath.fromUri(Uri.parse(uri))

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

private fun convertToDto(model: BipLevel): BipLevelDto {
    return BipLevelDto.Builder().setHardened(model.hardened).setIndex(model.index.toLong()).build()
}

private fun convertToModel(dto: BipLevelDto): BipLevel {
    return BipLevel(dto.index.toInt(), dto.hardened)
}