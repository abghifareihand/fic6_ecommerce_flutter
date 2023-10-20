part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchProductName extends SearchEvent {
  final String name;
  SearchProductName({
    required this.name,
  });
}
