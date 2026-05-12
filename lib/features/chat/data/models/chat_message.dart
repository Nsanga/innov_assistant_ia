import 'package:equatable/equatable.dart';

enum MessageRole { user, assistant }

class ChatMessage extends Equatable {
  final String id;
  final MessageRole role;
  final String content;
  final DateTime timestamp;
  final String? toolUsed;

  const ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
    this.toolUsed,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: json['role'] == 'user' ? MessageRole.user : MessageRole.assistant,
      content: json['content'] ?? json['response'] ?? '',
      timestamp: DateTime.now(),
      toolUsed: json['tool_used'],
    );
  }

  @override
  List<Object?> get props => [id, role, content, timestamp, toolUsed];
}