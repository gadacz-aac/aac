import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/settings/screens/symbol_settings.dart';
import 'package:aac/src/features/symbols/settings/widgets/cherry_pick_image.dart';
import 'package:aac/src/features/symbols/settings/widgets/color_picker.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreviewSymbolImage extends ConsumerWidget {
  const PreviewSymbolImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(colorProvider);
    final label = ref.watch(labelProvider);
    return FractionallySizedBox(
      widthFactor: 0.55,
      child: Stack(children: [
        SymbolCard(
            symbol: CommunicationSymbol(
                label: label,
                imagePath:
                    "https://www.catholicnewsagency.com/images/Church_on_fire_Credit_butterbits_via_Flickr_CC_BY_SA_20_CNA_8_3_15.jpg?jpg",
                color: color)),
        Positioned(
            top: 6,
            right: 3,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => const ImageOptions());
              },
              child: const ShowImageOptions(),
            ))
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
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 25.0),
      child: Wrap(
        children: [ChangeImage(), CropImage(), RemoveImage()],
      ),
    );
  }
}

class RemoveImage extends StatelessWidget {
  const RemoveImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: true,
      onTap: () {
        // deleteImage(); // TODO dupa
        Navigator.pop(context);
      },
      leading: const Icon(Icons.delete_outlined),
      title: const Text("Usuń Obraz"),
    );
  }
}

class CropImage extends StatelessWidget {
  const CropImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: true,
      onTap: () {
        // cropImage(imagePath); // TODO dupa
        Navigator.pop(context);
      },
      leading: const Icon(Icons.crop_outlined),
      title: const Text("Przytnij Obraz"),
    );
  }
}

class ChangeImage extends StatelessWidget {
  const ChangeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ImageCherryPicker())).then((value) {
          // setState(() {
          //   imagePath = value;
          // });
          Navigator.pop(context);
        });
      },
      leading: const Icon(Icons.edit_outlined),
      title: const Text("Zamień Obraz"),
    );
  }
}
