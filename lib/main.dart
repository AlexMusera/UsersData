import 'package:flutter/material.dart';
import 'package:users/views/user_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromRGBO(47, 169, 214, 1)),
      home: ListUsersPage(),
    );
  }
}
