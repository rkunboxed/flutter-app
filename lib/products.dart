import 'package:flutter/material.dart';

// STATELESS EXAMPLE
class Products extends StatelessWidget {
  final List<Map<String, dynamic>>
      products; //final means value will never change in this execution context if it gets called again the data will be replaced

  Products(
      this.products); //constructor to grab data handed to it by the parent widget (see product_manager.dart)

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      margin: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Text(products[index]['title'],
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Oswald',
                          ))),
                  SizedBox(width: 20.0),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(5.0)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                    child: Text(
                      '\$' +
                          products[index]['price']
                              .toString(), //$ is special so you need to escape it
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )),
          //DecoratedBox(
          //limiited styling, no padding but can use Padding widget or switch to container
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                margin: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text('Union Square, San Francisco'))
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                child: IconButton(
                  icon: Icon(Icons.info),
                  color: Theme.of(context).accentColor,
                  onPressed: () => Navigator.pushNamed<bool>(
                      context, '/product/' + index.toString()))
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                child: IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Colors.red,
                  onPressed: () => Navigator.pushNamed<bool>(
                      context, '/product/' + index.toString()))
              )],
          )
        ],
      ),
    );
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
