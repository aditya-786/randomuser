import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://randomuser.me/api/?results=1000";
  bool isLoading = true;
  List data;

  Future getJsonData() async {
    var response = await http.get(
      Uri.encodeFull(url),
    );

    List convertedData = jsonDecode(response.body)['results'];

    setState(() {
      data = convertedData;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Users'),
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(
                                data[index]['picture']['medium'],
                              ),
                            ),
                            title: Text(
                                "Name: ${data[index]['name']['first'] + " " + data[index]['name']['last']}"),
                            subtitle: Text("Phone: ${data[index]['phone']}"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
