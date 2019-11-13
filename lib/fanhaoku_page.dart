import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:select_dialog/select_dialog.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provide/provide.dart';
import 'provide/fanhao.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:fijkplayer/fijkplayer.dart';
//import 'video.dart';

class FanHaoKu extends StatefulWidget {
  @override
  _FanHaoKuState createState() => _FanHaoKuState();
}

class _FanHaoKuState extends State<FanHaoKu> {
  SolidController _controller = SolidController();
  FijkPlayer _player = FijkPlayer();
  int _fanhaoIndex = 20;
  int _fanhaoCur = 0;
  List<int> _fanhaoIds = [];
  String _fanhaoSelect = "mide";
  String _streamUrl =
      "https://cc3001.dmm.co.jp/litevideo/freepv/s/ssn/ssni00589/ssni00589_dmb_w.mp4";
  List<String> _fanhaoChoices = [
    "mide",
    "ipx",
    "ssni",
    "wanz",
    "hnd",
    "miaa",
    "pred",
    "kawd",
    "ebod",
    "cjod",
    "sdde",
    "rki",
    "ekdv",
    "mird",
    "jufe",
    "cawd",
    "atid",
    "mism",
    "onez", //213
    "shkd",
    "mudr",
    "gvg",
    "dvaj",
    "miae",
    "dasd",
    "mvsd",
    "mifd", //092
    "xvsr",
    "meyd",
    "abp",
    "pppd",
    "juy",
    "jul",
    "stars",
  ];
  Map _fanhaoMaxMap = new Map();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _callLoad() async {
    for (var i = 0; i < 10; i++) {
      _fanhaoIds.add(_fanhaoIndex);
      _fanhaoIndex -= 1;
    }
  }

  _initFanhaoMax() {
    for (var item in _fanhaoChoices) {
      _fanhaoMaxMap[item] = 20;
    }
    _fanhaoMaxMap["ssni"] = 628;
    _fanhaoMaxMap["ipx"] = 407;
    _fanhaoMaxMap["kawd"] = 999;
    _fanhaoMaxMap["mide"] = 709;
    _fanhaoMaxMap["ebod"] = 721;
    _fanhaoMaxMap["wanz"] = 913;
    _fanhaoMaxMap["miaa"] = 192;
    _fanhaoMaxMap["pred"] = 199;
    _fanhaoMaxMap["gvg"] = 966;
    _fanhaoMaxMap["hnd"] = 762;
    _fanhaoMaxMap["ekdv"] = 603;
    _fanhaoMaxMap["mird"] = 197;
    _fanhaoMaxMap["dasd"] = 606;
    _fanhaoMaxMap["abp"] = 927;
    _fanhaoMaxMap["stars"] = 162;
    _fanhaoMaxMap["juy"] = 999;
    _fanhaoMaxMap["dvaj"] = 425;
    _fanhaoMaxMap["mifd"] = 92;
    _fanhaoMaxMap["onez"] = 213;
    _fanhaoMaxMap["mvsd"] = 173;
    _fanhaoMaxMap["mudr"] = 90;
    _fanhaoMaxMap["miae"] = 358;
    _fanhaoMaxMap["xvsr"] = 514;
    _fanhaoMaxMap["shkd"] = 881;
    _fanhaoMaxMap["pppd"] = 808;
    _fanhaoMaxMap["atid"] = 380;
    _fanhaoMaxMap["jul"] = 51;
    _fanhaoMaxMap["sdde"] = 603;
    _fanhaoMaxMap["rki"] = 501;
    _fanhaoMaxMap["jufe"] = 122;
    _fanhaoMaxMap["cawd"] = 35;
    _fanhaoMaxMap["mism"] = 155;
    _fanhaoMaxMap["meyd"] = 549;
  }

  String _buildFanhao(String fanhao, int index) {
    if (index < 100 && index >= 10) {
      fanhao = fanhao + "0" + (index).toString();
    } else if (index < 10) {
      fanhao = fanhao + "00" + (index).toString();
    } else {
      fanhao = fanhao + (index).toString();
    }
    return fanhao;
  }

