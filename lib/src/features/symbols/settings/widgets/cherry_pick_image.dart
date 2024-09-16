import 'dart:io';

import 'package:aac/src/features/arasaac/arasaac_service.dart';
import 'package:aac/src/shared/utils/get_random_string.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

bool isValidImage(ContentType contentType) {
  final imageTypes = [
    "image/gif",
    "image/jpeg",
    "image/png",
    "image/tiff",
  ];

  return imageTypes.contains(contentType.toString().toLowerCase());
}

class AacSearchField extends StatelessWidget {
  final String placeholder;

  final Widget? icon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onClick;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final FocusNode? focusNode;
  const AacSearchField(
      {super.key,
      required this.placeholder,
      this.icon,
      this.readOnly = false,
      this.focusNode,
      this.suffixIcon,
      this.controller,
      this.onClick,
      this.onChanged,
      this.errorText,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      focusNode: focusNode,
      style: const TextStyle(fontSize: 16),
      onTap: onClick,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: const Color(0xFFF4F2F2),
        filled: true,
        hintText: placeholder,
        prefixIcon: icon ?? const Icon(Icons.search),
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        errorText: errorText,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide.none),
      ),
    );
  }
}

class ArasaacSearchScreen extends ConsumerStatefulWidget {
  const ArasaacSearchScreen({super.key});

  @override
  ConsumerState<ArasaacSearchScreen> createState() =>
      _ArasaacSearchScreenState();
}

class _ArasaacSearchScreenState extends ConsumerState<ArasaacSearchScreen> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    final symbols = ref.watch(arasaacSearchResultsProvider(query)).valueOrNull;

    return Column(
      children: [
        AacSearchField(
          onChanged: (value) => setState(() {
            query = value;
          }),
          placeholder: "Szukaj w arrasac",
          icon: const Icon(Icons.search_outlined),
        ),
        const SizedBox(
          height: 28.0,
        ),
        symbols == null || symbols.isEmpty
            ? Expanded(
                child: Center(
                    child: Text(
                "Oj mój... jak tu pusto",
                style: Theme.of(context).textTheme.titleLarge,
              )))
            : Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 13),
                  itemCount: symbols.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Image.network(
                        symbols[index],
                      ),
                      onTap: () => Navigator.pop(context, symbols[index]),
                    );
                  },
                ),
              )
      ],
    );
  }
}

class ImageCherryPicker extends StatelessWidget {
  const ImageCherryPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      animationDuration: Duration.zero,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: const SafeArea(
              child: TabBar(
                tabs: [
                  Tab(
                    text: "Arasaac",
                  ),
                  Tab(
                    text: "Urządzenie",
                  ),
                  Tab(
                    text: "Link",
                  ),
                ],
              ),
            )),
        body: const TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 27.0, horizontal: 20.0),
              child: ArasaacSearchScreen(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 27.0, horizontal: 20.0),
              child: UploadFromDeviceScreen(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 27.0, horizontal: 20.0),
              child: UploadImageFromLinkScreen(),
            )
          ],
        ),
      ),
    );
  }
}

class UploadImageFromLinkScreen extends StatefulWidget {
  const UploadImageFromLinkScreen({super.key});

  @override
  State<UploadImageFromLinkScreen> createState() =>
      _UploadImageFromLinkScreenState();
}

class _UploadImageFromLinkScreenState extends State<UploadImageFromLinkScreen> {
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: AacSearchField(
              controller: controller,
              errorText: errorText,
              placeholder: "Wklej link do obrazka",
              validator: (value) {
                if (value == null) return null;

                if (!Uri.parse(value).isAbsolute) {
                  return "Niepoprawny adres url";
                }

                return null;
              }),
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
            height: 48,
            child: ElevatedButton(
                onPressed: tryDownload,
                style: ButtonStyle(
                    backgroundColor:
                        const WidgetStatePropertyAll(Color(0xFF2A1B3B)),
                    iconSize: const WidgetStatePropertyAll(24.0),
                    iconColor: const WidgetStatePropertyAll(Color(0xFFD3CEE3)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)))),
                child: const Icon(Icons.upload)))
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void tryDownload() async {
    if (!_formKey.currentState!.validate()) return;

    if (controller.text.trim().isEmpty) return;

    final uri = Uri.parse(controller.text);
    if (!uri.isAbsolute) return;

    // TODO this can i throw for various reasons, one might be url that can't be resolved because Łukasz broke DNS
    final request = await HttpClient().getUrl(uri);
    final response = await request.close();

    final contentType = response.headers.contentType;

    if (contentType == null || !isValidImage(contentType)) {
      setState(() {
        errorText = "Podany url jest obrazkiem";
      });
      return;
    }

    File file;
    final tempDir = await getTemporaryDirectory();
    do {
      final fileName = getRandomString(8);
      file = File('${tempDir.path}/$fileName.${contentType.subType}');
    } while (file.existsSync());

    // TODO handle failed writes
    await response.pipe(file.openWrite());

    if (!mounted) return;
    Navigator.pop(context, file.path);
  }
}

class UploadFromDeviceScreen extends StatelessWidget {
  const UploadFromDeviceScreen({super.key});

  void pickImageFromGallery(BuildContext context) async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    late final Map<Permission, PermissionStatus> statuses;

    if (androidInfo.version.sdkInt <= 32) {
      statuses = await [Permission.storage].request();
    } else {
      statuses = await [Permission.photos].request();
    }

    final hasPermission =
        statuses.values.every((status) => status == PermissionStatus.granted);

    if (!hasPermission) return;

    final file = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (file == null) return;

    if (!context.mounted) return;

    Navigator.pop(context, file.path);
  }

  void pickImageFromCamera(BuildContext context) async {
    final camera = await Permission.camera.request();

    if (camera.isDenied) return;

    final file = await ImagePicker().pickImage(source: ImageSource.camera);

    if (file == null) return;

    if (!context.mounted) return;
    Navigator.pop(context, file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
            onPressed: () => pickImageFromCamera(context),
            style: ButtonStyle(
                backgroundColor:
                    const WidgetStatePropertyAll(Color(0xFF2A1B3B)),
                iconSize: const WidgetStatePropertyAll(24.0),
                iconColor: const WidgetStatePropertyAll(Color(0xFFD3CEE3)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)))),
            icon: const Icon(Icons.add_a_photo_outlined),
            label: const Text(
              "Aparat",
              style: TextStyle(color: Color(0xFFD3CEE3)),
            )),
        ElevatedButton.icon(
            onPressed: () => pickImageFromGallery(context),
            style: ButtonStyle(
                backgroundColor:
                    const WidgetStatePropertyAll(Color(0xFF2A1B3B)),
                iconSize: const WidgetStatePropertyAll(24.0),
                iconColor: const WidgetStatePropertyAll(Color(0xFFD3CEE3)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)))),
            icon: const Icon(Icons.add_photo_alternate_outlined),
            label: const Text(
              "Galeria",
              style: TextStyle(color: Color(0xFFD3CEE3)),
            )),
      ],
    );
  }
}
