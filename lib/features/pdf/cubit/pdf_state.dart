part of 'pdf_cubit.dart';

@immutable
abstract class PdfState extends Equatable {}

class PdfStateInitial extends PdfState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PdfStateLoaded extends PdfState {
  final Uint8List pdfBytes;

  PdfStateLoaded(this.pdfBytes);
  @override
  // TODO: implement props
  List<Object?> get props => [pdfBytes];
}
