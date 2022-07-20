import 'package:capstoneproject/base/base_bloc.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingTask extends StatelessWidget {
  const LoadingTask({
    Key? key,
    required this.child,
    required this.bloc,
  }) : super(key: key);

  final Widget child;
  final BaseBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<bool>.value(
      value: bloc.loadingStream,
      initialData: false,
      child: Stack(
        children: <Widget>[
          child,
          Consumer<bool>(
            builder: (context, isLoading, child) => Center(
              child: isLoading ? const Air18LoadingView() : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
