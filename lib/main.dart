import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scratcher/scratcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: TextButton(
        child: const Text('Open your reward'),
        onPressed: () async {
          _selected = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const FullScreenDialog(childWidget: ScratchCard());
              },
              fullscreenDialog: true));
          if (_selected != null) {
            setState(() {
              _selected = _selected;
            });
          }
        },
      ),
    )));
  }
}

class FullScreenDialog extends StatelessWidget {
  const FullScreenDialog({Key? key, required this.childWidget})
      : super(key: key);

  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.grey[400]),
            ),
            childWidget,
          ],
        ),
      ),
    );
  }
}

class ScratchCard extends StatefulWidget {
  const ScratchCard({Key? key}) : super(key: key);

  @override
  _ScratchCardState createState() => _ScratchCardState();
}

class _ScratchCardState extends State<ScratchCard> {
  final scratchKey = GlobalKey<ScratcherState>();
  bool canAdd = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.white),
                  borderRadius: BorderRadius.circular(12.0)),
              child: const Text(
                'B',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 56),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Get the product for free',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              'Wipe off the protective layer and put the free product in the shopping basket',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 24),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Scratcher(
                key: scratchKey,
                brushSize: 30,
                threshold: 70,
                image: Image.asset('assets/scratch_cover.png'),
                onChange: (value) => print("Scratch progress: $value%"),
                onThreshold: () {
                  print("Threshold reached, you won!");
                  setState(() {
                    canAdd = true;
                  });
                },
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('assets/golden_ticket.png'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                canAdd ? Fluttertoast.showToast(msg: 'Added to cart') : null;
              },
              child: const Text(
                'Add product to cart',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  primary: canAdd ? Colors.cyan[300] : Colors.grey,
                  minimumSize: const Size.fromHeight(50)),
            ),
            TextButton(
              onPressed: () {
                scratchKey.currentState
                    ?.reset(duration: const Duration(milliseconds: 500));
                setState(() {
                  canAdd = false;
                });
              },
              child: const Text(
                'RESET',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      )),
    );
  }
}
