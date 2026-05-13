import 'package:equatable/equatable.dart';
import 'chat_stat.dart';

enum MessageRole { user, assistant }

class ChatMessage extends Equatable {
  final String id;
  final MessageRole role;
  final String content;
  final DateTime timestamp;
  final String? toolUsed;
  final List<ChatStat>? stats;
  final List<String>? quickReplies;
  final String? timestampLabel;

  const ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
    this.toolUsed,
    this.stats,
    this.quickReplies,
    this.timestampLabel,
  });

  /// Crée une copie de ce message avec des champs modifiés
  ChatMessage copyWith({
    String? id,
    MessageRole? role,
    String? content,
    DateTime? timestamp,
    String? toolUsed,
    List<ChatStat>? stats,
    List<String>? quickReplies,
    String? timestampLabel,
    bool clearStats = false,
    bool clearQuickReplies = false,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      role: role ?? this.role,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      toolUsed: toolUsed ?? this.toolUsed,
      stats: clearStats ? null : (stats ?? this.stats),
      quickReplies: clearQuickReplies ? null : (quickReplies ?? this.quickReplies),
      timestampLabel: timestampLabel ?? this.timestampLabel,
    );
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString(),
      role: json['role'] == 'user' ? MessageRole.user : MessageRole.assistant,
      content: json['content'] ?? json['response'] ?? '',
      timestamp: json['timestamp'] != null 
          ? DateTime.tryParse(json['timestamp']) ?? DateTime.now()
          : DateTime.now(),
      toolUsed: json['tool_used'],
      stats: json['stats'] != null
          ? (json['stats'] as List)
              .map((stat) => ChatStat.fromJson(stat))
              .toList()
          : null,
      quickReplies: json['quick_replies'] != null
          ? List<String>.from(json['quick_replies'])
          : null,
      timestampLabel: json['timestamp_label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role == MessageRole.user ? 'user' : 'assistant',
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'tool_used': toolUsed,
      'stats': stats?.map((stat) => stat.toJson()).toList(),
      'quick_replies': quickReplies,
      'timestamp_label': timestampLabel,
    };
  }

  /// Helper pour créer un message utilisateur
  factory ChatMessage.user({
    required String content,
    String? id,
    DateTime? timestamp,
    String? timestampLabel,
  }) {
    final now = DateTime.now();
    return ChatMessage(
      id: id ?? now.millisecondsSinceEpoch.toString(),
      role: MessageRole.user,
      content: content,
      timestamp: timestamp ?? now,
      timestampLabel: timestampLabel ?? 'À l\'instant',
    );
  }

  /// Helper pour créer un message assistant
  factory ChatMessage.assistant({
    required String content,
    String? id,
    DateTime? timestamp,
    String? toolUsed,
    List<ChatStat>? stats,
    List<String>? quickReplies,
    String? timestampLabel,
  }) {
    final now = DateTime.now();
    return ChatMessage(
      id: id ?? now.millisecondsSinceEpoch.toString(),
      role: MessageRole.assistant,
      content: content,
      timestamp: timestamp ?? now,
      toolUsed: toolUsed,
      stats: stats,
      quickReplies: quickReplies,
      timestampLabel: timestampLabel ?? 'À l\'instant',
    );
  }

  /// Helper pour générer un label temporel formaté
  String get formattedTimestamp {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'À l\'instant';
    } else if (difference.inHours < 1) {
      return 'Il y a ${difference.inMinutes} min';
    } else if (difference.inDays < 1) {
      return 'Il y a ${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return 'Il y a ${difference.inDays}j';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  @override
  List<Object?> get props => [
        id,
        role,
        content,
        timestamp,
        toolUsed,
        stats,
        quickReplies,
        timestampLabel,
      ];
}