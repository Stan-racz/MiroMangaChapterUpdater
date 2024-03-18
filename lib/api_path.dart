String getMangaInfoFromTitlePath(String title) {
  return "https://api.mangadex.org/manga?limit=10&title=$title&order%5BlatestUploadedChapter%5D=desc";
}
