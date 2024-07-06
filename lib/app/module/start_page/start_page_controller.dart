import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/life_cycle/controller_life_cycle.dart';

part 'start_page_controller.g.dart';

class StartPageController = StartPageControllerBase with _$StartPageController;

abstract class StartPageControllerBase with Store, ControllerLifeCycle {
  final pageViewController = PageController();

  @override
  void onInit([Map<String, dynamic>? params]) {}

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }
}
