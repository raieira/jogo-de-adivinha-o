import 'package:flutter/material.dart';

void main() {
  runApp(const GuessNumberApp());
}

class GuessNumberApp extends StatelessWidget {
  const GuessNumberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'jogo de Adivinhação',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GuessGamePage(),
    );
  }
}

class GuessGamePage extends StatefulWidget {
  const GuessGamePage({super.key});

  @override
  State<GuessGamePage> createState() => _GuessGamePageState();
}

class _GuessGamePageState extends State<GuessGamePage> {
  int min = 0;
  int max = 100;
  int palpite = 50;
  int tentativas = 0;
  bool jogoFinalizado = false;

  void _reiniciar() {
    setState(() {
      min = 0;
      max = 100;
      palpite = 50;
      tentativas = 0;
      jogoFinalizado = false;
    });
  }

  void _responder(String resposta) {
    setState(() {
      tentativas++;

      if (resposta == 'maior') {
        min = palpite + 1;
      } else if (resposta == 'menor') {
        max = palpite - 1;
      } else if (resposta == 'acertou') {
        jogoFinalizado = true;
        return;
      }

      // evita erro caso o intervalo se inverta
      if (min > max) {
        jogoFinalizado = true;
        return;
      }

      palpite = ((min + max) / 2).floor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('jogo de Adivinhação'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: jogoFinalizado
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'acertei em $tentativas tentativas!',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _reiniciar,
                      child: const Text('jogar novamente'),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'pense em um número entre 0 e 100',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'meu palpite é:',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$palpite',
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text('seu número é...'),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 16,
                      children: [
                        ElevatedButton(
                          onPressed: () => _responder('menor'),
                          child: const Text('menor'),
                        ),
                        ElevatedButton(
                          onPressed: () => _responder('acertou'),
                          child: const Text('acertou'),
                        ),
                        ElevatedButton(
                          onPressed: () => _responder('maior'),
                          child: const Text('maior'),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
