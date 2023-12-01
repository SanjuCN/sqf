import 'package:flutter/material.dart';
import 'package:sqf/controller/database_controller.dart';
import 'package:sqf/model/datamodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await database_controller.initdb();
  await database_controller.getdata();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home_screen(),
    );
  }
}

class home_screen extends StatefulWidget {
  home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  void initState() {
    database_controller.getdata();
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  database_controller data = database_controller();
  TextEditingController datacontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: SearchBar(
                    hintText: "Search",
                    controller: datacontroller,
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  database_controller.addUser(datacontroller.text);
                },
                child: Text("add")),
            Container(
              height: 550,
              child: ListView.builder(
                itemCount: database_controller.mylist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title:
                        Text(database_controller.mylist[index].name.toString()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
