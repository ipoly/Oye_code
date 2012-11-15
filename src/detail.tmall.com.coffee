$ = @oye.$
@oye.fetchMethods = {
    "siteName":"天猫"
    "path":/./
    "goodsName":-> $("#detail .tb-detail-hd h3").text()
    "price":->
        $("#J_StrPrice:not(.del),#J_PromoBox .tb-wrTuan-num:first,#J_PromoBox > strong").text()
    "prop":->
        el = $(".tb-prop:not(#J_regionSellServer):has(.tb-selected)").clone()
        el.find("li:not(.tb-selected),i").remove()
        el.text()
    "img":-> $("#J_ImgBooth").attr("src")
    # 商品页面鉴定
    "identify": (item)->
        return false unless item
        rule = /id=\w+/
        itemID = item.url.match(rule)?[0]
        return false unless itemID
        pageID = location.href.match(rule)?[0]
        return pageID is itemID
}
