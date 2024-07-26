part of '../home_page.dart';

class _DrawerCustom extends StatefulWidget {
  final HomeController controller;

  const _DrawerCustom({required this.controller});

  @override
  State<_DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<_DrawerCustom> {
  final _selectDay = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _selectDay.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      backgroundColor: Colors.white54
      // .withOpacity(0.3
      ,
      elevation: 5,
      shape: const UnderlineInputBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(45),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: const Text(
                    "Validade",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  subtitle: const Text("Ajuste os dias "),
                  trailing: const Icon(
                    Icons.access_time_outlined,
                    size: 30,
                  ),
                  onTap: () {
                    DialogCustom(context: context).showSelectDueDate(
                      onPressed: () {
                        if (_selectDay.text.isNotEmpty) {
                          widget.controller.saveDaysSelectedForExpiration(days: _selectDay.text);
                          _selectDay.clear();
                          Navigator.pop(context);
                        } else {
                          Messages.info("Campo obrigaotio");
                        }
                      },
                      controller: _selectDay,
                      homeController: widget.controller,
                    );
                  },
                ),
              ],
            ),
          ),
          const Text(
            "Desenvolvedor por \nNeviton Viana",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
