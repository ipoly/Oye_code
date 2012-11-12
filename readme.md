# 前端功能说明

## 文件目录：
+ ### app.js
    主脚本，由插件通过script标记插入页面。

+ ### hostname.js
     各商城的抓取设置脚本。

+ ### src
     源文件目录。

=================

## 响应的域名
+ #### 京东
    + www.360buy.com
    + book.360buy.com
    + mvd.360buy.com

+ #### 一淘和一淘商城
    + www.1mall.com
    + www.yihaodian.com

+ #### 伊藤
    + www.yiteng365.com

+ #### 淘宝
    + www.taobao.com
    + s.taobao.com
    + item.taobao.com

+ #### 天猫
    + www.tmall.com
    + list.tmall.com
    + temai.tmall.com
    + detail.tmall.com

========================

## 工作流程
脚本文件载入后，自动调用当前hostname对应的**抓取设置脚本**;

同时请求**购物车数据**，如果验证登陆未通过，则插件面板为“未登录”状态;

如果没有对应的**抓取设置脚本**，或经脚本验证当前页不是产品详细页，则插件面板为“购物车”状态;

否则验证当前页是否已存在购物车中，以决定插件面板为“添加订单”状态或“添加截图状态”。


========================

## 公开接口
+ ###oye
    本插件的命名空间

+ ###oye.dir
    根目录地址，所有的脚本、样式表和图片都从此开始寻址

    默认调试用的地址是oye.zerdoor.com

+ ###oye.screenShotDone()
    截图动作完成后的回调函数，由插件调用，以显示图片正在上传的状态

+ ###oye.screenShotCallback(Array)
    截图上传完成后的回调函数，由插件调用，期待一个**图片地址数组**作为参数


========================


## 服务器交互
### 数据请求地址
${oye.dir}/json/cart.jsonp

### request可用参数
1. #### 请求购物车列表
    + **action: Cartlist**

2. #### 增加一个抓取数据
    + **action: AddCart**
    + siteName: string
    + goodsName: string
    + price: string
    + prop: string
    + img: string
    + url: string
    + number: 1

3. #### 删除一个商品记录
    + **action: DelCart**
    + CartID: string


### response数据
**格式** jsonp

1. **object** 错误状态 
    + **Error: int** 错误代码
        + 1: 尚未登录，请先登陆！
        + 2: 添加失败，传入数据有误！
        + 3: 系统内部处理失败，请重试！
    + **msg: string** 错误信息

2. **list: object Array** 最新的5条商品记录
    + **CartID: string** 商品id
    + **goodsName: string** 商品名称
    + **img: string** 商品图片地址
    + **price: string** 商品价格
    + **prop: string** 商品属性
    + **siteName: string** 商城名称
    + **url: string** 商品地址
    + **number: int** 订购数量，默认为1
    + **pic: object Array** 商品截图列表
        + **href: string** 图片地址









