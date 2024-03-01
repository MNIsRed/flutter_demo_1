import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo_1/guess/guess_appbar.dart';
import 'package:flutter_demo_1/guess/result_notice.dart';

class GuessPage extends StatefulWidget {
  const GuessPage({super.key});

  @override
  State<StatefulWidget> createState() => _GuessPage();
}

class _GuessPage extends State<GuessPage> {
  // 随机数字
  int _randomValue = 0;
  final Random _random = Random();

  // 是否正在猜测
  bool _guessing = false;

  // 猜测值和数字的比较关系，null代表相等
  bool? _isBigger;

  TextEditingController inputWatcher = TextEditingController();

  void _generateRandomValue() {
    setState(() {
      _guessing = true;
      _randomValue = _random.nextInt(100);
    });
  }

  void _check() {
    int? guessValue = int.tryParse(inputWatcher.text);
    if (!_guessing || guessValue == null) return;
    if (guessValue == _randomValue) {
      setState(() {
        _guessing = false;
        _isBigger = null;
        inputWatcher.text = "";
      });
      return;
    }
    setState(() {
      _isBigger = guessValue > _randomValue;
    });
  }

  @override
  void dispose() {
    // 控制器要注意销毁
    inputWatcher.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GuessAppbar(
        controller: inputWatcher,
        onCheck: _check,
      ),
      body: Stack(
        children: [
          if (_isBigger != null)
            Column(
              children: [
                // if保证一个控件，正好通过中间的Spacer，达成大在上，小在下的UI
                if (_isBigger!)
                  //ResultNotice设置为const后将无法触发didUpdateWidget，导致动画不刷新
                  ResultNotice(
                    info: "大",
                    color: Colors.blue,
                  ),
                const Spacer(),
                if (!_isBigger!) ResultNotice(info: "小", color: Colors.red),
              ],
            ),
          Center(
            child: Text(
              _guessing ? '**' : '$_randomValue',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _guessing ? null : _generateRandomValue,
        backgroundColor: _guessing ? Colors.grey : Colors.blue,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
