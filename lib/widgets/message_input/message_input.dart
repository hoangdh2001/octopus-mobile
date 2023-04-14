import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/widgets/auto_complete_input/auto_complete_input.dart';
import 'package:octopus/widgets/message_input/message_send_button.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({super.key});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: OctopusTheme.of(context).colorTheme.contentView,
      ),
      child: GestureDetector(
          onPanUpdate: (details) {
            if (details.delta.dy > 0) {}
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: _buildTextField(context),
              ),
            ],
          )),
    );
  }

  Flex _buildTextField(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        _buildTextInput(context),
        _buildSendButton(context),
      ],
    );
  }

  Expanded _buildTextInput(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.5).r,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.withOpacity(0.1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LimitedBox(
                  maxHeight: 40,
                  child: AutoCompleteInput(
                    key: const Key('messageInputText'),
                    enabled: true,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.center,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: "Aa",
                      hintStyle: OctopusTheme.of(context).textTheme.hint,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(16, 12, 13, 11),
                    ),
                    style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSendButton(BuildContext context) {
    return MessageSendButton(
      onSendMessage: () {},
      isIdle: false,
      isEditEnabled: true,
    );
  }
}
