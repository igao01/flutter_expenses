import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction, {Key? key}) : super(key: key);

  List<Map<String, dynamic>> get groupedTransaction {
    // gera uma lista com 7 elementos
    return List.generate(7, (index) {
      // pega os dias da semana  subtraindo os dias a partir da data atual
      // hoje = hoje - 0dia (index = 0)
      // ontem = hoje - 1dia (index = 1)
      // e assim por diante
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      // soma os valores das transcoes no dia
      double totalSum = 0.0;

      for (int i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }
      return {
        // pega a primeira letra do dia da semana
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
      // reversed() inverte a ordem da lista
    }).reversed.toList();
  }

  double get _weekTotalValue {
    // realiza um for internamente acumulando o valor de todas
    // as transações feitas dentro de uma semana
    return groupedTransaction.fold(0.0, (sum, tr) {
      return sum + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction.map((tr) {
            return Flexible(
              // divide o espaçamento igualmente entre os elementos
              fit: FlexFit.tight,
              child: ChartBar(
                day: tr['day'],
                value: tr['value'],
                percentage: _weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
