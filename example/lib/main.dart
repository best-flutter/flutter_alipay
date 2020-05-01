import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alipay/flutter_alipay.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:easy_alert/easy_alert.dart';



void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new AlertProvider(child: new Main()),
    );
  }
}



class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  String _payInfo = "";
  AlipayResult _payResult;

  final myController = new TextEditingController();

  void _loadData(){
    _payInfo = "";
    _payResult = null;

    http
        .post("http://192.168.1.104:8095/api/pay/prePay",
        body: json.encode({}))
        .then((http.Response response) {
      if (response.statusCode == 200) {
        print(response.body);
        var map = json.decode(response.body);
        setState(() {
          _payInfo = map;
          myController.text = _payInfo;
        });
        return;
      }
      throw new Exception("拉取订单支付信息失败");
    }).catchError((e) {
      setState(() {
        _payInfo = e.toString();
        myController.text = _payInfo;
      });
    });

    setState(() {

    });
  }

  @override
  initState() {
    super.initState();

    _loadData();
  }

  onChanged(String value) {
    _payInfo = value;
  }

  callAlipay() async {
    dynamic payResult;
    try {
      print("The pay info is : " + _payInfo);
      payResult = await FlutterAlipay.pay(_payInfo);
    } on Exception catch (e) {
      payResult = null;
    }

    if (!mounted) return;

    setState(() {
      _payResult = payResult;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Alipay example'),
      ),
      body: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
//            new RaisedButton(child:new Text('检查是否安装'),onPressed: () async{
//
//              if(await FlutterAlipay.isInstalled()){
//                Alert.alert(context,title: "已经安装");
//              }else{
//                Alert.alert(context,title: "没有安装");
//              }
//
//            }),
            new Text("输入调用字符串,如何生成请查阅支付宝官方文档:https://docs.open.alipay.com/"),
            new TextField(
                maxLines: 15, onChanged: onChanged, controller: myController),
            new RaisedButton(onPressed: callAlipay, child: new Text("调用支付宝")),
            new RaisedButton(onPressed: (){

              _loadData();

            }, child: new Text("重新下单")),
            new Text(_payResult == null ? "" : _payResult.toString())
          ],
        ),
      ),
    );
  }
}
