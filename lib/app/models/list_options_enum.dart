import 'package:flutter/material.dart';

enum ListOptionsEnum {
  Rebaixar,
  Consumo,
  Quebra,
  Transformar,
  Outros,
}

extension ListOptionsEnumIcons on ListOptionsEnum {
  IconData get icon {
    switch (this) {
      case ListOptionsEnum.Rebaixar:
        return Icons.paid_rounded;
      case ListOptionsEnum.Consumo:
        return Icons.delete_sharp;
      case ListOptionsEnum.Quebra:
        return Icons.dining_outlined;
      case ListOptionsEnum.Transformar:
        return Icons.flip_camera_android_rounded;
      case ListOptionsEnum.Outros:
        return Icons.more_horiz;
    }
  }
}
