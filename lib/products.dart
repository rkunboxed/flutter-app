import 'package:flutter/material.dart';

import './pages/product.dart';

// STATELESS EXAMPLE
class Products extends StatelessWidget {
  final List<Map<String, String>> products; //final means value will never change in this execution context if it gets called again the data will be replaced
  final Function deleteProduct;

  Products(this.products, {this.deleteProduct}); //constructor to grab data handed to it by the parent widget (see product_manager.dart)

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
            child: Column(
              children: <Widget>[
                Image.asset(products[index]['image']),
                Text(products[index]['title']),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(child: 
                      Text('Details'),
                      onPressed: () => Navigator.pushNamed<bool>(context, '/product/' + index.toString())
                        
                      .then((bool value) {
                        if (value) {
                          deleteProduct(index);
                        }
                      }),
                    )
                  ],)
              ],
            ),);
  }

  Widget _buildProductList() {
    //long version
      Widget productCards = Center(child: Text('No products found.'));

      if (products.length > 0) {
        productCards = ListView.builder( 
          itemBuilder: _buildProductItem,
          itemCount: products.length,
        );
      }

      return productCards;

      // short version w/ternary
      // return products.length > 0 ? ListView.builder(
      //   itemBuilder: _buildProductItem,
      //   itemCount: products.length,
      // ) : Center(child: Text('No products found.'));
  }

  @override
    Widget build(BuildContext context) {
      return _buildProductList();
    }
}

// OLD WAY
  // children: products
  //   .map((element) => Card(
  //         child: Column(
  //           children: <Widget>[
  //             Image.asset('assets/food.jpg'),
  //             Text(element)
  //           ],
  //         ),
  //       ))
  //   .toList(),