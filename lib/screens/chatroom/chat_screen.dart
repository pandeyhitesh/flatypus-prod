import 'package:color_log/color_log.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/widgets/custom_text_n_icon_button.dart';
import 'package:flatypus/common/widgets/text_input_field_custom.dart';
import 'package:flatypus/screens/chatroom/widgets/show_message_list.dart';
import 'package:flatypus/services/firestore/chatroom_service.dart';
import 'package:flatypus/state/controllers/floating_add_button_controller.dart';
import 'package:flatypus/theme/borders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_colors.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  ConsumerState<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageTextController = TextEditingController();
  final _focusNode = FocusNode();
  final _scrollController = ScrollController();
  Color _sendButtonColor = _inactiveButtonColor;
  static const _inactiveButtonColor = AppColors.primaryColor;
  static const _activeButtonColor = AppColors.yellowAccent2;
  bool _isLoading = false;

  void _onMessageTextChange(String? messageText) {
    print('messageText: $messageText');
    if (messageText != null && messageText.isNotEmpty) {
      setState(() {
        _sendButtonColor = _activeButtonColor;
      });
    } else {
      setState(() {
        _sendButtonColor = _inactiveButtonColor;
      });
    }
  }

  void _onSendButtonClick() async {
    if (_isLoading) return;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // send message to firestore
      try {
        setState(() {
          _isLoading = true;
        });
        await ChatRoomService().sendMessage(
          messageText: _messageTextController.text,
          houseId: 'TbJDaKhp4kNf6QbTNSIU',
        );
        _messageTextController.clear();
        if (mounted) {
          FocusScope.of(context).unfocus();
          _resetFloatingAddButton(true);
          _scrollController.animateTo(
            0,
            duration: Duration(milliseconds: 500),
            curve: Curves.linear,
          );
        }
        setState(() {
          _sendButtonColor = kBackgroundColor;
        });
      } catch (e) {
        clog.error('Error: Failed to send message, error: $e');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _resetFloatingAddButton(bool value) {
    ref.read(floatingAddButtonControllerProvider.notifier).state = value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: ShowMessageList(scrollController: _scrollController)),
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: kRadius,
              topRight: kRadius,
            ),
            border: Border(
              top: BorderSide(
                width: 1,
                color: AppColors.white.withAlpha(alphaFromOpacity(.5)),
              ),
            ),
          ),
          padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextInputField(
                  hintText: 'Type a message',
                  controller: _messageTextController,
                  focusNode: _focusNode,
                  onChanged: _onMessageTextChange,
                  validationFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Message cannot be empty';
                    }
                    return null;
                  },
                  onTap: () {
                    _resetFloatingAddButton(false);
                    _formKey.currentState!.reset();
                  },
                  onFieldSubmitted: () {
                    _resetFloatingAddButton(true);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, bottom: 10),
                      child: CustomTextNIconButton(
                        label: 'Send',
                        icon: Icons.send,
                        onTap: _onSendButtonClick,
                        backgroundColor: _sendButtonColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
