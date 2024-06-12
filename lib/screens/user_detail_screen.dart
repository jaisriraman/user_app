import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_detail/user_detail_bloc.dart';
import '../blocs/user_detail/user_detail_event.dart';
import '../blocs/user_detail/user_detail_state.dart';
import '../repositories/user_repository.dart';
import '../utils/image_resource.dart';

class UserDetailScreen extends StatelessWidget {
  final int userId;

  UserDetailScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Detail', style: TextStyle(fontFamily: FontResousrce.SF_Pro_Bold),)),
      body: BlocProvider(
        create: (context) => UserDetailBloc(UserRepository())..add(FetchUserDetail(userId)),
        child: BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (context, state) {
            if (state is UserDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserDetailLoaded) {
              final user = state.user;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                      radius: 50,
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: TextStyle(fontSize: 24,fontFamily: FontResousrce.SF_Pro_Bold),
                    ),
                    Text(user.email, style: TextStyle(fontFamily: FontResousrce.SF_Pro_Regular),),
                  ],
                ),
              );
            } else if (state is UserDetailError) {
              return Center(child: Text('Failed to load user detail', style: TextStyle(fontFamily: FontResousrce.SF_Pro_Regular),));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
