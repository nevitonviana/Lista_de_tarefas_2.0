part of '../details_page.dart';

class _CardDetail extends StatelessWidget {
  final String name;
  final DateTime date;
  final int daysForExpiration;
  final bool isIndicatorByColor;
  final bool isRebaixa;
  final bool selectedCard;
  final bool isSelectable;
  final Function(bool?)? onChanged;
  final Function()? onTap;
  final void Function() onDoubleTap;
  final VoidCallback? onLongPress;

  const _CardDetail({
    required this.name,
    required this.date,
    required this.onDoubleTap,
    this.isIndicatorByColor = false,
    required this.daysForExpiration,
    this.isRebaixa = false,
    this.selectedCard = false,
    this.onChanged,
    this.onLongPress,
    this.isSelectable = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onTap: onTap,
      child: Card(
        borderOnForeground: false,
        shadowColor: isIndicatorByColor
            ? isRebaixa
                ? Colors.blue
                : Colors.red
            : Colors.transparent,
        color: Colors.white,
        margin: const EdgeInsets.only(top: 15),
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          color: isIndicatorByColor
              ? Date.indicatorByColor(
                  date: date, daysForExpiration: daysForExpiration)
              : Colors.white,
          child: Container(
            color: isSelectable ? Colors.grey : Colors.transparent,
            height: 85.h,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Visibility(
                  visible: isSelectable,
                  child: Checkbox(value: selectedCard, onChanged: onChanged),
                ),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
                // const Spacer(),
                Text(
                  Date.format(date),
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
