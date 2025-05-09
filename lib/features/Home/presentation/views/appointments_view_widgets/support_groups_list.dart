/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/features/Home/presentation/views/appointments_view_widgets/info_row.dart'
    show infoRow;

class SupportGroupsList extends StatefulWidget {

  const SupportGroupsList({super.key,});

  @override
  State<SupportGroupsList> createState() => _SupportGroupsListState();
}

class _SupportGroupsListState extends State<SupportGroupsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.supportGroups.isEmpty) {
      return const Center(child: Text(''));
    }

    return SizedBox(
      height: 240.h,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: widget.supportGroups.length,
          itemBuilder: (context, index) {
            final group = widget.supportGroups[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SizedBox(
                width: 250.w,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: ListView(
                      children: [
                        Text(
                          group.title,
                          style: TextStyles.bold16,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        infoRow(Icons.access_time, "الوقت: ${group.date}"),
                        infoRow(
                            Icons.timer_outlined, "المدة: ${group.duration}"),
                        infoRow(
                            Icons.event_seat, "عدد المقاعد: ${group.seats}"),
                        infoRow(Icons.attach_money,
                            "السعر: ${group.price.toStringAsFixed(2)}"),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
*/
