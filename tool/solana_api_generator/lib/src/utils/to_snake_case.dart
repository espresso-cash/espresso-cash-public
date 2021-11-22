String toSnakeCase(String base) => base
    .replaceAllMapped(RegExp(r'(?<=[a-z])[A-Z]'), (m) => '_${m.group(0)}')
    .toLowerCase();
