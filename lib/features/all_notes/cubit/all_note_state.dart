// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'all_note_cubit.dart';

abstract class AllNotesState {}

class AllNotesLoading extends AllNotesState {}

class AllNotesLoadingSuccess extends AllNotesState {
  final List<VidIdAndListOfNotesModal> vidIdAndListOfNotesModalList;

  AllNotesLoadingSuccess(this.vidIdAndListOfNotesModalList);
}

class AllNotesLoadingError extends AllNotesState {
  String errorMessage;
  AllNotesLoadingError({
    required this.errorMessage,
  });
}
