part of 'ai_cubit.dart';

@immutable
sealed class AiState {}

final class AiInitial extends AiState {}
final class AiLoading extends AiState {}
final class AiGenerated extends AiState {
  final String generatedText;

  AiGenerated(this.generatedText);
}

final class AiListPhraseGenarted extends  AiState {
  final List<String> generatedText;

  AiListPhraseGenarted(this.generatedText);
}
final class AiError extends AiState {
  final String errorMessage;

  AiError(this.errorMessage);
}
final class AiDateChoosed extends AiState {
  final String  date;

  AiDateChoosed(this.date);
}

