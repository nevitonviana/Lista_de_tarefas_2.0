import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/extensions/size_screen_extension.dart';
import '../../core/widgtes/custom_button.dart';
import '../../core/widgtes/custom_text_form_field.dart';
import '../../models/list_options_enum.dart';
import 'widgets/calendar_button.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();

  final _barcodeEC = TextEditingController();

  final _quantityEC = TextEditingController();

  final _descriptionEC = TextEditingController();
  final _dataEC = TextEditingController();
  final _focusNode = FocusNode();
  final _focusNode1 = FocusScopeNode();

  String? _selectedOption;
  String? _data;

  late OutlinedButton bb;

  @override
  void dispose() {
    _nameEC.dispose();
    _descriptionEC.dispose();
    _quantityEC.dispose();
    _barcodeEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.w),
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Builder(
            builder: (_) => Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    controller: _nameEC,
                    label: "Nome Produto",
                    icon: Icons.drive_file_rename_outline_outlined,
                    validator: Validatorless.required("Campo Obrigatorio"),
                  ),
                  CustomTextFormField(
                    controller: _barcodeEC,
                    label: "Codigo",
                    icon: Icons.integration_instructions_sharp,
                    validator: Validatorless.required("Campo Obrigatorio"),
                  ),
                  CustomTextFormField(
                    controller: _quantityEC,
                    label: "Quantidade/Kg",
                    icon: Icons.numbers_sharp,
                  ),
                  Visibility(
                    child: CustomTextFormField(
                      controller: _descriptionEC,
                      label: "Obiservações",
                      icon: Icons.description_rounded,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CalendarButton2(
                          focusNode: _focusNode,
                        ),
                        Expanded(
                          child: DropdownButtonFormField(
                            validator: Validatorless.required("Campo Obrigatorio"),
                            alignment: Alignment.center,
                            hint: const Text("Opições"),
                            onChanged: (value) => _selectedOption = value,
                            items: ListOptionsEnum.values
                                .map<DropdownMenuItem<String>>(
                                  (e) => DropdownMenuItem(
                                    value: e.name,
                                    child: Text(e.name),
                                  ),
                                )
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                  CustomButton(
                    label: "Escaniar",
                    icon: Icons.camera_enhance_outlined,
                    onPressed: () {},
                  ),
                  CustomButton(
                    label: "Salvar",
                    icon: Icons.save,
                    onPressed: () {
                      final formValid = _formKey.currentState?.validate() ?? false;
                      _formKey.currentState?.save();
                      if (formValid && _selectedOption != null) {
                      } else {
                        // CalendarButton();
                        // bb.onPressed?.call();
                        setState(() {
                          // bb.onPressed?.call();
                          _focusNode.requestFocus();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}