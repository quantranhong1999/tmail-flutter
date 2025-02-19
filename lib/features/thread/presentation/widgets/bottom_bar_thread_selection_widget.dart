import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:model/model.dart';
import 'package:tmail_ui_user/main/localizations/app_localizations.dart';

typedef OnPressEmailSelectionActionClick = void Function(EmailActionType, List<PresentationEmail>);

class BottomBarThreadSelectionWidget {

  final BuildContext _context;
  final ImagePaths _imagePaths;
  final ResponsiveUtils _responsiveUtils;
  final List<PresentationEmail> _listSelectionEmail;
  final PresentationMailbox? _currentMailbox;

  OnPressEmailSelectionActionClick? _onPressEmailSelectionActionClick;

  BottomBarThreadSelectionWidget(
    this._context,
    this._imagePaths,
    this._responsiveUtils,
    this._listSelectionEmail,
    this._currentMailbox,
  );

  void addOnPressEmailSelectionActionClick(OnPressEmailSelectionActionClick onPressEmailSelectionActionClick) {
    _onPressEmailSelectionActionClick = onPressEmailSelectionActionClick;
  }

  Widget build() {
    return Container(
      key: Key('bottom_bar_thread_selection_widget'),
      alignment: Alignment.center,
      color: Colors.white,
      child: MediaQuery(
        data: MediaQueryData(padding: EdgeInsets.zero),
        child: _buildListOptionButton()
      )
    );
  }

  Widget _buildListOptionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        (ButtonBuilder(_listSelectionEmail.isAllEmailRead ? _imagePaths.icUnread : _imagePaths.icRead)
            ..key(Key('button_mark_read_email'))
            ..paddingIcon(EdgeInsets.all(8))
            ..textStyle(TextStyle(fontSize: 12, color: AppColor.colorTextButton))
            ..onPressActionClick(() {
              if (_onPressEmailSelectionActionClick != null) {
                _onPressEmailSelectionActionClick!(
                    _listSelectionEmail.isAllEmailRead ? EmailActionType.markAsUnread : EmailActionType.markAsRead,
                    _listSelectionEmail);
              }})
            ..text(
                _listSelectionEmail.isAllEmailRead ? AppLocalizations.of(_context).unread : AppLocalizations.of(_context).read,
                isVertical: _responsiveUtils.isMobile(_context)))
          .build(),
        (ButtonBuilder(_listSelectionEmail.isAllEmailStarred ? _imagePaths.icUnStar : _imagePaths.icStar)
            ..key(Key('button_mark_as_star_email'))
            ..paddingIcon(EdgeInsets.all(8))
            ..textStyle(TextStyle(fontSize: 12, color: AppColor.colorTextButton))
            ..onPressActionClick(() {
              if (_onPressEmailSelectionActionClick != null) {
                _onPressEmailSelectionActionClick!(
                    _listSelectionEmail.isAllEmailStarred ? EmailActionType.markAsUnStar : EmailActionType.markAsStar,
                    _listSelectionEmail);
              }})
            ..text(_listSelectionEmail.isAllEmailStarred ? AppLocalizations.of(_context).mark_as_unstar : AppLocalizations.of(_context).mark_as_star,
                isVertical: _responsiveUtils.isMobile(_context)))
          .build(),
        (ButtonBuilder(_imagePaths.icMove)
            ..key(Key('button_move_email'))
            ..paddingIcon(EdgeInsets.all(8))
            ..textStyle(TextStyle(fontSize: 12, color: AppColor.colorTextButton))
            ..onPressActionClick(() {
              if (_onPressEmailSelectionActionClick != null) {
                _onPressEmailSelectionActionClick!(EmailActionType.move, _listSelectionEmail);
              }})
            ..text(AppLocalizations.of(_context).move, isVertical: _responsiveUtils.isMobile(_context)))
          .build(),
        (ButtonBuilder(_imagePaths.icDelete)
          ..key(Key('button_delete_email'))
          ..paddingIcon(EdgeInsets.all(8))
          ..textStyle(TextStyle(fontSize: 12, color: AppColor.colorTextButton))
          ..onPressActionClick(() {
            if (_currentMailbox?.role != PresentationMailbox.roleTrash) {
              _onPressEmailSelectionActionClick?.call(EmailActionType.moveToTrash, _listSelectionEmail);
            } else {
              _onPressEmailSelectionActionClick?.call(EmailActionType.deletePermanently, _listSelectionEmail);
            }
            })
          ..text(AppLocalizations.of(_context).delete, isVertical: _responsiveUtils.isMobile(_context)))
        .build()
      ]
    );
  }
}