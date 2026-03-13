import 'package:flutter/material.dart';
import 'package:cajero/domain/entities/supervision_data.dart';
import 'package:cajero/domain/usecases/supervision/get_supervision_data_usecase.dart';

class SupervisionController extends ChangeNotifier {
  final GetSupervisionDataUseCase getSupervisionDataUseCase;
  SupervisionData? _data;
  bool _isLoading = false;

  SupervisionController({required this.getSupervisionDataUseCase});

  SupervisionData? get data => _data;
  bool get isLoading => _isLoading;

  Future<void> loadSupervisionData() async {
    _isLoading = true;
    notifyListeners();
    _data = await getSupervisionDataUseCase.execute();
    _isLoading = false;
    notifyListeners();
  }
}
