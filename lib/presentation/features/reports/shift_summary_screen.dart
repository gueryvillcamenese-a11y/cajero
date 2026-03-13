import 'package:flutter/material.dart';
import 'package:cajero/injection/injection_container.dart';
import 'package:cajero/presentation/features/reports/shift_summary_controller.dart';

class ShiftSummaryScreen extends StatefulWidget {
  const ShiftSummaryScreen({super.key});

  @override
  State<ShiftSummaryScreen> createState() => _ShiftSummaryScreenState();
}

class _ShiftSummaryScreenState extends State<ShiftSummaryScreen> {
  late ShiftSummaryController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ShiftSummaryController(getShiftSummaryUseCase: sl.getShiftSummaryUseCase);
    _controller.loadSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          children: [
            Text('Resumen de Turno', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Cajero: Juan Pérez | Caja Principal', style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
            icon: const Icon(Icons.logout, color: Colors.red),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined, size: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          if (_controller.isLoading || _controller.summary == null) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFFFB74D)));
          }
          final summary = _controller.summary!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTotalSalesCard(summary.totalSales, summary.totalTickets, summary.averageTicket),
                const SizedBox(height: 24),
                const Text(
                  'Ventas por Hora',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const Text('Hoy: 8:00 - 18:00', style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 16),
                _buildChartPlaceholder(summary.hourlySales),
                const SizedBox(height: 32),
                const Text(
                  'Métodos de Pago',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 16),
                ...summary.paymentMethodsPercentages.entries.map((e) => 
                  _buildPaymentMethodItem(e.key, e.value)
                ).toList(),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Imprimiendo reporte...')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFB74D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Imprimir Reporte Parcial',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFFFB74D),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/catalog');
          if (index == 1) Navigator.pushNamed(context, '/inventory');
          if (index == 3) Navigator.pushNamed(context, '/supervision');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Ventas'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Inventario'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reportes'),
          BottomNavigationBarItem(icon: Icon(Icons.groups_outlined), label: 'Equipo'),
        ],
      ),
    );
  }

  Widget _buildTotalSalesCard(double total, int tickets, double avg) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Ventas Totales',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.trending_up, color: Colors.green, size: 14),
                  SizedBox(width: 4),
                  Text(
                    '12%',
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '\$${total.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Tickets', tickets.toString()),
            _buildStatItem('Ticket Promedio', '\$${avg.toStringAsFixed(2)}'),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildChartPlaceholder(List<double> data) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(data.length, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 12,
                height: data[index],
                decoration: BoxDecoration(
                  color: index == 5 ? const Color(0xFFFFB74D) : Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${8 + index}h',
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildPaymentMethodItem(String method, int percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(method, style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text('$percentage%', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor: Colors.grey[100],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    method == 'Efectivo' ? const Color(0xFFFFB74D) : Colors.grey[400]!,
                  ),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
