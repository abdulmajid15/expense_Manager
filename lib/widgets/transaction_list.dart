import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  Color _bgcolor;
  @override
  Widget build(BuildContext context) {
    @override
    void didUp() {
      // TODO: implement initState
      const randomcolors = [
        Colors.blue,
        Colors.black26,
        Colors.teal,
        Colors.purple,
      ];
      _bgcolor = randomcolors[Random().nextInt(3)];
      super.initState();
    }

    // void didUpdateWidget(oldWidget) {
    //   const randomcolors = [
    //     Colors.blue,
    //     Colors.black26,
    //     Colors.teal,
    //     Colors.purple,
    //   ];
    //   _bgcolor = randomcolors[Random().nextInt(3)];
    //   super.didChangeDependencies();
    // }

    return Container(
      height: 450,
      child: widget.transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 150,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '${widget.transactions[index].amount}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      widget.transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd()
                          .format(widget.transactions[index].date),
                    ),
                    // for checking width of mobile
                    trailing: MediaQuery.of(context).size.width > 420
                        ? FlatButton.icon(
                            textColor: Theme.of(context).errorColor,
                            icon: Icon(Icons.delete),
                            label: Text('delete'),
                            onPressed: () =>
                                widget.deleteTx(widget.transactions[index].id),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () =>
                                widget.deleteTx(widget.transactions[index].id),
                          ),
                  ),
                );
              },
              itemCount: widget.transactions.length,
            ),
    );
  }
}