  String _buildFanhaoCoverUrl(String fanhao) {
    //http://pics.dmm.co.jp/mono/movie/adult/1sdde275/1sdde275pl.jpg
    //http://pics.dmm.co.jp/mono/movie/adult/49ekdv603/49ekdv603pl.jpg
    //http://pics.dmm.co.jp/mono/movie/adult/1stars162/1stars162pl.jpg
    //http://pics.dmm.co.jp/mono/movie/adult/118onez213/118onez213pl.jpg
    //http://pics.dmm.co.jp/mono/movie/adult/53dvaj0001/53dvaj0001pl.jpg
    //http://pics.dmm.co.jp/mono/movie/adult/60xvsr001/60xvsr001pl.jpg
    //http://pics.dmm.co.jp/mono/movie/adult/xvsr514so/xvsr514sopl.jpg
    String url;
    if (fanhao.contains("gvg")) {
      url =
          'http://pics.dmm.co.jp/mono/movie/adult/13$fanhao/13${fanhao}pl.jpg';
    } else if (fanhao.contains("abp") || fanhao.contains("onez")) {
      url =
          'http://pics.dmm.co.jp/mono/movie/adult/118$fanhao/118${fanhao}pl.jpg';
    } else if (fanhao.contains("ekdv")) {
      url =
          'http://pics.dmm.co.jp/mono/movie/adult/49$fanhao/49${fanhao}pl.jpg';
    } else if (fanhao.contains("stars") || fanhao.contains("sdde")) {
      url = 'http://pics.dmm.co.jp/mono/movie/adult/1$fanhao/1${fanhao}pl.jpg';
    } else if (fanhao.contains("dvaj")) {
      url =
          'http://pics.dmm.co.jp/mono/movie/adult/53$fanhao/53${fanhao}pl.jpg';
    } else if (fanhao.contains("xvsr")) {
      url =
          "http://pics.dmm.co.jp/mono/movie/adult/${fanhao}so/${fanhao}sopl.jpg";
      //'http://pics.dmm.co.jp/mono/movie/adult/60$fanhao/60${fanhao}pl.jpg';
    } else {
      url = 'http://pics.dmm.co.jp/mono/movie/adult/$fanhao/${fanhao}pl.jpg';
    }
    return url;
  }

  String _buildFanhaoStreamUrl(String fanhao, int id) {
    //https://cc3001.dmm.co.jp/litevideo/freepv/s/ssn/ssni00588/ssni00588_dmb_w.mp4
    //http://pics.dmm.co.jp/mono/movie/adult/ssni628/ssni628pl.jpg
    if (fanhao.length >= 3) {
      String _id = "00" + (id).toString();
      if (id < 100 && id > 10) {
        _id = "0" + _id;
      } else if (id < 10 && id > 0) {
        _id = "00" + _id;
      }
      var fanhao_1 = fanhao.substring(0, 1);
      var fanhao_123 = fanhao.substring(0, 3);
      fanhao = fanhao + _id;
      return 'https://cc3001.dmm.co.jp/litevideo/freepv/$fanhao_1/$fanhao_123/$fanhao/${fanhao}_dmb_w.mp4';
    } else {
      return "err";
    }
  }

  Widget _coverImage(int index) {
    var fanhao = _buildFanhao(_fanhaoSelect, index);
    var url = _buildFanhaoCoverUrl(fanhao);
    //print(url);
    return FadeInImage.memoryNetwork(
      image: url,
      placeholder: kTransparentImage /* 透明图片 */,
    );

    /*
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
    */
  }

  @override
  void initState() {
    super.initState();
    _initFanhaoMax();
    _fanhaoIndex = _fanhaoMaxMap[_fanhaoSelect];
    _callLoad();
    _player.addListener(_videoListener);
  }

