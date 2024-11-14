import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final listTile = <Tile>[
    Tile(key: ValueKey('파란색'), color: Colors.blue, name: '파란색 타일'),
    Tile(key: ValueKey('빨간색'), color: Colors.red, name: '빨간색 타일'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('키가 있는 위젯 만들어 보기'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: listTile,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: swapTiles,
        child: Icon(Icons.swap_horiz),
      ),
    );
  } // end of bulid()

// 첫 번째 타일과 두 번째 타일을 교환하는 기능
void swapTiles() {
    // ['파란색타일', '빨간색타일']
    setState(() {
      // 첫 번째 타일을 제거하고 그 타일을 반환하는 기능
      // ['빨간색타일']
      // var removedTile = listTile.removeAt(0);
      // ['빨간색타일', '파란색타일']
      // 제거된 타일을 두 번째 위치로 삽입하자.
      // listTile.insert(1, removedTile);

      // 축약해서 코드 작성해보기
      listTile.insert(1, listTile.removeAt(0));
    });
}

} // end of State class

class Tile extends StatefulWidget {
  final Color color; // 타일의 색상
  final String name; // 타일의 이름

  // Key 속성을 추가해서 부모 클래스(State)고유 식별자를 보장한다.
  const Tile({required Key key, required this.color, required this.name}) : super(key: key);

  @override
  State<Tile> createState() => _TileState();
}

// 우리가 만든 커스텀 Tile 클래스의 상태 관리 클래스
class _TileState extends State<Tile> {
  // State 멤버 변수 widget 이런 멤버 변수를 제공해서 상위 클래스에 접근할 수 있도록 만들어 주고 있다.
  Color? currentColor; // 현재 타일의 색상

  @override
  void initState() {
    super.initState();
    // 부모 클래스 변수에 접근해서 값을 가져 온다.
    currentColor = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: currentColor,
      width: 100,
      height: 100,
      alignment: Alignment.center,
      child: Text(
        widget.name,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}