$ = @oye.$
@oye.fetchMethods = {
    "siteName":"伊藤洋华堂"
    "path":/\bcommodity\b/
    "goodsName":-> $("#commodityName").text()
    "price":->
        $("#commodityPrice").text().replace("¥","")
    "img":-> $("#bigImg").attr("src")
    "identify": (item)->
        return false unless item
        rule = /id=\w+/
        itemID = item.url.match(rule)?[0]
        return false unless itemID
        pageID = location.href.match(rule)?[0]
        return pageID is itemID
}
