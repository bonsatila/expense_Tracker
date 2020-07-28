import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selecteDate;

  void _submitData(){
    if(amountController.text.isEmpty) return;
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if(enteredTitle.isEmpty || enteredAmount <=0 || _selecteDate == null){
      return;
    }
    widget.addTransaction(enteredTitle, enteredAmount, _selecteDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate == null){
        return;
      }
      setState(() {
        _selecteDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,

            child: Container(
              padding: EdgeInsets.all(10),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title'
                    ),
                    // onChanged: (value) => {
                    //   titleInput = value
                    // },
                    controller: titleController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Amount'
                    ),
                    // onChanged: (value) => {
                    //   amountInput = value
                    // },
                    controller: amountController,
                    keyboardType: TextInputType.numberWithOptions(decimal:true),
                    onSubmitted: (_) => _submitData() ,
                  ),
                  Container(
                    height: 70,
                    child: Row(children: <Widget>[
                        Expanded(child: 
                          Text(
                            _selecteDate == null ? 
                            'No Date Chosen' : 
                            'Picked Date: ${DateFormat.yMd().format(_selecteDate)}'
                          ),
                        ),
                        FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold),), 
                          onPressed: _presentDatePicker,
                        )
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Text('Add Transaction'), 
                    textColor: Theme.of(context).textTheme.button.color,
                    color: Theme.of(context).primaryColor,
                    onPressed: () => {
                      _submitData()
                    },
                  )
                ],
              ),
            ),
          );
  }
}