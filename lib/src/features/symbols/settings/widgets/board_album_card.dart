import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/database/daos/child_communication_symbol_dao.dart';
import 'package:aac/src/features/symbols/card/symbol_image.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// First symbol images of a board and its total symbol count.
typedef BoardPreview = (List<String> images, int symbolCount);

final boardPreviewProvider =
    FutureProvider.autoDispose.family<BoardPreview, int>((ref, boardId) async {
  final symbols =
      await ref.watch(childSymbolDaoProvider).findByBoardId(boardId, false);

  return (symbols.map((e) => e.imagePath).take(4).toList(), symbols.length);
});

Color _tileColor(BuildContext context) =>
    Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.06);

/// Rounded square shortcut tile with a caption below, in the style of
/// gallery "create album" actions.
class BoardActionTile extends StatelessWidget {
  const BoardActionTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: _tileColor(context),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Icon(icon,
                size: 22, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 88,
            height: 2 * textTheme.bodyMedium!.fontSize! * 1.4,
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall?.copyWith(
                  height: 1.4,
                  color: textTheme.bodyMedium?.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Collage of up to four board symbol images, like an album cover.
class BoardCoverCollage extends StatelessWidget {
  const BoardCoverCollage({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Container(
        color: _tileColor(context),
        alignment: Alignment.center,
        child: Icon(Icons.apps_outlined,
            size: 32, color: Theme.of(context).colorScheme.primary),
      );
    }

    if (images.length == 1) {
      return SymbolImage(images.first, fit: BoxFit.cover);
    }

    final rows = <List<String>>[];
    for (var i = 0; i < images.length; i += 2) {
      rows.add(images.skip(i).take(2).toList());
    }

    return Column(
      children: [
        for (final row in rows)
          Expanded(
            child: Row(
              children: [
                for (final image in row)
                  Expanded(
                    child: SymbolImage(image, fit: BoxFit.cover),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Fixed size album tile with the board cover and name below, used in rows.
class BoardAlbumTile extends ConsumerWidget {
  const BoardAlbumTile({
    super.key,
    required this.name,
    this.boardId,
    this.onTap,
    this.onDelete,
  });

  final String name;
  final int? boardId;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preview =
        boardId == null ? null : ref.watch(boardPreviewProvider(boardId!)).value;

    final tile = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 96,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 96,
              decoration: BoxDecoration(
                color: _tileColor(context),
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.hardEdge,
              child: BoardCoverCollage(images: preview?.$1 ?? const []),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );

    if (onDelete == null) return tile;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        tile,
        Positioned(
          top: -6,
          right: -6,
          child: InkWell(
            onTap: onDelete,
            customBorder: const CircleBorder(),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AacColors.iconsGrey,
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.close, size: 14, color: AacColors.noColorWhite),
            ),
          ),
        ),
      ],
    );
  }
}

/// Album card for grids: cover collage, board name and symbol count. Styled
/// like SymbolCard (white card, soft shadow) to match the application UI.
class BoardAlbumCard extends ConsumerWidget {
  const BoardAlbumCard({
    super.key,
    required this.name,
    this.boardId,
    this.onTap,
    this.onLongPress,
  });

  final String name;
  final int? boardId;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preview =
        boardId == null ? null : ref.watch(boardPreviewProvider(boardId!)).value;
    final textTheme = Theme.of(context).textTheme;
    final symbolCount = preview?.$2 ?? 0;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(color: AacColors.noColorWhite),
                clipBehavior: Clip.hardEdge,
                child: BoardCoverCollage(images: preview?.$1 ?? const []),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 6, 6, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppLocalizations.of(context).symbolCount(symbolCount),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall
                        ?.copyWith(color: AacColors.iconsGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
