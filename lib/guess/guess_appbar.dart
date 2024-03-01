import 'package:flutter/material.dart';

class GuessAppbar extends StatelessWidget implements PreferredSizeWidget {
  const GuessAppbar({super.key, required this.controller, required this.onCheck});

  // 传一个void方法进来，会自动回调check的
  final VoidCallback onCheck;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        // 顶部状态栏显示 ,加上后导致状态栏图标变白
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //     // Android无影响，light时ios显示黑色字体，dark时显示白色字体
        //     statusBarBrightness: Brightness.dark,
        //     // ios无影响，Android会修改toolbar的颜色,设置transparent会导致状态栏文字变白
        //     statusBarColor: Colors.transparent),
        // 左侧部分
        leading: const Icon(Icons.menu, color: Colors.black),
        // 右侧部分
        actions: [
          IconButton(
              onPressed: onCheck,
              icon: const Icon(
                Icons.run_circle_outlined,
                color: Colors.blue,
              ))
        ],
        title: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xffF3F6F9),
              constraints: BoxConstraints(maxHeight: 35),
              border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              hintText: "输入数字：0~99",
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey)),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
