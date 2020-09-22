import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:fx_prj_test_flutter_app/login_screen/profile_page.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState()=> _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{

  void startLineLogin() async{
    try {
      final result = await LineSDK.instance.login(scopes: ["profile"]);
      print(result.toString());
      var accesstoken = await getAccessToken();
      var displayname = result.userProfile.displayName;
      var statusmessage = result.userProfile.statusMessage;
      var imgUrl = result.userProfile.pictureUrl;
      var userId = result.userProfile.userId;

      print("AccessToken> " + accesstoken);
      print("DisplayName> " + displayname);
      print("StatusMessage> " + statusmessage);
      print("ProfileURL> " + imgUrl);
      print("userId> " + userId);

      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(puserId: userId, paccessToken: accesstoken, pdisplayName: displayname, pimgUrl: imgUrl, pstatusMessage: statusmessage,)));

    } on PlatformException catch (e) {
      print(e);
      switch (e.code.toString()){
        case "CANCEL":
          showDialogBox("You canceled the login.", "A moment you pressed cancel login Please log in again.");
          print("User Cancel the login");
          break;
        case "AUTHENTICATION_AGENT_ERROR":
          showDialogBox("You are not allowed to log in as well LINE", "A moment you pressed cancel login Please log in again.");
          print("User decline the login");
          break;
        default:
          showDialogBox("Something went wrong", "An unknown error occurred. Please log in again.");
          print("Unknown but failed to login");
          break;
      }
    }
  }
Future getAccessToken() async{
  try {
    final result = await LineSDK.instance.currentAccessToken;
    return result.value;
  }  on PlatformException catch (e) {
    print(e.message);
  }
}
  void showDialogBox(String title, String body) async{
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
                Text(body)
              ],),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],);
        }
    );
  }
  void lineSDKInit() async{
    await LineSDK.instance.setup("1654951350").then((_){// set up your channel ID
      print("LineSDK is Prepared");
    });
  }
  @override
  void initState() {
    lineSDKInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Image.asset("asset/images/line_logo.png", width: 100, height: 100,),
            ),
            Text("Welcome to Our App", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),),
            Text("Please login before you can use", style: TextStyle(fontSize: 15,)),
            Padding(
              padding: const EdgeInsets.only(left:24, right:24,top: 15),
              child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 0, bottom: 10, right: 10, left: 10),
                        child: RaisedButton(
                          color: Color.fromRGBO(0, 185, 0, 1),
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(1),
                          child: Column(
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage(
                                        'assets/images/line_logo.png',
                                      ),
                                      height: 50,
                                      width: 50,
                                    ),
                                    Container(
                                      color: Colors.black12,
                                      width: 2,
                                      height: 40,
                                    ),
                                    Expanded(
                                      child: Center(child: Text("LINEでログイン", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),)
                                  ]
                              ),
                            ],
                          ),
                          onPressed: (){
                            startLineLogin();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:24, right:24,top: 15),
              child:  Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 0, bottom: 10, right: 10, left: 10),
                  child: RaisedButton(
                    color: Color.fromRGBO(0, 120, 225, 1),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(1),
                    child: Column(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Image(
                                image: AssetImage(
                                  'assets/images/twitter_ic.png',
                                ),
                                height: 50,
                                width: 50,
                              ),
                              Container(
                                color: Colors.black12,
                                width: 2,
                                height: 40,
                              ),
                              Expanded(
                                child: Center(child: Text("Twitter でログイン", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),)
                            ]
                        )
                      ],
                    ),
                    onPressed: (){
                      startLineLogin();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}