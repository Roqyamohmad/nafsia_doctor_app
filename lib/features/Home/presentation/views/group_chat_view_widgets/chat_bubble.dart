import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isDoctor;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isDoctor,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool _showActions = false;

  void _handleHorizontalDrag(DragUpdateDetails details) {
    // إذا سحب جهة اليمين (من اليسار لليمين)
    if (details.delta.dx > 10) {
      setState(() => _showActions = false);
    }
    // إذا سحب جهة اليسار (من اليمين لليسار)
    if (details.delta.dx < -10) {
      setState(() => _showActions = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isDoctor ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onHorizontalDragUpdate: _handleHorizontalDrag,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: widget.isDoctor ? AppColors.primaryColor : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(widget.isDoctor ? 16 : 0),
              bottomRight: Radius.circular(widget.isDoctor ? 0 : 16),
            ),
          ),
          child: Column(
            crossAxisAlignment: widget.isDoctor
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                widget.message,
                style: TextStyles.bold16.copyWith(color: Colors.white),
              ),
              if (_showActions &&
                  (widget.onEdit != null || widget.onDelete != null))
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.onEdit != null)
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          size: 24,
                          color: Colors.white,
                        ),
                        onPressed: widget.onEdit,
                        tooltip: "تعديل",
                      ),
                    if (widget.onDelete != null)
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          size: 24,
                          color: Colors.white,
                        ),
                        onPressed: widget.onDelete,
                        tooltip: "حذف",
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
