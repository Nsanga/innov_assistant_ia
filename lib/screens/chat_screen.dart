import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assistant_ia/core/constants/app_colors.dart';
import '../features/chat/presentation/bloc/chat_bloc.dart';
import '../features/chat/data/models/chat_message.dart';
import '../widgets/chat/welcome_placeholder.dart';
import '../widgets/chat/user_bubble.dart';
import '../widgets/chat/assistant_bubble.dart';
import '../widgets/chat/chat_input_bar.dart';
import '../widgets/app_bars/chat_app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    context.read<ChatBloc>().add(SendMessage(text));
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const ChatAppBar(),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatLoaded) _scrollToBottom();
        },
        builder: (context, state) {
          final messages =
              state is ChatLoaded ? state.messages : <ChatMessage>[];

          return Column(
            children: [
              Expanded(
                child: messages.isEmpty
                    ? const WelcomePlaceholder()
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final msg = messages[index];
                          final isUser = msg.role == MessageRole.user;
                          return isUser
                              ? UserBubble(message: msg)
                              : AssistantBubble(message: msg);
                        },
                      ),
              ),
              ChatInputBar(
                controller: _messageController,
                onSend: _sendMessage,
                onAttach: () {
                  // TODO: Implémenter la pièce jointe
                },
                onVoice: () {
                  // TODO: Implémenter la saisie vocale
                },
              ),
            ],
          );
        },
      ),
    );
  }
}