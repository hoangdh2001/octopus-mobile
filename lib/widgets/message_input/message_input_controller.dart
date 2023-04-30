import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/ui/message_text_field.dart';
import 'package:uuid/uuid.dart';

typedef MessageValueListenableBuilder = ValueListenableBuilder<Message>;

class MessageInputController extends ValueNotifier<Message> {
  factory MessageInputController({
    Message? message,
    Map<RegExp, TextStyleBuilder>? textPatternStyle,
  }) =>
      MessageInputController._(
        initialMessage: message ?? Message(),
        textPatternStyle: textPatternStyle,
      );

  factory MessageInputController.fromText(
    String? text, {
    Map<RegExp, TextStyleBuilder>? textPatternStyle,
  }) =>
      MessageInputController._(
        initialMessage: Message(text: text),
        textPatternStyle: textPatternStyle,
      );

  MessageInputController._({
    required Message initialMessage,
    Map<RegExp, TextStyleBuilder>? textPatternStyle,
  })  : _textEditingController = MessageTextFieldController.fromValue(
          initialMessage.text == null
              ? TextEditingValue.empty
              : TextEditingValue(
                  text: initialMessage.text!,
                  composing: TextRange.collapsed(initialMessage.text!.length),
                ),
          textPatternStyle: textPatternStyle,
        ),
        _initialMessage = initialMessage,
        super(initialMessage) {
    addListener(_textEditingSyncer);
  }

  void _textEditingSyncer() {
    final cleanText = value.text;

    if (cleanText != _textEditingController.text) {
      final previousOffset = _textEditingController.value.selection.start;
      final previousText = _textEditingController.text;
      final diff = (cleanText?.length ?? 0) - previousText.length;
      _textEditingController
        ..text = cleanText ?? ''
        ..selection = TextSelection.collapsed(
          offset: previousOffset + diff,
        );
    }
  }

  Message get message => value;

  MessageTextFieldController get textEditingController =>
      _textEditingController;
  final MessageTextFieldController _textEditingController;

  String get text => _textEditingController.text;

  Message _initialMessage;

  set message(Message message) {
    value = message;
  }

  set text(String newText) {
    var newTextWithCommand = newText;

    value = value.copyWith(text: newTextWithCommand);
  }

  int get baseOffset => textEditingController.selection.baseOffset;

  int get selectionStart => textEditingController.selection.start;

  List<Attachment> get attachments => value.attachments;

  /// Sets the list of [attachments] for the message.
  set attachments(List<Attachment> attachments) {
    value = value.copyWith(attachments: attachments);
  }

  void reset({bool resetId = true}) {
    if (resetId) {
      final newId = const Uuid().v4();
      _initialMessage = _initialMessage.copyWith(id: newId);
    }
    value = _initialMessage;
  }

  void addAttachment(Attachment attachment) {
    attachments = [...attachments, attachment];
  }

  /// Adds a new attachment at the specified [index].
  void addAttachmentAt(int index, Attachment attachment) {
    attachments = [...attachments]..insert(index, attachment);
  }

  /// Removes the specified [attachment] from the message.
  void removeAttachment(Attachment attachment) {
    attachments = [...attachments]..remove(attachment);
  }

  /// Remove the attachment with the given [attachmentId].
  void removeAttachmentById(String attachmentId) {
    attachments = [...attachments]..removeWhere((it) => it.id == attachmentId);
  }

  /// Removes the attachment at the given [index].
  void removeAttachmentAt(int index) {
    attachments = [...attachments]..removeAt(index);
  }

  /// Clears the message attachments.
  void clearAttachments() {
    attachments = [];
  }

  @override
  void dispose() {
    removeListener(_textEditingSyncer);
    _textEditingController.dispose();
    super.dispose();
  }
}

class RestorableMessageInputController
    extends RestorableChangeNotifier<MessageInputController> {
  RestorableMessageInputController({Message? message})
      : _initialValue = message ?? Message();

  factory RestorableMessageInputController.fromText(String? text) =>
      RestorableMessageInputController(message: Message(text: text));

  final Message _initialValue;

  @override
  MessageInputController createDefaultValue() =>
      MessageInputController(message: _initialValue);

  @override
  MessageInputController fromPrimitives(Object? data) {
    final message = Message.fromJson(json.decode(data! as String));
    return MessageInputController(message: message);
  }

  @override
  String toPrimitives() => json.encode(value.value);
}
