import 'package:bloc/bloc.dart';
import 'package:bwa2_airplane/models/transaction_model.dart';
import 'package:bwa2_airplane/services/transaction_service.dart';
import 'package:equatable/equatable.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  void createTransaction(TransactionModel transaction) async {
    try {
      emit(TransactionLoading());
      await TransactionService().createTransaction(transaction);
      emit(TransactionSuccess([]));
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }

  void fetchTransactions() async {
    try {
      emit(TransactionLoading());

      List<TransactionModel> transaction =
          await TransactionService().fetchTransactions();
      emit(TransactionSuccess(transaction));
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }
}
