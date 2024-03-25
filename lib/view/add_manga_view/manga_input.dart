import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/add_manga_bloc/add_manga_state.dart';

import '/bloc/add_manga_bloc/add_manga_bloc.dart';

class MangaInput extends StatelessWidget {
  const MangaInput(
      {required this.focusNode, super.key, required this.textController});
  final TextEditingController textController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMangaBloc, AddMangaState>(
      builder: (context, state) {
        return TextFormField(
          controller: textController,
          focusNode: focusNode,
          decoration: const InputDecoration(
            icon: Icon(Icons.menu_book),
            labelText: 'Cherchez votre manga avec son titre',
            helperText: 'Exemple: Baki Rahen, Kengan Omega...',
          ),
          keyboardType: TextInputType.text,
          onChanged: (value) {},
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
