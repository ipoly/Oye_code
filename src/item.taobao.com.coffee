$ = @oye.$
@oye.fetchMethods = {
    "siteName":"淘宝"
    "path":/item\.htm/
    "goodsName":-> $("#detail .tb-detail-hd h3").text()
    "price":->
        $("#J_StrPrice:not(.del),#J_PromoPrice strong").text()
    "prop":->
        el = $(".tb-prop:not(#J_regionSellServer):has(.tb-selected)").clone()
        el.find("li:not(.tb-selected),i").remove()
        el.text()
    "img":-> $("#J_ImgBooth").attr("src")
}