  void _videoListener() {
    print("#######listener");
    FijkValue value = _player.value;
    var isOpened = Provide.value<Fanhao>(context).isOpened;
    //double height;
    print("isOpen:$isOpened");
    print("isFull:$value");
    if (!isOpened && value.prepared) {
      _player.reset();
      // height = value.size.height;
      // print("height:$height");
      // if (!isOpened && height > 0) {
      //   _player.reset();
      // }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
    _player.removeListener(_videoListener);
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    for (var i = 0; i < 10; i++) {
      var a = _fanhaoIds[0] + 1;
      _fanhaoIds.insert(0, a);
    }
    // if failed,use refreshFailed()
    _refreshController.requestLoading(needMove: false);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length + 1).toString());
    if (_fanhaoIndex > 0) {
      _callLoad();
    } else {
      _refreshController.footerMode.value = LoadStatus.noMore;
    }
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  double _headHeight = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.face),
        title: Text("番号库"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              SelectDialog.showModal<String>(
                context,
                label: "选择番号",
                selectedValue: _fanhaoSelect,
                items: List.generate(
                    _fanhaoChoices.length, (index) => _fanhaoChoices[index]),
                onChange: (String selected) {
                  setState(() {
                    _fanhaoSelect = selected;
                    _fanhaoIndex = _fanhaoMaxMap[_fanhaoSelect];
                    _fanhaoIds = [];
                    _callLoad();
                    _refreshController.requestLoading(needMove: false);
                  });
                },
              );
            },
          )
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("下拉刷新");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("加载失败,请重试");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("释放加载更多");
            } else {
              body = Text("没有更多了");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) {
            return Container(
                child: Padding(
              padding: EdgeInsets.only(top: 5, left: 10, right: 10),
              child: Center(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      child: _coverImage(_fanhaoIds[i]),
                      onDoubleTap: () async {
                        _fanhaoCur = _fanhaoIds[i];

                        if ([
                          "ssni",
                          "ipx",
                          "mide",
                          "wanz",
                          "hnd",
                          "kawd",
                          "pred",
                          "ebod",
                          "miaa",
                          "cjod",
                          "mird",
                          "onez",
                          "miae",
                          "mvsd",
                        ].contains(_fanhaoSelect)) {
                          _streamUrl =
                              _buildFanhaoStreamUrl(_fanhaoSelect, _fanhaoCur);
                          print(_streamUrl);
                          _controller.isOpened
                              ? _controller.hide()
                              : _controller.show();
                        }
                      },
                    ),
                    Container(
                      //color: Colors.grey,
                      child: Text(
                        _buildFanhao(_fanhaoSelect, _fanhaoIds[i]),
                      ),
                    )
                  ],
                ),
              ),
            ));
          }, //Card(child: Center(child: Text(items[i]))),
          //itemExtent: 100.0,
          itemCount: _fanhaoIds.length,
        ),
      ),
      bottomSheet: SolidBottomSheet(
        onHide: () async {
          if (!_player.value.fullScreen) {
            _player.reset();
          }
          Provide.value<Fanhao>(context).setHide();
        },
        onShow: () async {
          print("onShow");
          Provide.value<Fanhao>(context).setShow();
        },
        controller: _controller,
        canUserSwipe: true,
        toggleVisibilityOnTap: false,
        draggableBody: false,
        maxHeight: 300,
        headerBar: Provide<Fanhao>(
          builder: (context, child, counter) {
            return Container(
                color: Theme.of(context).primaryColor,
                height: counter.isOpened ? 40 : 0,
                child: Center(
                  child: Text(
                    _buildFanhao(_fanhaoSelect, _fanhaoCur),
                    style: TextStyle(color: Colors.white,),
                  ),
                ));
          },
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Provide<Fanhao>(
              builder: (context, child, counter) {
                if (counter.isOpened) {
                  var _state=_player.value.state;
                  _player.setDataSource(_streamUrl, autoPlay: true);
                  return Center(
                    child: FijkView(
                      color: Colors.black,
                      player: _player,
                    ),
                  );
                } else {
                  return Container(
                    color: Colors.black,
                    //child: Text("can not load video player!"),
                  );
                }
              },
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add_a_photo),
      //   onPressed: () async {
      //     //Provide.value<Counter>(context).add();
      //     _controller.isOpened ? _controller.hide() : _controller.show();
      //   },
      // ),
    );
  }
}
