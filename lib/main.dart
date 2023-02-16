import 'dart:convert';
import 'package:diotest/next.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic>? _users;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    final data = jsonDecode(response.body);
    setState(() {
      _users = data['data'];
    });
  }

  Widget _buildList() {
    if (_users == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: _users!.length,
      itemBuilder: (context, index) {
        final user = _users![index];
        return Card(
          color: Colors.lightBlue[100],
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user['avatar']),
            ),
            title: Text('${user['first_name']} ${user['last_name']}'),
            subtitle: Text(user['email']),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.to(() => const NextPage());
              },
              child: const Text("Next"))
        ],
      ),
      body: _buildList(),
    );
  }
}
