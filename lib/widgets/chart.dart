import 'package:chp4/widgets/chart_bar.dart';
import 'package:flutter/material.dart';

import 'package:chp4/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  Chart(this.transactions, this._size);

  final double _size;
  List<Transaction> transactions;

  List<Map<String, Object>> get groupedTransactionValues {
    // note that i use a different, more performant method than max uses,
    // as i don't iterate over a list 7 times, but instead only once.
    // Max does however use a getter in the main dart file to filter
    // transactions to the last week only, thus making it more similar
    // to this one's performance, but more convoluted.
    List<double> dayTotals = new List.filled(7, 0);
    DateTime now = DateTime.now();

    for (int i = 0; i < transactions.length; i++) {
      DateTime date = transactions[i].date;
      int diff = DateTime(date.year, date.month, date.day)
          .difference(DateTime(now.year, now.month, now.day))
          .inDays;
      if (diff < 1 && diff > -7) {
        dayTotals[diff * -1] += transactions[i].amount;
      }
    }

    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': dayTotals[index]
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _size *
          (MediaQuery.of(context).size.height -
              Scaffold.of(context).appBarMaxHeight),
      child: Card(
        margin: EdgeInsets.all(12),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedTransactionValues.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  e['day'],
                  e['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (e['amount'] as double) / totalSpending,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
