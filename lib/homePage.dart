import 'package:flutter/material.dart';

import 'gsheets.dart';
import 'loading.dart';
import 'pomodoroTimerPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  List<String> names = <String>[];

  @override
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    await _getNamesFromSheet();
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  _getNamesFromSheet() async {
    names = <String>[];
    List<Map<String, String>> namesFromSheet = await getNames();
    if (namesFromSheet == null) return;
    namesFromSheet.forEach((element) {
      names.add(element["Name"]);
    });
  }

  final _formKey = GlobalKey<FormState>();
  void _addItem() async {
    String newName = await _showDialog();
    print(newName);
    await insertNew(newName);
    setState(() {
      isLoading = true;
    });
    await _getNamesFromSheet();
    setState(() {
      isLoading = false;
    });
    print("add item");
  }

  Future<String> _showDialog() async {
    String _newName;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: [
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Subject Name',
                            labelText: 'Name *',
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _newName = value;
                            });
                          },
                          validator: (value) =>
                              value.isEmpty ? 'Please enter a name' : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("Add"),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              print(_newName);
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
    return _newName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pomodoro Timer"),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () => _addItem())
        ],
      ),
      body: isLoading
          ? Loading()
          : Container(
              margin: EdgeInsets.all(8.0),
              child: names.length == 0
                  ? Container(child: Text("No subjects"))
                  : ListView.builder(
                      itemCount: names.length,
                      itemBuilder: (context, index) {
                        return ListItem(
                          name: names[index],
                        );
                      }),
            ),
    );
  }
}

class ListItem extends StatelessWidget {
  final name;

  const ListItem({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(12)),
          child: FlatButton(
            onPressed: () {},
            child: Row(
              children: [
                Expanded(child: Text(name)),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PomodoroTimer(
                          title: name,
                        );
                      }));
                    },
                    child: Text("Start"),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
