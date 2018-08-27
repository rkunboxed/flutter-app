import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {

  final Function addProduct;
  final Function deleteProduct;

  ProductCreatePage(this.addProduct, this.deleteProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String titleValue = '';
  String descValue = '';
  double priceValue = 0.0;
  


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(children: <Widget>[
      TextField(
        decoration: InputDecoration(labelText: 'Title'),
        onChanged: (String value) { //fires every keystroke
          setState(() {
            titleValue = value;
          });
        },
      ),
      TextField(
        decoration: InputDecoration(labelText: 'Description'),
        maxLines: 3,
        onChanged: (String value) {
          setState(() {
            descValue = value;
          });
        },
      ),
      TextField(
        decoration: InputDecoration(labelText: 'Price'),
        keyboardType: TextInputType.number,
        onChanged: (String value) {
          setState(() {
            priceValue = double.parse(value);
          });
        },
      ),
      SizedBox(height: 10.0),
      RaisedButton(
        child: Text('Save'),
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        onPressed: () {
          final Map<String, dynamic> product = {
            'title': titleValue,
            'description': descValue,
            'price': priceValue,
            'image': 'assets/food.jpg'
          };
          widget.addProduct(product);
          Navigator.pushReplacementNamed(context, '/');
          // showModalBottomSheet(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return Column(children: <Widget>[
          //         Text('This is a modal'),
          //       ]);
          //     });
        },
      ),
    ]));
  }
}
