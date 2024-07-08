import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/ui/extensions/size_screen_extension.dart';
import '../../models/list_options_enum.dart';

part 'widgets/card_option.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _sizeRL = MediaQuery.sizeOf(context).width * .1;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * .2, right: _sizeRL, left: _sizeRL),
        child: ListView(
          children: ListOptionsEnum.values
              .map(
                (e) => _CardOption(
                  label: e.name,
                  icon: e.icon,
                  onTap: () => Modular.to.pushNamed("/details", arguments: e.name),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}