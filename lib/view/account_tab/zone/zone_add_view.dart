import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/color_extension.dart';
import '../../../common_widget/line_textfield.dart';
import '../../../common_widget/round_button.dart';
import '../../../view_model/zone_view_model.dart';

class ZoneAddView extends StatefulWidget {
  final bool isEdit;
  const ZoneAddView({super.key, this.isEdit = false});

  @override
  State<ZoneAddView> createState() => _ZoneAddViewState();
}

class _ZoneAddViewState extends State<ZoneAddView> {
  final bVM = Get.put(ZoneViewModel());

  @override
  void dispose() {
    Get.delete<ZoneViewModel>();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height,
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 2),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.isEdit ? "Edit Zone" : "Add New Zone",
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Obx(
              () => LineTextField(
                  title: "Zone Name",
                  placeholder: "Enter Name",
                  controller: bVM.txtZoneName.value),
            ),
            const SizedBox(
              height: 25,
            ),
            RoundButton(
                title: widget.isEdit ? "Update" : "Add",
                onPressed: () {
                  if (widget.isEdit) {
                    bVM.actionUpdate(() {
                      Navigator.pop(context);
                    });
                  } else {
                    bVM.actionAdd(() {
                      Navigator.pop(context);
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
