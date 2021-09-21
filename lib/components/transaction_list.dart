import 'package:expenses/components/response_empty_list.dart';
import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  late final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? ResponseEmptyList()
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];

              return TransactionItem(
                // utilizado quan é necessario alterar ordem dos itens da lista
                // fazer alterações em um item específico
                // reorgnizar a lista
                // GlobalObjectKey demanda muita performance
                // NAO DEVE SER UTILIZADO SEM NECESSIDADE
                key: GlobalObjectKey(tr),
                tr: tr,
                onRemove: onRemove,
              );
            });
  }
}
