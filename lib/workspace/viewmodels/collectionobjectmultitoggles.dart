import 'package:flutter/material.dart';

class CollectionObjectToggles extends StatefulWidget {
  final height;
  final Color color;
  final Widget title;
  final margin;
  final double value;
  final onValueChange;
  final max;
  final min;
  const CollectionObjectToggles({
    Key key,
    this.height: 30,
    this.margin: const EdgeInsets.symmetric(horizontal: 109),
    this.color: Colors.grey,
    @required this.title,
    this.max: 1,
    this.min: 0,
    @required this.onValueChange,
    @required this.value,
  }) : super(key: key);

  @override
  _CollectionObjectTogglesState createState() =>
      _CollectionObjectTogglesState();
}

class _CollectionObjectTogglesState extends State<CollectionObjectToggles> {
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
      color: widget.color,
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
                      child: widget.title,
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
                            widget.value.toStringAsFixed(2),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          overlayShape: SliderComponentShape.noOverlay,
                          trackHeight: 15,
                        ),
                        child: Slider(
                          activeColor: Colors.white,
                          inactiveColor: Colors.grey.shade800,
                          value: widget.value,
                          onChanged: (value) {
                            widget.onValueChange(value);
                          },
                          max: widget.max,
                          min: widget.min,
                          label: widget.value.toStringAsFixed(2),
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
