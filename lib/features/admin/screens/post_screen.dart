import 'package:amazon_clone/Models/product.dart';
import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/add_products.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final AdminServices adminServices = AdminServices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  void fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    print("Sahil : " + products.toString());
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
        showSnackBar(context, "The Product deleted successfully");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const CustomLoader()
        : Scaffold(
            body: GridView.builder(
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: SingleProduct(
                          image: productData.images[0],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteProduct(productData, index);
                            },
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      )
                    ],
                  );
                }),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductScreen.routeName);
              },
              tooltip: "Add a Product",
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
  }
}
