# @codekit-prepend jquery
# @codekit-prepend juicer
# @codekit-prepend fancybox
# @codekit-prepend fancybox-thumbs

# oye对象在jquery内定义。
win = @
o = @oye
$ = o.$
# 文件根目录
o.dir ?= "http://oye.zerdoor.com/"
# 购物车数据缓存
o.cartData = {status:{action:"",Error:"",msg:""},list:[]}

# session刷新频率
o.sessionTimeout = 20
$("head").append("<link rel='stylesheet' type='text/css' href='#{o.dir}api/js/main.css' media='all' />")
$("head").append("<link rel='stylesheet' type='text/css' href='#{o.dir}api/js/source/jquery.fancybox.css' media='all' />")
$("head").append("<link rel='stylesheet' type='text/css' href='#{o.dir}api/js/source/helpers/jquery.fancybox-thumbs.css' media='all' />")

# 预载图片
preloadImg =["temp1.png","loading.gif"]
for img in preloadImg
    a = $("<img/>")
    a.attr("src","#{o.dir}api/js/#{img}")


# 载入对应的抓取脚本
$.ajaxSetup({scriptCharset:"utf-8"})
$.getScript("#{o.dir}api/js/#{location.hostname}.js").done(-> ui.trigger("refresh",o.cartData) )

templates = {
    ui:"""
        <div class="oye_ui">
            <a id="oye_logo" href="#{o.dir}"></a>
            <div class="oye_cart"></div>
            <div class="oye_panel"> </div>
            <div id="oye_notice"></div>
        </div>
    """

    # 购物车列表面板
    cart: juicer("""
        <table>
            <caption>测试：${timeMark}</caption>
            <thead>
                <tr>
                    <td></td>
                    <td>代购商品</td>
                    <td>来源商城</td>
                    <td>数量</td>
                    <td>操作</td>
                </tr>
            <thead>
            <tbody>
            {@each list.slice(0,5) as item}
                <tr>
                    <th><a href="${item.url}" title="${item.goodsName}"><img src="${item.img}"/></a></th>
                    <td><a href="${item.url}" title="${item.goodsName}">${item.goodsName}</a></td>
                    <td>${item.siteName}</td>
                    <td>${item.number}</td>
                    <td>
                        {@if item.pic.length}
                        <span data-id="${item.CartID}" class="oye_screenShotView">查看截图</span>
                        {@/if}
                        <span data-id="${item.CartID}" class="oye_del">删除</span>
                    </td>
                </tr>
            {@/each}
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="5">
                        <a href="#{o.dir}temp1.png" id="oye_submit"></a>
                        <p>查看操作完整购物车，请前往 <a href="#{o.dir}temp1.png" target="_blank">噢叶商城购物车</a></p>
                    </td>
                </tr>
            </tfoot>
        </table>
    """)

    # 未登陆
    panel0:"""<span class="lh40">点我 <a href="#{o.dir}user.php?act=default">登录</a> 以使用代购功能</span>"""

    # 当前页已在购物车中
    panel1:juicer("""
        <a title="查看购物车" class="oye_icon oye_icon_cart"><i class="oye_cart_part"></i><span class="oye_inCart">${list.length}</span></a>
        <a title="查看截图" class="oye_icon oye_icon_img"><span class="oye_inPic">${current.pic.length}</span></a>
        <a title="添加截图" class="oye_icon oye_icon_camera" id="oye_screenshot"></a>
    """)

    # 当前页不在购物车中
    panel2:juicer("""
        <a title="查看购物车" class="oye_icon oye_icon_cart"><i class="oye_cart_part"></i><span class="oye_inCart">${list.length}</span></a>
        <button title="立即订购" type="button" id="oye_add"></button>
    """)

    # 当前页不是商品详细页
    panel3:juicer("""
        <a title="查看购物车" class="oye_icon oye_icon_cart"><i class="oye_cart_part"></i><span class="oye_inCart">${list.length}</span></a>
    """)
}

