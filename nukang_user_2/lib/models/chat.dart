// lib/models/chat.dart
class Chat {
  final String id;
  final String workerId;
  final String workerName;
  final String workerImage;
  final String lastMessage;
  final String lastTime;
  final bool isRead;
  final int unreadCount;

  Chat({
    required this.id,
    required this.workerId,
    required this.workerName,
    required this.workerImage,
    required this.lastMessage,
    required this.lastTime,
    this.isRead = true,
    this.unreadCount = 0,
  });
}

enum MessageStatus { sent, delivered, read }

class ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String message;
  final DateTime time;
  final bool isMe;
  final MessageStatus status;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.time,
    required this.isMe,
    this.status = MessageStatus.sent,
  });
}