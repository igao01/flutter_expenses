import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double value;
  final double percentage;

  ChartBar({
    Key? key,
    required this.day,
    required this.value,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // constroi o layout utilizando valores do widget pai como referencia
      child: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: [
            // diminui o tamnho do texto automaticamente para caber em uma linha
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '${value.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              // desenha a barra do gráfico
              // Stack é utilizado para sobreposição de widgets
              // aqui é utilizado um container com a cor cinza para ser o background
              // de outro container com a cor roxa sobrepondo o container cinza
              // o atributo height do container roxo é definido pela porcentagem
              // recebida como parâmetro no construtor
              child: Stack(
                // a barra inicia debaixo para cima
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: constraints.maxHeight * 0.15,
              child: Text('$day'),
            ),
          ],
        );
      }),
    );
  }
}
