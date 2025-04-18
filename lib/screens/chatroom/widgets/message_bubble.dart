import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/models/chat_message_model.dart';
import 'package:flatypus/models/user_model.dart';
import 'package:flatypus/services/firestore/chatroom_service.dart'
    show ChatRoomService;
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.user,
    required this.userColor,
  });
  final ChatMessageModel message;
  final UserModel user;
  final Color userColor;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final isMe = message.senderId == currentUser?.uid;
    return Container(
      decoration: BoxDecoration(
        color:
            isMe
                ? AppColors.secondaryColor.withAlpha(alphaFromOpacity(.5))
                : AppColors.primaryColor,
        borderRadius: BorderRadius.all(kRadius).copyWith(
          bottomRight: isMe ? Radius.circular(6) : kRadius,
          topLeft: !isMe ? Radius.circular(6) : kRadius,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.only(
        bottom: 10,
        left: isMe ? 24 : 0,
        right: !isMe ? 24 : 0,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMe)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      user.photoURL ?? '',
                      height: 30,
                      width: 30,
                    ),
                  ),
                SizedBox(width: !isMe ? 12 : 5),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isMe)
                        Text(
                          user.displayName?.capitalizeAll() ??
                              user.email ??
                              user.phoneNumber ??
                              'User',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            color: isMe ? AppColors.white : userColor,
                          ),
                        ),

                      // if (!isMe) const SizedBox(height: 3),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: ChatRoomService().decryptMessage(
                                message.encryptedText,
                                message.iv,
                              ),
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                color: AppColors.white.withAlpha(
                                  alphaFromOpacity(1),
                                ),
                                fontSize: 15,
                              ),
                            ),
                            TextSpan(
                              text: ' *********',
                              style: TextStyle(color: Colors.transparent)
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 2,)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(),
              child: Text(
                chatTimeStampFormat.format(message.timestamp),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.white.withAlpha(alphaFromOpacity(.7)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
