import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/text_to_speech/provider.dart';
import 'package:aac/src/features/text_to_speech/tts_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultiSelectAction implements SymbolTapAction {
  @override
  void execute(
      BuildContext context, WidgetRef ref, CommunicationSymbol symbol) {
    if (ref.read(areSymbolsSelectedProvider)) {
      ref.read(selectedSymbolsProvider).toggle(symbol);
    }
  }
}

class NavigateToChildBoardAction implements SymbolTapAction {
  @override
  void execute(
      BuildContext context, WidgetRef ref, CommunicationSymbol symbol) {
    if (symbol.childBoardId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BoardScreen(boardId: symbol.childBoardId!),
        ),
      );
    }
  }
}

class SymbolSelectAction implements SymbolTapAction {
  @override
  void execute(
      BuildContext context, WidgetRef ref, CommunicationSymbol symbol) {
    ref.read(selectedSymbolsProvider).toggle(symbol);
  }
}

class SpeakAction implements SymbolTapAction {
  @override
  void execute(
      BuildContext context, WidgetRef ref, CommunicationSymbol symbol) {
    ref.read(ttsManagerProvider).sayWord(symbol);
    final isParentMode = ref.read(isParentModeProvider);
    if (!isParentMode) {
      ref.read(sentenceNotifierProvider.notifier).addWord(symbol);
    }
  }
}

abstract class SymbolTapAction {
  void execute(BuildContext context, WidgetRef ref, CommunicationSymbol symbol);
}
