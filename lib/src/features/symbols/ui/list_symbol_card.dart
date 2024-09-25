import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:aac/src/features/symbols/ui/symbol_image.dart';
import 'package:aac/src/features/text_to_speech/provider.dart';
import 'package:aac/src/features/text_to_speech/tts_manager.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SymbolListTile extends ConsumerStatefulWidget {
  const SymbolListTile({super.key, required this.symbol, this.onTapActions = const [], this.onLongPressActions = const []});

  final CommunicationSymbol symbol;
  final bool imageHasBackground = false;
  final List<SymbolOnTapAction> onTapActions;
  final List<SymbolOnTapAction> onLongPressActions;

  BoxDecoration buildBoxDecoration(WidgetRef ref) {
    final isSelected = ref
      .watch(selectedSymbolsProvider)
      .state
      .any((element) => element.id == symbol.id);

    return BoxDecoration(
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
  }

  @override
  ConsumerState<SymbolListTile> createState() => _SymbolListTileState();
}

class _SymbolListTileState extends ConsumerState<SymbolListTile> {
  bool _isExpanded = false;
  List<CommunicationSymbol> _childSymbols = [];

  bool get isExpanded => _isExpanded;

  @override
  void initState() {
    super.initState();
    if (widget.symbol.childBoard.value != null) {
      _loadChildSymbols();
    }
  }

  bool _hasChildSymbolsInBin() {
    final childBoard = widget.symbol.childBoard.value;
    if (childBoard != null) {
      return childBoard.symbols.any(
        (child) => child.childBoard.value == null && child.isDeleted == true
      );
    }
    return false;
  }
  Future<void> _loadChildSymbols() async {
    final childBoard = widget.symbol.childBoard.value;
    if (childBoard != null) {
      final childSymbols = childBoard.symbols
          .where((child) => child.childBoard.value == null && child.isDeleted == true) // Only load non-folder children
          .toList();
      // delayed call of setState() after build
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _childSymbols = childSymbols;
          });
        }
      });
    }
  }

  void _onLongPress(BuildContext context, WidgetRef ref) {
    if (ref.read(isParentModeProvider) &&
        widget.onLongPressActions.contains(SymbolOnTapAction.select)) {
      ref.read(selectedSymbolsProvider).toggle(widget.symbol);
    }
  }

  void _onTap(BuildContext context, WidgetRef ref) {
    final isParentMode = ref.read(isParentModeProvider);

    if (widget.onTapActions.contains(SymbolOnTapAction.multiselect) &&
        ref.read(areSymbolsSelectedProvider)) {
      ref.read(selectedSymbolsProvider).toggle(widget.symbol);
      return;
    }

    if (isParentMode && widget.onTapActions.contains(SymbolOnTapAction.select)) {
      ref.read(selectedSymbolsProvider).toggle(widget.symbol);
    }

    if (widget.onTapActions.contains(SymbolOnTapAction.speak)) {
      ref.read(ttsManagerProvider).sayWord(widget.symbol);

      if (!isParentMode) {
        ref.read(sentenceNotifierProvider.notifier).addWord(widget.symbol);
      }
    }

    if (widget.onTapActions.contains(SymbolOnTapAction.cd) &&
        widget.symbol.childBoard.value != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BoardScreen(
                  title: widget.symbol.label,
                  boardId: widget.symbol.childBoard.value!.id,
                )),
      );
    }

    if (widget.onTapActions.contains(SymbolOnTapAction.listChild) && widget.symbol.childBoard.value != null ) {
      if (_hasChildSymbolsInBin()) {
        _isExpanded = !_isExpanded;
      }
      setState(() {
        if (_isExpanded) {
          _loadChildSymbols();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    // EdgeInsets imagePadding;

    if (widget.symbol.color == null) {
      bgColor = AacColors.noColorWhite;
      textColor = Colors.black;
    } else {
      bgColor = Color(widget.symbol.color!);
      textColor = Colors.white;
    }

    // imagePadding = widget.imageHasBackground
    //     ? const EdgeInsets.all(0)
    //     : const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0, bottom: 14.0);

    final child = Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 40.0),
            child: Row(
              children: [
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Center(
                    child: SymbolImage(widget.symbol.imagePath),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.symbol.label,
                    style: const TextStyle(color: Colors.black),
                    maxLines: null,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 40.0,
            decoration: BoxDecoration(
              color: bgColor,
            ),
            child: _hasChildSymbols()
              ? _triangleIcon(isExpanded, textColor)
              : null,
          ),
        ),
      ],
    );

    final mainContent = InkWell(
      onLongPress: () => _onLongPress(context, ref),
      onTap: () => _onTap(context, ref),
      child: IntrinsicHeight(
        child: Container(
          decoration: widget.buildBoxDecoration(ref),
          clipBehavior: Clip.hardEdge,
          child: child,
        ),
      ),
    );

      return Consumer(
        builder: (context, ref, child) {
          if (widget.symbol.childBoard.value != null) {
            if (widget.symbol.isDeleted) {
              _loadChildSymbols();
            } else {
              _isExpanded = false;
              _childSymbols.clear();
            }
          }
          return Column(
            children: [
              mainContent,
              if (_isExpanded && _childSymbols.isNotEmpty)
                Column(
                  children: _childSymbols
                      .map((symbol) => Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: SymbolListTile(
                              symbol: symbol,
                              onTapActions: widget.onTapActions,
                              onLongPressActions: widget.onLongPressActions,
                            ),
                          ))
                      .toList(),
                ),
            ],
          );
        },
      );

  }

  bool _hasChildSymbols() {
    return widget.symbol.childBoard.value != null;
  }

  Widget _triangleIcon(bool isExpanded, Color textColor) {
    return RotatedBox(
      quarterTurns: 2,
      child: Icon(
        Icons.play_arrow,
        size: 20.0,
        color: textColor,
      ),
    );
  }
}
