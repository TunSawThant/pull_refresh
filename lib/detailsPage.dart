import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_refresh/user.dart';

class DetailsPage extends StatelessWidget {
  final User _userslist;
  DetailsPage(this._userslist);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(_userslist.name),
      ),
      body: Container(
        color: Colors.lightGreen,
        child: Column(
          children: <Widget>[
            SizedBox(height: 5.0,),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(_userslist.picture,height: 100,width: 100,),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    _userslist.name,
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                  Text(_userslist.email,style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),

                  Container(
                    margin: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(10.0)

                      ),
                      child: Text(_userslist.about,style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic),textAlign: TextAlign.justify,)
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
