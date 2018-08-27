import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

Future<Post> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class AuthPage extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      return _AuthPageState();
    }
}

class _AuthPageState extends State<AuthPage> {
  String _username = '';
  String _password = '';
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Username'),
            keyboardType: TextInputType.emailAddress,
            onChanged: (String value) { //fires every keystroke
              setState(() {
                _username = value;
              });
            },
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
            onChanged: (String value) {
              setState(() {
                _password = value;
              });
            },
          ),
          SizedBox(height: 10.0),
          SwitchListTile(
            value: _acceptTerms,
            onChanged: (bool value) {
              setState(() {
                _acceptTerms = value;
              });
            },
            title: Text('Accept Terms')
          ),
          RaisedButton(
            child: Text('LOGIN'),
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () {
              //send login info
              Navigator.pushReplacementNamed( //results in the inability to go back (no back button)
                context,
                '/'
              );
            },
          ),
          SizedBox(height: 10.0),
          FutureBuilder<Post>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
          ]),
      )
    );
  }
}