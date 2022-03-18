.PHONY: build test

excludeUnused := "{**.g.dart,**.freezed.dart,**.gen.dart,**/generated_plugin_registrant.dart}"

PROD_DEFINITIONS=--dart-define PROD=true --dart-define SENTRY_DSN="${SENTRY_DSN}"
DART_TEST_DEFINITIONS=\
		 -DLOCAL_TOKEN_LIST=true \
		 -DSOLANA_RPC_URL=${SOLANA_RPC_URL} \
		 -DSOLANA_WEBSOCKET_URL=${SOLANA_WEBSOCKET_URL}
FLUTTER_TEST_DEFINITIONS=\
		 --dart-define LOCAL_TOKEN_LIST=true \
		 --dart-define SOLANA_RPC_URL=${SOLANA_RPC_URL} \
		 --dart-define SOLANA_WEBSOCKET_URL=${SOLANA_WEBSOCKET_URL}

# CryptoPlease app rules

app_get:
	melos exec -c 1 --flutter -- "make get"

app_check_formatting:
	melos exec -c 1 --flutter -- "make format"

app_build:
	melos exec -c 1 --depends-on="build_runner" --flutter -- "make build"
	melos exec -c 1 --depends-on="drift_dev" --flutter -- "make generate_test_schemas"

app_analyze:
	melos exec -c 1 --flutter -- "make analyze"

app_test: app_build
	melos exec -c 1 --dir-exists="test" --flutter -- "make test"

app_test_solana:
	melos exec -c 1 --scope="cryptoplease" -- "make test_solana"

# Libs rules

libs_check_formatting:
	melos exec -c 1 --no-flutter -- dart pub get
	melos exec -c 1 --no-flutter -- dart format --set-exit-if-changed -o none .

libs_analyze:
	melos exec -c 1 --no-flutter -- "dart analyze --fatal-infos ."

libs_test:
	melos exec -c 1 --dir-exists="test" --no-flutter -- "dart run test --coverage=coverage"

libs_coverage:
	melos exec --scope="solana" -- dart run coverage:format_coverage -i coverage -o coverage/coverage.lcov --lcov --report-on=lib --packages=.packages
	melos exec --scope="solana" -- "remove_from_coverage -f coverage/coverage.lcov -r '\.(g|freezed)\.dart$$'"

# Other rules

check_unused_code_all:
	melos exec -c 1 -- "make check_unused_code"

flutter_image_build:
ifndef FLUTTER_VERSION
	$(error "FLUTTER_VERSION must be set")
endif
	docker build --tag ghcr.io/cryptoplease/flutter:${FLUTTER_VERSION} --build-arg flutter_version=${FLUTTER_VERSION} .

flutter_image_deploy:
ifndef FLUTTER_VERSION
	$(error "FLUTTER_VERSION must be set")
endif
	docker push ghcr.io/cryptoplease/flutter:${FLUTTER_VERSION}

# Rules that should be run in the package.

get:
	flutter pub get

format:
	flutter format -n --set-exit-if-changed .

build:
	flutter pub run build_runner build

generate_test_schemas:
	flutter pub run drift_dev schema generate moor_schemas test/generated/

analyze:
	flutter analyze --fatal-infos
	flutter pub run mews_pedantic:metrics analyze --fatal-style --fatal-performance --fatal-warnings lib

check_unused_code:
	flutter pub run mews_pedantic:metrics check-unused-code lib --fatal-unused --exclude=$(excludeUnused)
	flutter pub run mews_pedantic:metrics check-unused-files lib --fatal-unused --exclude=$(excludeUnused)

test:
	flutter test --exclude-tags solana

test_solana:
	dart run $(DART_TEST_DEFINITIONS) tool/tests_setup.dart
	flutter test $(FLUTTER_TEST_DEFINITIONS) --tags solana

test_e2e:
	flutter test integration_test/app_test.dart

firebase_e2e:
	cd android \
		&& ./gradlew app:assembleAndroidTest \
		&& ./gradlew app:assembleDebug -Ptarget=integration_test/app_test.dart

	gcloud firebase test android run \
		--type instrumentation \
		--app build/app/outputs/apk/debug/app-debug.apk \
		--test build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk \
		--timeout 5m \
		--device model=blueline,version=28,orientation=portrait

build_ios:
ifndef BUILD_NUMBER
	$(error "BUILD_NUMBER must be set")
endif
ifndef SENTRY_DSN
	$(error "SENTRY_DSN must be set")
endif
	flutter build ipa --build-number=$(BUILD_NUMBER) $(PROD_DEFINITIONS)

build_android:
ifndef BUILD_NUMBER
	$(error "BUILD_NUMBER must be set")
endif
ifndef SENTRY_DSN
	$(error "SENTRY_DSN must be set")
endif
	flutter build appbundle --build-number=$(BUILD_NUMBER) $(PROD_DEFINITIONS)
