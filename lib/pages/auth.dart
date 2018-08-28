import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
  String _email = '';
  String _password = '';
  bool _acceptTerms = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required';
        } else if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Entry must be in a valid email format';
        }
      },
      onSaved: (String value) {
        //do not need to use set state since we aren't displaying it anywhere requiring a rerender (rerun the build method)
        _email = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required';
        }
      },
      onSaved: (String value) {
        //do not need to use setState since we aren't displaying it anywhere requiring a rerender (rerun the build method)
        _password = value;
      },
    );
  }

  Widget _buildSwitchListTile() {
    return SwitchListTile(
      value: _acceptTerms,
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
      title: Text('Accept Terms')
    );
  }

  //testing plain old get request (not linked to form data)
  void _submitCreds() {
    // validate form fields
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save(); //executes onSave method for every text field
    // TODO: VALIDATE CREDS

    // test generic HTTP get request
    fetchPost().then((response) {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  // test how to open up a new web url (not linked to form data)
  _launchURL() async {
  final String clientId = '123';
  final String redirect = 'http://google.com';
  final String url = 'https://flow.polar.com/oauth2/authorization?response_type=code&client_id=' + clientId + '&redirect_uri=' + redirect;
  
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                _buildEmailTextField(),
                _buildPasswordTextField(),
                SizedBox(height: 10.0),
                _buildSwitchListTile(),
                RaisedButton(
                  child: Text('LOGIN'),
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  onPressed: () {
                    //_submitCreds();
                    _launchURL();
                  },
                ),
              ]),
            ),
          ),
          // Container(
          //     margin: EdgeInsets.all(20.0),
          //     child: FutureBuilder<Post>(
          //       future: fetchPost(),
          //       builder: (context, snapshot) {
          //         if (snapshot.hasData) {
          //           return Text(snapshot.data.title);
          //         } else if (snapshot.hasError) {
          //           return Text("${snapshot.error}");
          //         }

          //         // By default, show a loading spinner
          //         return CircularProgressIndicator();
          //       },
          //     ))
        ]));
  }
}
