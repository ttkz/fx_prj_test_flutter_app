
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

class ProfileScreen extends StatefulWidget{
  final String puserId;
  final String pdisplayName;
  final String pstatusMessage;
  final String paccessToken;
  final String pimgUrl;
  ProfileScreen({Key key, @required this.puserId, @required this.pdisplayName, @required this.pstatusMessage, @required this.paccessToken, @required this.pimgUrl}) : super(key: key);

  ProfileScreenState createState()=> ProfileScreenState();
}
class ProfileScreenState extends State<ProfileScreen>{
  String displayName = "{DisplayName}";
  String statusMessage = "{Status}";
  String imgUrl = "{imgUrl}";
  String accessToken = "{AccessToken}";
  String userId = "{userId}";
  void logout() async{
    try {
      await LineSDK.instance.logout();
      Navigator.pop(context);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
  @override
  void initState() {
    setState(() {
      userId = widget.puserId;
      displayName = widget.pdisplayName;
      statusMessage = widget.pstatusMessage;
      imgUrl = widget.pimgUrl;
      accessToken = widget.paccessToken;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Line Login With profiele"),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Image.network(imgUrl, width: 200, height: 200,),
                ),
              ],

            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text("Welcome", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("* DisplayName:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            Wrap(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(8.0),
                  child: Text(displayName,style: TextStyle(fontSize: 20),),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("* userId:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            Wrap(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(8.0),
                  child: Text(userId,style: TextStyle(fontSize: 20),),)
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("* StatusMessage:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            Wrap(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(8.0),
                  child: Text(statusMessage,style: TextStyle(fontSize: 20),),)
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("* accessToken:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            Wrap(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(8.0),
                  child: Text(accessToken,style: TextStyle(fontSize: 15),),)
              ],),
            Row(children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: FlatButton(
                    child: Text("Log Out", style: TextStyle(color: Colors.white),),
                    color: Color.fromRGBO(255, 59, 10, 1),
                    padding: EdgeInsets.all(8),
                    onPressed: () {
                      logout();
                    },),
                ),
              )
            ],)

          ],
        ),
      ),
    );
  }

}