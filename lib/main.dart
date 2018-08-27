import 'package:flutter/material.dart';

//import './pages/auth.dart';
import './pages/manage.dart';
import './pages/products.dart';
import './pages/product.dart';
import './pages/auth.dart';

// void main() { //main function must be named "main" and must be in the main.dart file, void means it doesn't return anything
//   runApp(MyApp());
// }

//can also use fat arrows
//void main() => runApp(MyApp());
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
    State<StatefulWidget> createState() {
      return _MyAppState();
    }
}

class _MyAppState extends State<MyApp> {
  List <Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) { //void means it isn't going to return anything
      setState(() {
        _products.add(product); 
      });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    //widget and BuildContext are types
    return MaterialApp(
      //core root widget and widget tree
      //debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.deepOrange
      ),
      //home: AuthPage(), //can only use this or the / in routes, not both
      routes: { //can't use routes for dynamic paths though or passing data around (see onGenerateRoute below)
        '/': (BuildContext context) => ProductsPage(_products), //pass in the map and methods to make them avail to the sub page
        '/admin': (BuildContext context) => ManagePage(_addProduct, _deleteProduct),
        '/auth': (BuildContext context) => AuthPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        
        if (pathElements[0] != '') { //somehow determines if route started with a slash
          return null;
        }

        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]); //int.parse will convert the string to an int
          return MaterialPageRoute<bool>(
                          builder: (BuildContext context) => ProductPage(_products[index]['title'], _products[index]['image']),
                        );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) { //if null is returned during another routing call
        return MaterialPageRoute(
          builder: (BuildContext context) => ProductsPage(_products));
      },
    );
  }
}
