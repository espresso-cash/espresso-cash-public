include ../../Makefile

dump_schema:
ifndef VERSION
	$(error "VERSION must be set")
endif
	flutter pub run drift_dev schema dump lib/data/db.dart moor_schemas/moor_schema_v$(VERSION).json

splash:
	flutter pub run flutter_native_splash:create

update_tokens:
	dart run tool/update_token_list.dart
