
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:model/model.dart';

class EmailContentItemBuilder {

  final BuildContext _context;
  final EmailContent _emailContent;
  final Widget? loadingWidget;
  final BoxConstraints _constraints;

  EmailContentItemBuilder(
    this._context,
    this._emailContent,
    this._constraints,
    {
      this.loadingWidget
    }
  );

  Widget build() {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent),
      child: MediaQuery(
        data: MediaQueryData(padding: EdgeInsets.zero),
        child: _buildItem()
      )
    );
  }

  Widget _buildItem() {
    switch(_emailContent.type) {
      case EmailContentType.textHtml:
        if (kIsWeb) {
          return HtmlContentViewerOnWeb(
                widthContent: _constraints.maxWidth,
                heightContent: MediaQuery.of(_context).size.height,
                contentHtml: _emailContent.content,
                controller: HtmlViewerControllerForWeb());
        } else {
          return HtmlContentViewer(
              widthContent: MediaQuery.of(_context).size.width,
              contentHtml: _emailContent.content,
              loadingWidget: loadingWidget);
        }
      case EmailContentType.textPlain:
        return Padding(
          padding: EdgeInsets.only(top: 20),
          child: SelectableText(
            _emailContent.content,
            style: TextStyle(fontSize: 14, color: AppColor.colorNameEmail, fontWeight: FontWeight.normal)));
      case EmailContentType.other:
        return SizedBox.shrink();
    }
  }
}