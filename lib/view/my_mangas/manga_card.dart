import 'package:flutter/material.dart';

class MangaCardWidget extends StatefulWidget {
  const MangaCardWidget({super.key});

  @override
  State<MangaCardWidget> createState() => MangaCardState();
}

class MangaCardState extends State<MangaCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Divider(
          color: Colors.grey[300],
          height: 1,
        ),
        Divider(
          color: Colors.grey[300],
          height: 1,
        ),
      ],
    );
  }
}
