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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 84,
            width: 84,
            decoration: BoxDecoration(
              color: _tileColor(context),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon,
                size: 28, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 92,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
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

/// Album card for grids: cover collage, board name and symbol count.
class BoardAlbumCard extends ConsumerWidget {
  const BoardAlbumCard({
    super.key,
    required this.name,
    this.boardId,
    this.onTap,
  });

  final String name;
  final int? boardId;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preview =
        boardId == null ? null : ref.watch(boardPreviewProvider(boardId!)).value;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _tileColor(context),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: _tileColor(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.hardEdge,
                child: BoardCoverCollage(images: preview?.$1 ?? const []),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              "${preview?.$2 ?? ""}",
              style: textTheme.bodySmall
                  ?.copyWith(color: AacColors.iconsGrey),
            ),
          ],
        ),
      ),
    );
  }
}
