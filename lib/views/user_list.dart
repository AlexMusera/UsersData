import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:users/model/userdata.dart';
import 'package:http/http.dart' as http;
import 'package:users/views/user_detail.dart';

class ListUsersPage extends StatefulWidget {
  const ListUsersPage({super.key});

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListUsersPage> {
  List<UserData> _userData = <UserData>[];
  bool isLoading = false;
  void _openPage(String selected) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return SelectedUserDetailPage(selected);
        },
      ),
    );
  }

  _fetchUsers() async {
    setState(() {
      isLoading = true;
    });
    var url =
        Uri.parse('https://lionfish-app-qkntx.ondigitalocean.app/api/users');
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        _userData = (json.decode(response.body) as List)
            .map((userData) => UserData.fromJson(userData))
            .toList();
        setState(() {
          isLoading = false;
        });
        for (int i = 0; i < _userData.length; i++) {
          print(_userData.elementAt(i).name);
          print(_userData.elementAt(i).email);
          print("===");
        }
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      return 'failed';
    }
  }

  @override
  initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Users List"),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 2,
                    color: Colors.black,
                  );
                },
                itemCount: _userData.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      _openPage(_userData[index].id);
                    },
                    contentPadding: EdgeInsets.all(10.0),
                    title: Text(_userData[index].name),
                    subtitle: Text(_userData[index].email),
                  );
                }));
  }
}
