import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:chp4/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;
  final double size;

  TransactionList(this.transactions, this._deleteTransaction, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.size *
          (MediaQuery.of(context).size.height -
              Scaffold.of(context).appBarMaxHeight),
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: [
                    Text(
                      "No Transactions Added Yet...",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.1),
                    Container(
                      height: constraints.maxHeight * 0.5,
                      child: Opacity(
                        opacity: 0.65,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Container(
                  child: Card(
                    elevation: 8,
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(2),
                        child: CircleAvatar(
                          radius: 27,
                          backgroundColor: Theme.of(context).canvasColor,
                          child: Text(
                            NumberFormat.compactCurrency(
                                    decimalDigits: 2, symbol: '\$')
                                .format(transactions[index].amount),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      title: Text(
                        '${transactions[index].title}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            _deleteTransaction(transactions[index].id),
                      ),
                      // CircleAvatar(
                      //   radius: 30,
                      //   child: Text(
                      //     NumberFormat.compactCurrency(
                      //             decimalDigits: 2, symbol: '\$')
                      //         .format(transactions[index].amount),
                      //   ),
                      // ),
                    ),
                  ),
                );
                // return Card(
                //   child: Row(
                //     children: [
                //       Container(
                //         height: 70,
                //         width: 100,
                //         margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
                //         padding: EdgeInsets.all(5),
                //         alignment: Alignment.center,
                //         child: Text(
                //           NumberFormat.compactCurrency(
                //                   decimalDigits: 2, symbol: '\$')
                //               .format(transactions[index].amount),
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 16,
                //             color: Theme.of(context).primaryColor,
                //           ),
                //         ),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             width: 2,
                //             color: Theme.of(context).primaryColor,
                //           ),
                //           shape: BoxShape.circle,
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             transactions[index].title,
                //             style: Theme.of(context).textTheme.headline6,
                //           ),
                //           SizedBox(height: 5),
                //           Text(
                //             DateFormat.yMMMd().format(transactions[index].date),
                //             style: TextStyle(color: Colors.grey),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
