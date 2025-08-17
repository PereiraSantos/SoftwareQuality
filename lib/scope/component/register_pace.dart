import 'package:flutter/material.dart';
import 'package:software_quality/scope/model/pace.dart';
import 'package:software_quality/scope/view_model/scope_view_model.dart';

class RegisterPace extends StatefulWidget {
  const RegisterPace({super.key, required, required this.scopeViewModel});

  final ScopeViewModel scopeViewModel;

  @override
  State<RegisterPace> createState() => _RegisterPaceState();
}

class _RegisterPaceState extends State<RegisterPace> {
  @override
  Widget build(BuildContext context) {
    var i = 1;

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              if (widget.scopeViewModel.pace.text == '') return;

              widget.scopeViewModel.paces.add(Pace(description: widget.scopeViewModel.pace.text));
              widget.scopeViewModel.clearPace();
              setState(() {});
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            child: const Text(
              'SALVAR',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
          ...widget.scopeViewModel.paces.map((e) {
            return Padding(
              padding: const EdgeInsets.only(left: 8, top: 5),
              child: Text('Passo ${i++}: ${e.description}'),
            );
          })
        ],
      ),
    );
  }
}
