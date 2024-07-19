part of '../options_page.dart';

class _CardOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _CardOption({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(top: 15),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(width: 2),
        ),
        elevation: 5,
        color: Colors.grey[400],
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 70.h,
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 18.tx),
              ),
              const Spacer(),
              Icon(
                icon,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
