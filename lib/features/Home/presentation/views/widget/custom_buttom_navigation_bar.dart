import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/helper_functions/is_device_in_portrait.dart';
import 'package:nafsia_app/features/Home/domain/entities/buttom_navigation_bar_entity.dart';
import 'package:nafsia_app/features/Home/presentation/views/widget/buttom_navigation_bar_item.dart';

// ignore: must_be_immutable
class CustomButtonNavigationBar extends StatefulWidget {
  int selectedIndex = 0;
  ValueChanged<int> onItemTapped;
  CustomButtonNavigationBar(
      {super.key, this.selectedIndex = 0, required this.onItemTapped});

  @override
  State<CustomButtonNavigationBar> createState() =>
      _CustomButtonNavigationBarState();
}

class _CustomButtonNavigationBarState extends State<CustomButtonNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: isDeviceInPortrait(context) ? 70.h : 120.h,
        decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
            shadows: [
              BoxShadow(
                color: Color(0x19000000),
                offset: Offset(0, -2),
                blurRadius: 25,
                spreadRadius: 0,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: buttonNavigationBarEntityList.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onItemTapped(index);
                  });
                },
                child: ButtonNavigationBarItem(
                  isSelected: widget.selectedIndex == index,
                  barEntity: item,
                ));
          }).toList(),
        ));
  }
}
