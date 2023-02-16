import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  List<dynamic>? _userProfile;
  // function to get image

  Future<void> fetchUserProfile() async {
    var response =
        await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _userProfile = data['data'];
      });
    }
  }

  @override
  void initState() {
    fetchUserProfile();
    super.initState();
  }

  Widget _buildMyList() {
    if (_userProfile == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: _userProfile!.length,
      itemBuilder: (context, index) {
        final userProfile = _userProfile![index];
        return Card(
          color: Colors.lightBlue[100],
          child: ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(userProfile['avatar'])),
            title: Text(
                "${userProfile['first_name']} - ${userProfile['last_name']}"),
            subtitle: Text("${userProfile['email']}"),
            trailing: Text("${userProfile['id']}"),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () {
                // Get.to(() => PageThree());
              },
              child: Text("page 3"))
        ],
        title: const Text(
          "Next Page",
          style: TextStyle(color: Colors.amberAccent),
        ),
        centerTitle: true,
      ),
      body: _buildMyList(),
    );
  }
}
