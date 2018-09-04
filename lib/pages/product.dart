import 'package:flutter/material.dart';

import 'dart:async';

class ProductPage extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final String location;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl, this.description, this.price, this.location);

  _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content:
              Text('This action cannot be undone'),
          actions: <Widget>[
            FlatButton(
              child: Text('NEVERMIND'),
              onPressed: () {
                Navigator.pop(context); //this just closes the dialog
              },
            ),
            FlatButton(
              child: Text('YES DELETE'),
              onPressed: () {
                Navigator.pop(context); //closes dialog
                Navigator.pop(context,true); //continues on with `true` value that deletes the product
              },
            ),
          ],
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //willpopscope is manual way to handle back button
        print('back button pressed');
        Navigator.pop(context,
            false); //this allows data to be passed (in this case, `false`)
        return Future.value(
            false); //this allows the actual routing; false says ignore original request and proceed with the manual one (the navigator pop above)
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(imageUrl),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(title, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, fontFamily: 'Oswald')),
                  ),
                  Row(children: <Widget>[
                    SizedBox(width: 10.0),
                    Expanded(child: Text(description, style: TextStyle(fontSize: 18.0))),
                    Text('\$' + price.toString(), style: TextStyle(fontSize: 18.0)),
                    SizedBox(width: 10.0)
                  ],),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          child: Text('DELETE'),
                          //onPressed: () => Navigator.pop(context, true)
                          onPressed: () => _showWarningDialog(context)
                      )
                  )
                ]),
          ),
    );
  }
}
