import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/theme_cubit/theme_cubit.dart';

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
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 3.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Brightness Mode",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  PopupMenuButton(
                    color: Theme.of(context).colorScheme.background,
                    icon: Icon(
                      Icons.menu_open,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text(
                          "Light Mode",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        onTap: () {
                          context
                              .read<ThemeCubit>()
                              .updateTheme(ThemeMode.light);
                        },
                      ),
                      PopupMenuItem(
                        child: Text(
                          "Dark Mode",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        onTap: () {
                          context
                              .read<ThemeCubit>()
                              .updateTheme(ThemeMode.dark);
                        },
                      ),
                      PopupMenuItem(
                        child: Text(
                          "Device System settings",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        onTap: () {
                          context
                              .read<ThemeCubit>()
                              .updateTheme(ThemeMode.system);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}
