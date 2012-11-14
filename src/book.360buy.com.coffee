$ = @oye.$
@oye.fetchMethods = {
    "siteName":"京东"
    "path":/\d+\.html$/
    "goodsName":->
        el = $("#name h1").clone()
        el.find("*").remove()
        el.text()
    "price":-> $("#priceinfo").html().replace(/[^\d.]/g,"")
    "prop":->
        el = $("#summary").clone()
        el.find(".hide").remove()
        el.text().replace(/(\s*\n)+/g,"|")
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
