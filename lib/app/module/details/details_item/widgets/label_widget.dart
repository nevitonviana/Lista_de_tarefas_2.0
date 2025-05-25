part of '../details_item_page.dart';

class _LabelWidget extends StatelessWidget {
  final String label;
  final String nameItem;

  final VoidCallback? onPressed;

  const _LabelWidget(
      {required this.label, required this.nameItem, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$label :",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                nameItem,
                style: const TextStyle(
                  overflow: TextOverflow.clip,
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: .18.sw),
              child: IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.copy,
                  size: 25,
                ),
                disabledColor: Colors.transparent,
              ),
            ),
          ],
        ),
        Divider(
          indent: .1.sh,
          endIndent: .19.sw,
        ),
      ],
    );
  }
}
