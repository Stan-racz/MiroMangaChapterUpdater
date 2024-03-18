import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/add_manga_bloc/add_manga_state.dart';
import 'manga_info_card_widget.dart';

import '../bloc/add_manga_bloc/add_manga_bloc.dart';
import '../bloc/add_manga_bloc/add_manga_event.dart';
import '../model/manga_model.dart';
import 'manga_input.dart';

class AddMangaView extends StatefulWidget {
  const AddMangaView({super.key});

  @override
  AddMangaViewState createState() => AddMangaViewState();
}

class AddMangaViewState extends State<AddMangaView> {
  // final _formKey = GlobalKey<FormState>();
  final _mangaFocusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mangaFocusNode.addListener(
      () {
        // if (!_mangaFocusNode.hasFocus) {
        //   FocusScope.of(context).requestFocus(_mangaFocusNode);
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Ajoutez votre manga'),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: const Alignment(0, 0),
          child: Column(
            children: [
              MangaInput(
                focusNode: _mangaFocusNode,
                textController: _textController,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(10),
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    Color(0xffE5E5E5),
                  ),
                ),
                onPressed: () {
                  context.read<AddMangaBloc>().add(
                        SearchMangaFromTitleEvent(
                          _textController.text,
                        ),
                      );
                },
                child: const Text(
                  "Rechercher",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocConsumer<AddMangaBloc, AddMangaState>(
                listener: (context, state) {
                  debugPrint("mdr state $state");
                },
                builder: (context, state) {
                  return switch (state) {
                    AddMangaInitial() => MangaInfoCardWidget(
                        manga: Manga(
                          id: "",
                          description: "",
                          titre: "Titre",
                          status: "",
                          annee: "",
                        ),
                      ),
                    MangaFoundByTitleState() =>
                      MangaInfoCardWidget(manga: state.manga),
                    MangaLoadingState() =>
                      MangaInfoCardWidget(manga: state.manga),
                    AddMangaState() => MangaInfoCardWidget(
                        manga: Manga(
                          id: "",
                          description: "",
                          titre: "Titre",
                          status: "",
                          annee: "",
                        ),
                      ),
                  };
                },
              )
              // BlocBuilder<AddMangaBloc, AddMangaState>(
              //   bloc: AddMangaBloc(),
              //   builder: (context, state) {
              //     return switch (state) {
              //       AddMangaInitial() => MangaInfoCardWidget(
              //           manga: Manga(
              //             id: "",
              //             description: "yolo",
              //             titre: "samer",
              //             status: "mangainitial",
              //             annee: "",
              //           ),
              //         ),
              //       MangaFoundByTitleState() =>
              //         MangaInfoCardWidget(manga: state.manga),
              //       AddMangaState() => MangaInfoCardWidget(
              //           manga: Manga(
              //             id: "",
              //             description: "yolo",
              //             titre: "samer",
              //             status: "mangainitial",
              //             annee: "",
              //           ),
              //         ),
              //     };
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
