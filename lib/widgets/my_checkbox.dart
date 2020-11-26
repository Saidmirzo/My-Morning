import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  final bool defaultvalue;
  final Function onChange;
  final String text;
  final Widget textWidget;

  const MyCheckbox({
    Key key,
    this.onChange,
    this.defaultvalue,
    this.text,
    this.textWidget
  }) : super(key: key);
  
  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool status;

  @override
  void initState() {
    status = widget.defaultvalue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('status = $status');
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
      child: Row(
        children: [
          Checkbox(
            value: status ?? widget.defaultvalue,
            onChanged: (value){
              setState(() {
                // Это заглушка. Если нужно реально обрабатывать чекбокс, 
                // то этот код замените на widget.onChange и передавайте в нее функцию
                // при инициализации виджета
                print('Checkbox checked');
                status = status ? false : true;
              });
            }
          ),
          Flexible(
            child: widget.textWidget ?? Text(
              widget.text,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}