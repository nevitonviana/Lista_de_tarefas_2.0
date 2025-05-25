import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/life_cycle/controller_life_cycle.dart';

part 'start_page_controller.g.dart';

class StartPageController = StartPageControllerBase with _$StartPageController;

abstract class StartPageControllerBase with Store, ControllerLifeCycle {
  final pageViewController = PageController();

  @observable
  int currentPageIndex = 0;

  @action
  void setCurrentPageIndex(int index) {
    currentPageIndex = index;
  }

  @override
  void onInit([Map<String, dynamic>? params]) {}

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }
}

