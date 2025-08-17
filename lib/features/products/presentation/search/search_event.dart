abstract class SearchEvent {
  const SearchEvent();
}

class SearchProducts extends SearchEvent {
  final String query;

  const SearchProducts(this.query);
}