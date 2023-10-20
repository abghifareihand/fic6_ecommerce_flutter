part of 'search_bloc.dart';

abstract class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final ListProductResponseModel listProduct;
  SearchSuccess({
    required this.listProduct,
  });
}

final class SearchError extends SearchState {}
