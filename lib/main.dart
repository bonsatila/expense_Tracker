import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(headline5: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 18,
          fontWeight: FontWeight.bold
        )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(headline6:TextStyle(fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.w100)),)
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
    // Transaction(id:'t1', title: 'new shoes', amount: 70.69, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Weekly Groceries', amount: 160.40, date: DateTime.now())
  ];

  void _addNewTransaction(String txTitle, double txAmount){
    final newTxt = Transaction(
      title: txTitle, 
      amount: txAmount, 
      date: DateTime.now(), 
      id: DateTime.now().toString());
      setState(() {
        _userTransactions.add(newTxt);
      });
  }
  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (bCtx) {
      return NewTransaction(_addNewTransaction);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses', style: Theme.of(context).textTheme.headline6,),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () => _startAddNewTransaction(context),)
        ]
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: double.infinity,
                child:Card(
                    color: Colors.amber,
                  child: Container(
                    width: double.infinity,
                    child:Text('CHART!'),),
                  elevation: 5,
                ),
              ),
              TransactionList(_userTransactions)
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
    );
  }
}
