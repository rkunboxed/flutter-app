import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
      decoration: InputDecoration(labelText: 'Email', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required';
        // } else if (!RegExp(
        //         r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        //     .hasMatch(value)) {
        //   return 'Entry must be in a valid email format';
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
      decoration: InputDecoration(labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required';
        }
      },
      onSaved: (String value) {
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

  Future _authenticate() async {
    if (!_formKey.currentState.validate()) {
      return null;
    }
    _formKey.currentState.save();

    var _authString = _email + ':' + _password;
    var _authBytes = utf8.encode(_authString);
    var _auth64 = base64.encode(_authBytes);
    var _authHeader = 'Basic ' + _auth64;

    HttpClient client = new HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    client.postUrl(Uri.parse('https://redfalcondev.com/auth/login/'))
        .then((HttpClientRequest request) {
          request.headers.add(HttpHeaders.CONTENT_TYPE, 'application/json');
          request.headers.add(HttpHeaders.AUTHORIZATION, _authHeader);

          return request.close();
        })
        .then((HttpClientResponse response) {
          print(response.statusCode);
          // Process the response.
          if (response.statusCode == 200) {
            print('YOU DID IT');
            Navigator.pushReplacementNamed(context, '/');
          }
        });
  }

  // test how to open up a new web url (not linked to form data)
  // _launchURL() async {
  //   final String clientId = '123';
  //   final String redirect = 'http://google.com';
  //   final String url = 'https://flow.polar.com/oauth2/authorization?response_type=code&client_id=' + clientId + '&redirect_uri=' + redirect;
    
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
            decoration: BoxDecoration(image: DecorationImage(
              image: AssetImage('assets/mtn-road.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop)
              )),
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                _buildEmailTextField(),
                SizedBox(height: 10.0),
                _buildPasswordTextField(),
                SizedBox(height: 10.0),
                _buildSwitchListTile(),
                RaisedButton(
                  child: Text('LOGIN'),
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  onPressed: () {
                    //_submitCreds();
                    //_launchURL();
                    _authenticate();
                  },
                ),
              ]),
            ),
          ),
        );
  }
}
