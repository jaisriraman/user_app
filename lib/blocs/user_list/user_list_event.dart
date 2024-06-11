import 'package:equatable/equatable.dart';

abstract class UserListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends UserListEvent {
  final int page;

  FetchUsers(this.page);

  @override
  List<Object> get props => [page];
}
