import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final double price;

  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5.0)),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      child: Text(
        '\$' + price.toString(), //$ is special so you need to escape it
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
