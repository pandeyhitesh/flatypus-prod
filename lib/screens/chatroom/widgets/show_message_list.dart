import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_log/color_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/methods/get_user_message_color.dart';
import 'package:flatypus/models/chat_message_model.dart';
import 'package:flatypus/models/user_model.dart';
import 'package:flatypus/services/firestore/chatroom_service.dart';
import 'package:flatypus/state/providers/house_provider.dart';
import 'package:flatypus/state/providers/users_provider.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'message_bubble.dart';

// Custom class to hold messages and snapshots
class MessagesWithLastDocument {
  final List<ChatMessageModel> messages;
  final DocumentSnapshot? lastDocument;
  final bool initialLoad;

  MessagesWithLastDocument(this.messages, this.lastDocument, this.initialLoad);

  @override
  String toString() {
    return 'lastDocument: ${lastDocument?.data()}}, MessagesWithLastDocument{messages: $messages';
  }
}

class ShowMessageList extends ConsumerStatefulWidget {
  const ShowMessageList({super.key, required this.scrollController});
  final ScrollController scrollController;

  // Base tertiary color from your theme
  static const Color tertiaryColor = AppColors.yellowAccent2;

  @override
  ConsumerState<ShowMessageList> createState() => _ShowMessageListState();
}

class _ShowMessageListState extends ConsumerState<ShowMessageList> {
  late ScrollController _scrollController;
  List<ChatMessageModel> messages = [];
  // To track the last loaded message for pagination
  DocumentSnapshot? lastDocument;
  bool isLoadingMore = false;
  late Stream<MessagesWithLastDocument> _realTimeStream;
  final ChatRoomService _chatService = ChatRoomService();

  void _loadMoreMessages() async {
    if (lastDocument == null || isLoadingMore) return;

    setState(() {
      isLoadingMore = true;
    });

    // Fetch older messages manually
    final olderMessagesStream =
        _chatService
            .getMessages(
              houseId: 'TbJDaKhp4kNf6QbTNSIU',
              lastDocument: lastDocument,
              initialLoad: false,
            )
            .first; // Take the first emission for pagination

    final olderMessagesData = await olderMessagesStream;
    // var allMessages = messages;
    // allMessages.addAll(olderMessagesData.messages);
    final updatedMessageSet = (messages + olderMessagesData.messages).toSet();
    setState(() {
      messages = updatedMessageSet.toList();
      clog.info('message count = ${messages.length}');
      lastDocument = olderMessagesData.lastDocument;
      isLoadingMore = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore) {
      _loadMoreMessages();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController;
    _realTimeStream = _chatService.getMessages(
      houseId: 'TbJDaKhp4kNf6QbTNSIU',
      initialLoad: true, // Initial load flag
    );
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(usersProvider);
    final house = ref.watch(houseProvider);
    if (house == null) return _houseNotAddedMessage();
    return Padding(
      padding: kHorizontalScrPadding,
      child: StreamBuilder<MessagesWithLastDocument>(
        stream: _realTimeStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            clog.error(
              'Error: Failed to get messages, error: ${snapshot.error}',
            );
          }
          if (!snapshot.hasData) {
            isLoadingMore = true;
          } else {
            isLoadingMore = false;

            final snapshotData = snapshot.data!;

            // Only update messages if it's the initial load or new messages
            if (messages.isEmpty ||
                snapshotData.messages.length > messages.length ||
                messages.first != snapshotData.messages.first) {
              messages = snapshotData.messages;
              lastDocument = snapshotData.lastDocument;
            }
          }
          return Column(
            children: [
              // Container(height: 50, width: 100, color: Colors.red),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: widget.scrollController,
                  shrinkWrap: true,
                  itemCount:
                      isLoadingMore ? messages.length + 1 : messages.length,
                  itemBuilder: (context, index) {
                    if (messages.isEmpty) return const SizedBox();

                    final message = messages[index];
                    final senderUser = users.firstWhere(
                      (u) => u.uid == message.senderId,
                      orElse:
                          () => UserModel.fromFirebaseUser(
                            FirebaseAuth.instance.currentUser!,
                          ),
                    );
                    final currentDate = message.timestamp;
                    bool showDate =
                        index ==
                            messages.length -
                                1 || // First message (top with reverse: true)
                        (index < messages.length - 1 && // Not the last item
                            (messages[index + 1].timestamp.day !=
                                    currentDate.day ||
                                messages[index + 1].timestamp.month !=
                                    currentDate.month ||
                                messages[index + 1].timestamp.year !=
                                    currentDate.year));

                    return index == messages.length
                        ? _olderMessageLoadingWidget()
                        : Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (showDate) _showMessageDate(currentDate),
                            MessageBubble(
                              message: message,
                              user: senderUser,
                              userColor: getUserColor(message.senderId),
                            ),
                          ],
                        );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _olderMessageLoadingWidget() => Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 20),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 1,
            color: AppColors.secondaryColor,
          ),
        ),
        SizedBox(width: 10),
        Text(
          'Loading older messages...',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    ),
  );

  Widget _showMessageDate(DateTime date) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: kBorderRadius,
        ),
        child: Text(
          messageDateFormat.format(date),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.white.withAlpha(alphaFromOpacity(.7)),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );

  Widget _houseNotAddedMessage() => Center(
    child: Padding(
      padding: EdgeInsets.all(30.0),
      child: Text(
        'You are not associated with any house. Add a house to get started',
        style: Theme.of(context).textTheme.labelMedium,
      ),
    ),
  );
}
