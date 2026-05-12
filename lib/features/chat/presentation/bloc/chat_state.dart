part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;

  const ChatLoaded(this.messages, {this.isLoading = false});

  @override
  List<Object> get props => [messages, isLoading];
}

class ChatError extends ChatState {
  final String message;
  const ChatError(this.message);

  @override
  List<Object> get props => [message];
}