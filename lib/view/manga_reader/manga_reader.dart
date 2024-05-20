import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/reader_bloc/reader_bloc.dart';
import '../../bloc/reader_bloc/reader_state.dart';
import '../../model/chapter_model.dart';
import 'page_loading_widget.dart';

class MangaReader extends StatefulWidget {
  const MangaReader({
    super.key,
    required this.chapter,
  });
  final Chapter chapter;

  @override
  State<MangaReader> createState() => MangaReaderState();
}

class MangaReaderState extends State<MangaReader> {
  int index = 0;
  setPageUp(int currentPage) {
    setState(
      () {
        if (currentPage < widget.chapter.pages - 1) {
          index = currentPage + 1;
        }
      },
    );
  }

  setPageDown(int currentPage) {
    setState(
      () {
        if (currentPage > 0) {
          index = currentPage - 1;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.chapter.title,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<ReaderBloc, ReaderState>(
              builder: (context, state) {
                return switch (state) {
                  ChapterPagesLoading() => const PageLoadingWidget(),
                  PagesLoaded() => InteractiveViewer(
                      child: Image.network(
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            height: 40,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        state.pageList[index],
                      ),
                    ),
                  ReaderState() => const SizedBox()
                };
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    setPageDown(index);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Center(
                  child: Text(
                    "Page ${index + 1}/${widget.chapter.pages}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setPageUp(index);
                  },
                  icon: Icon(
                    Icons.arrow_forward_rounded,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
