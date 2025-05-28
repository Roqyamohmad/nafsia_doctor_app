import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/message_cubit/message_cubit.dart';
import 'package:nafsia_app/features/Home/data/model/community_messages_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/message_cubit/message_state.dart';
import 'chat_bubble.dart';

class DoctorChatPage extends StatefulWidget {
  final String sessionId;
  final String sessionTitle;

  const DoctorChatPage({
    super.key,
    required this.sessionId,
    required this.sessionTitle,
  });

  @override
  State<DoctorChatPage> createState() => _DoctorChatPageState();
}

class _DoctorChatPageState extends State<DoctorChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context
        .read<CommunityMessageCubit>()
        .getAllMessages(sessionId: widget.sessionId)
        .then((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0, // لأن reverse: true
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showEditDialog(CommunityMessageModel message) {
    final controller = TextEditingController(text: message.message);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("تعديل الرسالة"),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              context.read<CommunityMessageCubit>().updateMessage(
                    messageId: message.id,
                    newMessage: controller.text.trim(),
                  );
              Navigator.pop(context);
              _scrollToBottom();
            },
            child: const Text("حفظ"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommunityMessageCubit, CommunityMessageState>(
      listener: (context, state) {
        if (state is CommunityMessageSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إرسال الرسالة')),
          );
          _scrollToBottom();
        } else if (state is CommunityMessageFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('خطأ: ${state.error}')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.sessionTitle,
            style: TextStyles.bold19.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<CommunityMessageCubit, CommunityMessageState>(
                builder: (context, state) {
                  final messages =
                      context.read<CommunityMessageCubit>().messages;
                  if (state is CommunityMessageLoading && messages.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: messages.length,
                    itemBuilder: (_, index) {
                      final msg = messages[index];
                      return ChatBubble(
                        message: msg.message,
                        isDoctor: true,
                        onEdit: () => _showEditDialog(msg),
                        onDelete: () {
                          context.read<CommunityMessageCubit>().deleteMessage(
                                messageId: msg.id,
                              );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'اكتب رسالة...',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.teal,
                    ),
                    child: IconButton(
                      onPressed: () {
                        final msg = messageController.text.trim();
                        if (msg.isNotEmpty) {
                          context.read<CommunityMessageCubit>().sendMessage(
                                sessionId: widget.sessionId,
                                message: msg,
                              );
                          messageController.clear();
                        }
                      },
                      icon: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
