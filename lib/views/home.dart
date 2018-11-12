import 'package:flutter/material.dart';
import 'gesturePwd.dart';
import 'LoginPwd.dart';
import 'TopTabPages/TopTabPage_1.dart';
import 'TopTabPages/TopTabPage_2.dart';
import 'TopTabPages/TopTabPage_3.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //定义底部导航项目
  final List<Tab> _bottomTabs = <Tab>[
    new Tab(
      text: '首页',
      icon: new Icon(Icons.home),
    ),
    //icon和text的显示顺序已经内定，如需自定义，到child属性里面加
    new Tab(
      icon: new Icon(Icons.bubble_chart),
      text: '社区',
    ),
    new Tab(
      icon: new Icon(Icons.mic),
      text: '搜索',
    ),
    new Tab(
      icon: new Icon(Icons.book),
      text: '学习',
    ),
    new Tab(
      icon: new Icon(Icons.person),
      text: '我的',
    ),
  ];

  //定义底部导航Tab
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
        vsync: this, //动画效果的异步处理，默认格式
        length: _bottomTabs.length //控制Tab的数量
        ); //底部主导航栏控制器
  }

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar:
            AppBar(title: Text('title'), backgroundColor: Colors.blueAccent),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                //Material内置控件
                accountName: new Text('Yogurt_lei'),
                //用户名
                accountEmail: new Text('yogurt_lei@foxmail.com'),
                //用户邮箱
                currentAccountPicture: new GestureDetector(
                  //用户头像
                  onTap: () => print('current user'),
                  child: new CircleAvatar(
                    //圆形图标控件
                    backgroundImage: new NetworkImage(
                        'https://avatars0.githubusercontent.com/u/22915313?s=400&u=bfa806b1e8d6d587c8080aa2c799149017c900fe&v=4'), //图片调取自网络
                  ),
                ),
                decoration: new BoxDecoration(
                  //用一个BoxDecoration装饰器提供背景图片
                  image: new DecorationImage(
                    fit: BoxFit.fill,
//                    image: new NetworkImage(
//                        'http://kbs55.demo.xiaoi.com/kbaseui-std/DATAS/system_login_logo.jpg')
                    //调用本地资源，需要到pubspec.yaml中配置文件路径
                    image: new ExactAssetImage('images/system_bg.jpg'),
                  ),
                ),
              ),
              new ListTile(
                  title: new Text('修改登录密码'),
                  leading: new Icon(Icons.lock),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new LoginPwdPage('从首页设置进入登录密码修改')));
                  }),
              new ListTile(
                title: new Text('手势密码'),
                leading: new Icon(Icons.gesture),
                trailing: new Switch(
                  value: true,
                  onChanged: null,
                  activeColor: Colors.green,
                  activeTrackColor: Colors.green,
                ),
              ),
              new ListTile(
                  title: new Text('手势密码修改'),
                  leading: new Icon(
                    Icons.gesture,
                    color: Colors.red,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new GesturePwdPage('从首页设置进入手势密码修改')));
                  }),
              new Divider(), //分割线控件
              new ListTile(
                //退出按钮
                title: new Text('退出'),
                leading: new Icon(Icons.cancel),
                onTap: () => Navigator.of(context).pop(), //点击后收起侧边栏
              ),
            ],
          ),
        ),
        body: new TabBarView(controller: _tabController, children: [
          new News(data: '参数值'),
          new TabPage2(),
          new TabPage3(),
          new TabPage3(),
          new TabPage3(),
        ]),
        bottomNavigationBar: new Material(
          color: Color.fromRGBO(247, 247, 250, 1), //底部导航栏主题颜色
          child: new TabBar(
            controller: _tabController,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey,
            tabs: _bottomTabs,
            indicatorColor: Colors.white, //tab标签的下划线颜色
          ),
        ));
  }
}
