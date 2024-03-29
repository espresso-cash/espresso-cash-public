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
