import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/life_cycle/page_life_cycle_state.dart';
import '../../core/ui/extensions/size_screen_extension.dart';
import '../../core/ui/widgets/format_date.dart';
import '../../models/item_model.dart';
import 'details_controller.dart';
import 'widgets/custom_dismissible.dart';
import 'widgets/dialog_custom.dart';

part 'widgets/card_detail.dart';

class DetailsPage extends StatefulWidget {
  final String? _name;
  final String? _searchItem;

  const DetailsPage({
    super.key,
    String? name,
    String? searchItem,
  })  : _name = name,
        _searchItem = searchItem;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends PageLifeCycleState<DetailsController, DetailsPage> {
  @override
  Map<String, dynamic>? get params => {'name': widget._name, 'searchItem': widget._searchItem};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(widget._name ?? "Resultados"),
        centerTitle: true,
        actions: [
          Observer(builder: (context) {
            return Visibility(
              visible: controller.listItems.isNotEmpty && widget._name != null,
              child: IconButton(
                onPressed: () {
                  DialogCustom(context).dialogDelete(
                    onPressedDelete: () {
                      controller.deleteAllItems(optionOfDeletes: widget._name!);
                    },
                    label: ' todos os itens de ${widget._name}',
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  opticalSize: 30,
                  size: 30,
                ),
              ),
            );
          }),
        ],
      ),
      body: Observer(
        builder: (_) {
          return controller.listItems.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.listItems.length,
                  itemBuilder: (context, index) {
                    final ItemModel item = controller.listItems[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: CustomDismissible(
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            await Modular.to.pushNamed("/home", arguments: item);
                            widget._searchItem == null
                                ? await controller.getItems(item.options)
                                : controller.searchItemNameOrBarcode(search: widget._searchItem!);
                          } else {
                            await DialogCustom(context).dialogDelete(
                              label: item.name,
                              onPressedDelete: () async {
                                await controller.deleteItem(id: item.id!);
                              },
                            );
                          }
                          return false;
                        },
                        child: _CardDetail(
                          onTap: () async {
                            await Modular.to.pushNamed('/details/detailsItem', arguments: item);
                            widget._searchItem == null
                                ? await controller.getItems(item.options)
                                : controller.searchItemNameOrBarcode(search: widget._searchItem!);
                          },
                          name: item.name,
                          data: item.date.toString(),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Não ha nenhum ",
                      style: const TextStyle(fontSize: 20, color: Colors.black54),
                      children: [
                        TextSpan(
                          text: widget._name ?? "Resultado",
                          style: const TextStyle(color: Colors.black, decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
