import 'package:equatable/equatable.dart';
import '../../models/user.dart';

abstract class UserListState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<User> users;
  final bool hasReachedMax;

  UserListLoaded(this.users, this.hasReachedMax);

  @override
  List<Object> get props => [users, hasReachedMax];
}

class UserListError extends UserListState {
  final String error;

  UserListError(this.error);

  @override
  List<Object> get props => [error];
}
