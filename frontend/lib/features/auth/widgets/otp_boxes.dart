import 'package:flutter/material.dart';

class OTPBoxes extends StatefulWidget {
  final TextEditingController controller;

  const OTPBoxes({
    super.key,
    required this.controller,
  });

  @override
  State<OTPBoxes> createState() => _OTPBoxesState();
}

class _OTPBoxesState extends State<OTPBoxes> {
  final List<TextEditingController> controllers =
      List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes =
      List.generate(
    6,
    (_) => FocusNode(),
  );

  void updateOTP() {
    widget.controller.text =
        controllers
            .map(
              (e) => e.text,
            )
            .join();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (index) {
          return SizedBox(
            width: 50,
            child: TextField(
              controller:
                  controllers[index],
              focusNode:
                  focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType:
                  TextInputType.number,
              maxLength: 1,

              decoration:
                  InputDecoration(
                counterText: "",
                filled: true,
                fillColor:
                    Colors.white,
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
              ),

              onChanged: (value) {
                updateOTP();

                if (value.isNotEmpty &&
                    index < 5) {
                  FocusScope.of(context)
                      .requestFocus(
                    focusNodes[
                        index + 1],
                  );
                }

                if (value.isEmpty &&
                    index > 0) {
                  FocusScope.of(context)
                      .requestFocus(
                    focusNodes[
                        index - 1],
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    for (final controller
        in controllers) {
      controller.dispose();
    }

    for (final node
        in focusNodes) {
      node.dispose();
    }

    super.dispose();
  }
}