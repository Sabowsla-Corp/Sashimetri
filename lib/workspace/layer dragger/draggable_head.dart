import 'package:flutter/material.dart';
import 'package:sashimetri/workspace/layer%20dragger/drag_head_toggler.dart';

class DraggableHead extends StatelessWidget {
  const DraggableHead(
      {Key? key,
      this.dragUpdte,
      required this.onToggle,
      this.isExpanded,
      this.onDragEnd})
      : super(key: key);

  final bool? isExpanded;
  final dragUpdte;
  final onDragEnd;
  final Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Draggable(
            data: this,
            onDragEnd: onDragEnd,
            onDragUpdate: dragUpdte,
            feedback: Container(),
            child: Center(
              child:
                  Icon(Icons.grid_view_rounded, color: Colors.white, size: 15),
            ),
          ),
          DragHeadToggler(
            onPressed: onToggle,
            isExpanded: isExpanded!,
          ),
          Text(
            " Layers",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
