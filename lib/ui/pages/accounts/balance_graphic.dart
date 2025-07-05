import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

// Виджет графика баланса для переиспользования
class BalanceChart extends StatefulWidget {
  final Map<DateTime, double> dailyBalances;
  final Map<DateTime, double> monthlyBalances;
  final bool initialIsDailyView;

  const BalanceChart({
    Key? key,
    required this.dailyBalances,
    required this.monthlyBalances,
    this.initialIsDailyView = true,
  }) : super(key: key);

  @override
  _BalanceChartState createState() => _BalanceChartState();
}

class _BalanceChartState extends State<BalanceChart>
    with TickerProviderStateMixin {
  late bool isDailyView;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    isDailyView = widget.initialIsDailyView;
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleView(bool daily) {
    if (isDailyView != daily) {
      setState(() {
        isDailyView = daily;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  Map<DateTime, double> get currentData =>
      isDailyView ? widget.dailyBalances : widget.monthlyBalances;

  List<BarChartGroupData> _generateBarGroups() {
    final data = currentData;
    final sortedEntries =
        data.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

    return sortedEntries.asMap().entries.map((entry) {
      final index = entry.key;
      final balance = entry.value.value;
      final absoluteBalance = balance.abs(); // Все полосы идут вверх

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: absoluteBalance,
            color: balance >= 0 ? Colors.green : Colors.red,
            width: isDailyView ? 8 : 16,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: absoluteBalance,
              color:
                  balance >= 0
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
            ),
          ),
        ],
      );
    }).toList();
  }

  String _getBottomTitle(double value, int totalCount) {
    final data = currentData;
    final sortedEntries =
        data.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

    final index = value.toInt();
    if (index >= 0 && index < sortedEntries.length) {
      // Показываем только начальную, среднюю и конечную даты
      if (index == 0 || index == totalCount - 1 || index == (totalCount ~/ 2)) {
        final date = sortedEntries[index].key;
        if (isDailyView) {
          return DateFormat('dd.MM').format(date);
        } else {
          return DateFormat('MMM').format(date);
        }
      }
    }
    return '';
  }

  double get maxY {
    final values = currentData.values.map((v) => v.abs()).toList();
    return values.isEmpty ? 100 : values.reduce((a, b) => a > b ? a : b) * 1.2;
  }

  @override
  Widget build(BuildContext context) {
    final dataCount = currentData.length;

    return Column(
      children: [
        // Segmented Control
        Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _toggleView(true),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          isDailyView ? Colors.blue[600] : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      'По дням',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDailyView ? Colors.white : Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _toggleView(false),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          !isDailyView ? Colors.blue[600] : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      'По месяцам',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: !isDailyView ? Colors.white : Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // График
        Container(
          height: 260,
          padding: EdgeInsets.all(16),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation.value,
                child: Opacity(
                  opacity: _animation.value,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxY,
                      minY: 0,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipPadding: EdgeInsets.all(8),
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final data = currentData;
                            final sortedEntries =
                                data.entries.toList()
                                  ..sort((a, b) => a.key.compareTo(b.key));

                            if (groupIndex < sortedEntries.length) {
                              final entry = sortedEntries[groupIndex];
                              final date = entry.key;
                              final balance = entry.value;

                              return BarTooltipItem(
                                '${DateFormat(isDailyView ? 'dd.MM.yyyy' : 'MMM yyyy').format(date)}\n${balance.toStringAsFixed(0)} ₽',
                                TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }
                            return null;
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final title = _getBottomTitle(value, dataCount);
                              if (title.isEmpty) return Container();

                              return SideTitleWidget(
                                meta: meta,
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            },
                            reservedSize: 30,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 60,
                            getTitlesWidget: (value, meta) {
                              return SideTitleWidget(
                                meta: meta,
                                child: Text(
                                  '${(value / 1000).toStringAsFixed(0)}k',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          left: BorderSide(color: Colors.grey[300]!, width: 1),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: isDailyView ? 1000 : 10000,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey[300]!,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      barGroups: _generateBarGroups(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
