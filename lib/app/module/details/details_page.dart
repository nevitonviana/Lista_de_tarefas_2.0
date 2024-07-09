import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/life_cycle/page_life_cycle_state.dart';
import '../../core/ui/extensions/size_screen_extension.dart';
import 'details_controller.dart';

part 'widgets/card_detail.dart';

class DetailsPage extends StatefulWidget {
  final String _name;

  const DetailsPage({
    super.key,
    required String name,
  }) : _name = name;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends PageLifeCycleState<DetailsController, DetailsPage> {
  @override
  Map<String, dynamic>? get params => {'name': widget._name};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(widget._name),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          return controller.listItems.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.listItems.length,
                  itemBuilder: (context, index) {
                    print(controller.listItems.length);
                    final item = controller.listItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: _CardDetail(
                        onTap: (){
                          Modular.to.pushNamed('/details/detailsItem', arguments: item);
                        },
                        name: item.name,
                        data: item.date.toString(),
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
                          text: widget._name,
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
