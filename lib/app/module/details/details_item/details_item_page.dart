import 'package:flutter/material.dart';

import '../../../core/ui/extensions/size_screen_extension.dart';
import '../../../models/item_model.dart';

part 'widgets/label_widget.dart';

part 'widgets/buttons_widget.dart';

class DetailsItemPage extends StatelessWidget {
  final ItemModel _item;

  const DetailsItemPage({
    super.key,
    required ItemModel item,
  }) : _item = item;

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
              _LabelWidget(label: "Name", nameItem: _item.name),
              _LabelWidget(label: "Data do Vencimento", nameItem: _item.date.toString()),
              _LabelWidget(
                label: "Codigo Do Produto",
                nameItem: _item.barcode,
                onPressed: () {},
              ),
              _LabelWidget(
                  label: "Kg/Unidades", nameItem: _item.quantity!.isNotEmpty ? _item.quantity! : "1"),
              _LabelWidget(label: "Status do Produto", nameItem: _item.options),
              Builder(
                builder: (context) {
                  print(_item.description?.isNotEmpty);
                  return Container();
                },
              ),
              Visibility(
                visible: _item.description!.isNotEmpty,
                child: _LabelWidget(label: "Descrição", nameItem: _item.description ?? ""),
              ),
              const SizedBox(height: 20),
              _ButtonsWidget(
                onTapEdit: () {},
                onTapShare: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
