import 'package:chp4/widgets/chart.dart';
import 'package:chp4/widgets/add_transaction.dart';
import 'package:chp4/widgets/transaction_list.dart';
import 'package:chp4/models/transaction.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Manager',
      home: MyHomePage(),
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Quicksand',
            ),
            button: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Quicksand')),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
              headline6: TextStyle(
                  fontFamily: 'OpenSand',
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
        ),
        primarySwatch: Colors.purple,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    Transaction(
      id: "t1",
      title: "New Shoes",
      amount: 39.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t3",
      title: "Monthly Groceries",
      amount: 66.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t4",
      title: "Yearly Groceries",
      amount: 1116.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t4",
      title: "Yearly Groceries",
      amount: 1116.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t4",
      title: "Yearly Groceries",
      amount: 1116.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t4",
      title: "Yearly Groceries",
      amount: 1116.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t4",
      title: "Yearly Groceries",
      amount: 1116.53,
      date: DateTime.now(),
    ),
  ];
  bool _showChart = false;

  void addTransaction(Transaction newTransaction) {
    setState(() {
      transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (BuildContext ctx) {
          return AddTransaction(addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              startAddNewTransaction(context);
            },
          ),
        ],
        title: Text("Expenses Manager"),
      ),
      body: SingleChildScrollView(
        child: Builder(builder: (BuildContext ctx) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_isLandscape) switchRow(),
              if (_isLandscape)
                _showChart
                    ? Chart(transactions, 0.55)
                    : TransactionList(transactions, _deleteTransaction, 0.77),
              if (!_isLandscape) ...[
                Chart(transactions, 0.22),
                TransactionList(transactions, _deleteTransaction, 0.60)
              ]
            ],
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startAddNewTransaction(context);
        },
      ),
    );
  }

  Widget switchRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Transactions"),
        Switch(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            }),
        Text("Chart")
      ],
    );
  }
}
