import 'package:flutter/material.dart';
import 'package:software_quality/scenery/model/scenery.dart';

class CheckBoxScenery extends StatefulWidget {
  const CheckBoxScenery({super.key, required this.scenery, required this.onClick});

  final Scenery scenery;
  final Function(bool?) onClick;

  @override
  State<CheckBoxScenery> createState() => _CheckBoxSceneryState();
}

class _CheckBoxSceneryState extends State<CheckBoxScenery> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 12,
            child: Text(
              widget.scenery.description ?? '',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 25,
              child: Checkbox(
                value: widget.scenery.select,
                onChanged: (value) {
                  widget.onClick(value);
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
