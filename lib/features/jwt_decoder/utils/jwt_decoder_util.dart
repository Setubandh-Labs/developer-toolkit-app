import 'dart:convert';

class JwtDecoderUtil {
  static Map<String, dynamic> decode(
    String token,
  ) {
    final parts = token.split('.');

    if (parts.length != 3) {
      throw Exception('Invalid JWT');
    }

    final payload = parts[1];

    final normalized =
        base64Url.normalize(payload);

    final decoded = utf8.decode(
      base64Url.decode(normalized),
    );

    return jsonDecode(decoded);
  }
}