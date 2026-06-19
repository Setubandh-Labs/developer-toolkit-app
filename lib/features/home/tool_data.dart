import '../json_formatter/presentation/json_formatter_page.dart';
import '../uuid_generator/presentation/uuid_generator_page.dart';
import '../base64_tool/presentation/base64_page.dart';
import '../jwt_decoder/presentation/jwt_decoder_page.dart';

import 'tool_item.dart';

const tools = [
  ToolItem(
    title: 'JSON Formatter',
    description: 'Format and validate JSON',
    page: JsonFormatterPage(),
  ),
  ToolItem(
    title: 'UUID Generator',
    description: 'Generate UUIDs instantly',
    page: UuidGeneratorPage(),
  ),
  ToolItem(
    title: 'Base64 Encoder/Decoder',
    description: 'Encode and decode Base64',
    page: Base64Page(),
  ),
  ToolItem(
    title: 'JWT Decoder',
    description: 'Inspect JWT payloads',
    page: JwtDecoderPage(),
  ),
];