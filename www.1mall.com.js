// Generated by CoffeeScript 1.4.0
(function(){var e;e=this.oye.$;this.oye.fetchMethods={siteName:"一号商城",path:/\bproduct\b/,goodsName:function(){return e("#productMainName").text()},price:function(){return e("#nonMemberPrice:not(.price_del) strong,#productFacadePrice").text()},prop:function(){return e("#seriesShow td:last()").text()},img:function(){return e("#productImg").attr("src")},identify:function(e){var t,n,r;if(!e)return!1;r=/[_?].*$/;t=e.url.replace(r,"");if(!t)return!1;n=location.href.replace(r,"");return n===t}}}).call(this);