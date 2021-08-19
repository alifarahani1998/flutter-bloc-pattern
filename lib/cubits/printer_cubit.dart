import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'printer_state.dart';

class PrinterCubit extends Cubit<PrinterState> {
  PrinterCubit() : super(PrinterState(text: 'start'));


  void addWord() => emit(
      PrinterState(text: state.text + ' ali'));

}
