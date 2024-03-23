import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final _mangaFocusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mangaFocusNode.addListener(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Ajoutez votre manga',
            style: GoogleFonts.aBeeZee(
              fontSize: 24,
              color: Colors.grey,
            ),
          ),
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
                  if (_textController.text != "") {
                    context.read<AddMangaBloc>().add(
                          SearchMangaFromTitleEvent(
                            _textController.text,
                          ),
                        );
                  } else {
                    Fluttertoast.showToast(
                        msg: "S'il vous plait entrez un manga",
                        backgroundColor: Colors.red[300],
                        textColor: Colors.white,
                        fontSize: 16);
                  }
                },
                child: const Text(
                  "Rechercher",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              if (kDebugMode)
                ElevatedButton(
                  style: const ButtonStyle(
                    elevation: MaterialStatePropertyAll(10),
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Color(0xffE5E5E5),
                    ),
                  ),
                  onPressed: () {
                    context.read<AddMangaBloc>().add(
                          TestEvent(),
                        );
                  },
                  child: const Text(
                    "test",
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
                  if (state is MangaNotFoundState) {
                    Fluttertoast.showToast(
                        msg: "Erreur : Manga non trouvé",
                        backgroundColor: Colors.red[300],
                        textColor: Colors.white,
                        fontSize: 16);
                  } else if (state is AddMangaSuccess) {
                    Fluttertoast.showToast(
                        msg: "Manga bien sauvegardé",
                        backgroundColor: Colors.grey,
                        textColor: Colors.black,
                        fontSize: 16);
                  } else if (state is MangaAlreadyAdded) {
                    Fluttertoast.showToast(
                        msg: "Manga déjà sauvegardé",
                        backgroundColor: Colors.red[300],
                        textColor: Colors.white,
                        fontSize: 16);
                  }
                  return switch (state) {
                    AddMangaInitial() => MangaInfoCardWidget(
                        manga: Manga(
                          mangadex_id: "",
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
                          mangadex_id: "",
                          description: "",
                          titre: "Titre",
                          status: "",
                          annee: "",
                        ),
                      ),
                  };
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
