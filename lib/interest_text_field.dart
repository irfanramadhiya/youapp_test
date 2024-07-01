import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class InterestTextField extends StatefulWidget {
  const InterestTextField({super.key, required this.interestFromApi});

  final List<String> interestFromApi;

  @override
  State<InterestTextField> createState() => _InterestTextFieldState();
}

class _InterestTextFieldState extends State<InterestTextField> {
  late double _distanceToField;
  late StringTagController _stringTagController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _stringTagController = StringTagController();
  }

  @override
  void dispose() {
    super.dispose();
    _stringTagController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldTags<String>(
      initialTags: widget.interestFromApi,
      textfieldTagsController: _stringTagController,
      letterCase: LetterCase.normal,
      validator: (String tag) {
        if (_stringTagController.getTags!.contains(tag)) {
          return 'You\'ve already entered that';
        }
        widget.interestFromApi.add(tag);
        return null;
      },
      inputFieldBuilder: (context, inputFieldValues) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: TextField(
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),
            onTap: () {
              _stringTagController.getFocusNode?.requestFocus();
            },
            controller: inputFieldValues.textEditingController,
            focusNode: inputFieldValues.focusNode,
            decoration: InputDecoration(
              errorText: inputFieldValues.error,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Colors.white10,
              isDense: true,
              prefixIconConstraints:
                  BoxConstraints(maxWidth: _distanceToField * 0.8),
              prefixIcon: inputFieldValues.tags.isNotEmpty
                  ? SingleChildScrollView(
                      controller: inputFieldValues.tagScrollController,
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          left: 8,
                        ),
                        child: Wrap(
                            runSpacing: 4,
                            spacing: 4,
                            children: inputFieldValues.tags.map((String tag) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white10,
                                ),
                                margin: const EdgeInsets.only(right: 4),
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      tag,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(width: 4),
                                    InkWell(
                                      child: const Icon(
                                        Icons.close,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      onTap: () {
                                        widget.interestFromApi.remove(tag);
                                        inputFieldValues.onTagRemoved(tag);
                                      },
                                    )
                                  ],
                                ),
                              );
                            }).toList()),
                      ),
                    )
                  : null,
            ),
            onChanged: inputFieldValues.onTagChanged,
            onSubmitted: inputFieldValues.onTagSubmitted,
          ),
        );
      },
    );
  }
}
