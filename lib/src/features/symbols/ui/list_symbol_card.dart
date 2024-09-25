import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/ui/symbol_image.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SymbolListTile extends ConsumerStatefulWidget {
  const SymbolListTile({super.key, required this.symbol});

  final CommunicationSymbol symbol;
  final bool imageHasBackground = false;

  @override
  ConsumerState<SymbolListTile> createState() => _SymbolListTileState();
}

class _SymbolListTileState extends ConsumerState<SymbolListTile> {
  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;
  late final List<CommunicationSymbol> childSymbols;
  @override
  void initState() {
    super.initState();

    childSymbols = widget.symbol.childBoard.value?.symbols
        .where((child) =>
            child.childBoard.value == null &&
            child.isDeleted == true) // Only load non-folder children
        .toList() ?? [];
  }

  bool _hasChildSymbolsInBin() {
    final childBoard = widget.symbol.childBoard.value;
    if (childBoard != null) {
      return childBoard.symbols.any(
          (child) => child.childBoard.value == null && child.isDeleted == true);
    }
    return false;
  }

  void _onLongPress(BuildContext context, WidgetRef ref) {
    ref.read(selectedSymbolsProvider).toggle(widget.symbol);
  }

  void _onTap(BuildContext context, WidgetRef ref) {
    if (ref.read(areSymbolsSelectedProvider)) {
      ref.read(selectedSymbolsProvider).toggle(widget.symbol);
      return;
    }

    if (widget.symbol.childBoard.value != null) {
      if (_hasChildSymbolsInBin()) {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    if (widget.symbol.color == null) {
      bgColor = AacColors.noColorWhite;
      textColor = Colors.black;
    } else {
      bgColor = Color(widget.symbol.color!);
      textColor = Colors.white;
    }

    final isSelected = ref
        .watch(selectedSymbolsProvider)
        .state
        .any((element) => element.id == widget.symbol.id);

    final boxDecoration = BoxDecoration(
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

    final mainContent = InkWell(
      onLongPress: () => _onLongPress(context, ref),
      onTap: () => _onTap(context, ref),
      child: Container(
        decoration: boxDecoration,
        clipBehavior: Clip.hardEdge,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 40.0),
              child: Row(
                children: [
                  SymbolImage(
                    widget.symbol.imagePath,
                    width: 35,
                    height: 35,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.symbol.label,
                    style: const TextStyle(color: Colors.black),
                    maxLines: null,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 35,
              height: 35,
              child: ColoredBox(
                color: bgColor,
                child: _hasChildSymbolsInBin()
                    ? _triangleIcon(isExpanded, textColor)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        mainContent,
        if (_isExpanded && childSymbols.isNotEmpty)
          Column(
            children: childSymbols
                .map((symbol) => Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: SymbolListTile(
                        symbol: symbol,
                      ),
                    ))
                .toList(),
          ),
      ],
    );
  }

  Widget _triangleIcon(bool isExpanded, Color textColor) {
    return RotatedBox(
      quarterTurns: isExpanded ? 1 : 0,
      child: Icon(
        Icons.play_arrow,
        size: 20.0,
        color: textColor,
      ),
    );
  }
}
