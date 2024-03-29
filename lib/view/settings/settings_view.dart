import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Colors.orange,
            thickness: 1.5,
          ),
        ),
        title: Text(
          "Settings",
          style: GoogleFonts.aBeeZee(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
