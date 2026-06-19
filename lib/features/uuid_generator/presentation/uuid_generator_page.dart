import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../providers/uuid_provider.dart';

class UuidGeneratorPage extends ConsumerWidget {
  const UuidGeneratorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uuidValue = ref.watch(uuidProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('UUID Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                uuidValue.isEmpty
                    ? 'Press Generate UUID'
                    : uuidValue,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  const uuid = Uuid();

                  ref
                      .read(uuidProvider.notifier)
                      .state = uuid.v4();
                },
                child: const Text(
                  'Generate UUID',
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: uuidValue.isEmpty
                    ? null
                    : () async {
                        await Clipboard.setData(
                          ClipboardData(
                            text: uuidValue,
                          ),
                        );

                        if (context.mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Copied to clipboard',
                              ),
                            ),
                          );
                        }
                      },
                child: const Text('Copy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}