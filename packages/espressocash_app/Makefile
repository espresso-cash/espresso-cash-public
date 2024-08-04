DART_TEST_DEFINITIONS=\
		 -DSOLANA_RPC_URL=${SOLANA_RPC_URL} \
		 -DSOLANA_WEBSOCKET_URL=${SOLANA_WEBSOCKET_URL}

FLUTTER_TEST_DEFINITIONS=\
		 --dart-define SOLANA_RPC_URL=${SOLANA_RPC_URL} \
		 --dart-define SOLANA_WEBSOCKET_URL=${SOLANA_WEBSOCKET_URL}

splash:
	dart run flutter_native_splash:create

update_tokens:
	dart run tool/update_token_list.dart

flutter_test:
	dart run $(DART_TEST_DEFINITIONS) tool/tests_setup.dart
	flutter test $(FLUTTER_TEST_DEFINITIONS)

%:
	@$(MAKE) -f ../../Makefile $@

deps_cycles:
	python3 ./tool/cycles.py deps.dot --only-shortest

deps_graph_all:
	lakos lib -i "{**.freezed.dart,**.g.dart,storybook/**,data/**,di.config.dart,di.dart,gen/**,l10n/gen/**,routing.dart,di.dart,generated_plugin_registrant.dart}" --metrics > deps.dot

deps_graph_features:
	dcm as lib/features --exclude="" --modules="/features/" > features.dot && python3 ./tool/cycles.py features.dot --only-shortest && echo "No cycles"
