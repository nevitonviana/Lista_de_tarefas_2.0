import 'package:flutter/material.dart';

import '../../core/ui/extensions/size_screen_extension.dart';

part 'widgets/card_detail.dart';

class DetailsPage extends StatelessWidget {
  final String _name;

  const DetailsPage({
    super.key,
    required String name,
  }) : _name = name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(_name),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => _CardDetail(
          name: "teste euyvdsua",
          data: "20/50",
        ),
      ),
    );
  }
}
