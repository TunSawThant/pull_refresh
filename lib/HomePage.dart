import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_refresh/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;

import 'detailsPage.dart';
class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

Future<http.Response> _binduser(int pageno) async{
  http.Response _response  =await http.get("http://www.json-generator.com/api/json/get/ceDTBYcMEi?indent=$pageno");
  return _response;
}

class _HomePage1State extends State<HomePage1> {
  RefreshController _refreshController;
  List<User> _userlist=[];
  int _numpage=1;

  void addtoUserlist(jData){
    for(var jsonData in jData){
      User _user=User(jsonData['index'], jsonData['about'],jsonData['picture'] ,jsonData['email'] ,jsonData['name']) ;
      _userlist.add(_user);
    }
  }
  void _onRefresh() async{
    _userlist=[];
    _numpage=1;
   await _binduser(_numpage).then((res){
      setState(() {
        addtoUserlist(json.decode(res.body));
      });
    });
    _refreshController.refreshCompleted();
  }
  void _onLoading() async{
    _numpage++;
    await _binduser(_numpage).then((res){
      setState(() {
        addtoUserlist(json.decode(res.body));
      });
    });
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController=RefreshController(initialRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pull to Refresh"),
        centerTitle: true,
      ),
      body:  SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropMaterialHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
              body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemExtent: 100.0,
          itemCount: _userlist.length,
          itemBuilder: (BuildContext context,int index){
            return Container(
              color: Colors.yellow,
              padding: EdgeInsets.all(4.0),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(_userlist[index].picture),
                  ),
                  title: Text(_userlist[index].name),
                  subtitle: Text(_userlist[index].email),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(_userlist[index])));
                  },
                ),
              ),
            );
          },
        ),
      ),

    );
  }
}
