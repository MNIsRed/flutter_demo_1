import 'package:flutter/material.dart';

class ResultNotice extends StatefulWidget {
  const ResultNotice({super.key, this.info = "", this.color = Colors.red});

  final String info;
  final Color color;

  @override
  State<StatefulWidget> createState ()=> _ResultNotice();
}

class _ResultNotice extends State<ResultNotice> with TickerProviderStateMixin{
  late AnimationController controller;

  @override void initState() {
    super.initState();
    controller = AnimationController(vsync: this,
    duration: const Duration(milliseconds: 500));
    //initState 中也要设置forward，因为第一次显示时，不会走didUpdateWidget
    controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    // State通过widget获取StatefulWidget中的成员
    return Expanded(child: Container(alignment:Alignment.center,color: widget.color,child: AnimatedBuilder(
      animation: controller,
      builder: (_,child) => Text(widget.info,
      style: TextStyle(
        fontSize: 54*controller.value,
        color: Colors.white
      ),),
    ),));
  }

  @override void didUpdateWidget(covariant ResultNotice oldWidget) {
    controller.forward(from: 0);
    super.didUpdateWidget(oldWidget);
  }

}
