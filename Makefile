.PHONY: build test

excludeUnused := "{**.g.dart,**.freezed.dart,**.gen.dart,**/generated_plugin_registrant.dart}"

PROD_DEFINITIONS=--dart-define PROD=true --dart-define SENTRY_DSN="${SENTRY_DSN}"

flutter_image_build:
ifndef FLUTTER_VERSION
	$(error "FLUTTER_VERSION must be set")
endif
	docker build --tag ghcr.io/espresso-cash/flutter:${FLUTTER_VERSION} --build-arg flutter_version=${FLUTTER_VERSION} .

flutter_image_deploy:
ifndef FLUTTER_VERSION
	$(error "FLUTTER_VERSION must be set")
endif
	docker push ghcr.io/espresso-cash/flutter:${FLUTTER_VERSION}

activate_utils:
	dart pub global activate melos
	dart pub global activate lakos
	dart pub global activate remove_from_coverage

dart_get:
	dart pub get

dart_analyze:
	dart analyze --fatal-infos .
	dart pub run dart_code_metrics:metrics analyze --fatal-style --fatal-performance --fatal-warnings lib

dart_test:
	dart test

dart_coverage:
	dart run coverage:format_coverage -i coverage -o coverage/coverage.lcov --lcov --report-on=lib
	remove_from_coverage -f coverage/coverage.lcov -r "\.(g|freezed)\.dart$$"

flutter_get:
	flutter pub get

flutter_build:
	flutter pub run build_runner build --delete-conflicting-outputs

flutter_generate_test_schemas:
	flutter pub run drift_dev schema generate moor_schemas test/generated/

flutter_analyze:
	flutter analyze --fatal-infos
	flutter pub run dart_code_metrics:metrics analyze --fatal-style --fatal-performance --fatal-warnings lib

flutter_check_unused_code:
	flutter pub run dart_code_metrics:metrics check-unused-code lib --fatal-unused --exclude=$(excludeUnused)
	flutter pub run dart_code_metrics:metrics check-unused-files lib --fatal-unused --exclude=$(excludeUnused)

flutter_test:
	flutter test

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
