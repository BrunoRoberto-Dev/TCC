// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:foco_alternativo/timeservice.dart';
import 'package:foco_alternativo/utils.dart';
import 'package:provider/provider.dart';

class TimeOptions extends StatelessWidget {


  const TimeOptions({super.key}); 
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimeService>(context);
    return SingleChildScrollView(
      controller: ScrollController(initialScrollOffset: 240),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: selectableTimes.map((time){
          return InkWell(
            onTap: () => provider.selectTime(double.parse(time)),
            child: Container(
              margin: const EdgeInsets.only(left:10),
              width: 70,
              height: 50,
              decoration: int.parse(time) == provider.selectedTime ? BoxDecoration(
               color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ) : BoxDecoration(
                border: Border.all(width: 3,color: Colors.white30),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text((int.parse(time) ~/ 60).toString(),
                style: TextStyle(fontSize: 25, color: int.parse(time) == provider.selectedTime ? renderColor(provider.currentState):Colors.white, fontWeight: FontWeight.w700)),
                ),
            ),
          );
        }).toList() ,
      ),
    );
  }
}
