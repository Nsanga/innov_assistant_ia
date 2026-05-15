import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assistant_ia/core/constants/app_colors.dart';
import '../features/chat/presentation/bloc/chat_bloc.dart';
import '../features/chat/data/models/chat_message.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
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

  void _newConversation() {
    context.read<ChatBloc>().add(const ResetChat());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: ChatAppBar(onNewConversation: _newConversation),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          final user = authState is AuthSuccess ? authState.user : null;
          final userName = user?.prenom ?? '';

          return BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatLoaded) _scrollToBottom();
        },
        builder: (context, state) {
          final messages =
              state is ChatLoaded ? state.messages : <ChatMessage>[];

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  // +1 pour le WelcomePlaceholder en index 0
                  itemCount: messages.length + 1,
                  itemBuilder: (context, index) {
                    // Index 0 → toujours le message de bienvenue
                    if (index == 0) {
                      return WelcomePlaceholder(userName: userName);
                    }

                    // Index 1..n → vrais messages (décalage de 1)
                    final msg = messages[index - 1];
                    final isUser = msg.role == MessageRole.user;
                    return isUser
                        ? UserBubble(message: msg, user: user)
                        : AssistantBubble(message: msg);
                  },
                ),
              ),
              ChatInputBar(
                controller: _messageController,
                onSend: _sendMessage,
                onAttach: () {},
                onVoice: () {},
              ),
            ],
          );
        },
      );
      },
      ),
    );
  }
}