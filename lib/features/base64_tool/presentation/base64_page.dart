import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/base64_provider.dart';
import '../utils/base64_util.dart';

class Base64Page extends ConsumerStatefulWidget {
  const Base64Page({super.key});

  @override
  ConsumerState<Base64Page> createState() => _Base64PageState();
}

class _Base64PageState extends ConsumerState<Base64Page> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final output = ref.watch(base64OutputProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Base64 Encoder/Decoder'),
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
                hintText: 'Enter text or Base64 value',
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _encode,
                    child: const Text('Encode'),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: _decode,
                    child: const Text('Decode'),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton(
                    onPressed: _clear,
                    child: const Text('Clear'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(output),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: output.isEmpty ? null : _copy,
                child: const Text('Copy'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _encode() {
    try {
      final result = Base64Util.encode(
        _controller.text,
      );

      ref
          .read(base64OutputProvider.notifier)
          .state = result;
    } catch (_) {
      _showError('Encoding failed');
    }
  }

  void _decode() {
    try {
      final result = Base64Util.decode(
        _controller.text,
      );

      ref
          .read(base64OutputProvider.notifier)
          .state = result;
    } catch (_) {
      _showError('Invalid Base64');
    }
  }

  void _clear() {
    _controller.clear();

    ref
        .read(base64OutputProvider.notifier)
        .state = '';
  }

  void _copy() {
    final output =
        ref.read(base64OutputProvider);

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

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}