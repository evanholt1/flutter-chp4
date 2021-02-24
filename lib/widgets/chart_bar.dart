import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  ChartBar(this.label, this.spending, this.spendingPctofTotal);

  final String label;
  final double spending;
  final double spendingPctofTotal;

  @override
  Widget build(BuildContext context) {
    return chartBar(context);
  }

  Widget chartBar(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                    NumberFormat.compactCurrency(decimalDigits: 2, symbol: '\$')
                        .format(spending)),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
                height: constraints.maxHeight * 0.60,
                width: 10,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(220, 220, 220, 1),
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    FractionallySizedBox(
                      heightFactor: spendingPctofTotal,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.15,
              child: Text(label),
            ),
          ],
        );
      },
    );
  }
}
