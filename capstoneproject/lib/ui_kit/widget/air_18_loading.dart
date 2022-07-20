import 'package:capstoneproject/ui_kit/cubit/loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Air18Loading extends StatefulWidget {
  final LoadingCubit loadingCubit;
  const Air18Loading({required this.loadingCubit, Key? key, }) : super(key: key);

  @override
  State<Air18Loading> createState() => _Air18LoadingState();
}

class _Air18LoadingState extends State<Air18Loading> {

  Widget _buildLoadingDialog(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(100),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16)
            ),
            child: const LoadingIndicator(
              indicatorType: Indicator.ballSpinFadeLoader,
              backgroundColor: Colors.transparent,
              colors: [
                Colors.blue,
                Colors.green,
                Colors.greenAccent,
                Colors.yellow,
                Colors.orange,
                Colors.red,
                Colors.pink,
                Colors.purple,
                Colors.indigo
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, LoadingState>(
      bloc: widget.loadingCubit,
      builder: (context,state) => state.maybeWhen(
        loading: ()=>  _buildLoadingDialog(context),
        orElse: ()=> Container(),
      ),
    );
  }
}