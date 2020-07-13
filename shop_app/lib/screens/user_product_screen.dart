import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product';

  Future<void> _refreshProducts(BuildContext context) async{
    await Provider.of<Products>(context,listen: false).fetchAndSetProducts(true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Manage Products',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder:(ctx,snapshot)=> snapshot.connectionState == ConnectionState.waiting ? Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.purple),
          ),
        ) :RefreshIndicator(
          onRefresh: ()=> _refreshProducts(context),
          child: Consumer<Products>(
            builder:(ctx,productsData,_)=> Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemBuilder: (_, i) =>
                    Column(
                      children: [
                        UserProductItem(
                          id: productsData.items[i].id,
                          title: productsData.items[i].title,
                          imgUrl: productsData.items[i].imageUrl,
                        ),
                        Divider(),
                      ],
                    ),
                itemCount: productsData.items.length,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(EditProductScreen.routeName);
        },
      ),
    );
  }

}
