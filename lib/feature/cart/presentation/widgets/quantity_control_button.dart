import 'package:flutter/material.dart';


class QuantityControlButton extends StatelessWidget {
  const QuantityControlButton({super.key, required this.icon, required this.onPressed, required this.color, required this.heroTag});
  final IconData icon ;
  final Function onPressed;
  final Color color;
  final String heroTag;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
       onPressed();
      },
      heroTag:null,
      mini: true,
      backgroundColor:color,
      child:  Icon(icon,color: Colors.white,),
    );
  }
}
