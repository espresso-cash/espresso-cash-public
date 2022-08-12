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

flutter_get:
	flutter pub get

flutter_build:
	flutter pub run build_runner build --delete-conflicting-outputs

flutter_generate_test_schemas:
	flutter pub run drift_dev schema generate moor_schemas test/generated/

flutter_analyze:
	flutter analyze --fatal-infos
	flutter pub run mews_pedantic:metrics analyze --fatal-style --fatal-performance --fatal-warnings lib

flutter_check_unused_code:
	flutter pub run mews_pedantic:metrics check-unused-code lib --fatal-unused --exclude=$(excludeUnused)
	flutter pub run mews_pedantic:metrics check-unused-files lib --fatal-unused --exclude=$(excludeUnused)

flutter_test:
	flutter test --exclude-tags solana

flutter_test_e2e:
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
