import 'package:flutter/material.dart';

class DeleteLayer extends StatefulWidget {
  const DeleteLayer({
    Key? key,
    required this.onTap,

  }) : super(key: key);

  final onTap;

  @override
  State<DeleteLayer> createState() => _DeleteLayerState();
}

class _DeleteLayerState extends State<DeleteLayer> {
  bool hover = false;
  void onHover(bool e) {
    setState(() {
      hover = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: hover ? Colors.white30 : Colors.white10,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onHover: onHover,
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              Icons.delete,
              size: 16,
              color:  Colors.white ,
            ),
          ),
        ),
      ),
    );
  }
}
