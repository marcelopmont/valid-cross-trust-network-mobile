import 'dart:convert';

Map<String, dynamic> decodeBase64ToMap(String? input) {
  final normalized = _normalizeBase64(input ?? '');
  final bytes = base64.decode(normalized);
  final jsonStr = utf8.decode(bytes);
  return json.decode(jsonStr);
}

String _normalizeBase64(String input) {
  var normalized = input.replaceAll('-', '+').replaceAll('_', '/');

  switch (normalized.length % 4) {
    case 2:
      normalized += '==';
      break;
    case 3:
      normalized += '=';
      break;
  }

  return normalized;
}
