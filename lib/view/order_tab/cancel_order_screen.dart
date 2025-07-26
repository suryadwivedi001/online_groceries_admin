import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/color_extension.dart';
import '../../common_widget/my_order_row.dart';
import 'order_detail_screen.dart';
import '../../view_model/order_view_model.dart';

class CancelOrderScreen extends StatefulWidget {
  const CancelOrderScreen({super.key});

  @override
  State<CancelOrderScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final oVM = Get.find<OrderViewModel>();

    return Scaffold(
      body: Obx(
        () => oVM.cancelOrderArr.isEmpty
            ? Center(
                child: Text(
                  "No Order",
                  style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                itemBuilder: (context, index) {
                  var obj = oVM.cancelOrderArr[index];
                  return MyOrderRow(
                      mObj: obj,
                      onTap: () {
                        Get.to(() => OrderDetailScreen(obj: obj));
                      });
                },
                itemCount: oVM.cancelOrderArr.length,
              ),
      ),
    );
  }
}