# 定义ui
ui = $(templates.ui)
# 定义显示与隐藏事件
.on("show hide",(e)-> $(@)[e.type]())
# 获取数据
.on("click","#oye_add",-> o.trigger("fetchdata"))
# 删除商品
.on("click",".oye_del",->
    data = {}
    data.CartID = $(@).data("id")
    data.action = "DelCart"
    o.trigger("cartReload",data)
)
# 调用截图插件
.on("click","#oye_screenshot",->
    trigger = $("#oye_shot")
    if trigger.length
        trigger[0].click()
    else
        # 测试用数据
        o.screenShotCallback([
            {href:"http://pic.cnhan.com/uploadfile/2012/0905/20120905040655740.jpg"},
            {href:"http://pic.cnhan.com/uploadfile/2012/0905/20120905040700746.jpg"},
            {href:"http://pic.cnhan.com/uploadfile/2012/0905/20120905040700342.jpg"},
            {href:"http://pic.cnhan.com/uploadfile/2012/0905/20120905040831340.jpg"},
            {href:"http://pic.cnhan.com/uploadfile/2012/0905/20120905040832569.jpg"},
            {href:"http://pic.cnhan.com/uploadfile/2012/0905/20120905040832588.jpg"},
            {href:"http://pic.cnhan.com/uploadfile/2012/0905/20120905040833724.jpg"}
        ])

)
# 打开截图浏览
.on("screenShotShow",(e,list)->
    if list?.length
        ui.trigger("hide")
        $.fancybox.open(list,{
            helpers : {
                    thumbs : {
                        width  : 50,
                        height : 50
                    }
            }
            afterClose:->
                ui.trigger("show")
        })
)
# 从列表查看截图
.on("click",".oye_screenShotView",->
    CartID = $(@).data("id")
    pic = i.pic for i in o.cartData.list when parseInt(i.CartID) == CartID
    ui.trigger("screenShotShow",[pic])
)
# 从主面板"查看截图"
.on("click",".oye_icon_img",->
    ui.trigger("screenShotShow",[o.cartData.current.pic])
)
# 显示购物车列表
.on("hover",".oye_icon_cart,.oye_cart",(e)->
    cart = $(".oye_cart")
    icon = $(".oye_icon_cart")
    clearTimeout(o.timer)
    type = e.type
    o.timer = setTimeout(
        ->
            if type is "mouseenter" and o.cartData.list.length
                cart.show()
                icon.addClass("active")
            else
                cart.hide()
                icon.removeClass("active")
    ,300)
)
# 刷新ui面板
.on("refresh",(e,data)->
    t = $(@)
    panel = t.find(".oye_panel")
    cart = t.find(".oye_cart")
    cart.html(templates.cart.render(data))

    # 判断是否登陆,Error==1 表示未登陆
    return panel.html(templates.panel0) if data.status.Error is 1

    # 对有抓取脚本的站点，判断当前页是否商品详细页
    if o.fetchMethods and !o.fetchMethods.path.test(location.href)
        return panel.html(templates.panel3.render(data))

    # 判断当前页是否已在购物车中
    data.current = null
    data.current = i for i in data.list when i.url is location.href or o.fetchMethods?.identify?(i)
    if data.current
        data.current.pic?= []
        # $("#oye_id").val(data.current.CartID)
        win.oye_id = data.current.CartID
        panel.html(templates.panel1.render(data))
    else
        panel.html(templates.panel2.render(data))

    ico = $(".oye_icon_cart")
    if cart.is(":visible")
        ico.addClass("active")

)
# 消息和状态提示
# 消息默认显示3秒，状态则在更新前一直显示
.on("alert statusIn",(e,data)->
    return unless data?
    n = $(@).find("#oye_notice")
    n.html(data)
    clearTimeout(o.alertTimer)
    n.stop(true,true).fadeIn()
    if e.type is "alert"
        o.alertTimer = setTimeout(->
            n.fadeOut()
        ,3000)
)
# 退出状态
.on("statusOut",->
    $(@).find("#oye_notice").fadeOut()
)


body = $("body").append(ui)
body.on("click","a[href='javascript:;']",(e)-> e.preventDefault());
if $.browser.msie and $.browser.version is "6.0"
    $win = $(win)
    $win.on("scroll resize",->
        ui.css("bottom",->
            body.innerHeight() - $win.height() - $(win).scrollTop()
        )
    )

# 使用jquery的事件绑定来扩展oye对象
o.on = ->
    $(@).on(arguments...)

o.trigger = ->
    $(@).trigger(arguments...)

o.off = ->
    $(@).off(arguments...)

# 抓取数据
o.on("fetchdata",->
    data = {}
    for own name,value of o.fetchMethods
        data[name] = if $.type(value) is "function" then value() else value

    data.goodsName ?= document.title
    data.price ?= ""
    data.prop ?= ""
    data.img ?= @fetchImg() or ""
    data.siteName ?= location.hostname
    data.url = win.location.href
    data.action = "AddCart"
    data.number = 1
    # 数据库限制
    for own name,value of data
        if value.length > 400
            $.error("#{name} 的长度超过400。")
    delete data.path
    delete data.identify
    @trigger("cartReload",data)
)
# 刷新购物车数据
.on("cartReload",(e,data)->
    cartData = o.cartData
    para = {action:"Cartlist"}
    $.extend(para,data)
    cartData.status.action = para.action
    $.getJSON(
        "#{o.dir}api/plugins.php?callback=?",
        para,
        (data)->
            if data.Error
                $.extend(cartData.status,data)
                ui.trigger("alert",data.msg)
            else
                # 补全图片的相对路径
                for item in data
                    for i in item.pic
                        i.href = o.dir + i.href if !/^http/.test(i.href)

                cartData.list = data
                if cartData.status.action is "AddCart"
                    ui.trigger("alert","恭喜您！商品已加入购物车。")
                if cartData.status.action is "DelCart"
                    ui.trigger("alert","商品已删除。")
            cartData.timeMark = (new Date()).toLocaleTimeString()
            ui.trigger("refresh",cartData)
    )
)
.trigger("cartReload")

# 刷新数据避免session过期
setInterval((->o.trigger("cartReload")),1000*60*o.sessionTimeout)

# 抓取当前窗口中可见的，高度最大的图片
o.fetchImg = ->
    imgs = $("img:visible:not([src$=gif])")
    imgs = imgs.filter(->
        t = $(@)
        w = $(win)
        top =  t.offset().top - w.scrollTop()
        if top > 0 and top < w.height()
            return true
        else
            return false
    )
    imgs.sort((a,b)->
        $(b).height() - $(a).height()
    )
    imgs.first().attr("src")

# 截屏动作完成
o.screenShotDone = ->
    ui.trigger("statusIn","截图保存中<img alt='...' src='#{o.dir}api/js/loading.gif' class='oye_loading'/>")

# 截屏回调
o.screenShotCallback = (data)->
    console?.log "截图成功",data
    return $.error("截图数据为空") unless data
    if data.Error
        ui.trigger("alert",data.msg)
    else
        @cartData.timeMark = (new Date()).toLocaleTimeString()
        for i in data
            i.href = o.dir + i.href if !/^http/.test(i.href)
        @cartData.current.pic = data
        ui.trigger("refresh",@cartData)
        ui.trigger("alert","恭喜您！截图已添加。")

# 调整惠惠的尺寸
$("body").on("mouseenter","#youdaoGWZS,#i1e0fgj",->
    $(@).animate({width:ui.offset().left-20})
)

# 提示载入
console?.log "脚本已载入"











