import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/life_cycle/page_life_cycle_state.dart';
import '../../core/ui/extensions/size_screen_extension.dart';
import '../../core/ui/widgets/custom_button.dart';
import '../../core/ui/widgets/custom_text_form_field.dart';
import '../../core/ui/widgets/messages.dart';
import '../../models/item_model.dart';
import '../../models/list_options_enum.dart';
import 'home_controller.dart';
import 'widgets/calendar_button.dart';
import 'widgets/dialog_search.dart';

part 'widgets/drawer_custom.dart';

class HomePage extends StatefulWidget {
  final ItemModel? _item;

  const HomePage({super.key, ItemModel? model}) : _item = model;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _barcodeEC = TextEditingController();
  final _quantityEC = TextEditingController();
  final _descriptionEC = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _nameEC.dispose();
    _descriptionEC.dispose();
    _quantityEC.dispose();
    _barcodeEC.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  _resetEditingController() {
    widget._item?.barcode;
    _nameEC.clear();
    _barcodeEC.clear();
    _quantityEC.clear();
    _descriptionEC.clear();
  }

  _updateItem() {
    if (widget._item != null) {
      _nameEC.text = widget._item?.name ?? "";
      _barcodeEC.text = widget._item?.barcode ?? "";
      _quantityEC.text = widget._item?.quantity ?? "";
      _descriptionEC.text = widget._item?.description ?? "";
      controller.selectedDateTime = widget._item?.date;
      controller.selectedOption = widget._item?.options;
    }
  }

  @override
  void initState() {
    super.initState();
    // final start = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateItem();
      // final duration = DateTime.now().difference(start);
      // debugPrint("⏱ Tempo até renderização: ${duration.inMilliseconds}ms");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _DrawerCustom(
        controller: controller,
      ),
      appBar: widget._item != null
          ? AppBar(
              title: const Text('Editar'),
              centerTitle: true,
              leading: const BackButton(),
            )
          : AppBar(
              title: const Text(
                'Home',
                style: TextStyle(),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    onPressed: () {
                      DialogCustom(context: context).showSearch(
                        onPressedIcon: () async => _nameEC.text = await controller.barcodeScanner(),
                        controller: _nameEC,
                        onPressed: () async {
                          if (_nameEC.text == '') {
                            Messages.warning("Código de barras ou nome do produto inválido");
                            return;
                          }
                          await Modular.to.pushNamed("/details/details?searchItem=${_nameEC.text}");
                          _nameEC.clear();
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.search_outlined,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.w),
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Form(
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
                  textInputType: TextInputType.number,
                  label: "Código",
                  icon: Icons.integration_instructions_sharp,
                  validator: Validatorless.required("Campo Obrigatorio"),
                ),
                CustomTextFormField(
                  controller: _quantityEC,
                  label: "Quantidade/Kg",
                  textInputType:
                      const TextInputType.numberWithOptions(decimal: true, signed: false),
                  icon: Icons.numbers_sharp,
                ),
                Observer(
                  builder: (_) {
                    return Visibility(
                      visible: controller.selectedOption == ListOptionsEnum.Outros.name ||
                          controller.selectedOption == ListOptionsEnum.Transformar.name,
                      child: CustomTextFormField(
                        textInputType: TextInputType.multiline,
                        controller: _descriptionEC,
                        label: "Observações",
                        icon: Icons.description_rounded,
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CalendarButton(
                        focusNode: _focusNode,
                      ),
                      SizedBox(
                        width: 130.w,
                        child: Observer(builder: (_) {
                          return DropdownButtonFormField(
                            iconSize: 30,
                            padding: const EdgeInsets.only(left: 10),
                            value: controller.selectedOption,
                            validator: Validatorless.required('Campo Obrigatorio'),
                            alignment: Alignment.center,
                            hint: const Text(
                              'Opições',
                              textAlign: TextAlign.center,
                            ),
                            onChanged: (value) => controller.selectedOption = value,
                            items: ListOptionsEnum.values
                                .map<DropdownMenuItem<String>>(
                                  (e) => DropdownMenuItem(
                                    value: e.name,
                                    child: Text(e.name),
                                  ),
                                )
                                .toList(),
                          );
                        }),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  label: "Escanear",
                  icon: Icons.camera_enhance_outlined,
                  widget: 60,
                  onPressed: () async {
                    _barcodeEC.text = await controller.barcodeScanner();
                    if (_barcodeEC.text != '') {
                    _nameEC.text = await controller.getInfoBarcode(barcode: _barcodeEC.text);
                    }
                  },
                ),
                CustomButton(
                  label: "Salvar",
                  icon: Icons.save,
                  onPressed: () {
                    final formValid = _formKey.currentState?.validate() ?? false;
                    _formKey.currentState?.save();
                    if (formValid) {
                      if (controller.selectedDateTime != null) {
                        if (widget._item == null) {
                          controller.saveProduct(
                            name: _nameEC.text,
                            barcode: _barcodeEC.text,
                            description: _descriptionEC.text,
                            quantity: _quantityEC.text,
                          );
                          _resetEditingController();
                        } else {
                          var item = widget._item!.copyWith(
                              name: _nameEC.text,
                              barcode: _barcodeEC.text,
                              description: _descriptionEC.text,
                              quantity: _quantityEC.text);
                          controller.updateItem(item: item);
                        }
                      } else {
                        _focusNode.requestFocus();
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
