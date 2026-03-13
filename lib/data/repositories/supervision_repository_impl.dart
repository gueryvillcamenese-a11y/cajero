import 'package:cajero/domain/entities/supervision_data.dart';
import 'package:cajero/domain/repositories/i_reports_repository.dart';

class SupervisionRepositoryImpl implements ISupervisionRepository {
  @override
  Future<SupervisionData> getSupervisionData() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return SupervisionData(
      totalFlow: 4250.00,
      flowIncreasePercentage: 12.5,
      pendingAuthorizations: 3,
      urgentPending: 2,
      terminals: [
        TerminalStatus(name: 'Caja Principal 01', status: 'Activa - Juan P.', amount: 2450.00, color: 'green'),
        TerminalStatus(name: 'Caja Rápida 02', status: 'En Descanso - Ana M.', amount: 850.50, color: 'orange'),
        TerminalStatus(name: 'Caja 03 (Bodega)', status: 'Desconectada', amount: 0.00, color: 'grey'),
      ],
    );
  }
}
