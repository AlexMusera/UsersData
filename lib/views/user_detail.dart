import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:users/model/userdata.dart';

class SelectedUserDetailPage extends StatefulWidget {
  final String _selected;
  SelectedUserDetailPage(this._selected);
  @override
  _SelectedUserDetailPageState createState() =>
      new _SelectedUserDetailPageState();
}

class _SelectedUserDetailPageState extends State<SelectedUserDetailPage> {
  Map<String, dynamic> data = {};
  var isLoading = false;

  _fetchUserDetail() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse(
        'https://lionfish-app-qkntx.ondigitalocean.app/api/user/${widget._selected}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      print(data["name"]);
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load User details');
    }
  }

  @override
  initState() {
    super.initState();
    _fetchUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'User Details';
    return MaterialApp(
        title: appTitle,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
          ),
          body: Center(
            child: Text(data["bio"])
            Text('wazza')
            Text('Awilo'),

            // #docregion add-widget
            // body: const SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       NameSection(
            //         name: 'Oeschinen Lake Campground',
            //         email: 'Kandersteg, Switzerland',
            //       ),
            //       TextBio(
            //         bio: appTitle;
            //             // 'Lake Oeschinen lies at the foot of the Blüemlisalp in the '
            //             // 'Bernese Alps. Situated 1,578 meters above sea level, it '
            //             // 'is one of the larger Alpine Lakes. A gondola ride from '
            //             // 'Kandersteg, followed by a half-hour walk through pastures '
            //             // 'and pine forest, leads you to the lake, which warms to 20 '
            //             // 'degrees Celsius in the summer. Activities enjoyed here '
            //             // 'include rowing, and riding the summer toboggan run.',
            //       ),
            //     ],
            //   ),
            // ),
          ),
        ));
  }
}

class NameSection extends StatelessWidget {
  const NameSection({
    super.key,
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextBio extends StatelessWidget {
  const TextBio({
    super.key,
    required this.bio,
  });

  final String bio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        bio,
        softWrap: true,
      ),
    );
  }
}
