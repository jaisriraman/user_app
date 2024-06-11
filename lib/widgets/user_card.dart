import 'package:flutter/material.dart';
import '../models/user.dart';
import '../screens/user_detail_screen.dart';

class UserCard extends StatelessWidget {
  final User user;

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatar),
        ),
        title: Text('${user.firstName} ${user.lastName}'),
        subtitle: Text(user.email),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailScreen(userId: user.id),
            ),
          );
        },
      ),
    );
  }
}
