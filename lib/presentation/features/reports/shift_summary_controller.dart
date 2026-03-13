import 'package:flutter/material.dart';
import 'package:cajero/domain/entities/shift_summary.dart';
import 'package:cajero/domain/usecases/reports/get_shift_summary_usecase.dart';

class ShiftSummaryController extends ChangeNotifier {
  final GetShiftSummaryUseCase getShiftSummaryUseCase;
  ShiftSummary? _summary;
  bool _isLoading = false;

  ShiftSummaryController({required this.getShiftSummaryUseCase});

  ShiftSummary? get summary => _summary;
  bool get isLoading => _isLoading;

  Future<void> loadSummary() async {
    _isLoading = true;
    notifyListeners();
    _summary = await getShiftSummaryUseCase.execute();
    _isLoading = false;
    notifyListeners();
  }
}
