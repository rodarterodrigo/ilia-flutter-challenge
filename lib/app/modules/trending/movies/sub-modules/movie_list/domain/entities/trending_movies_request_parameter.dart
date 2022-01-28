class TrendingMoviesRequestParameter {
  final String timeWindow;
  final String language;
  final String locationLanguage;
  final int page;

  const TrendingMoviesRequestParameter(
      {required this.language,
      required this.locationLanguage,
      required this.timeWindow,
      required this.page});
}
