import 'package:flutter/material.dart';

import '../../core/life_cycle/page_life_cycle_state.dart';
import '../home/home_page.dart';
import 'start_page_controller.dart';

class StartHomePage extends StatefulWidget {
  const StartHomePage({super.key});

  @override
  State<StartHomePage> createState() => _StartHomePageState();
}

class _StartHomePageState extends PageLifeCycleState<StartHomeController, StartHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageViewController,
        children: [
          const HomePage(),
          Container(),
        ],
      ),
      bottomNavigationBar: AnimatedBuilder(
          animation: controller.pageViewController,
          builder: (context, snapShot) {
            return BottomNavigationBar(
              // selectedItemColor: Colors.brown,
              backgroundColor: Colors.grey[200],
              fixedColor: Color(5242915),
              onTap: (value) => controller.pageViewController.jumpToPage(value),
              currentIndex: controller.pageViewController.page?.round() ?? 0,
              items: const [
                BottomNavigationBarItem(
                    label: "Salvar",
                    icon: Icon(Icons.save_as_rounded),
                    backgroundColor: Colors.amber,
                    tooltip: "ettse"),
                BottomNavigationBarItem(
                  label: "Listar",
                  icon: Icon(Icons.list_alt_sharp),
                  backgroundColor: Colors.cyanAccent,
                ),
              ],
            );
          }),
    );
  }
}

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
