import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/json_formatter_provider.dart';
import '../utils/json_formatter_util.dart';

class JsonFormatterPage extends ConsumerStatefulWidget {
  const JsonFormatterPage({super.key});

  @override
  ConsumerState<JsonFormatterPage> createState() =>
      _JsonFormatterPageState();
}

class _JsonFormatterPageState
    extends ConsumerState<JsonFormatterPage> {
  final TextEditingController _controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final output =
        ref.watch(jsonOutputProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON Formatter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Paste JSON here',
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _formatJson,
                    child: const Text(
                      'Format JSON',
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton(
                    onPressed: _clear,
                    child: const Text(
                      'Clear',
                    ),
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

  void _formatJson() {
    try {
      final formatted =
          JsonFormatterUtil.format(
        _controller.text,
      );

      ref.read(
        jsonOutputProvider.notifier,
      ).state = formatted;
    } catch (_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Invalid JSON',
          ),
        ),
      );
    }
  }

  void _clear() {
    _controller.clear();

    ref.read(
      jsonOutputProvider.notifier,
    ).state = '';
  }

  void _copy() {
    final output =
        ref.read(jsonOutputProvider);

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