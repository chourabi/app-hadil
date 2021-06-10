import 'package:flutter/material.dart';

class DetailItemBirth extends StatelessWidget {
  final String title;
  final DateTime value;
  const DetailItemBirth({Key key, this.title, this.value}) : super(key: key);
  


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(title, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Text(value ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailItemBirthEditComponent extends StatelessWidget {
  final String title;
  final Widget widget;

  const DetailItemBirthEditComponent({Key key, @required this.title, @required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(title,style: TextStyle(fontSize: 20)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: widget,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}