import 'dart:io';

import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/features/arasaac/arasaac_service.dart';
import 'package:aac/src/features/settings/utils/app_language.dart';
import 'package:aac/src/shared/utils/try_download_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:aac/src/shared/ui/scaffold.dart';
import 'package:aac/src/shared/ui/search_input.dart';

bool isValidImage(ContentType contentType) {
  final imageTypes = [
    "image/gif",
    "image/jpeg",
    "image/png",
    "image/tiff",
  ];

  return imageTypes.contains(contentType.toString().toLowerCase());
}

String downloadImageErrorMessage(AppLocalizations l10n, DownloadImageError error) {
  return switch (error) {
    DownloadImageError.downloadFailed => l10n.downloadFailed,
    DownloadImageError.notAnImage => l10n.notAnImage,
    DownloadImageError.saveFailed => l10n.saveImageFailed,
  };
}

class ArasaacSearchScreen extends ConsumerStatefulWidget {
  const ArasaacSearchScreen({super.key});

  @override
  ConsumerState<ArasaacSearchScreen> createState() =>
      _ArasaacSearchScreenState();
}

class _ArasaacSearchScreenState extends ConsumerState<ArasaacSearchScreen> {
  String query = "";

  /// null means "follow the app language".
  String? language;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final appLanguage = ref.watch(appLanguageCodeProvider);
    final effectiveLanguage = language ?? appLanguage;
    final symbols =
        ref.watch(arasaacSearchResultsProvider(query, effectiveLanguage));

    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 27.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AacSearchField(
                onChanged: (value) => setState(() {
                  query = value;
                }),
                placeholder: l10n.searchArasaac,
                icon: const Icon(Icons.search_outlined),
              ),
              const SizedBox(height: 8),
              Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
                Text(l10n.searchLanguage),
                DropdownButton<String>(
                  value: effectiveLanguage,
                  underline: const SizedBox.shrink(),
                  items: [
                    DropdownMenuItem(
                        value: defaultLanguage,
                        child: Text(l10n.languagePolish)),
                    DropdownMenuItem(
                        value: 'en', child: Text(l10n.languageEnglish)),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      language = value;
                    });
                  },
                ),
              ]),
            ],
          ),
        ),
      ),
      symbols.when(
          data: (data) {
            if (data.isNotEmpty) {
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 27.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 13),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return InkWell(
                        child: Image.network(
                          data[index],
                        ),
                        onTap: () async {
                          final (file, err) =
                              await tryDownloadImage(Uri.parse(data[index]));

                          if (err != null) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(downloadImageErrorMessage(
                                        l10n, err))));
                          }

                          Navigator.pop(context, file!.path);
                        });
                  }, childCount: data.length),
                ),
              );
            }
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.arasaacEmptyTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      l10n.arasaacEmptySubtitle,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, _) => SliverToBoxAdapter(
                child: Center(
                  child: Text("$error"),
                ),
              ),
          loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator())))
    ]);
  }
}

class ImageCherryPicker extends StatelessWidget {
  const ImageCherryPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      animationDuration: Duration.zero,
      child: AacScaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              child: TabBar(
                tabs: [
                  Tab(
                    text: l10n.arasaacTab,
                  ),
                  Tab(
                    text: l10n.deviceTab,
                  ),
                  Tab(
                    text: l10n.linkTab,
                  ),
                ],
              ),
            )),
        body: TabBarView(
          children: [
            ArasaacSearchScreen(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 27.0, horizontal: 20.0),
              child: UploadFromDeviceScreen(),
            ),
            UploadImageFromLinkScreen()
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
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 27.0, horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: AacSearchField(
                  icon: const Icon(Icons.link),
                  controller: controller,
                  errorText: errorText,
                  placeholder: l10n.pasteImageLink,
                  validator: (value) {
                    if (value == null) return null;

                    if (!Uri.parse(value).isAbsolute) {
                      return l10n.invalidUrl;
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
                        iconColor:
                            const WidgetStatePropertyAll(Color(0xFFD3CEE3)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)))),
                    child: const Icon(Icons.upload)))
          ]),
        ),
      ),
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

    final (file, err) = await tryDownloadImage(uri);

    if (err != null) {
      setState(() {
        errorText =
            downloadImageErrorMessage(AppLocalizations.of(context), err);
      });

      return;
    }

    if (!mounted) return;
    Navigator.pop(context, file!.path);
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
    final l10n = AppLocalizations.of(context);
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
            label: Text(
              l10n.camera,
              style: const TextStyle(color: Color(0xFFD3CEE3)),
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
            label: Text(
              l10n.gallery,
              style: const TextStyle(color: Color(0xFFD3CEE3)),
            )),
      ],
    );
  }
}
