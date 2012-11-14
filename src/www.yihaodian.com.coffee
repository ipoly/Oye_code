$ = @oye.$
@oye.fetchMethods = {
    "siteName":"一号店"
    "path":/\bproduct\b/
    "goodsName":-> $("#productMainName").text()
    "price":->
        $("#nonMemberPrice:not(.price_del) strong,#productFacadePrice").text()
    "img":-> $("#productImg").attr("src")
    # 商品页面鉴定
    "identify": (item)->
        return false unless item
        rule = /[_?].*$/
        itemID = item.url.replace(rule,"")
        return false unless itemID
        pageID = location.href.replace(rule,"")
        return pageID is itemID
}
