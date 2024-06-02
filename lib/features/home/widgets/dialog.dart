import 'package:assignment/features/home/model/userModel.dart';
import 'package:assignment/utils/strings.dart';
import 'package:flutter/material.dart';

class ChangeRupeeDialog extends StatefulWidget {
  final int index;
  final User user;
  final Function(int, int) onUpdate;

  ChangeRupeeDialog({
    required this.index,
    required this.user,
    required this.onUpdate,
  });

  @override
  _ChangeRupeeDialogState createState() => _ChangeRupeeDialogState();
}

class _ChangeRupeeDialogState extends State<ChangeRupeeDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.user.rupee.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(MyStrings.changeRup),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: MyStrings.entrNewRupVal,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(MyStrings.cancel),
        ),
        TextButton(
          onPressed: () {
            int newRupee = int.parse(_controller.text);
            widget.onUpdate(widget.index, newRupee);
            Navigator.of(context).pop();
          },
          child: Text(MyStrings.save),
        ),
      ],
    );
  }
}
