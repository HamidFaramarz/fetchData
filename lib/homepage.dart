import 'dart:convert';

import 'package:diotest/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Users> user = [];
  Future<List<Users>> getAll() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:1337/api/apps/"));
    if (response.statusCode == 200) {
      user.clear();
    }
    final decodedData = jsonDecode(response.body);
    for (var u in decodedData["data"]) {
      user.add(Users(
          u['id'], u['attributes']["name"], u['attributes']["email"], ""));
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Fetch Data from API"),
        ),
        body: FutureBuilder(
            future: getAll(),
            builder: (context, AsyncSnapshot<List<Users>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, index) => InkWell(
                          child: ListTile(
                            title: Text(snapshot.data?[index]?.name ?? ""),
                            subtitle: Text(snapshot.data?[index]?.email ?? ""),
                            onTap: () {},
                          ),
                        ));
              }
            }));
  }
}
