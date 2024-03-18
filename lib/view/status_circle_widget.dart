import 'package:flutter/material.dart';

class StatusCircleWidget extends StatelessWidget {
  final String mangaStatus;
  const StatusCircleWidget({super.key, required this.mangaStatus});

  @override
  Widget build(BuildContext context) {
    // return switch (mangaStatus) {
    //   case mangaStatus == "ongoing" =>

    // }
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: const SizedBox(height: 10, width: 10),
    );
  }
}
