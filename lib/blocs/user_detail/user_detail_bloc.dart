import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/user.dart';
import '../../repositories/user_repository.dart';
import 'user_detail_event.dart';
import 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserRepository userRepository;

  UserDetailBloc(this.userRepository) : super(UserDetailInitial()){
    on<FetchUserDetail>((event, emit) async {
     emit (UserDetailLoading());
      try {
        final user = await userRepository.fetchUserDetail(event.userId);
        emit (UserDetailLoaded(user));
      } catch (e) {
        emit (UserDetailError(e.toString()));
      }
    });
  }
}
