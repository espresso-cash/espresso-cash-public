DART_TEST_DEFINITIONS=\
		 -DSOLANA_RPC_URL=${SOLANA_RPC_URL} \
		 -DSOLANA_WEBSOCKET_URL=${SOLANA_WEBSOCKET_URL}

FLUTTER_TEST_DEFINITIONS=\
		 --dart-define SOLANA_RPC_URL=${SOLANA_RPC_URL} \
		 --dart-define SOLANA_WEBSOCKET_URL=${SOLANA_WEBSOCKET_URL}

dump_schema:
ifndef VERSION
	$(error "VERSION must be set")
endif
	dart run drift_dev schema dump lib/data/db/db.dart moor_schemas/moor_schema_v$(VERSION).json

%:
	@$(MAKE) -f ../../Makefile $@

deps_graph_all:
	lakos lib -i "{**.freezed.dart,**.g.dart,storybook/**,data/**,di.config.dart,di.dart,gen/**,l10n/gen/**,routing.dart,di.dart,generated_plugin_registrant.dart}" --metrics > deps.dot

deps_graph_features:
	lakos lib/features -i "{**.freezed.dart,**.g.dart,**/src/**}" --metrics > features.dot

deps_cycles:
	python3 ./tool/cycles.py deps.dot --only-shortest

build_landing:
	flutter build web --web-renderer canvaskit --target lib/landing/main.dart //TODO check web-renderer