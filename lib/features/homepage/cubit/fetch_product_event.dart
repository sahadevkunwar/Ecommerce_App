abstract class ProductEvent {}

class FetchProductEvent extends ProductEvent {
  final String query;
  FetchProductEvent({required this.query});
}

class RefreshProductEvent extends ProductEvent {
    final String query;
  RefreshProductEvent({required this.query});
}

class LoadMoreProductEvent extends ProductEvent {
      final String query;
  LoadMoreProductEvent({required this.query});
}
