import 'package:cajero/domain/entities/shift_summary.dart';
import 'package:cajero/domain/repositories/i_reports_repository.dart';

class ReportsRepositoryImpl implements IReportsRepository {
  @override
  Future<ShiftSummary> getShiftSummary() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return ShiftSummary(
      totalSales: 1250.00,
      totalTickets: 45,
      averageTicket: 27.78,
      hourlySales: [40, 60, 30, 80, 50, 90, 70, 45],
      paymentMethodsPercentages: {
        'Efectivo': 65,
        'Tarjeta': 20,
        'Transfer': 15,
      },
    );
  }
}
