import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../account_tab/account_view.dart';
import '../category_tab/category_tab_screen.dart';
import '../offer_tab/offer_tab_view.dart';
import '../order_tab/order_tab_screen.dart';
import '../product_tab/product_tab_screen.dart';
import '../type_tab/type_tab_screen.dart';
import '../../common/color_extension.dart';
import '../../view_model/product_view_model.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> with SingleTickerProviderStateMixin {
  late TabController controller;
  int selectTab = 0;

  // Create and keep single controller instance
  final ProductViewModel pVM = Get.put(ProductViewModel());

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    controller = TabController(length: 5, vsync: this);

    controller.addListener(() {
      if (!controller.indexIsChanging) {
        selectTab = controller.index;
        setState(() {});

        if (selectTab == 0) {
          print('[DEBUG] Product tab selected, triggering apiList');
          pVM.apiList();
        }
      }
    });

    // Optionally, initially trigger apiList if first tab:
    if (selectTab == 0) {
      pVM.apiList();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(controller: controller, children: const [
        ProductTabScreen(),
        CategoryTabScreen(),
        TypeTabScreen(),
        OrderTabScreen(),
        AccountView(),
      ]),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, -2))
            ]),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: TabBar(
              controller: controller,
              indicatorColor: Colors.transparent,
              indicatorWeight: 1,
              labelColor: TColor.primary,
              labelStyle: TextStyle(
                color: TColor.primary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelColor: TColor.primaryText,
              unselectedLabelStyle: TextStyle(
                color: TColor.primaryText,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              tabs: [
                Tab(
                  text: "Product",
                  icon: Image.asset(
                    "assets/img/store_tab.png",
                    width: 25,
                    height: 25,
                    color: selectTab == 0 ? TColor.primary : TColor.primaryText,
                  ),
                ),
                Tab(
                  text: "Category",
                  icon: Image.asset(
                    "assets/img/explore_tab.png",
                    width: 25,
                    height: 25,
                    color: selectTab == 1 ? TColor.primary : TColor.primaryText,
                  ),
                ),
                Tab(
                  text: "Type",
                  icon: Image.asset(
                    "assets/img/explore_tab.png",
                    width: 25,
                    height: 25,
                    color: selectTab == 2 ? TColor.primary : TColor.primaryText,
                  ),
                ),
                Tab(
                  text: "Orders",
                  icon: Image.asset(
                    "assets/img/fav_tab.png",
                    width: 25,
                    height: 25,
                    color: selectTab == 3 ? TColor.primary : TColor.primaryText,
                  ),
                ),
                Tab(
                  text: "Account",
                  icon: Image.asset(
                    "assets/img/account_tab.png",
                    width: 25,
                    height: 25,
                    color: selectTab == 4 ? TColor.primary : TColor.primaryText,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
