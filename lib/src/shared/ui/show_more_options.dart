import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<T?> showMoreOptions<T>(
    BuildContext context, Widget Function(BuildContext context) builder) {
  return showModalBottomSheet<T?>(
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: builder,
  );
}

class ShowMoreOptions extends ConsumerWidget {
  const ShowMoreOptions({super.key, required this.builder});

  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: () => showMoreOptions(context, builder),
        icon: const Icon(Icons.more_vert));
  }
}
