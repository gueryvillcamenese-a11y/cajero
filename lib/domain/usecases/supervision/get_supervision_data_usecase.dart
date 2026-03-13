import 'package:cajero/domain/entities/supervision_data.dart';
import 'package:cajero/domain/repositories/i_reports_repository.dart';

class GetSupervisionDataUseCase {
  final ISupervisionRepository repository;

  GetSupervisionDataUseCase(this.repository);

  Future<SupervisionData> execute() {
    return repository.getSupervisionData();
  }
}
