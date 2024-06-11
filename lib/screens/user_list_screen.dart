import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_list/user_list_bloc.dart';
import '../blocs/user_list/user_list_event.dart';
import '../blocs/user_list/user_list_state.dart';
import '../widgets/user_card.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadUsers();
  }

  void _loadUsers() {
    context.read<UserListBloc>().add(FetchUsers(_currentPage));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _currentPage++;
      });
      _loadUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state is UserListLoading && _currentPage == 1) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserListLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.users.length
                  : state.users.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.users.length) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return UserCard(user: state.users[index]);
                }
              },
            );
          } else if (state is UserListError) {
            return Center(child: Text('Failed to load users'));
          }
          return Center(child: Text('No users'));
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
