// Generated by CoffeeScript 1.3.3
(function(){var e;e=this.oye.$;this.oye.fetchMethods={siteName:"京东",path:/\bproduct\b/,goodsName:function(){var e;return typeof pageConfig!="undefined"&&pageConfig!==null?(e=pageConfig.product)!=null?e.name:void 0:void 0},price:function(){var e;return typeof pageConfig!="undefined"&&pageConfig!==null?(e=pageConfig.product)!=null?e.price:void 0:void 0},prop:function(){var t;t=e("#choose-result .dd").clone();t.find("em").remove();return t.text()},img:function(){return e("#spec-n1 img").attr("src")}}}).call(this);