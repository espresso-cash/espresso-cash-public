package com.solana.solana_seed_vault.utils

import android.database.Cursor

object CursorSerializer {

    fun serialize(cursor: Cursor?): MutableList<MutableMap<String, Any>> {
        val list : MutableList<MutableMap<String, Any>> = mutableListOf()

        if (cursor == null) return list

        while(cursor.moveToNext()){
            val row = HashMap<String, Any>()

            val lastColumnIndex = cursor.columnCount - 1

            for (index in 0..lastColumnIndex) {
                val name = cursor.getColumnName(index)

                when (cursor.getType(index)) {
                    Cursor.FIELD_TYPE_STRING -> row[name] = cursor.getString(index)
                    Cursor.FIELD_TYPE_BLOB -> row[name] = cursor.getBlob(index)
                    Cursor.FIELD_TYPE_FLOAT -> row[name] = cursor.getFloat(index)
                    Cursor.FIELD_TYPE_INTEGER -> row[name] = cursor.getInt(index)
                    Cursor.FIELD_TYPE_NULL -> { }
                }
            }

            list.add(row)
    }

        return list
    }

}