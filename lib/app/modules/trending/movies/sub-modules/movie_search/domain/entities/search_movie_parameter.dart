class SearchMovieParameter {
  final String searchValue;
  final String language;
  final int page;

  const SearchMovieParameter(
      {required this.language,
        required this.searchValue,
        required this.page});
}