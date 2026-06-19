import 'dart:convert';

class JsonFormatterUtil {
  static String format(String input) {
    final decoded = jsonDecode(input);

    const encoder = JsonEncoder.withIndent('  ');

    return encoder.convert(decoded);
  }
}