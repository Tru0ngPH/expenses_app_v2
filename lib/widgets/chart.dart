import 'package:exp_app/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransaction}) : super(key: key);

  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      double totalAmount = 0.0;

      //lay  ngay  bang cach tinh  tu ngau hien tai tru di index
      // ngay  thi se duojc nhung ngay truoc do
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].dateTime.day == weekDay.day &&
            recentTransaction[i].dateTime.month == weekDay.month &&
            recentTransaction[i].dateTime.year == weekDay.year) {
          totalAmount += recentTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
    }).reversed.toList();
  }

  double get _totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum += element['amount'] as double;
    });
  }

  @override
  Widget build(BuildContext context) {
    //tao  1 ban do
    print(groupedTransactionValues);
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((ele) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: ele['day'] as String,
                spendingAmount: ele['amount'] as double,
                spedingPctOfTotal: _totalSpending != 0
                    ? ((ele['amount'] as double) / _totalSpending)
                    : 0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
