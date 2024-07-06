import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/life_cycle/controller_life_cycle.dart';

part 'start_page_controller.g.dart';

class StartHomeController = StartHomeControllerBase with _$StartHomeController;

abstract class StartHomeControllerBase with Store, ControllerLifeCycle {
  final pageViewController = PageController();

  @override
  void onInit([Map<String, dynamic>? params]) {}

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }
}
