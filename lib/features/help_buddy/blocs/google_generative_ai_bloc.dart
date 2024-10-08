import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:harvest_hero/features/help_buddy/help_buddy.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/src/models/models.dart';
import 'package:uuid/uuid.dart';

part 'google_generative_ai_bloc.freezed.dart';

part 'google_generative_ai_bloc.g.dart';

@freezed
class GoogleGenerativeAiState with _$GoogleGenerativeAiState {
  const factory GoogleGenerativeAiState({
    @Default([]) List<Message> generativeChats,
    String? imageAnalysisResult,
  }) = _GoogleGenerativeAiState;

  factory GoogleGenerativeAiState.fromJson(Map<String, dynamic> json) =>
      _$GoogleGenerativeAiStateFromJson(json);
}

class GoogleGenerativeAiBloc extends Cubit<GoogleGenerativeAiState> {
  GoogleGenerativeAiBloc({required this.generativeAiRepository})
      : super(
          const GoogleGenerativeAiState(
            generativeChats: [],
          ),
        );

  final GoogleGenerativeAiRepository generativeAiRepository;
  final _user = const User(
    id: "user",
  );
  final _gemini = const User(
    id: "gemini",
    imageUrl: 'https://i.imgur.com/U0l6Ygp.png',
  );

  void submitPrompt(String text) async {
    List<Message> previousChatList =
        List<TextMessage>.from(state.generativeChats);
    previousChatList.insert(
      0,
      TextMessage(
        text: text,
        author: _user,
        id: const Uuid().v1(),
      ),
    );

    emit(
      state.copyWith(
        generativeChats: previousChatList,
      ),
    );
    final response = await generativeAiRepository.generateFromPrompt(
      text: text,
      type: ContentType.text,
    );

    previousChatList = List<Message>.from(state.generativeChats);
    previousChatList.insert(
      0,
      TextMessage(
        id: const Uuid().v1(),
        text: response.text ?? "Couldn't generate",
        author: _gemini,
      ),
    );

    emit(
      state.copyWith(
        generativeChats: List<Message>.from(previousChatList),
      ),
    );
  }

  Future<void> submitParts(List<Part> parts) async {
    final response = await generativeAiRepository.generateFromParts(
      parts: parts,
      type: ContentType.text,
    );

    emit(
      state.copyWith(
        imageAnalysisResult: response.text,
      ),
    );
  }

  void clearImageAnalysisResponse() {
    emit(state.copyWith(imageAnalysisResult: null));
  }

  Future<DateTime?> predictHarvestDate(FormGroup form) async{
    final cropName = form.control('name').value;
    final harvestDatePredictionText = "Predict the harvest date for the $cropName sowed on ${form.control('cropSowedOn').value}. Consider we are using Kolkata, India as a point of Reference. Analyze previous weather data and give me an approximate date. Give only the date in format dd/MM/yyyy. If you can't provide me the date, just give me a random suitable date for the crop I mentioned, don't say I don't have access to data!" ;
    final response = await generativeAiRepository.generateFromPrompt(
      text: harvestDatePredictionText,
      type: ContentType.text,
    );
    final harvestDate = response.text;
    final dateFormat = DateFormat('dd/MM/yyyy');
    if (harvestDate != null) {
      try{
        final harvestDateFormatted = dateFormat.parse(harvestDate);
        return harvestDateFormatted;
      } catch(e){
        return null;
      }
    }
    return null;
  }
}
