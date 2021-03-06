import 'package:flutter/material.dart';

import '../pages/product_create.dart';
import '../pages/product_list.dart';

class ManagePage extends StatelessWidget {
  final Function addProduct;

  ManagePage(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        //tab wrapper
        length: 2, //number of tabs
        child: Scaffold(
          drawer: Drawer(
              child: Column(
            children: <Widget>[
              AppBar(automaticallyImplyLeading: false, title: Text('Uhhhh')),
              ListTile(
                leading: Icon(Icons.shop),
                title: Text('Back to Products'),
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/'
                  );
                },
              )
            ],
          )),
          appBar: AppBar(
            title: Text('Manage Product'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.create),
                  text: 'Create Product'
                ),
                Tab(
                  icon: Icon(Icons.list),
                  text: 'My Products'
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ProductCreatePage(addProduct),
              ProductListPage()
            ],
          )
        ),
      );
  }
}
