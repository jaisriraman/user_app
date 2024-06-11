import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/user.dart';
import '../../repositories/user_repository.dart';
import 'user_list_event.dart';
import 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserRepository userRepository;
  bool isFetching = false;

  UserListBloc(this.userRepository) : super(UserListInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserListState> emit) async {
    if (isFetching || (state is UserListLoaded && (state as UserListLoaded).hasReachedMax)) return;

    isFetching = true;
    try {
      if (state is UserListInitial) {
        emit(UserListLoading());
      }

      final users = await userRepository.fetchUsers(event.page);

      if (state is UserListLoaded) {
        final currentState = state as UserListLoaded;
        emit(UserListLoaded(
          currentState.users + users,
          users.isEmpty,
        ));
      } else {
        emit(UserListLoaded(users, users.isEmpty));
      }
    } catch (e) {
      emit(UserListError(e.toString()));
    }
    isFetching = false;
  }
}
