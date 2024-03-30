import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../bloc/add_manga_bloc/add_manga_event.dart';
import '/bloc/add_manga_bloc/add_manga_state.dart';

import '/bloc/add_manga_bloc/add_manga_bloc.dart';

class MangaInput extends StatelessWidget {
  const MangaInput(
      {required this.mangaFocusNode, super.key, required this.textController});
  final TextEditingController textController;
  final FocusNode mangaFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMangaBloc, AddMangaState>(
      builder: (context, state) {
        return TextFormField(
          controller: textController,
          focusNode: mangaFocusNode,
          decoration: const InputDecoration(
            icon: Icon(Icons.book),
            labelText: 'Cherchez votre manga avec son titre',
            helperText: 'Exemple: Baki Rahen, Kengan Omega...',
          ),
          keyboardType: TextInputType.text,
          onFieldSubmitted: (value) {
            if (textController.text != "") {
              context.read<AddMangaBloc>().add(
                    SearchMangaFromTitleEvent(
                      textController.text,
                    ),
                  );
              mangaFocusNode.unfocus();
            } else {
              Fluttertoast.showToast(
                  msg: "S'il vous plait entrez un manga",
                  backgroundColor: Colors.red[300],
                  textColor: Colors.white,
                  fontSize: 16);
            }
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
