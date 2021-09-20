import 'dart:io';
import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main(List<String> args) => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a orientação da tela para o aplicativo
    /*SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
    ]);*/

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: CustomTheme.THEME,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Conta antiga',
      value: 400.00,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tênis de  Corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't3',
      title: 'Novo Tênis de  Corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't4',
      title: 'Novo Tênis de  Corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't5',
      title: 'Novo Tênis de  Corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't6',
      title: 'Novo Tênis de  Corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't7',
      title: 'Novo Tênis de  Corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
  ];

  // GET RECENT TRANSACTION
  List<Transaction> get _recentTransactions {
    // retorna uma lista com as transações realizadas nos ultimos 7 dias
    return _transactions.where((tr) {
      // verifica se a data da transação foi anterior a 7 dias
      // contando a partir de hoje
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  // ADD TRANSACTION
  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    // fecha o modal
    Navigator.of(context).pop();
  }

  // REMOVE TRANSACTION
  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  // OPEN MODAL
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      // parte da solucao para exibir o form acima do teclado
      // https://stackoverflow.com/questions/53869078/how-to-move-bottomsheet-along-with-keyboard-which-has-textfieldautofocused-is-t/57515977#57515977
      isScrollControlled: true,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS ? GestureDetector(onTap: fn, child: Icon(icon)) : IconButton(icon: Icon(icon), onPressed: fn);
  }

  //  METODO BUILD

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    // coloca os icones na barra de acordo com a plataforma
    final iconList = Platform.isIOS ? CupertinoIcons.news : Icons.list;
    final iconChart = Platform.isIOS ? CupertinoIcons.refresh : Icons.bar_chart;

    // ACTIONS
    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          _showChart ? iconList : iconChart,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];

    final PreferredSizeWidget appBar = AppBar(
      title: Text('Despesas Pessoais'),
      actions: actions,
    );

    // CALCULO DA ALTURA DISPONIVEL

    // calcula a altura disponivel subtraindo a altura da appBar e statusBar
    final _availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height // pega o valor da altura da appBar
        -
        mediaQuery.padding.top; // pega a altura da status bar

    // BODY PAGE

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // define o espaçamente e a posicao dos elementos
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          // define como o conteudo deve ocupar o eixo perpendicular
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /*if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Exibir Gráfico'),
                  // adaptive se adapta ao padrao visual do SO
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                  ),
                ],
              ),*/
            if (_showChart || !isLandscape) // sempre exibe no modo retrato
              Container(
                height: _availableHeight *
                    (isLandscape ? 0.7 : 0.3), // heitgh 30% da altura disponivel ou 70% em modo paisagem
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              Container(
                height: _availableHeight * (isLandscape ? 1 : 0.7), // heitgh 70% da altura disponivel
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            // permite que a tela do app seja rolável, é necessario que componente
            // pai possua um height definido
            body: bodyPage,
            // Esconde o FAB caso a plataforma seja IOS
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
  }
}
