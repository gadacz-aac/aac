import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/ui/symbol_image.dart';
import 'package:aac/src/features/text_to_speech/provider.dart';
import 'package:aac/src/features/text_to_speech/tts_manager.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SymbolOnTapAction { select, multiselect, speak, speakAndBuildSentence, cd }
// this ^ gets out of hand already it's bout to get more and more complex
// someone figure a better way to handle this bs
// - Piotrek

class SymbolCard extends ConsumerWidget {
  const SymbolCard({
    super.key,
    required this.symbol,
    this.onTapActions = const [],
    this.onLongPressActions = const [],
  });

  final CommunicationSymbol symbol;
  final bool imageHasBackground = false;
  final List<SymbolOnTapAction> onTapActions;
  final List<SymbolOnTapAction> onLongPressActions;
  void _onLongPress(BuildContext context, WidgetRef ref) {
    if (ref.read(isParentModeProvider) &&
        onLongPressActions.contains(SymbolOnTapAction.select)) {
      ref.read(selectedSymbolsProvider).toggle(symbol);
    }
  }

  void _onTap(BuildContext context, WidgetRef ref) {
    final isParentMode = ref.read(isParentModeProvider);

    if (onTapActions.contains(SymbolOnTapAction.multiselect) &&
        ref.read(areSymbolsSelectedProvider)) {
      ref.read(selectedSymbolsProvider).toggle(symbol);
      return;
    }

    if (isParentMode && onTapActions.contains(SymbolOnTapAction.select)) {
      ref.read(selectedSymbolsProvider).toggle(symbol);
    }

    if (onTapActions.contains(SymbolOnTapAction.speak)) {
      ref.read(ttsManagerProvider).sayWord(symbol);

      if (!isParentMode) {
        ref.read(sentenceNotifierProvider.notifier).addWord(symbol);
      }
    }

    if (onTapActions.contains(SymbolOnTapAction.cd) &&
        symbol.childBoard.value != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BoardScreen(
                  title: symbol.label,
                  boardId: symbol.childBoard.value!.id,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color bgColor;
    Color textColor;

    if (symbol.color == null) {
      bgColor = AacColors.noColorWhite;
      textColor = Colors.black;
    } else {
      bgColor = Color(symbol.color!);
      textColor = Colors.white;
    }

    final isSelected = ref
        .watch(selectedSymbolsProvider)
        .state
        .any((element) => element.id == symbol.id);

    final imagePadding = imageHasBackground
        ? const EdgeInsets.all(0)
        : const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0, bottom: 14.0);

    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      boxShadow: const [
        BoxShadow(
          color: AacColors.shadowPrimary,
          blurRadius: 4,
          offset: Offset(0, 2),
          spreadRadius: 0,
        ),
        BoxShadow(
          color: AacColors.shadowPrimary,
          blurRadius: 0,
          offset: Offset(0, 0),
          spreadRadius: 1,
        )
      ],
      border: isSelected
          ? Border.all(
              color: AacColors.mainControlBackground,
              width: 3,
              strokeAlign: BorderSide.strokeAlignOutside)
          : null,
      color: Colors.white,
    );

    return InkWell(
        onLongPress: () => _onLongPress(context, ref),
        onTap: () => _onTap(context, ref),
        child: IntrinsicHeight(
          child: Container(
            decoration: boxDecoration,
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: imagePadding,
                  child: SymbolImage(symbol.imagePath,
                      height: 80, fit: BoxFit.fitHeight),
                ),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: AacColors.labelShadow,
                                blurRadius: 1,
                                spreadRadius: 4,
                                offset: Offset(0, 4))
                          ],
                          color: bgColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 6.0),
                        // alignment: Alignment.center,
                        child: Text(symbol.label,
                            textAlign: TextAlign.center,
                            textHeightBehavior: const TextHeightBehavior(
                                applyHeightToFirstAscent: true,
                                applyHeightToLastDescent: true,
                                leadingDistribution:
                                    TextLeadingDistribution.even),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .merge(TextStyle(
                                  // fontSize: 17.0,
                                  color: textColor,
                                  height: 1.25,
                                )))))
              ],
            ),
          ),
        ));
  }
}
