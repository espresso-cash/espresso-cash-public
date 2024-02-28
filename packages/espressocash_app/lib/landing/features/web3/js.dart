// ignore_for_file: inference_failure_on_untyped_parameter, strict_raw_type, inference_failure_on_function_invocation, avoid-recursive-calls, prefer-explicit-type-arguments

import 'package:js/js.dart'
    if (dart.library.io) 'package:webthree/src/browser/js_stub.dart'
    if (dart.library.js) 'package:js/js.dart';
import 'package:js/js_util.dart'
    if (dart.library.io) 'package:webthree/src/browser/js_util_stub.dart'
    if (dart.library.js) 'package:js/js_util.dart';

//Javascript object conversion
Object mapToJsObject(Map map) {
  final object = newObject();
  map.forEach((k, v) {
    if (v is Map) {
      setProperty(object as Object, k as Object, mapToJsObject(v));
    } else {
      setProperty(object as Object, k as Object, v);
    }
  });

  return object as Object;
}

Map jsObjectToMap(dynamic jsObject) {
  final Map result = {};
  final List keys = _objectKeys(jsObject);
  for (final dynamic key in keys) {
    final dynamic value = getProperty(jsObject as Object, key as Object);
    List nestedKeys = [];
    if (value is List) {
      nestedKeys = objectKeys(value);
    }
    if (nestedKeys.isNotEmpty) {
      //nested property
      result[key] = jsObjectToMap(value);
    } else {
      result[key] = value;
    }
  }

  return result;
}

List<String> objectKeys(dynamic jsObject) => _objectKeys(jsObject);

@JS('Object.keys')
external List<String> _objectKeys(jsObject);

@JS()
@anonymous
class JSrawRequestSwitchChainParams {
  // Must have an unnamed factory constructor with named arguments.
  external factory JSrawRequestSwitchChainParams({String chainId});
  external String get chainId;
}

@JS('JSON.stringify')
external String stringify(Object obj);
//javascript object conversion ends
