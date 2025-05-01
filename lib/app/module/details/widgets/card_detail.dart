part of '../details_page.dart';

class _CardDetail extends StatelessWidget {
  final String name;
  final DateTime date;
  final bool isIndicatorByColor;
  final bool isRebaixa;

  final VoidCallback onTap;
  final void Function() onDoubleTap;
  final int daysForExpiration;

  const _CardDetail({
    required this.name,
    required this.date,
    required this.onTap,
    required this.onDoubleTap,
    this.isIndicatorByColor = false,
    required this.daysForExpiration,
    this.isRebaixa = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        child: Card(
          borderOnForeground: false,
          shadowColor: isRebaixa ? Colors.blue : Colors.red,
          color: Colors.white,
          margin: const EdgeInsets.only(top: 15),
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          shape: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: isIndicatorByColor
                  ? Date.indicatorByColor(
                      date: date, daysForExpiration: daysForExpiration)
                  : Colors.white,
            ),
            height: 85.h,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Text(
                  Date.format(date),
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ));
  }
}
