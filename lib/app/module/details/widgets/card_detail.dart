part of '../details_page.dart';

class _CardDetail extends StatelessWidget {
  final String name;
  final String data;
  final VoidCallback onTap;

  const _CardDetail({
    required this.name,
    required this.data, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.only(top: 15),
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          shape: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
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
                  data,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ));
  }
}
