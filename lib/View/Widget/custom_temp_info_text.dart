import 'package:flutter/material.dart';

class CustomTempInfoText extends StatelessWidget {
  const CustomTempInfoText(
      {super.key,
      required this.iconData,
      required this.title,
      required this.data});
  final String title;
  final String data;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 5),
            Icon(iconData, color: Colors.white),
          ],
        ),
        const Spacer(),
        Text(
          data,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
