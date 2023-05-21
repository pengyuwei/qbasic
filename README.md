# QBasic

QBasic的原创代码集合，大部分写于1995-2000年间。

- Game
    - FLY-12.BAS: 双人线下海战游戏辅助工具（玩法来自《714航班》）
    - FACE.BAS: 一个挤眉弄眼的人脸
- Tools
    - LINE.BAS: 模仿Windows的变换线写的变换线屏保
    - WORD5-10.BAS: 指法练习程序
    - P.BAS: 一个锁屏程序，输入/286可解锁
    - CIH.BAS: 放到开机启动里，在CIH病毒发作那天给出提醒
    - CIRCLE2.BAS: 一个圆形光环的时钟
    - DOSSHELL.BAS: 模拟DOS启动，并且自动随机执行DOS命令
    - FBRUSH.BAS: DOS下的画图工具
- Demo
    - menu.bas: 演示了如何开发一个标准的DOS样式的菜单
    - SETUP.BAS: 一个图形界面的安装进度条
    - SEE.BAS: 一个全屏的空白表单
    - BOMB.BAS: 一个爆炸效果
    - ANIMENU.BAS: 一个展开菜单的动画
    - AUTM1-10.BAS: 一个SHELL功能菜单的自动选取动画
    - FDISK.BAS: 模拟fdisk命令的界面和流程
- Effect
    - BOX.BAS: 用画线的方法模拟3D正方形在旋转
    - SIN.BAS: 正弦曲线
    - CAT.BAS: 实现了一个文字抽线淡出效果
    - WMTEXT.BAS: 一个文字效果
    - DOSC-1.BAS: 一个蓝条上下扫过屏幕的效果
    - TEMP256.BAS: 画一串圆形
    - LINESHOW.BAS: 胡乱画的一些线条
    - CSHOW.BAS: 对终端中指定范围的文本进行着色的工具，cshow x1,y1-x2,y2,color

## Mod

这个目录收录了当年从各种渠道找到的basic源代码，一些经过我的魔改，好玩极了。。

- BAN-12.BAS：扔香蕉。基于DOS附带的源代码改版，增加了黑夜场景、爆炸效果和生命力。需要在qbasic下运行
- DIDRIS.BAS: 一个高水平的俄罗斯方块游戏
- NIBBLES.BAS: 微软的贪吃蛇游戏（原版）
- X.BAS: 一个类似3Wounders的推箱子游戏
- SeaBattleChess: 海战棋游戏的改版，增加了一些效果
- tflybomb.bas: 海战棋的人机版本

## Running Environment

所有代码都是在DOS6.22环境中的调试通过的，目前可以通过如下工具和环境运行：

1. qb64 for Windows/macOS/Linux
2. qb4.5 in dosbox
3. qb4.5 + UCDOS 7 + DOS 6.22 in VirtualBOX
4. qbasic in DOS 6.22

有一些带乱码的源代码是基于UCDOS开发的，在非中文环境会显示乱码，在非UCDOS的中文环境下，文字或者图形会错位。这种文件需要使用上面的环境3来运行；由于QB和QBasic并不完全兼容，所以极个别的代码需要去qbasic下也就是上面的环境4来运行。

## Screenshot

| <img src="http://www.memcd.com/pengyuwei/images/1998_casktown.png" width="100%" /> | <img src="http://www.memcd.com/toyshop/ffb/images/big/wm1.jpg" width="100%" /> |  <img src="http://www.memcd.com/toyshop/ffb/images/big/look_main.gif" width="100%" />  |  <img src="http://www.memcd.com/toyshop/ffb/images/big/scr_line.gif" width="100%" />  |  <img src="http://www.memcd.com/toyshop/ffb/images/big/mud_login.gif" width="100%" />  |  <img src="http://www.memcd.com/toyshop/ffb/images/big/MENU1.JPG" width="100%" />  |
| --- | --- | --- | --- | --- | --- |
| RPG.BAS | WM.BAS | look_main.BAS    | scr_line.bas  |   mud.bas  | MENU1.BAS  |


## Reference

- [FreeBasic](https://www.freebasic.net/)
- [qb64](https://qb64.com/)
- [FutureBasic](http://www.brilorsoftware.com/fb/pages/home.html)
- [PureBasic](https://www.purebasic.com/index.php)
- [gambas](https://gambas.sourceforge.net/en/main.html)
- [SPIDERBASIC](https://www.spiderbasic.com/)
- [thinbasic](https://www.thinbasic.com/)
- [在 macOS 下编译 FreeBasic](https://zhuanlan.zhihu.com/p/611374318)
- [build FreeBasic on macOS 13.1 with clang](https://github.com/freebasic/fbc/issues/409)
- [从VB6进阶到PowerBASIC的快速指引](http://www.yfvb.com/thread-6408.htm)
- [VisualFreeBasic 5.8.7“雨水”版](http://www.yfvb.com/soft-48.htm)
- https://github.com/QB64Official/qb64
- https://github.com/Galleondragon/qb64
- https://retool.com/visual-basic/
- http://www.memcd.com/toyshop/
- 已经停服： http://quickbasic.126.com
- 已经停服： http://quickbasic.yeah.net
- 已经停服： http://hoker.org