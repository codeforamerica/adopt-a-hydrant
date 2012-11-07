/* ===================================================
 * bootstrap-transition.js v2.0.2
 * http://twitter.github.com/bootstrap/javascript.html#transitions
 * ===================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================== */
!function(e){e(function(){"use strict";e.support.transition=function(){var t=document.body||document.documentElement,n=t.style,r=n.transition!==undefined||n.WebkitTransition!==undefined||n.MozTransition!==undefined||n.MsTransition!==undefined||n.OTransition!==undefined;return r&&{end:function(){var t="TransitionEnd";return e.browser.webkit?t="webkitTransitionEnd":e.browser.mozilla?t="transitionend":e.browser.opera&&(t="oTransitionEnd"),t}()}}()})}(window.jQuery),!function(e){"use strict";var t='[data-dismiss="alert"]',n=function(n){e(n).on("click",t,this.close)};n.prototype={constructor:n,close:function(t){function s(){i.trigger("closed").remove()}var n=e(this),r=n.attr("data-target"),i;r||(r=n.attr("href"),r=r&&r.replace(/.*(?=#[^\s]*$)/,"")),i=e(r),i.trigger("close"),t&&t.preventDefault(),i.length||(i=n.hasClass("alert")?n:n.parent()),i.trigger("close").removeClass("in"),e.support.transition&&i.hasClass("fade")?i.on(e.support.transition.end,s):s()}},e.fn.alert=function(t){return this.each(function(){var r=e(this),i=r.data("alert");i||r.data("alert",i=new n(this)),typeof t=="string"&&i[t].call(r)})},e.fn.alert.Constructor=n,e(function(){e("body").on("click.alert.data-api",t,n.prototype.close)})}(window.jQuery),!function(e){"use strict";var t=function(t,n){this.$element=e(t),this.options=e.extend({},e.fn.button.defaults,n)};t.prototype={constructor:t,setState:function(e){var t="disabled",n=this.$element,r=n.data(),i=n.is("input")?"val":"html";e+="Text",r.resetText||n.data("resetText",n[i]()),n[i](r[e]||this.options[e]),setTimeout(function(){e=="loadingText"?n.addClass(t).attr(t,t):n.removeClass(t).removeAttr(t)},0)},toggle:function(){var e=this.$element.parent('[data-toggle="buttons-radio"]');e&&e.find(".active").removeClass("active"),this.$element.toggleClass("active")}},e.fn.button=function(n){return this.each(function(){var r=e(this),i=r.data("button"),s=typeof n=="object"&&n;i||r.data("button",i=new t(this,s)),n=="toggle"?i.toggle():n&&i.setState(n)})},e.fn.button.defaults={loadingText:"loading..."},e.fn.button.Constructor=t,e(function(){e("body").on("click.button.data-api","[data-toggle^=button]",function(t){var n=e(t.target);n.hasClass("btn")||(n=n.closest(".btn")),n.button("toggle")})})}(window.jQuery),!function(e){"use strict";var t=function(t,n){this.$element=e(t),this.options=e.extend({},e.fn.carousel.defaults,n),this.options.slide&&this.slide(this.options.slide),this.options.pause=="hover"&&this.$element.on("mouseenter",e.proxy(this.pause,this)).on("mouseleave",e.proxy(this.cycle,this))};t.prototype={cycle:function(){return this.interval=setInterval(e.proxy(this.next,this),this.options.interval),this},to:function(t){var n=this.$element.find(".active"),r=n.parent().children(),i=r.index(n),s=this;if(t>r.length-1||t<0)return;return this.sliding?this.$element.one("slid",function(){s.to(t)}):i==t?this.pause().cycle():this.slide(t>i?"next":"prev",e(r[t]))},pause:function(){return clearInterval(this.interval),this.interval=null,this},next:function(){if(this.sliding)return;return this.slide("next")},prev:function(){if(this.sliding)return;return this.slide("prev")},slide:function(t,n){var r=this.$element.find(".active"),i=n||r[t](),s=this.interval,o=t=="next"?"left":"right",u=t=="next"?"first":"last",a=this;this.sliding=!0,s&&this.pause(),i=i.length?i:this.$element.find(".item")[u]();if(i.hasClass("active"))return;return!e.support.transition&&this.$element.hasClass("slide")?(this.$element.trigger("slide"),r.removeClass("active"),i.addClass("active"),this.sliding=!1,this.$element.trigger("slid")):(i.addClass(t),i[0].offsetWidth,r.addClass(o),i.addClass(o),this.$element.trigger("slide"),this.$element.one(e.support.transition.end,function(){i.removeClass([t,o].join(" ")).addClass("active"),r.removeClass(["active",o].join(" ")),a.sliding=!1,setTimeout(function(){a.$element.trigger("slid")},0)})),s&&this.cycle(),this}},e.fn.carousel=function(n){return this.each(function(){var r=e(this),i=r.data("carousel"),s=typeof n=="object"&&n;i||r.data("carousel",i=new t(this,s)),typeof n=="number"?i.to(n):typeof n=="string"||(n=s.slide)?i[n]():i.cycle()})},e.fn.carousel.defaults={interval:5e3,pause:"hover"},e.fn.carousel.Constructor=t,e(function(){e("body").on("click.carousel.data-api","[data-slide]",function(t){var n=e(this),r,i=e(n.attr("data-target")||(r=n.attr("href"))&&r.replace(/.*(?=#[^\s]+$)/,"")),s=!i.data("modal")&&e.extend({},i.data(),n.data());i.carousel(s),t.preventDefault()})})}(window.jQuery),!function(e){"use strict";var t=function(t,n){this.$element=e(t),this.options=e.extend({},e.fn.collapse.defaults,n),this.options.parent&&(this.$parent=e(this.options.parent)),this.options.toggle&&this.toggle()};t.prototype={constructor:t,dimension:function(){var e=this.$element.hasClass("width");return e?"width":"height"},show:function(){var t=this.dimension(),n=e.camelCase(["scroll",t].join("-")),r=this.$parent&&this.$parent.find(".in"),i;r&&r.length&&(i=r.data("collapse"),r.collapse("hide"),i||r.data("collapse",null)),this.$element[t](0),this.transition("addClass","show","shown"),this.$element[t](this.$element[0][n])},hide:function(){var e=this.dimension();this.reset(this.$element[e]()),this.transition("removeClass","hide","hidden"),this.$element[e](0)},reset:function(e){var t=this.dimension();return this.$element.removeClass("collapse")[t](e||"auto")[0].offsetWidth,this.$element[e?"addClass":"removeClass"]("collapse"),this},transition:function(t,n,r){var i=this,s=function(){n=="show"&&i.reset(),i.$element.trigger(r)};this.$element.trigger(n)[t]("in"),e.support.transition&&this.$element.hasClass("collapse")?this.$element.one(e.support.transition.end,s):s()},toggle:function(){this[this.$element.hasClass("in")?"hide":"show"]()}},e.fn.collapse=function(n){return this.each(function(){var r=e(this),i=r.data("collapse"),s=typeof n=="object"&&n;i||r.data("collapse",i=new t(this,s)),typeof n=="string"&&i[n]()})},e.fn.collapse.defaults={toggle:!0},e.fn.collapse.Constructor=t,e(function(){e("body").on("click.collapse.data-api","[data-toggle=collapse]",function(t){var n=e(this),r,i=n.attr("data-target")||t.preventDefault()||(r=n.attr("href"))&&r.replace(/.*(?=#[^\s]+$)/,""),s=e(i).data("collapse")?"toggle":n.data();e(i).collapse(s)})})}(window.jQuery),!function(e){"use strict";function r(){e(t).parent().removeClass("open")}var t='[data-toggle="dropdown"]',n=function(t){var n=e(t).on("click.dropdown.data-api",this.toggle);e("html").on("click.dropdown.data-api",function(){n.parent().removeClass("open")})};n.prototype={constructor:n,toggle:function(t){var n=e(this),i=n.attr("data-target"),s,o;return i||(i=n.attr("href"),i=i&&i.replace(/.*(?=#[^\s]*$)/,"")),s=e(i),s.length||(s=n.parent()),o=s.hasClass("open"),r(),!o&&s.toggleClass("open"),!1}},e.fn.dropdown=function(t){return this.each(function(){var r=e(this),i=r.data("dropdown");i||r.data("dropdown",i=new n(this)),typeof t=="string"&&i[t].call(r)})},e.fn.dropdown.Constructor=n,e(function(){e("html").on("click.dropdown.data-api",r),e("body").on("click.dropdown.data-api",t,n.prototype.toggle)})}(window.jQuery),!function(e){"use strict";function n(){var t=this,n=setTimeout(function(){t.$element.off(e.support.transition.end),r.call(t)},500);this.$element.one(e.support.transition.end,function(){clearTimeout(n),r.call(t)})}function r(e){this.$element.hide().trigger("hidden"),i.call(this)}function i(t){var n=this,r=this.$element.hasClass("fade")?"fade":"";if(this.isShown&&this.options.backdrop){var i=e.support.transition&&r;this.$backdrop=e('<div class="modal-backdrop '+r+'" />').appendTo(document.body),this.options.backdrop!="static"&&this.$backdrop.click(e.proxy(this.hide,this)),i&&this.$backdrop[0].offsetWidth,this.$backdrop.addClass("in"),i?this.$backdrop.one(e.support.transition.end,t):t()}else!this.isShown&&this.$backdrop?(this.$backdrop.removeClass("in"),e.support.transition&&this.$element.hasClass("fade")?this.$backdrop.one(e.support.transition.end,e.proxy(s,this)):s.call(this)):t&&t()}function s(){this.$backdrop.remove(),this.$backdrop=null}function o(){var t=this;this.isShown&&this.options.keyboard?e(document).on("keyup.dismiss.modal",function(e){e.which==27&&t.hide()}):this.isShown||e(document).off("keyup.dismiss.modal")}var t=function(t,n){this.options=n,this.$element=e(t).delegate('[data-dismiss="modal"]',"click.dismiss.modal",e.proxy(this.hide,this))};t.prototype={constructor:t,toggle:function(){return this[this.isShown?"hide":"show"]()},show:function(){var t=this;if(this.isShown)return;e("body").addClass("modal-open"),this.isShown=!0,this.$element.trigger("show"),o.call(this),i.call(this,function(){var n=e.support.transition&&t.$element.hasClass("fade");!t.$element.parent().length&&t.$element.appendTo(document.body),t.$element.show(),n&&t.$element[0].offsetWidth,t.$element.addClass("in"),n?t.$element.one(e.support.transition.end,function(){t.$element.trigger("shown")}):t.$element.trigger("shown")})},hide:function(t){t&&t.preventDefault();if(!this.isShown)return;var i=this;this.isShown=!1,e("body").removeClass("modal-open"),o.call(this),this.$element.trigger("hide").removeClass("in"),e.support.transition&&this.$element.hasClass("fade")?n.call(this):r.call(this)}},e.fn.modal=function(n){return this.each(function(){var r=e(this),i=r.data("modal"),s=e.extend({},e.fn.modal.defaults,r.data(),typeof n=="object"&&n);i||r.data("modal",i=new t(this,s)),typeof n=="string"?i[n]():s.show&&i.show()})},e.fn.modal.defaults={backdrop:!0,keyboard:!0,show:!0},e.fn.modal.Constructor=t,e(function(){e("body").on("click.modal.data-api",'[data-toggle="modal"]',function(t){var n=e(this),r,i=e(n.attr("data-target")||(r=n.attr("href"))&&r.replace(/.*(?=#[^\s]+$)/,"")),s=i.data("modal")?"toggle":e.extend({},i.data(),n.data());t.preventDefault(),i.modal(s)})})}(window.jQuery),!function(e){"use strict";var t=function(e,t){this.init("tooltip",e,t)};t.prototype={constructor:t,init:function(t,n,r){var i,s;this.type=t,this.$element=e(n),this.options=this.getOptions(r),this.enabled=!0,this.options.trigger!="manual"&&(i=this.options.trigger=="hover"?"mouseenter":"focus",s=this.options.trigger=="hover"?"mouseleave":"blur",this.$element.on(i,this.options.selector,e.proxy(this.enter,this)),this.$element.on(s,this.options.selector,e.proxy(this.leave,this))),this.options.selector?this._options=e.extend({},this.options,{trigger:"manual",selector:""}):this.fixTitle()},getOptions:function(t){return t=e.extend({},e.fn[this.type].defaults,t,this.$element.data()),t.delay&&typeof t.delay=="number"&&(t.delay={show:t.delay,hide:t.delay}),t},enter:function(t){var n=e(t.currentTarget)[this.type](this._options).data(this.type);!n.options.delay||!n.options.delay.show?n.show():(n.hoverState="in",setTimeout(function(){n.hoverState=="in"&&n.show()},n.options.delay.show))},leave:function(t){var n=e(t.currentTarget)[this.type](this._options).data(this.type);!n.options.delay||!n.options.delay.hide?n.hide():(n.hoverState="out",setTimeout(function(){n.hoverState=="out"&&n.hide()},n.options.delay.hide))},show:function(){var e,t,n,r,i,s,o;if(this.hasContent()&&this.enabled){e=this.tip(),this.setContent(),this.options.animation&&e.addClass("fade"),s=typeof this.options.placement=="function"?this.options.placement.call(this,e[0],this.$element[0]):this.options.placement,t=/in/.test(s),e.remove().css({top:0,left:0,display:"block"}).appendTo(t?this.$element:document.body),n=this.getPosition(t),r=e[0].offsetWidth,i=e[0].offsetHeight;switch(t?s.split(" ")[1]:s){case"bottom":o={top:n.top+n.height,left:n.left+n.width/2-r/2};break;case"top":o={top:n.top-i,left:n.left+n.width/2-r/2};break;case"left":o={top:n.top+n.height/2-i/2,left:n.left-r};break;case"right":o={top:n.top+n.height/2-i/2,left:n.left+n.width}}e.css(o).addClass(s).addClass("in")}},setContent:function(){var e=this.tip();e.find(".tooltip-inner").html(this.getTitle()),e.removeClass("fade in top bottom left right")},hide:function(){function r(){var t=setTimeout(function(){n.off(e.support.transition.end).remove()},500);n.one(e.support.transition.end,function(){clearTimeout(t),n.remove()})}var t=this,n=this.tip();n.removeClass("in"),e.support.transition&&this.$tip.hasClass("fade")?r():n.remove()},fixTitle:function(){var e=this.$element;(e.attr("title")||typeof e.attr("data-original-title")!="string")&&e.attr("data-original-title",e.attr("title")||"").removeAttr("title")},hasContent:function(){return this.getTitle()},getPosition:function(t){return e.extend({},t?{top:0,left:0}:this.$element.offset(),{width:this.$element[0].offsetWidth,height:this.$element[0].offsetHeight})},getTitle:function(){var e,t=this.$element,n=this.options;return e=t.attr("data-original-title")||(typeof n.title=="function"?n.title.call(t[0]):n.title),e=(e||"").toString().replace(/(^\s*|\s*$)/,""),e},tip:function(){return this.$tip=this.$tip||e(this.options.template)},validate:function(){this.$element[0].parentNode||(this.hide(),this.$element=null,this.options=null)},enable:function(){this.enabled=!0},disable:function(){this.enabled=!1},toggleEnabled:function(){this.enabled=!this.enabled},toggle:function(){this[this.tip().hasClass("in")?"hide":"show"]()}},e.fn.tooltip=function(n){return this.each(function(){var r=e(this),i=r.data("tooltip"),s=typeof n=="object"&&n;i||r.data("tooltip",i=new t(this,s)),typeof n=="string"&&i[n]()})},e.fn.tooltip.Constructor=t,e.fn.tooltip.defaults={animation:!0,delay:0,selector:!1,placement:"top",trigger:"hover",title:"",template:'<div class="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'}}(window.jQuery),!function(e){"use strict";var t=function(e,t){this.init("popover",e,t)};t.prototype=e.extend({},e.fn.tooltip.Constructor.prototype,{constructor:t,setContent:function(){var t=this.tip(),n=this.getTitle(),r=this.getContent();t.find(".popover-title")[e.type(n)=="object"?"append":"html"](n),t.find(".popover-content > *")[e.type(r)=="object"?"append":"html"](r),t.removeClass("fade top bottom left right in")},hasContent:function(){return this.getTitle()||this.getContent()},getContent:function(){var e,t=this.$element,n=this.options;return e=t.attr("data-content")||(typeof n.content=="function"?n.content.call(t[0]):n.content),e=e.toString().replace(/(^\s*|\s*$)/,""),e},tip:function(){return this.$tip||(this.$tip=e(this.options.template)),this.$tip}}),e.fn.popover=function(n){return this.each(function(){var r=e(this),i=r.data("popover"),s=typeof n=="object"&&n;i||r.data("popover",i=new t(this,s)),typeof n=="string"&&i[n]()})},e.fn.popover.Constructor=t,e.fn.popover.defaults=e.extend({},e.fn.tooltip.defaults,{placement:"right",content:"",template:'<div class="popover"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>'})}(window.jQuery),!function(e){"use strict";function t(t,n){var r=e.proxy(this.process,this),i=e(t).is("body")?e(window):e(t),s;this.options=e.extend({},e.fn.scrollspy.defaults,n),this.$scrollElement=i.on("scroll.scroll.data-api",r),this.selector=(this.options.target||(s=e(t).attr("href"))&&s.replace(/.*(?=#[^\s]+$)/,"")||"")+" .nav li > a",this.$body=e("body").on("click.scroll.data-api",this.selector,r),this.refresh(),this.process()}t.prototype={constructor:t,refresh:function(){this.targets=this.$body.find(this.selector).map(function(){var t=e(this).attr("href");return/^#\w/.test(t)&&e(t).length?t:null}),this.offsets=e.map(this.targets,function(t){return e(t).position().top})},process:function(){var e=this.$scrollElement.scrollTop()+this.options.offset,t=this.offsets,n=this.targets,r=this.activeTarget,i;for(i=t.length;i--;)r!=n[i]&&e>=t[i]&&(!t[i+1]||e<=t[i+1])&&this.activate(n[i])},activate:function(e){var t;this.activeTarget=e,this.$body.find(this.selector).parent(".active").removeClass("active"),t=this.$body.find(this.selector+'[href="'+e+'"]').parent("li").addClass("active"),t.parent(".dropdown-menu")&&t.closest("li.dropdown").addClass("active")}},e.fn.scrollspy=function(n){return this.each(function(){var r=e(this),i=r.data("scrollspy"),s=typeof n=="object"&&n;i||r.data("scrollspy",i=new t(this,s)),typeof n=="string"&&i[n]()})},e.fn.scrollspy.Constructor=t,e.fn.scrollspy.defaults={offset:10},e(function(){e('[data-spy="scroll"]').each(function(){var t=e(this);t.scrollspy(t.data())})})}(window.jQuery),!function(e){"use strict";var t=function(t){this.element=e(t)};t.prototype={constructor:t,show:function(){var t=this.element,n=t.closest("ul:not(.dropdown-menu)"),r=t.attr("data-target"),i,s;r||(r=t.attr("href"),r=r&&r.replace(/.*(?=#[^\s]*$)/,""));if(t.parent("li").hasClass("active"))return;i=n.find(".active a").last()[0],t.trigger({type:"show",relatedTarget:i}),s=e(r),this.activate(t.parent("li"),n),this.activate(s,s.parent(),function(){t.trigger({type:"shown",relatedTarget:i})})},activate:function(t,n,r){function o(){i.removeClass("active").find("> .dropdown-menu > .active").removeClass("active"),t.addClass("active"),s?(t[0].offsetWidth,t.addClass("in")):t.removeClass("fade"),t.parent(".dropdown-menu")&&t.closest("li.dropdown").addClass("active"),r&&r()}var i=n.find("> .active"),s=r&&e.support.transition&&i.hasClass("fade");s?i.one(e.support.transition.end,o):o(),i.removeClass("in")}},e.fn.tab=function(n){return this.each(function(){var r=e(this),i=r.data("tab");i||r.data("tab",i=new t(this)),typeof n=="string"&&i[n]()})},e.fn.tab.Constructor=t,e(function(){e("body").on("click.tab.data-api",'[data-toggle="tab"], [data-toggle="pill"]',function(t){t.preventDefault(),e(this).tab("show")})})}(window.jQuery),!function(e){"use strict";var t=function(t,n){this.$element=e(t),this.options=e.extend({},e.fn.typeahead.defaults,n),this.matcher=this.options.matcher||this.matcher,this.sorter=this.options.sorter||this.sorter,this.highlighter=this.options.highlighter||this.highlighter,this.$menu=e(this.options.menu).appendTo("body"),this.source=this.options.source,this.shown=!1,this.listen()};t.prototype={constructor:t,select:function(){var e=this.$menu.find(".active").attr("data-value");return this.$element.val(e),this.$element.change(),this.hide()},show:function(){var t=e.extend({},this.$element.offset(),{height:this.$element[0].offsetHeight});return this.$menu.css({top:t.top+t.height,left:t.left}),this.$menu.show(),this.shown=!0,this},hide:function(){return this.$menu.hide(),this.shown=!1,this},lookup:function(t){var n=this,r,i;return this.query=this.$element.val(),this.query?(r=e.grep(this.source,function(e){if(n.matcher(e))return e}),r=this.sorter(r),r.length?this.render(r.slice(0,this.options.items)).show():this.shown?this.hide():this):this.shown?this.hide():this},matcher:function(e){return~e.toLowerCase().indexOf(this.query.toLowerCase())},sorter:function(e){var t=[],n=[],r=[],i;while(i=e.shift())i.toLowerCase().indexOf(this.query.toLowerCase())?~i.indexOf(this.query)?n.push(i):r.push(i):t.push(i);return t.concat(n,r)},highlighter:function(e){return e.replace(new RegExp("("+this.query+")","ig"),function(e,t){return"<strong>"+t+"</strong>"})},render:function(t){var n=this;return t=e(t).map(function(t,r){return t=e(n.options.item).attr("data-value",r),t.find("a").html(n.highlighter(r)),t[0]}),t.first().addClass("active"),this.$menu.html(t),this},next:function(t){var n=this.$menu.find(".active").removeClass("active"),r=n.next();r.length||(r=e(this.$menu.find("li")[0])),r.addClass("active")},prev:function(e){var t=this.$menu.find(".active").removeClass("active"),n=t.prev();n.length||(n=this.$menu.find("li").last()),n.addClass("active")},listen:function(){this.$element.on("blur",e.proxy(this.blur,this)).on("keypress",e.proxy(this.keypress,this)).on("keyup",e.proxy(this.keyup,this)),(e.browser.webkit||e.browser.msie)&&this.$element.on("keydown",e.proxy(this.keypress,this)),this.$menu.on("click",e.proxy(this.click,this)).on("mouseenter","li",e.proxy(this.mouseenter,this))},keyup:function(e){switch(e.keyCode){case 40:case 38:break;case 9:case 13:if(!this.shown)return;this.select();break;case 27:if(!this.shown)return;this.hide();break;default:this.lookup()}e.stopPropagation(),e.preventDefault()},keypress:function(e){if(!this.shown)return;switch(e.keyCode){case 9:case 13:case 27:e.preventDefault();break;case 38:e.preventDefault(),this.prev();break;case 40:e.preventDefault(),this.next()}e.stopPropagation()},blur:function(e){var t=this;setTimeout(function(){t.hide()},150)},click:function(e){e.stopPropagation(),e.preventDefault(),this.select()},mouseenter:function(t){this.$menu.find(".active").removeClass("active"),e(t.currentTarget).addClass("active")}},e.fn.typeahead=function(n){return this.each(function(){var r=e(this),i=r.data("typeahead"),s=typeof n=="object"&&n;i||r.data("typeahead",i=new t(this,s)),typeof n=="string"&&i[n]()})},e.fn.typeahead.defaults={source:[],items:8,menu:'<ul class="typeahead dropdown-menu"></ul>',item:'<li><a href="#"></a></li>'},e.fn.typeahead.Constructor=t,e(function(){e("body").on("focus.typeahead.data-api",'[data-provide="typeahead"]',function(t){var n=e(this);if(n.data("typeahead"))return;t.preventDefault(),n.typeahead(n.data())})})}(window.jQuery),$(function(){function d(e,t,r){if(r==="green")var i=o;else if(r==="red")var i=u;var s=new google.maps.Marker({animation:google.maps.Animation.DROP,icon:i,map:n,position:t,shadow:a});google.maps.event.addListener(s,"click",function(){c&&c.close();var t=new google.maps.InfoWindow({maxWidth:210});google.maps.event.addListener(t,"closeclick",function(){h=!1}),c=t,f=e,l=s,$.ajax({type:"GET",url:"/info_window",data:{thing_id:e},success:function(e){t===c&&(t.setContent(e),t.open(n,s),h=!0)}})}),p.push(e)}function v(e,t){var n=$("#address_form input[type='submit']");$.ajax({type:"GET",url:"/things.json",data:{utf8:"✓",authenticity_token:$('#address_form input[name="authenticity_token"]').val(),lat:e,lng:t,limit:$('#address_form input[name="limit"]').val()},error:function(e){$(n).attr("disabled",!1)},success:function(e){$(n).attr("disabled",!1);if(e.errors)$("#address").parent().addClass("error"),$("#address").focus();else{$("#address").parent().removeClass("error");var t=-1;$(e).each(function(e,n){if($.inArray(n.id,p)!==-1)return!0;t+=1,setTimeout(function(){var e=new google.maps.LatLng(n.lat,n.lng);if(n.user_id)var t="green";else var t="red";d(n.id,e,t)},t*100)})}}})}function m(){$('#combo-form input[type="email"], #combo-form input[type="text"]:visible, #combo-form input[type="password"]:visible, #combo-form input[type="submit"]:visible, #combo-form input[type="tel"]:visible, #combo-form button:visible').each(function(e){if($(this).val()===""||$(this).attr("type")==="submit"||this.tagName.toLowerCase()==="button")return $(this).focus(),!1})}var e=new google.maps.LatLng(38.908934,-77.025833),t={center:e,disableDoubleClickZoom:!0,keyboardShortcuts:!1,mapTypeControl:!1,mapTypeId:google.maps.MapTypeId.ROADMAP,maxZoom:19,minZoom:15,panControl:!1,rotateControl:!1,scaleControl:!1,scrollwheel:!1,streetViewControl:!0,zoom:15,zoomControl:!0},n=new google.maps.Map(document.getElementById("map"),t),r=new google.maps.Size(27,37),i=new google.maps.Point(0,0),s=new google.maps.Point(13,18),o=new google.maps.MarkerImage("/assets/markers/green-b1dc0b7a12869cc19e09a36ac9745d58.png",r,i,s),u=new google.maps.MarkerImage("/assets/markers/red-e03aa4193a58c012faf322ec4edc11c8.png",r,i,s),a=new google.maps.MarkerImage("/assets/markers/shadow-de7111e855f2a6c1c69d0f1626d62e9f.png",new google.maps.Size(46,37),i,s),f,l,c,h=!1,p=[];google.maps.event.addListener(n,"dragend",function(){var e=n.getCenter();v(e.lat(),e.lng())}),$("#address_form").live("submit",function(){var e=$("#address_form input[type='submit']");return $(e).attr("disabled",!0),$("#address").val()===""?($(e).attr("disabled",!1),$("#address").parent().addClass("error"),$("#address").focus()):$.ajax({type:"GET",url:"/address.json",data:{utf8:"✓",authenticity_token:$('#address_form input[name="authenticity_token"]').val(),city_state:$("#city_state").val(),address:$("#address").val()},error:function(t){$(e).attr("disabled",!1),$("#address").parent().addClass("error"),$("#address").focus()},success:function(t){$(e).attr("disabled",!1);if(t.errors)$("#address").parent().addClass("error"),$("#address").focus();else{$("#address").parent().removeClass("error"),v(t[0],t[1]);var r=new google.maps.LatLng(t[0],t[1]);n.setCenter(r),n.setZoom(19)}}}),!1}),$('#combo-form input[type="radio"]').live("click",function(){var e=$(this);"new"===e.val()?($("#combo-form").data("state","user_sign_up"),$("#user_forgot_password_fields").slideUp(),$("#user_sign_in_fields").slideUp(),$("#user_sign_up_fields").slideDown(function(){m()})):"existing"===e.val()&&($("#user_sign_up_fields").slideUp(),$("#user_sign_in_fields").slideDown(function(){$("#combo-form").data("state","user_sign_in"),m(),$("#user_forgot_password_link").click(function(){$("#combo-form").data("state","user_forgot_password"),$("#user_sign_in_fields").slideUp(),$("#user_forgot_password_fields").slideDown(function(){m(),$("#user_remembered_password_link").click(function(){$("#combo-form").data("state","user_sign_in"),$("#user_forgot_password_fields").slideUp(),$("#user_sign_in_fields").slideDown(function(){m()})})})})}))}),$("#combo-form").live("submit",function(){var e=$("#combo-form input[type='submit']");$(e).attr("disabled",!0);var t=[];return/[\w\.%\+]+@[\w]+\.+[\w]{2,}/.test($("#user_email").val())?$("#user_email").parent().removeClass("error"):(t.push($("#user_email")),$("#user_email").parent().addClass("error")),!$(this).data("state")||$(this).data("state")==="user_sign_up"?($("#user_name").val()===""?(t.push($("#user_name")),$("#user_name").parent().addClass("error")):$("#user_name").parent().removeClass("error"),$("#user_password_confirmation").val().length<6||$("#user_password_confirmation").val().length>20?(t.push($("#user_password_confirmation")),$("#user_password_confirmation").parent().addClass("error")):$("#user_password_confirmation").parent().removeClass("error"),t.length>0?($(e).attr("disabled",!1),t[0].focus()):$.ajax({type:"POST",url:"/users.json",data:{utf8:"✓",authenticity_token:$('#combo-form input[name="authenticity_token"]').val(),user:{email:$("#user_email").val(),name:$("#user_name").val(),organization:$("#user_organization").val(),voice_number:$("#user_voice_number").val(),sms_number:$("#user_sms_number").val(),password:$("#user_password_confirmation").val(),password_confirmation:$("#user_password_confirmation").val()}},error:function(n){var r=$.parseJSON(n.responseText);$(e).attr("disabled",!1),r.errors.email&&(t.push($("#user_email")),$("#user_email").parent().addClass("error")),r.errors.name&&(t.push($("#user_name")),$("#user_name").parent().addClass("error")),r.errors.organization&&(t.push($("#user_organization")),$("#user_organization").parent().addClass("error")),r.errors.voice_number&&(t.push($("#user_voice_number")),$("#user_voice_number").parent().addClass("error")),r.errors.sms_number&&(t.push($("#user_sms_number")),$("#user_sms_number").parent().addClass("error")),r.errors.password&&(t.push($("#user_password_confirmation")),$("#user_password_confirmation").parent().addClass("error")),t[0].focus()},success:function(e){$.ajax({type:"GET",url:"/sidebar/search",data:{flash:{notice:"Thanks for signing up!"}},success:function(e){$("#content").html(e)}})}})):$(this).data("state")==="user_sign_in"?($("#user_password").val().length<6||$("#user_password").val().length>20?(t.push($("#user_password")),$("#user_password").parent().addClass("error")):$("#user_password").parent().removeClass("error"),t.length>0?($(e).attr("disabled",!1),t[0].focus()):$.ajax({type:"POST",url:"/users/sign_in.json",data:{utf8:"✓",authenticity_token:$('#combo-form input[name="authenticity_token"]').val(),user:{email:$("#user_email").val(),password:$("#user_password").val(),remember_me:$("#user_remember_me").val()}},error:function(t){$(e).attr("disabled",!1),$("#user_password").parent().addClass("error"),$("#user_password").focus()},success:function(e){$.ajax({type:"GET",url:"/sidebar/search",data:{flash:{notice:"Signed in!"}},success:function(e){$("#content").html(e)}})}})):$(this).data("state")==="user_forgot_password"&&(t.length>0?($(e).attr("disabled",!1),t[0].focus()):$.ajax({type:"POST",url:"/users/password.json",data:{utf8:"✓",authenticity_token:$('#combo-form input[name="authenticity_token"]').val(),user:{email:$("#user_email").val()}},error:function(t){$(e).attr("disabled",!1),$("#user_email").parent().addClass("error"),$("#user_email").focus()},success:function(){$(e).attr("disabled",!1),$("#user_remembered_password_link").click(),$("#user_password").focus()}})),!1}),$("#adoption_form").live("submit",function(){var e=$("#adoption_form input[type='submit']");return $(e).attr("disabled",!0),$.ajax({type:"POST",url:"/things.json",data:{id:$("#thing_id").val(),utf8:"✓",authenticity_token:$('#adoption_form input[name="authenticity_token"]').val(),_method:"put",thing:{user_id:$("#thing_user_id").val(),name:$("#thing_name").val()}},error:function(t){$(e).attr("disabled",!1)},success:function(e){$.ajax({type:"GET",url:"/info_window",data:{thing_id:f,flash:{notice:"You just adopted a hydrant!"}},success:function(e){c.close(),c.setContent(e),c.open(n,l),l.setIcon(o),l.setAnimation(google.maps.Animation.BOUNCE)}})}}),!1}),$("#abandon_form").live("submit",function(){var e=window.confirm("Are you sure you want to abandon this hydrant?");if(e){var t=$("#abandon_form input[type='submit']");$(t).attr("disabled",!0),$.ajax({type:"POST",url:"/things.json",data:{id:$("#thing_id").val(),utf8:"✓",authenticity_token:$('#abandon_form input[name="authenticity_token"]').val(),_method:"put",thing:{user_id:$("#thing_user_id").val(),name:$("#thing_name").val()}},error:function(e){$(t).attr("disabled",!1)},success:function(e){$.ajax({type:"GET",url:"/info_window",data:{thing_id:f,flash:{warning:"Hydrant abandoned!"}},success:function(e){c.close(),c.setContent(e),c.open(n,l),l.setIcon(u),l.setAnimation(null)}})}})}return!1}),$("#edit_profile_link").live("click",function(){var e=$(this);return $(e).addClass("disabled"),$.ajax({type:"GET",url:"/users/edit",error:function(t){$(e).removeClass("disabled")},success:function(e){$("#content").html(e)}}),!1}),$("#edit_form").live("submit",function(){var e=$("#edit_form input[type='submit']");$(e).attr("disabled",!0);var t=[];return/[\w\.%\+\]+@[\w\]+\.+[\w]{2,}/.test($("#user_email").val())?$("#user_email").parent().removeClass("error"):(t.push($("#user_email")),$("#user_email").parent().addClass("error")),$("#user_name").val()===""?(t.push($("#user_name")),$("#user_name").parent().addClass("error")):$("#user_name").parent().removeClass("error"),$("#user_zip").val()!=""&&!/^\d{5}(-\d{4})?$/.test($("#user_zip").val())?(t.push($("#user_zip")),$("#user_zip").parent().addClass("error")):$("#user_zip").parent().removeClass("error"),$("#user_password").val()&&($("#user_password").val().length<6||$("#user_password").val().length>20)?(t.push($("#user_password")),$("#user_password").parent().addClass("error")):$("#user_password").parent().removeClass("error"),$("#user_current_password").val().length<6||$("#user_current_password").val().length>20?(t.push($("#user_current_password")),$("#user_current_password").parent().addClass("error")):$("#user_current_password").parent().removeClass("error"),t.length>0?($(e).attr("disabled",!1),t[0].focus()):$.ajax({type:"POST",url:"/users.json",data:{id:$("#id").val(),thing_id:f,utf8:"✓",authenticity_token:$('#edit_form input[name="authenticity_token"]').val(),_method:"put",user:{email:$("#user_email").val(),name:$("#user_name").val(),organization:$("#user_organization").val(),voice_number:$("#user_voice_number").val(),sms_number:$("#user_sms_number").val(),address_1:$("#user_address_1").val(),address_2:$("#user_address_2").val(),city:$("#user_city").val(),state:$("#user_state").val(),zip:$("#user_zip").val(),password:$("#user_password").val(),password_confirmation:$("#user_password").val(),current_password:$("#user_current_password").val()}},error:function(n){var r=
$.parseJSON(n.responseText);$(e).attr("disabled",!1),r.errors.email&&(t.push($("#user_email")),$("#user_email").parent().addClass("error")),r.errors.name&&(t.push($("#user_name")),$("#user_name").parent().addClass("error")),r.errors.organization&&(t.push($("#user_organization")),$("#user_organization").parent().addClass("error")),r.errors.voice_number&&(t.push($("#user_voice_number")),$("#user_voice_number").parent().addClass("error")),r.errors.sms_number&&(t.push($("#user_sms_number")),$("#user_sms_number").parent().addClass("error")),r.errors.address_1&&(t.push($("#user_address_1")),$("#user_address_1").parent().addClass("error")),r.errors.address_2&&(t.push($("#user_address_2")),$("#user_address_2").parent().addClass("error")),r.errors.city&&(t.push($("#user_city")),$("#user_city").parent().addClass("error")),r.errors.state&&(t.push($("#user_state")),$("#user_state").parent().addClass("error")),r.errors.zip&&(t.push($("#user_zip")),$("#user_zip").parent().addClass("error")),r.errors.password&&(t.push($("#user_password")),$("#user_password").parent().addClass("error")),r.errors.current_password&&(t.push($("#user_current_password")),$("#user_current_password").parent().addClass("error")),t[0].focus()},success:function(e){$("#content").html(e)}}),!1}),$("#sign_out_link").live("click",function(){var e=$(this);return $(e).addClass("disabled"),$.ajax({type:"DELETE",url:"/users/sign_out.json",error:function(t){$(e).removeClass("disabled")},success:function(e){$.ajax({type:"GET",url:"/sidebar/combo_form",data:{flash:{warning:"Signed out."}},success:function(e){$("#content").html(e)}})}}),!1}),$("#sign_in_form").live("submit",function(){var e=$("#sign_in_form input[type='submit']");return $(e).attr("disabled",!0),$.ajax({type:"GET",url:"/users/sign_in",error:function(t){$(e).attr("disabled",!1)},success:function(e){c.close(),c.setContent(e),c.open(n,l)}}),!1}),$("#back_link").live("click",function(){var e=$(this);return $(e).addClass("disabled"),$.ajax({type:"GET",url:"/sidebar/search",error:function(t){$(e).removeClass("disabled")},success:function(e){$("#content").html(e)}}),!1}),$("#reminder_form").live("submit",function(){var e=$("#reminder_form input[type='submit']");return $(e).attr("disabled",!0),$.ajax({type:"POST",url:"/reminders.json",data:{utf8:"✓",authenticity_token:$('#reminder_form input[name="authenticity_token"]').val(),reminder:{to_user_id:$("#reminder_to_user_id").val(),thing_id:f}},error:function(t){$(e).attr("disabled",!1)},success:function(e){$.ajax({type:"GET",url:"/info_window",data:{thing_id:f,flash:{notice:"Reminder sent!"}},success:function(e){c.close(),c.setContent(e),c.open(n,l)}})}}),!1}),$(".alert-message").alert()});