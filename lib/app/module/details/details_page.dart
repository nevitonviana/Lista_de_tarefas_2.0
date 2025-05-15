import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/life_cycle/page_life_cycle_state.dart';
import '../../core/ui/extensions/size_screen_extension.dart';
import '../../core/ui/widgets/date.dart';
import '../../models/item_model.dart';
import '../../models/list_options_enum.dart';
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

class _DetailsPageState
    extends PageLifeCycleState<DetailsController, DetailsPage> {
  @override
  Map<String, dynamic>? get params =>
      {'name': widget._name, 'searchItem': widget._searchItem};

  bool _selectionMode = false;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(widget._name ?? "Resultados"),
        centerTitle: true,
        actions: [
          Observer(
            builder: (context) {
              return Row(
                children: [
                  Visibility(
                    visible: _selectionMode,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(
                              () {
                                _selectionMode = false;
                                controller.markedForSharing.clear();
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            size: 30,
                            color: Colors.redAccent,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.shareListItem();
                            setState(() {
                              _selectionMode = false;
                            });
                          },
                          icon: const Icon(
                            Icons.share_rounded,
                            color: Colors.blue,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible:
                        controller.listItems.isNotEmpty && widget._name != null,
                    child: IconButton(
                      onPressed: () {
                        DialogCustom(context).dialogDelete(
                          onPressedDelete: () {
                            controller.deleteAllItems(
                                optionOfDeletes: widget._name!);
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
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          return controller.listItems.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.listItems.length,
                  itemBuilder: (context, index) {
                    ItemModel item = controller.listItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: CustomDismissible(
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            await Modular.to
                                .pushNamed("/home", arguments: item);
                            widget._searchItem == null
                                ? await controller.getItems(item.options)
                                : controller.searchItemNameOrBarcode(
                                    search: widget._searchItem!);
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
                        child: Observer(
                          builder: (context) {
                            return _CardDetail(
                              onTap: _selectionMode
                                  ? null
                                  : () async {
                                      await Modular.to.pushNamed(
                                          '/details/detailsItem',
                                          arguments: item);
                                      widget._searchItem == null
                                          ? await controller.getItems(item.options)
                                          : controller.searchItemNameOrBarcode(
                                              search: widget._searchItem!);
                                    },
                              onChanged: (value) {

                                  controller.brandToShare(item: item);
                                  _selectionMode =
                                      controller.markedForSharing.isNotEmpty;

                              },
                              onDoubleTap: () {
                                final updatedItem =
                                    item.copyWith(finished: !item.finished);
                                controller.updateFinished(item: updatedItem);
                              },
                              onLongPress: () {
                                _selectionMode = true;
                                setState(() {
                                  controller.brandToShare(item: item);
                                });
                              },
                              isSelectable: _selectionMode,
                              selectedCard: controller.isItemSelected(item),
                              isRebaixa: item.finished,
                              name: item.name,
                              date: item.date,
                              isIndicatorByColor:
                                  item.options == ListOptionsEnum.Rebaixa.name &&
                                      widget._searchItem == null,
                              daysForExpiration:
                                  controller.daysSelectedForExpiration,
                            );
                          }
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Não ha nenhum ",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.black54),
                      children: [
                        TextSpan(
                          text: widget._name ?? "Resultado",
                          style: const TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline),
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
