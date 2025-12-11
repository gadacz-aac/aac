import 'package:flutter/material.dart';

class NoResultsScreen extends StatelessWidget {
  const NoResultsScreen(
      {super.key, required this.isLoading, this.title, this.subtitle});

  final String? title;
  final String? subtitle;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (isLoading) return const Spacer();
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 24.0,
                ),
                if (title != null)
                  Text(
                    title ?? "",
                    style: textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                if (subtitle != null)
                  Text(
                    subtitle ?? "",
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
