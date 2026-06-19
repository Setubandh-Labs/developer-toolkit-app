import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/jwt_provider.dart';
import '../utils/jwt_decoder_util.dart';

class JwtDecoderPage extends ConsumerStatefulWidget {
  const JwtDecoderPage({super.key});

  @override
  ConsumerState<JwtDecoderPage> createState() =>
      _JwtDecoderPageState();
}

class _JwtDecoderPageState
    extends ConsumerState<JwtDecoderPage> {
  final TextEditingController _controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final output =
        ref.watch(jwtOutputProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('JWT Decoder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 8,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    'Paste JWT token here',
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _decodeJwt,
                child: const Text(
                  'Decode',
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius:
                      BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    output,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed:
                    output.isEmpty ? null : _copy,
                child: const Text('Copy'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _decodeJwt() {
    try {
      final decoded =
          JwtDecoderUtil.decode(
        _controller.text,
      );

      const encoder =
          JsonEncoder.withIndent('  ');

      ref
          .read(jwtOutputProvider.notifier)
          .state = encoder.convert(
        decoded,
      );
    } catch (_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text('Invalid JWT Token'),
        ),
      );
    }
  }

  void _copy() {
    final output =
        ref.read(jwtOutputProvider);

    Clipboard.setData(
      ClipboardData(text: output),
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Copied to clipboard',
        ),
      ),
    );
  }
}