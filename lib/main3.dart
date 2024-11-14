import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  int _counter = 0; // 1. 버튼이 눌린 횟수를 저장하는 변수입니다.
  Color _backgroundColor = Colors.white; // 2. 배경색을 저장하는 변수입니다.
  late AnimationController _controller; // 3. 애니메이션의 진행을 제어하는 컨트롤러입니다.
  late Animation<double> _animation; // 4. 애니메이션의 스케일 값을 저장하는 변수입니다.

  @override
  void initState() {
    super.initState();
    print('메모리에 올라갈 때 한번만 호출이 된다.');

    // AnimationController 초기화
    _controller = AnimationController(
        // 빌드 할 때 미리 객체를 생성해 두는 녀석 --> 불변 객체가 된다.
        duration: const Duration(milliseconds: 300), // 5. 애니메이션의 지속 시간을 설정합니다.
        vsync: this); // 6. vsync는 화면 새로고침 주기에 동기화하여 애니메이션 성능을 최적화합니다.

    // Tween을 사용하여 애니메이션 범위 정의 (0.5 ~ 1.0)
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // 7. 애니메이션이 부드럽게 시작하고 끝나도록 설정합니다.
    ))
      ..addListener(() {
        setState(() {}); // 8. 애니메이션이 진행될 때마다 화면을 업데이트합니다.
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // 9. 메모리 누수를 방지하기 위해 애니메이션 컨트롤러를 해제합니다.
    super.dispose();
  }

  // 버튼을 눌렀을 때 호출되는 함수
  void _incrementCounter() {
    setState(() {
      _counter++; // 10. 버튼이 눌릴 때마다 카운터를 증가시킵니다.
      _backgroundColor = _getRandomColor(); // 11. 배경색을 랜덤으로 변경합니다.
    });

    // 12. 애니메이션을 앞으로 진행한 후, 완료되면 원래 상태로 되돌립니다.
    _controller.forward().then((_) {
      _controller.reverse();
    });
  }

  // 랜덤 색상을 생성하는 메서드
  Color _getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true, // 13. Material 3 스타일을 적용합니다.
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue) // 14. Material 3 컬러 테마의 기본 색상을 지정합니다.
          ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('애니메이션 및 생명주기'),
        ),
        backgroundColor: _backgroundColor, // 15. 배경색을 설정합니다.
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '버튼을 누른 횟수 : ${_counter}', // 16. 버튼이 눌린 횟수를 텍스트로 표시합니다.
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              // 17. Transform.scale 위젯으로 버튼의 크기를 애니메이션 효과로 조절합니다.
              Transform.scale(
                scale: _animation.value, // 18. 애니메이션 스케일 값을 적용합니다.
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    '눌러보기',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: _incrementCounter, // 19. 버튼을 누르면 _incrementCounter 함수 호출
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
