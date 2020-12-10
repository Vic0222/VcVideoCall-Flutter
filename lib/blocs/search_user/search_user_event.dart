//Use class instead of enum to pass data to events

import 'package:equatable/equatable.dart';

abstract class SearchUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchUserStarted extends SearchUserEvent {
  SearchUserStarted(this.keyword);

  final String keyword;

  @override
  List<Object> get props => [keyword];
}
