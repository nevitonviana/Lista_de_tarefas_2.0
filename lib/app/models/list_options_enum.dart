import 'package:flutter/material.dart';

enum ListOptionsEnum {
  Rebaixa,
  Consumo,
  Quebras,
  Transformar,
  Outros,
}

extension ListOptionsEnumIcons on ListOptionsEnum {
  IconData get icon {
    switch (this) {
      case ListOptionsEnum.Rebaixa:
        return Icons.paid_rounded;
      case ListOptionsEnum.Consumo:
        return Icons.delete_sharp;
      case ListOptionsEnum.Quebras:
        return Icons.dining_outlined;
      case ListOptionsEnum.Transformar:
        return Icons.flip_camera_android_rounded;
      case ListOptionsEnum.Outros:
        return Icons.more_horiz;
    }
  }
}
