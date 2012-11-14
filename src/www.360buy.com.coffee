$ = @oye.$
@oye.fetchMethods = {
    "siteName":"京东"
    "path":/\bproduct\b/
    "goodsName":-> pageConfig?.product?.name
    "price":-> pageConfig?.product?.price
    "prop":->
        el = $("#choose-result .dd").clone()
        el.find("em").remove()
        el.text()
    "img":-> $("#spec-n1 img").attr("src")
    # 商品页面鉴定
    "identify": (item)->
        return false unless item
        rule = /\?.*$/
        itemID = item.url.replace(rule,"")
        return false unless itemID
        pageID = location.href.replace(rule,"")
        return pageID is itemID
}
