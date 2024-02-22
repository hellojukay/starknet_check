import 'package:flutter/material.dart';
import 'package:starknet_check/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Github starknet 空投检测'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget? messgae;
  TextEditingController controller = TextEditingController();
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (flag)
              Icon(
                Icons.celebration,
                color: Colors.red[500]!,
                size: 80,
              ),
            const SizedBox(
              height: 40,
            ),
            if (messgae != null) messgae!,
            const SizedBox(
              height: 40,
            ),
            if (messgae != null)
              const SizedBox(
                height: 40,
              ),
            SizedBox(
              width: 400,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey[200]!, width: 1.0),
                  ),
                  hintText: 'Github Account ID',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 40,
                width: 180,
                child: ElevatedButton(
                    onPressed: () async {
                      String name = controller.text;
                      String? amount = await getAmount(name);
                      setState(() {
                        if (amount == null) {
                          flag = false;
                          messgae = Text(
                            '$name 账户未收到空投',
                            style: const TextStyle(fontSize: 30),
                          );
                        } else {
                          flag = true;
                          messgae = Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: '$name 账户被空投  ',
                                  style: const TextStyle(fontSize: 30),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: amount,
                                        style: const TextStyle(
                                            fontSize: 50, color: Colors.green)),
                                    const TextSpan(
                                        text: ' Starknet Token.\n',
                                        style: TextStyle(fontSize: 30)),
                                  ],
                                ),
                              ),
                              const SelectableText(
                                  'https://provisions.starknet.io/',
                                  style: TextStyle(fontSize: 30)),
                            ],
                          );
                        }
                      });
                    },
                    child: const Text(
                      '检查',
                      style: TextStyle(fontSize: 20),
                    )))
          ],
        ),
      ),
    );
  }
}
