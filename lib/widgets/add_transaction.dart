import 'package:flutter/material.dart';

import 'package:chp4/models/transaction.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  AddTransaction(this.addTransaction);

  final Function addTransaction;

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _date;

  void submitData() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) return;

    var amount = double.parse(_amountController.text);
    var title = _titleController.text;

    if (amount < 0) return;

    widget.addTransaction(Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: _date));

    Navigator.of(context).pop();
  }

  void chooseDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _date = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                  labelText: "Title", labelStyle: TextStyle(fontSize: 18)),
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                  labelText: "amount", labelStyle: TextStyle(fontSize: 18)),
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(_date == null
                        ? "No Date Chosen!"
                        : 'Picked Date: ${DateFormat.yMd().format(_date)}'),
                  ),
                  FlatButton(
                    onPressed: chooseDate,
                    child: Text(
                      _date == null ? "Choose Date" : "Change Date",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text("Add Transaction"),
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: () => submitData(),
            )
          ],
        ),
      ),
    );
  }
}
