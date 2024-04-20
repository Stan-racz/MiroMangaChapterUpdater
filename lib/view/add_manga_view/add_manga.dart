import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miro_manga_chapter_update/view/add_manga_view/manga_loading_widget.dart';

import '../../bloc/add_manga_bloc/add_manga_bloc.dart';
import '../../bloc/add_manga_bloc/add_manga_event.dart';
import '../../bloc/add_manga_bloc/add_manga_state.dart';
import 'manga_info_card_widget.dart';
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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              color: Colors.orange,
              thickness: 1.5,
            ),
          ),
          title: Text(
            "Ajouter un Manga",
            style: GoogleFonts.aBeeZee(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          actions: [
            if (kDebugMode)
              PopupMenuButton(
                icon: const Icon(
                  Icons.filter_list_outlined,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text("Test"),
                    onTap: () {
                      context.read<AddMangaBloc>().add(
                            TestEvent(),
                          );
                    },
                  ),
                ],
              )
          ],
        ),
        body: Column(
          children: [
            MangaInput(
              mangaFocusNode: _mangaFocusNode,
              textController: _textController,
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<AddMangaBloc, AddMangaState>(
              listener: (BuildContext context, AddMangaState state) {
                debugPrint("mdr state $state");
              },
              builder: (BuildContext context, AddMangaState state) {
                if (state is MangaNotFoundState) {
                  Fluttertoast.showToast(
                      msg: "Erreur : Manga non trouvé",
                      backgroundColor: Colors.red[300],
                      textColor: Colors.white,
                      fontSize: 16);
                } else if (state is AddMangaSuccess) {
                  Fluttertoast.showToast(
                      msg: "Manga sauvegardé",
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
                  AddMangaInitial() => const SizedBox(),
                  MangaFoundByTitleState() => Expanded(
                      child: ListView.separated(
                        itemCount: state.mangasFound.length,
                        itemBuilder: (context, index) => MangaInfoCardWidget(
                          manga: state.mangasFound[index],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                      ),
                    ),
                  MangaLoadingState() => const MangaLoadingWidget(),
                  AddMangaState() => const SizedBox(),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
