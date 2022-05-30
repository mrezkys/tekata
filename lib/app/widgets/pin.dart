import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tekata/app/style/app_color.dart';

class Pin extends StatefulWidget {
  final TextEditingController controller;
  final int itemCount;
  final double itemHeight, itemWidth;
  final List<dynamic> check;
  final bool checked;
  final void Function() onFinished;
  final List<List<FocusNode>> listFocusNode;
  final int index;
  Pin({
    required this.controller,
    required this.itemCount,
    this.itemHeight = 64,
    this.itemWidth = 64,
    required this.check,
    this.checked = false,
    required this.onFinished,
    required this.listFocusNode,
    required this.index,
  });

  @override
  State<Pin> createState() => _PinState();
}

class _PinState extends State<Pin> {
  late List<TextEditingController> listController = List.generate(widget.itemCount, (index) => TextEditingController());

  Color getBoxColor(String check) {
    if (check == 'true') {
      return AppColor.secondary;
    } else if (check == 'wrong') {
      return Colors.black.withOpacity(0.50);
    } else {
      return Colors.black.withOpacity(0.15);
    }
  }

  @override
  void initState() {
    super.initState();
    listController = List.generate(widget.itemCount, (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.itemCount, (index) {
        return Container(
          width: widget.itemHeight,
          height: widget.itemWidth,
          margin: EdgeInsets.only(bottom: 8),
          color: getBoxColor(widget.check[index]),
          child: RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (event) {
              if (event.logicalKey == LogicalKeyboardKey.backspace) {
                if (index != 0) {
                  widget.listFocusNode[widget.index][index - 1].requestFocus();
                }
              }
            },
            child: TextField(
              autofocus: false,
              readOnly: widget.checked,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
              ),
              controller: listController[index],
              style: TextStyle(fontSize: 32, color: Colors.white),
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              maxLength: 1,
              maxLines: 1,
              focusNode: widget.listFocusNode[widget.index][index],
              onChanged: (text) {
                if (text.isEmpty) {
                  if (index != 0) {
                    widget.listFocusNode[widget.index][index - 1].requestFocus();
                  }
                } else if (index < (widget.itemCount - 1)) {
                  widget.listFocusNode[widget.index][index + 1].requestFocus();
                }

                if (index == (widget.itemCount - 1) && listController[index].text.isNotEmpty) {
                  String answer = '';
                  for (var i = 0; i < widget.itemCount; i++) {
                    answer = answer + listController[i].text;
                  }
                  setState(() {
                    widget.controller.text = answer;
                  });
                  widget.onFinished();
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
