import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed("first");
            }, child: Text("First Task")),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed("second");
            }, child: Text("Second Task")),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed("third");
            }, child: Text("Third Task")),
          ],
        ),
      ),
    );
  }
}
