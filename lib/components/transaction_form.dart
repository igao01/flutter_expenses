import 'package:expenses/components/adaptive_date_picker.dart';
import 'package:expenses/components/adaptive_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_button.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double, DateTime) addTransaction;

  TransactionForm(this.addTransaction, {Key? key}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  late DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.parse(_valueController.text);

    if (title.isEmpty || value <= 0 || _selectedDate == null) return;

    widget.addTransaction(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            10,
            10,
            10,
            10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            // parte da solucao para exibir o form inteiro acima do teclado
            // https://stackoverflow.com/questions/53869078/how-to-move-bottomsheet-along-with-keyboard-which-has-textfieldautofocused-is-t/57515977#57515977
            mainAxisSize: MainAxisSize.min,
            children: [
              AdaptiveTextField(
                label: 'Título',
                controller: _titleController,
                onSubmit: _submitForm,
                keyboardType: TextInputType.text,
              ),
              AdaptiveTextField(
                label: 'Valor (R\$)',
                controller: _valueController,
                onSubmit: _submitForm,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              /* TextField(
                controller: _valueController,

                // numberWithOption(decimal true) especifica para o IOS exibir
                // o teclado numérico com separador ponto ou virgula
                // caso contrario só exibira números
                keyboardType: TextInputType.numberWithOptions(decimal: true),

                // atribui uma funcao ao botao submit presente no teclado
                // quando utilizado ( _ ) indica que a funcao recebe um parametro
                // mas não será utilizado
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
              ), */
              AdaptiveDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptiveButton(
                    onPressed: _submitForm,
                    label: 'Nova Transação',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
