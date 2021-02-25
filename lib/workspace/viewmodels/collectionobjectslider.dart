import 'package:flutter/material.dart';
import 'package:sashimetriweb/workspace/metrioptionsviews/styles.dart';

class CollectionObjectSlider extends StatefulWidget {
  final height;
  final Color color;
  final String title;
  final margin;
  final double value;
  final String label;
  final onValueChange;
  final max;
  final min;
  final onResetValue;
  const CollectionObjectSlider({
    Key key,
    this.height: 30,
    this.margin,
    this.color,
    @required this.label,
    this.title,
    this.max: 1,
    this.min: 0,
    this.onValueChange,
    this.value,
    @required this.onResetValue,
  }) : super(key: key);

  @override
  _CollectionObjectSliderState createState() => _CollectionObjectSliderState();
}

class _CollectionObjectSliderState extends State<CollectionObjectSlider> {
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
      color: widget.color != null ? widget.color : Colors.grey.shade900,
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
                    color: widget.color,
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
                  color: widget.color,
                  height: 40,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            widget.label,
                            style: TextStyle(
                              color: Colors.white,
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
                            activeColor: Colors.white,
                            inactiveColor: Colors.grey.shade800,
                            value: widget.value,
                            onChanged: widget.onValueChange,
                            max: widget.max,
                            min: widget.min,
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
