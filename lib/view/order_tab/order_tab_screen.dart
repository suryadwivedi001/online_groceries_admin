import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/color_extension.dart'; // already relative, no change needed
import 'cancel_order_screen.dart'; // already relative, no change needed
import 'completed_order_screen.dart'; // already relative, no change needed
import 'new_order_screen.dart'; // already relative, no change needed
import '../../view_model/order_view_model.dart'; // already relative, no change needed

class OrderTabScreen extends StatefulWidget {
  const OrderTabScreen({super.key});

  @override
  State<OrderTabScreen> createState() => _OrderTabScreenState();
}

class _OrderTabScreenState extends State<OrderTabScreen>
    with SingleTickerProviderStateMixin {
  final oVM = Get.put(OrderViewModel());

  TabController? controller;
  int selectTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller?.addListener(() {
      selectTab = controller?.index ?? 0;

      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller?.dispose();
    Get.delete<OrderViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Orders",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1,
                ),
              ],
            ),
            child: TabBar(
                controller: controller,
                indicatorColor: TColor.primary,
                indicatorWeight: 2,
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
                tabs: const [
                  Tab(
                    text: "New",
                  ),
                  Tab(
                    text: "Completed",
                  ),
                  Tab(
                    text: "Cancel",
                  )
                ]),
          ),
          const SizedBox(
            height: 1,
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: const [
                NewOrderScreen(),
                CompletedOrderScreen(),
                CancelOrderScreen(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
