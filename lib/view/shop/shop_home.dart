import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shop_api/controller/product_controller.dart';
import 'package:shop_api/model/product_model.dart';

class ShopHome extends StatefulWidget {
  const ShopHome({super.key});

  @override
  State<ShopHome> createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {
  List<ProductModel> productList = [];
  getProduct() async {
    await ProductController().getProucts().then((value) {
      setState(() {
        productList = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Shop'),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) => productWidget(productList[index]),
      ),
    );
  }

  Widget productWidget(ProductModel pro) => ExpansionTile(
        initiallyExpanded: true,
        title: Text(pro.title),
        children: [
          Row(
            children: [
              Flexible(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: CachedNetworkImage(
                    imageUrl: pro.image,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const Expanded(child: Text('Man T-shirt'))
            ],
          )
        ],
      );
}
