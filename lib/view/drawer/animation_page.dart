import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with TickerProviderStateMixin {
  List<String> imgList = ['assets/icons/ic_avatar_1.png', 'assets/icons/ic_avatar_2.png', 'assets/icons/ic_avatar_3.png', 'assets/icons/ic_avatar_5.png'];
  List<String> textList = ['放大缩小', '圆形转圈', '加入购物车', 'Hero动画'];

  /// 购物车动画相关变量
  GlobalKey _key = new GlobalKey();
  GlobalKey _key_2 = new GlobalKey();

  double top = 0;
  double left = 0;
  var startOffset, endOffset;
  bool isShowCar = false;

  /// 动画
  late AnimationController _animationController_01, _animationController_02, _animationController_03;
  late Animation _animation;

  @override
  void initState() {
    _animationController_01 = AnimationController(duration: Duration(seconds: 1), lowerBound: 80.0, upperBound: 110.0, vsync: this);
    _animationController_01.addListener(() {
      setState(() {});
    });

    // 由于圆形使用了Flutter提供的旋转动画，因此只需要声明一个controller
    _animationController_02 = AnimationController(duration: Duration(seconds: 2), vsync: this);

    _animationController_03 = AnimationController(duration: Duration(seconds: 1), vsync: this);
    _animation = Tween(begin: 0, end: 1.0).animate(_animationController_03)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController_03.reset();
          this.setState(() {
            isShowCar = false;
          });
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(38.0),
        child: AppBar(
          elevation: 6.0,
          centerTitle: true,
          title: new Text(
            '动画实例',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: 20),
            child: new GridView.builder(
              itemCount: imgList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, int index) {
                return itemView(index, imgList[index], textList[index]);
              },
            ),
          ),
          isShowCar
              ? shopCar()
              : Padding(
                  padding: EdgeInsets.all(0),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: _key_2,
        onPressed: () {
          print('点击购物车');
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

  Widget itemView(int index, String imgUrl, String text) {
    Widget widget;
    switch (index) {
      case 0:
        {
          widget = GestureDetector(
            onTap: () {
              _animationController_01.forward();
            },
            child: Column(children: <Widget>[
              Image.asset(
                imgUrl,
                width: _animationController_01.value,
                height: _animationController_01.value,
              ),
              Text(text)
            ]),
          );
          break;
        }
      case 1:
        {
          widget = GestureDetector(
            onDoubleTap: () {
              _animationController_02.forward();
            },
            child: Column(children: <Widget>[
              RotationTransition(
                  alignment: Alignment.center,
                  turns: _animationController_02,
                  child: Image.asset(
                    imgUrl,
                    width: 110,
                    height: 110,
                  )),
              Text(text)
            ]),
          );
          break;
        }
      case 2:
        {
          widget = GestureDetector(
            onTap: () {
              RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
              var offset = renderBox.localToGlobal(Offset(renderBox.size.width * 0.5, renderBox.size.height * 0.5));
              RenderBox carRender = _key_2.currentContext!.findRenderObject() as RenderBox;
              var offset_2 = carRender.localToGlobal(Offset(carRender.size.width * 0.5, carRender.size.height * 0.5));
              setState(() {
                startOffset = offset;
                endOffset = offset_2;
                isShowCar = true;
              });
              _animationController_03.forward();
            },
            child: Column(children: <Widget>[
              Image.asset(
                imgUrl,
                width: 110,
                height: 110,
                key: _key,
              ),
              Text(text)
            ]),
          );
          break;
        }
      default:
        {
          widget = GestureDetector(
            onTap: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new _Hero1Demo()));
            },
            child: Column(children: <Widget>[
              Hero(
                tag: 'hero',
                transitionOnUserGestures: true,
                child: Image.asset(
                  imgUrl,
                  width: 110,
                  height: 110,
                ),
              ),
              Text(text)
            ]),
          );
          break;
        }
    }
    return widget;
  }

  //  购物车widget
  Positioned shopCar() {
    var startX = startOffset.dx;
    var startY = startOffset.dy;
    // 购物车的定位
    var endX = endOffset.dx;
    var endY = endOffset.dy;

    return Positioned(
      top: startY + (endY - startY) * _animation.value,
      left: startX + (endX - startX) * _animation.value,
      child: Image.asset(
        'assets/icons/ic_avatar_3.png',
        width: 60,
        height: 60,
      ),
    );
  }
}

class _Hero1Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: 'hero',
            transitionOnUserGestures: true,
            child: Center(
              child: Image.asset(
                'assets/icons/ic_avatar_5.png',
              ),
            ),
          )),
    );
  }
}
