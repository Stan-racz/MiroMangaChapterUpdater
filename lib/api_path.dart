String getMangaInfoFromTitlePath(String title) {
  return "https://api.mangadex.org/manga?limit=10&title=$title&order%5BlatestUploadedChapter%5D=desc";
}

String getMangaChaptersFromMangaIdPath(String mangadexMangaId) {
  return "https://api.mangadex.org/chapter?limit=10&manga=$mangadexMangaId&translatedLanguage%5B%5D=en&&order%5Bchapter%5D=desc";
}
