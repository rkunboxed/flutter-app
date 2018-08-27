import 'package:flutter/material.dart';

import './products.dart';

// STATEFUL EXAMPLE - 2 classes connected
// class ProductManager extends StatefulWidget {
//   final Map<String, String> startingProduct; //map is like a JS object

//   ProductManager({this.startingProduct});
//   //ProductManager({this.startingProduct}); curly braces turn that into a named argument
//   //named argument would be passed with startingProduct: xyz
//   //need to wrap arguments in square brakets to make them optional (instead of curly braces)
//   //can set default value like: ProductManager({this.startingProduct = 'Sweets Tester'})

//   @override 
//   State<StatefulWidget> createState() {
//     return _ProductManagerState();
//   }
// }

// class _ProductManagerState extends State<ProductManager> {
//   // changes in state happen here
//   // underscores are used to denote private classes and properties
//   // they can't get called from anywhere else
//   List<Map<String, String>> _products = []; // list = array

//   @override
//   void initState() {//lifecycle hook
//     super.initState(); // super refers to base class you are extending (State in this case)

//     //populate our empty array with initial set of products from connected stateful widget
//     if (widget.startingProduct != null) {
//       _products.add(widget.startingProduct); //widget property gives you access to the connected stateful widget
//     }
    
//   }

//   //no need to run setState above becuase initState is run before anything is rendered in the Build step.
//   //setState is only needed when state is set and then needs to be modified.

  

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Container(
//         margin: EdgeInsets.all(10.0),
//         // moved to it's own widget
//         // child: RaisedButton(
//         //   color: Theme.of(context).accentColor,
//         //   onPressed: () {
//         //     setState(() {
//         //       _products.add('Advanced Food Tester'); 
//         //     });
//         //   },
//         //   child: Text('Add Product'),
//         // )
//         child: ProductControl(_addProduct), //pass reference to the function
//       ),
//       Expanded(
//         child: Products(_products, deleteProduct: _deleteProduct) //import custom products widget, send it the products list
//       )
//     ],);
//   }
// }

// CONVERTING TO STATELESS - moved state to Main.DragTarget

class ProductManager extends StatelessWidget {
final List<Map<String, dynamic>> products;

ProductManager(this.products);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Products(products) //import custom products widget, send it the products list
      )
    ],);
  }
}
