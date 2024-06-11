import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/user_repository.dart';
import 'blocs/user_list/user_list_bloc.dart';
import 'screens/user_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter User App',
      theme: ThemeData(
        fontFamily: 'SFPro',
      ),
      home: BlocProvider(
        create: (context) => UserListBloc(UserRepository()),
        child: UserListScreen(),
      ),
    );
  }
}
