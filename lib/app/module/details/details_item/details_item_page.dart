import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/extensions/size_screen_extension.dart';
import '../../../models/item_model.dart';

part 'widgets/buttons_widget.dart';
part 'widgets/label_widget.dart';

// ignore: must_be_immutable
class DetailsItemPage extends StatefulWidget {
  ItemModel _item;

  DetailsItemPage({
    super.key,
    required ItemModel item,
  }) : _item = item;

  @override
  State<DetailsItemPage> createState() => _DetailsItemPageState();
}

class _DetailsItemPageState extends State<DetailsItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: .05.sh),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _LabelWidget(label: "Name", nameItem: widget._item.name),
              _LabelWidget(label: "Data do Vencimento", nameItem: widget._item.date.toString()),
              _LabelWidget(
                label: "Codigo Do Produto",
                nameItem: widget._item.barcode,
                onPressed: () {},
              ),
              _LabelWidget(
                  label: "Kg/Unidades",
                  nameItem: widget._item.quantity!.isNotEmpty ? widget._item.quantity! : "1"),
              _LabelWidget(label: "Status do Produto", nameItem: widget._item.options),
              Visibility(
                visible: widget._item.description!.isNotEmpty,
                child: _LabelWidget(label: "Descrição", nameItem: widget._item.description ?? ""),
              ),
              const SizedBox(height: 20),
              _ButtonsWidget(
                onTapEdit: () async {
                  widget._item = (await Modular.to.pushNamed<ItemModel>("/home", arguments: widget._item))!;
                  setState(() {});
                },
                onTapShare: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
