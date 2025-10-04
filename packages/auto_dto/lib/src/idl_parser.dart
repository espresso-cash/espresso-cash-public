import 'dart:convert';
import 'dart:io';

import 'package:auto_dto/src/dto_info.dart';

class IdlParser {
  Future<List<DtoInfo>> parse(String path) async {
    final file = File(path);
    final content = await file.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;

    final accounts = json['accounts'] as List<dynamic>;
    final dtos = <DtoInfo>[];

    for (final account in accounts) {
      final accountMap = account as Map<String, dynamic>;
      final name = accountMap['name'] as String;
      final type = accountMap['type'] as Map<String, dynamic>;
      final kind = type['kind'] as String;

      if (kind == 'struct') {
        final fields = (type['fields'] as List<dynamic>)
            .map((field) {
              final fieldMap = field as Map<String, dynamic>;
              return FieldInfo(
                name: fieldMap['name'] as String,
                type: fieldMap['type'] as String,
              );
            })
            .toList();

        dtos.add(DtoInfo(name: name, fields: fields));
      }
    }

    return dtos;
  }
}
