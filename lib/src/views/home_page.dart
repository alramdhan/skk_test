import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skk_test/src/constants.dart';
import 'package:skk_test/src/model/User.dart';
import 'package:skk_test/src/service/api_client.dart';

import 'package:skk_test/src/view.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.title,
    required this.accesstoken
  }) : super(key: key);

  final String title;
  final String accesstoken;

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final ApiClient _apiClient = ApiClient();

  Future<List<User>> _getAllUsers() async {
    var _users = await _apiClient.getAllUsers(widget.accesstoken);

    return _users;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> logout() async {
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const LoginPage(title: "SKK Test")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      appBar: AppBar(
        backgroundColor: lightDarkBlue,
        title: const Text("SKK Test"),
      ),
      body: FutureBuilder<List<User>>(
        future: _getAllUsers(),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);
          if(snapshot.hasData) {
            return UserBoxListener(items: snapshot.data);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}

class UserBoxListener extends StatelessWidget {
  const UserBoxListener({
    Key? key,
    required this.items
  }) : super(key: key);

  final List<User>? items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: UserBox(item: items![index]),
          onTap: () {

          },
        );
      },
    );
  }
}

class UserBox extends StatelessWidget {
  const UserBox({
    Key? key,
    required this.item
  }) : super(key: key);

  final User item;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(2.0),
      height: 150.0,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network(item.profilepicture,
              width: 150,
              height: 150
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(item.name),
                    Text("Price: " + item.email)
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}