import 'package:flutter/material.dart';
import 'package:sashimetriweb/workspace/metrioptionsviews/styles.dart';

class CollectionObjectSliderEnum extends StatefulWidget {
  final height;
  final Color bgColor;
  final String title;
  final margin;
  final value;
  final onValueChange;
  final max;
  final min;
  final onResetValue;
  final divisions;
  final label;
  const CollectionObjectSliderEnum({
    Key key,
    this.height: 30,
    this.margin,
    this.bgColor,
    this.title,
    this.max: 1,
    this.min: 0,
    this.onValueChange,
    this.value,
    this.divisions,
    this.label,
    @required this.onResetValue,
  }) : super(key: key);

  @override
  _CollectionObjectSliderEnumState createState() =>
      _CollectionObjectSliderEnumState();
}

class _CollectionObjectSliderEnumState
    extends State<CollectionObjectSliderEnum> {
  bool sliderVisible = false;

  void toggleSliderView() {
    setState(() {
      sliderVisible = !sliderVisible;
    });
  }

  void updateMaxMins() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bgColor != null ? widget.bgColor : Colors.grey.shade900,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    sliderVisible ? Icons.arrow_drop_down : Icons.arrow_right,
                    color: Colors.white,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    color: widget.bgColor,
                    height: widget.height,
                    margin: widget.margin,
                    child: InkWell(
                      onTap: toggleSliderView,
                      child: Center(
                        child: Text(
                          widget.title,
                          style: collection,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (sliderVisible)
                Container(
                  color: widget.bgColor,
                  height: 50,
                  margin: EdgeInsets.only(left: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Center(
                            child: Text(
                              widget.label,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onDoubleTap: widget.onResetValue,
                        child: SliderTheme(
                          data: SliderThemeData(
                            overlayShape: SliderComponentShape.noOverlay,
                            trackHeight: 15,
                          ),
                          child: Slider(
                            divisions: widget.divisions,
                            activeColor: Colors.white,
                            inactiveColor: Colors.grey.shade800,
                            onChanged: widget.onValueChange,
                            value: widget.value,
                            max: widget.divisions - 1,
                            label: widget.label,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
