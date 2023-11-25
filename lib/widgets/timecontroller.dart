import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foco_alternativo/timeservice.dart';

class TimeController extends StatefulWidget {
  const TimeController({super.key});

  @override
  State<TimeController> createState() => _TimeControllerState();
}

class _TimeControllerState extends State<TimeController> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimeService>(context);
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(color: Colors.black26, shape: BoxShape.circle),
      child: Center(
        child: IconButton(onPressed: (){
          provider.timerPlaying 
          ? Provider.of<TimeService>(context,listen: false).pause() 
          : Provider.of<TimeService>(context,listen: false).start();
        } ,
         icon: provider.timerPlaying 
         ? const Icon(Icons.pause) 
         : const Icon(Icons.play_arrow_sharp),
       color: Colors.white,
       iconSize: 55, ),
      ),
    );
  }
}