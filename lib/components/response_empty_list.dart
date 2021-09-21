import 'package:flutter/material.dart';

class ResponseEmptyList extends StatelessWidget {
  const ResponseEmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          'Nenhuma transação cadastrada',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          child: Image.asset(
            'assets/images/waiting.png',

            // define de que for a imagem deve se adequar ao widget pai
            // é obritorio ter um widget pai com tamanho definido
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
