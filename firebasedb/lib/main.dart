import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Firebase databsase'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var led = '';
  var pir = '';

  DatabaseReference database =
      FirebaseDatabase().reference();

  void setData() {
    database.set({'led': '1'});
  }

  void setData2() {
    database.child('ledstatus').update({'led': 'updated'});
  }

  void getData() async {
    DataSnapshot data = await database.once();
    setState(() {
      led = data.value['led'];
    });
  }
  void pirMethod(){
    print('smart light mode change');
  }
  void ledMethod(){
    print('led on method ');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: database.child('ledstatus').onValue,
      builder: (context, snap) {
        if (snap.hasData &&
            !snap.hasError &&
            snap.data.snapshot.value != null) {
          Map data = snap.data.snapshot.value;
          led = data['led'];

        }
        return StreamBuilder(
            stream: database.child('pir').onValue,
            builder: (context, snap) {
              if (snap.hasData &&
                  !snap.hasError &&
                  snap.data.snapshot.value != null) {
                Map data = snap.data.snapshot.value;
                print(data);
                pir = data['status'];
              }
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        led,
                      ),
                      Text(pir),
                      RaisedButton(
                        onPressed: setData,
                        child: Text('Set LED'),
                      ),
                      RaisedButton(
                        onPressed: setData2,
                        child: Text('update led'),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
