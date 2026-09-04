import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/database/daos/board_dao.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/shared/form/widgets/number_field.dart';
import 'package:aac/src/shared/form/widgets/text_field.dart';
import 'package:aac/src/shared/ui/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateBoardScreen extends ConsumerStatefulWidget {
  const CreateBoardScreen({super.key, required this.params});

  final BoardEditModel params;

  @override
  ConsumerState<CreateBoardScreen> createState() => _CreateBoardScreenState();
}

class _CreateBoardScreenState extends ConsumerState<CreateBoardScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController columnCountController;

  bool _isNameUnique = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.params.name);
    columnCountController =
        TextEditingController(text: "${widget.params.columnCount}");

    nameController.addListener(_checkBoardNameExists);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    columnCountController.dispose();
  }

  Future<bool> boardNameExists(String name) async {
    final board =
        await ref.read(boardDaoProvider).selectByName(name).getSingleOrNull();

    return board != null && !board.isDeleted;
  }

  Future<void> _checkBoardNameExists() async {
    final name = nameController.text;

    if (name != widget.params.name) {
      final exists = await boardNameExists(name);
      setState(() {
        _isNameUnique = !exists;
      });
    } else {
      setState(() {
        _isNameUnique = true;
      });
    }
  }

  String? validateBoardName(String? val) {
    final l10n = AppLocalizations.of(context);
    if (val == null || val.isEmpty) {
      return l10n.boardNameRequired;
    }
    if (!_isNameUnique) {
      return l10n.boardNameExists;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ConstrainedBox(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.5),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      GenericTextField(
                        controller: nameController,
                        labelText: l10n.name,
                        validator: validateBoardName,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: GenericNumberField(
                            name: "columnCount",
                            controller: columnCountController,
                            inputFormatters: [positiveDigitsOnly],
                            validator: (val) {
                              if (val != null && val.startsWith("0")) {
                                return l10n.columnsPositive;
                              }
                              return null;
                            },
                            labelText: l10n.columnsCount,
                          )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AacButton(
                        onPressed: Navigator.of(context).pop,
                        type: ButtonType.noBackground,
                        child: Text(l10n.cancel),
                      ),
                      AacButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;
                            Navigator.pop(
                                context,
                                widget.params.copyWith(
                                  name: nameController.text,
                                  id: widget.params.id,
                                  columnCount:
                                      int.tryParse(columnCountController.text),
                                ));
                          },
                          child: Text(l10n.save))
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
