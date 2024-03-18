import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/add_manga_bloc/add_manga_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/add_manga_bloc/add_manga_state.dart';

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
          // initialValue: "",
          controller: textController,
          focusNode: focusNode,
          decoration: const InputDecoration(
            icon: Icon(Icons.menu_book),
            labelText: 'Cherchez votre manga avec son titre',
            helperText: 'Exemple: Baki Rahen, Kengan Omega...',
            // errorText: 'Please ensure the email entered is valid',
          ),
          keyboardType: TextInputType.text,
          onChanged: (value) {
            // context.read<MyFormBloc>().add(EmailChanged(email: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
