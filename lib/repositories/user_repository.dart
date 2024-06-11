import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserRepository {
  final String baseUrl = 'https://reqres.in/api';

  Future<List<User>> fetchUsers(int page) async {
    final response = await http.get(Uri.parse('$baseUrl/users?page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List users = data['data'];
      return users.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> fetchUserDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user detail');
    }
  }
}
