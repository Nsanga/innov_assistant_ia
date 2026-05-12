import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/chat_repository.dart';
import '../../data/models/chat_message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repository;

  ChatBloc(this.repository) : super(ChatInitial()) {
    on<SendMessage>(_onSendMessage);
    on<ResetChat>(_onResetChat);
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    final currentMessages = state is ChatLoaded ? (state as ChatLoaded).messages : <ChatMessage>[];

    // Message utilisateur
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: MessageRole.user,
      content: event.message,
      timestamp: DateTime.now(),
    );

    emit(ChatLoaded([...currentMessages, userMessage], isLoading: true));

    try {
      final assistantMessage = await repository.sendMessage(event.message);
      emit(ChatLoaded([...currentMessages, userMessage, assistantMessage]));
    } catch (e) {
      emit(ChatError(e.toString()));
      emit(ChatLoaded(currentMessages)); // Retour à l'état précédent
    }
  }

  void _onResetChat(ResetChat event, Emitter<ChatState> emit) {
    repository.resetSession();
    emit(ChatInitial());
  }
}