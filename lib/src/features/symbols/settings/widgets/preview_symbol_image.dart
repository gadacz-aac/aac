import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/settings/screens/image_provider.dart';
import 'package:aac/src/features/symbols/settings/screens/symbol_settings.dart';
import 'package:aac/src/features/symbols/settings/widgets/color_picker.dart';
import 'package:aac/src/features/symbols/ui/grid_symbol_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreviewSymbolImage extends ConsumerWidget {
  const PreviewSymbolImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(colorProvider);
    final label = ref.watch(labelProvider);
    final image = ref.watch(imageNotifierProvider);

    return FractionallySizedBox(
      widthFactor: 0.55,
      child: Stack(children: [
        GridSymbolCard(
            symbol: CommunicationSymbol(
                label: label, imagePath: image, color: color)),
        Consumer(builder: (context, ref, _) {
          // this is a bit funky, i admit. but because show modal creates another context so when you try to access provider later it be the same one as in here, unless you pass ref like so
          // https://github.com/rrousselGit/riverpod/issues/2338

          return Positioned(
              top: 6,
              right: 3,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          ImageOptions(ref: ref));
                },
                child: const ShowImageOptions(),
              ));
        })
      ]),
    );
  }
}

class ShowImageOptions extends StatelessWidget {
  const ShowImageOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: const BoxDecoration(
            color: Color(0xFF545454),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: const Text(
          "Edytuj",
          style: TextStyle(height: 2, color: Colors.white),
        ));
  }
}

class ImageOptions extends StatelessWidget {
  const ImageOptions({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 25.0),
      child: Wrap(
        children: [
          ChangeImage(ref: ref),
          CropImage(ref: ref),
          RemoveImage(ref: ref)
        ],
      ),
    );
  }
}

class RemoveImage extends StatelessWidget {
  const RemoveImage({
    super.key,
    required this.ref,
  });
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: !ref.watch(isDefaultImageProvider),
      onTap: () {
        ref.read(imageNotifierProvider.notifier).deleteImage();
        Navigator.pop(context);
      },
      leading: const Icon(Icons.delete_outlined),
      title: const Text("Usuń Obraz"),
    );
  }
}

class CropImage extends StatelessWidget {
  const CropImage({super.key, required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: !ref.watch(isDefaultImageProvider),
      onTap: () {
        ref.read(imageNotifierProvider.notifier).cropImage();
        Navigator.pop(context);
      },
      leading: const Icon(Icons.crop_outlined),
      title: const Text("Przytnij Obraz"),
    );
  }
}

class ChangeImage extends StatelessWidget {
  const ChangeImage({super.key, required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        ref.read(imageNotifierProvider.notifier).cherryPick(context);
      },
      leading: const Icon(Icons.edit_outlined),
      title: const Text("Zamień Obraz"),
    );
  }
}
