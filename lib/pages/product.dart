import 'package:flutter/material.dart';

import 'dart:async';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl);

  @override
    Widget build(BuildContext context) {
      return WillPopScope(onWillPop: () {//willpopscope is manual way to handle back button
        print('back button pressed');
        Navigator.pop(context, false);//this allows data to be passed (in this case, `false`)
        return Future.value(false); //this allows the actual routing; false says ignore original request and proceed with the manual one (the navigator pop above)
      }, child:
        Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(child: Column(
          // wrapping the column in a center widget plus the following two settings
          // will center everything vertically and horizontally
          //mainAxisAlignment: MainAxisAlignment.center, //(vertical entering)
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageUrl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(title),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                // child: Text('Custom Back Btn'),
                // onPressed: () => Navigator.pop(context)
                child: Text('DELETE'),
                onPressed: () => Navigator.pop(context, true)
              )
            )
          ]),
      )),);
    }
}