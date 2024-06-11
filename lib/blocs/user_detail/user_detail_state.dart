import 'package:equatable/equatable.dart';
import '../../models/user.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object> get props => [];
}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailLoaded extends UserDetailState {
  final User user;

  const UserDetailLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserDetailError extends UserDetailState {
  final String error;

  const UserDetailError(this.error);

  @override
  List<Object> get props => [error];
}
