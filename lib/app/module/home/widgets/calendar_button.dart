import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../core/ui/extensions/theme_extension.dart';
import '../../../core/ui/widgets/format_date.dart';
import '../../../core/ui/widgets/messages.dart';
import '../home_controller.dart';

class CalendarButton2 extends StatelessWidget {
  final FocusNode? focusNode;
  final dateFormat = DateFormat('dd/MM/y');

  CalendarButton2({super.key, this.focusNode});

  final controller = Modular.get<HomeController>();

  _selectedDate(BuildContext context) async {
    var lastDate = DateTime.now();
    lastDate = lastDate.add(const Duration(days: 10 * 365));
    controller.selectedDateTime = await showDatePicker(
      initialDate: controller.selectedDateTime ?? DateTime.now(),
      context: context,
      firstDate: DateTime(2000),
      lastDate: lastDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusNode: focusNode,
      onFocusChange: (value) async {
        FocusScope.of(context).unfocus();
        focusNode?.skipTraversal;
        Messages.warning("Obrigatorio selecionar uma data");
        await _selectedDate(context);
      },
      onTap: () async {
        _selectedDate(context);
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.today_rounded,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Observer(
              builder: (_) {
                if (controller.selectedDateTime != null) {
                  return Text(
                    FormatDate.dateFormat(controller.selectedDateTime!.toIso8601String()),
                    style: context.titleStyle,
                  );
                } else {
                  return Text(
                    "SELECIONE UMA DATA ",
                    style: context.titleStyle,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
