import 'package:flutter/material.dart';
import '../../../common/color_extension.dart';
import '../../../model/zone_model.dart';

class ZoneRow extends StatelessWidget {
  final ZoneModel obj;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onPressed;

  const ZoneRow(
      {super.key,
      required this.obj,
      required this.onEdit,
      required this.onDelete, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 2),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                obj.zoneName ?? "",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton(
              onPressed: onEdit,
              icon: Icon(
                Icons.edit_square,
                color: TColor.primary,
                size: 20,
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
