import 'package:flutter/material.dart';
import 'package:software_quality/functionality/model/functionality.dart';
import 'package:software_quality/scope/view_model/scope_view_model.dart';

// ignore: must_be_immutable
class FunctionalityCheckbox extends StatefulWidget {
  FunctionalityCheckbox({super.key, required this.functionality, required this.scopeViewModel});

  List<Functionality> functionality = [];
  final ScopeViewModel scopeViewModel;

  @override
  State<FunctionalityCheckbox> createState() => _FunctionalityCheckboxState();
}

class _FunctionalityCheckboxState extends State<FunctionalityCheckbox> {
  void _getList() {
    if (widget.functionality.isEmpty) widget.functionality = widget.scopeViewModel.functionalitys;
  }

  @override
  Widget build(BuildContext context) {
    _getList();

    return ListView.builder(
      itemCount: widget.functionality.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
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
                  widget.functionality[index].description ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 25,
                  child: Checkbox(
                    value: widget.functionality[index].select,
                    onChanged: (value) {
                      widget.scopeViewModel.selectFunctionality(widget.functionality, index, value);
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
