import 'package:aac/src/features/symbols/card/symbol_card_label.dart';
import 'package:aac/src/features/symbols/card/symbol_image.dart';
import 'package:aac/src/features/symbols/card/symbol_tap_actions.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/settings/widgets/color_picker.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isSymbolSelectedProvider =
    Provider.family.autoDispose<bool, int>((ref, id) {
  return ref
      .watch(selectedSymbolsProvider)
      .state
      .any((element) => element.id == id);
});

final selectedBorder = Border.all(
    color: AacColors.mainControlBackground,
    width: 3,
    strokeAlign: BorderSide.strokeAlignOutside);

class SymbolCard extends ConsumerWidget {
  const SymbolCard({
    super.key,
    required this.symbol,
    this.isDragging = false,
    this.onTapActions = const [],
  });

  final CommunicationSymbol symbol;
  final bool imageHasBackground = false;
  final bool isDragging;
  final List<SymbolTapAction> onTapActions;

  void _onTap(BuildContext context, WidgetRef ref) {
    for (var action in onTapActions) {
      action.execute(context, ref, symbol);
    }
  }

  BoxDecoration _buildBoxDecoration(bool isSelected, Color color) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      boxShadow: const [
        BoxShadow(
          color: AacColors.shadowPrimary,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
        BoxShadow(
          color: AacColors.shadowPrimary,
          spreadRadius: 1,
        ),
      ],
      border: isSelected || isDragging ? selectedBorder : null,
      color: color,
    );
  }

  Color _backgroundColor() {
    if (symbol.childBoardId == null) return Colors.white;
    if (symbol.color == null) return const Color(0xFFECECEC);
    return Color(
        colors.firstWhere((e) => e.code == symbol.color).folderBackgroundCode);
  }

  (Color labelBg, Color textColor) _labelColors() {
    if (symbol.color == null) return (AacColors.noColorWhite, Colors.black);
    return (Color(symbol.color!), Colors.white);
  }

  EdgeInsets _imagePadding() => imageHasBackground
      ? EdgeInsets.zero
      : const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0, bottom: 14.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(isSymbolSelectedProvider(symbol.id));
    final bgColor = _backgroundColor();
    final (labelBgColor, textColor) = _labelColors();

    return InkWell(
      onTap: () => _onTap(context, ref),
      child: IntrinsicHeight(
        child: Container(
          decoration: _buildBoxDecoration(isSelected, bgColor),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: _imagePadding(),
                child: SymbolImage(
                  symbol.imagePath,
                  height: 80,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SymbolCardLabel(
                  labelBgColor: labelBgColor,
                  symbol: symbol,
                  textColor: textColor),
            ],
          ),
        ),
      ),
    );
  }
}
