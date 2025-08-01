import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/color_extension.dart';
import '../../common_widget/product_cell.dart';
import '../offer_tab/offer_add_screen.dart';
import 'product_add_screen.dart';
import '../../view_model/product_view_model.dart';

class ProductTabScreen extends StatefulWidget {
  const ProductTabScreen({super.key});

  @override
  State<ProductTabScreen> createState() => _ProductTabScreenState();
}

class _ProductTabScreenState extends State<ProductTabScreen> {
  late final ProductViewModel pVM;

  @override
  void initState() {
    super.initState();

    // Find the existing instance created in MainTabView
    pVM = Get.find<ProductViewModel>();
    print('[DEBUG] ProductTabScreen initState: Found ProductViewModel instance');
  }

  @override
  Widget build(BuildContext context) {
    print('[DEBUG] ProductTabScreen build: product count = ${pVM.listArr.length}');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Product List",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {
                print('[DEBUG] Add product button tapped');
                Get.to(() => const ProductAddScreen());
              },
              child: Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: TColor.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/img/add.png",
                    width: 15,
                    height: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        print('[DEBUG] Obx rebuild: product count = ${pVM.listArr.length}');
        if (pVM.listArr.isEmpty) {
          print('[DEBUG] Product list is empty - showing fallback UI');
          return Center(child: Text("No products found"));
        }

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 2,
            mainAxisSpacing: 8,
          ),
          itemCount: pVM.listArr.length,
          itemBuilder: (context, index) {
            final obj = pVM.listArr[index];
            print('[DEBUG] Building product cell for index $index: ${obj.name}');
            return ProductCell(
              pObj: obj,
              onPressed: () async {
                print('[DEBUG] ProductCell tapped for: ${obj.name}');
                await Get.to(() => OfferAddScreen(obj: obj));
                print('[DEBUG] Returned from OfferAddScreen, refreshing list');
                pVM.apiList();
              },
              onEdit: () {
                print('[DEBUG] Edit triggered on product: ${obj.name}');
                pVM.actionEdit(obj);
              },
              onDelete: () {
                print('[DEBUG] Delete triggered on product: ${obj.name}');
                pVM.actionDelete(obj);
              },
            );
          },
        );
      }),
    );
  }
}
