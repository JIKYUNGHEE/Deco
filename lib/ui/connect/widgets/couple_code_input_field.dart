import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/themes/deco_theme_extension.dart';

class CodeInputTextField extends StatelessWidget {
  final Function(String value) checkCodeCallback;

  const CodeInputTextField({super.key, required this.checkCodeCallback});

  @override
  Widget build(BuildContext context) {
    final decoTheme = Theme.of(context).extension<DecoThemeExtension>()!;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: 60,
        height: 60,
        child: TextFormField(
          expands: true,
          minLines: null,
          maxLines: null,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
          ],
          textInputAction: TextInputAction.next,
          onChanged: (value) => {
            if (value != '') {
              FocusScope.of(context).nextFocus(),
            },
            checkCodeCallback(value),
          },
          maxLength: 1,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: decoTheme.textPrimary,
          ),

          decoration: InputDecoration(
            counterText: "",
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: decoTheme.outlinePressed, width: 1.6),
            ),
          ),
        ),
      ),
    );
  }
}
