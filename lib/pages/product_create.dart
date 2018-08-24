import 'package:flutter/material.dart';

class ProductCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      RaisedButton(
        child: Text('Save'),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Column(children: <Widget>[
                  Text('This is a modal'),
                ]);
              });
        },
      ),
    ]);
  }
}
