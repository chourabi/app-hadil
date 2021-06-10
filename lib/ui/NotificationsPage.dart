import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {

  final List<dynamic> notifications;
  NotificationsPage({Key key, this.notifications}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<dynamic> _notifications;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notifications = widget.notifications;

    _notifications.sort((a,b)=> a['id'] - b['id'] );
    _notifications = _notifications.reversed.toList();
  }

  
  @override
  Widget build(BuildContext context) {
    return(
      Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
        child: ListView.builder( itemCount: _notifications.length, itemBuilder: (context, index) {
        return(
          ListTile(
            title: Text('${_notifications[index]['title']}',
            style: TextStyle( fontWeight: _notifications[index]['seen'] == false ? FontWeight.bold : FontWeight.normal ),
            
            ),
            subtitle:Text('${_notifications[index]['message']}') ,
            
          )
        );
      }, ),
      ),
      )
    );
  }
}