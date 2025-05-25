import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../core/life_cycle/page_life_cycle_state.dart';
import '../home/home_page.dart';
import '../options/options_page.dart';
import 'start_page_controller.dart';

class StartHomePage extends StatefulWidget {
  const StartHomePage({super.key});

  @override
  State<StartHomePage> createState() => _StartHomePageState();
}

class _StartHomePageState
    extends PageLifeCycleState<StartPageController, StartHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageViewController,
        onPageChanged: controller.setCurrentPageIndex,
        children: const [
          HomePage(),
          OptionsPage(),
        ],
      ),
      bottomNavigationBar: Observer(
        builder: (_) => BottomNavigationBar(
          backgroundColor: Colors.grey[200],
          currentIndex: controller.currentPageIndex,
          onTap: (index) {
            controller.pageViewController.jumpToPage(index);
            controller.setCurrentPageIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
              label: "Salvar",
              icon: Icon(Icons.save_as_rounded),
              backgroundColor: Colors.amber,
            ),
            BottomNavigationBarItem(
              label: "Listar",
              icon: Icon(Icons.list_alt_sharp),
              backgroundColor: Colors.cyanAccent,
            ),
          ],
        ),
      ),
    );
  }
}
