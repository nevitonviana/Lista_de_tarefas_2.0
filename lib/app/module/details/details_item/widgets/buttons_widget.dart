part of '../details_item_page.dart';

class _ButtonsWidget extends StatelessWidget {
  final VoidCallback onTapEdit;
  final VoidCallback onTapShare;
  final String barcode;

  const _ButtonsWidget({required this.onTapEdit, required  this.barcode, required this.onTapShare});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton.icon(
          onPressed: onTapEdit,
          label: const Text(
            "Editar",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          icon: const Icon(
            Icons.edit_outlined,
            color: Colors.blue,
          ),
          style: OutlinedButton.styleFrom(backgroundColor: Colors.grey.shade200),
        ),
        IconButton(
          onPressed: () {
            ShowBarcode().generator(context: context, barcode: barcode);
          },
          icon: const Icon(
            CupertinoIcons.barcode,
            size: 35,
            color: Colors.black,
          ),
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(width: 1.5, color: Colors.black38),
            ),
          ),
        ),
        IconButton(
          onPressed:onTapShare,
          icon: const Icon(
            Icons.share_sharp,
            size: 30,
            color: Colors.blue,
          ),
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(width: 1.5, color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }
}
