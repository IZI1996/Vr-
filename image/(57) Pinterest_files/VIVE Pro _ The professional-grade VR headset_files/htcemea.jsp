Array.prototype.filter||(Array.prototype.filter=function(t,e){"use strict";if("Function"!=typeof t&&"function"!=typeof t||!this)throw new TypeError;var r=this.length>>>0,n=new Array(r),o=this,l=0,i=-1;if(void 0===e)for(;++i!==r;)i in this&&t(o[i],i,o)&&(n[l++]=o[i]);else for(;++i!==r;)i in this&&t.call(e,o[i],i,o)&&(n[l++]=o[i]);return n.length=l,n}),Array.prototype.forEach||(Array.prototype.forEach=function(t){var e,r;if(null===this||void 0===this)throw new TypeError('"this" is null or not defined');var n=Object(this),o=n.length>>>0;if("function"!=typeof t)throw new TypeError(t+" is not a function");for(arguments.length>1&&(e=arguments[1]),r=0;r<o;){var l;r in n&&(l=n[r],t.call(e,l,r,n)),r++}}),Array.prototype.indexOf||(Array.prototype.indexOf=function(t,e){var r;if(null==this)throw new TypeError('"this" is null or not defined');var n=Object(this),o=n.length>>>0;if(0===o)return-1;var l=0|e;if(l>=o)return-1;for(r=Math.max(l>=0?l:o-Math.abs(l),0);r<o;){if(r in n&&n[r]===t)return r;r++}return-1}),document.getElementsByClassName||(document.getElementsByClassName=function(t){var e,r,n,o=document,l=[];if(o.querySelectorAll)return o.querySelectorAll("."+t);if(o.evaluate)for(r=".//*[contains(concat(' ', @class, ' '), ' "+t+" ')]",e=o.evaluate(r,o,null,0,null);n=e.iterateNext();)l.push(n);else for(e=o.getElementsByTagName("*"),r=new RegExp("(^|\\s)"+t+"(\\s|$)"),n=0;n<e.length;n++)r.test(e[n].className)&&l.push(e[n]);return l}),document.querySelectorAll||(document.querySelectorAll=function(t){var e,r=document.createElement("style"),n=[];for(document.documentElement.firstChild.appendChild(r),document._qsa=[],r.styleSheet.cssText=t+"{x-qsa:expression(document._qsa && document._qsa.push(this))}",window.scrollBy(0,0),r.parentNode.removeChild(r);document._qsa.length;)(e=document._qsa.shift()).style.removeAttribute("x-qsa"),n.push(e);return document._qsa=null,n}),document.querySelector||(document.querySelector=function(t){var e=document.querySelectorAll(t);return e.length?e[0]:null}),Object.keys||(Object.keys=function(){"use strict";var t=Object.prototype.hasOwnProperty,e=!{toString:null}.propertyIsEnumerable("toString"),r=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],n=r.length;return function(o){if("function"!=typeof o&&("object"!=typeof o||null===o))throw new TypeError("Object.keys called on non-object");var l,i,s=[];for(l in o)t.call(o,l)&&s.push(l);if(e)for(i=0;i<n;i++)t.call(o,r[i])&&s.push(r[i]);return s}}()),"function"!=typeof String.prototype.trim&&(String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")}),window.hasOwnProperty=window.hasOwnProperty||Object.prototype.hasOwnProperty;
if (typeof usi_commons === 'undefined') {
	usi_commons = {
		
		debug:location.href.indexOf("usidebug") != -1,
		
		log:function(msg) {
			if (this.debug) {
				if (msg instanceof Error) {
					console.log(msg.name + ': ' + msg.message);
				} else {
					console.log.apply(console, arguments);
				}
			}
		},
		log_error: function(msg) {
			if (this.debug) {
				if (msg instanceof Error) {
					console.log('%c USI Error:', usi_commons.log_styles.error, msg.name + ': ' + msg.message);
				} else {
					console.log('%c USI Error:', usi_commons.log_styles.error, msg);
				}
			}
		},
		log_success: function(msg) {
			if (this.debug) {
				console.log('%c USI Success:', usi_commons.log_styles.success, msg);
			}
		},
		dir:function(obj) {
			if (this.debug) {
				console.dir(obj);
			}
		},
		log_styles: {
			error: 'color: red; font-weight: bold;',
			success: 'color: green; font-weight: bold;'
		},
		domain: "https://www.upsellit.com",
		cdn: "https://upsellit-14516.kxcdn.com",
		is_mobile: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()),
		device: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()) ? 'mobile' : 'desktop',
		gup:function(name) {
			name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
			var regexS = "[\\?&]" + name + "=([^&#\\?]*)";
			var regex = new RegExp(regexS);
			var results = regex.exec(window.location.href);
			if (results == null) return "";
			else return results[1];
		},
		load_script:function(source, callback) {
			if (source.indexOf("//www.upsellit.com") == 0) source = "https:"+source; //upgrade non-secure requests
			var docHead = document.getElementsByTagName("head")[0];
			if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
			var newScript = document.createElement('script');
			newScript.type = 'text/javascript';
			newScript.src = source;
			if (typeof callback == "function") newScript.onload = callback;
			docHead.appendChild(newScript);
		},
		load_display:function(usiQS, usiSiteID, usiKey, callback) {
			usiKey = usiKey || "";
			var source = this.domain + "/launch.jsp?qs=" + usiQS + "&siteID=" + usiSiteID + "&keys=" + usiKey;
			this.load_script(source, callback);
		},
		load_facebook:function(usiQS, usiSiteID, usiKey) {
		},
		load_view:function(usiHash, usiSiteID, usiKey, callback) {
			if (typeof(usi_force) != "undefined" || location.href.indexOf("usi_force") != -1 || (usi_cookies.get("usi_sale") == null && usi_cookies.get("usi_launched") == null && usi_cookies.get("usi_launched"+usiSiteID) == null)) {
				usiKey = usiKey || "";
				var usi_append = "";
				if (this.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + this.gup("usi_force_date");
				else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
				if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_id_cache") != null) usi_append += "&usi_id_cache=" + usi_cookies.get("usi_id_cache");
				if (this.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
				var source = this.domain + "/view.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
				if (typeof(this.last_view) !== "undefined" && this.last_view == usiSiteID+"_"+usiKey) return;
				this.last_view = usiSiteID+"_"+usiKey;
				if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') usi_js.cleanup();
				this.load_script(source, callback);
			}
		},
		remove_loads:function() {
            if (document.getElementById("usi_obj") != null) {
                document.getElementById("usi_obj").parentNode.parentNode.removeChild(document.getElementById("usi_obj").parentNode);
            }
            if (typeof(usi_commons.usi_loads) !== "undefined") {
                for (var i in usi_commons.usi_loads) {
                    if (document.getElementById("usi_"+i) != null) {
                        document.getElementById("usi_"+i).parentNode.parentNode.removeChild(document.getElementById("usi_"+i).parentNode);
                    }
                }
            }
        },
		load:function(usiHash, usiSiteID, usiKey, callback){
			usiKey = usiKey || "";
			var usi_append = "";
			if (this.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + this.gup("usi_force_date");
			else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
			if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_id_cache") != null) usi_append += "&usi_id_cache=" + usi_cookies.get("usi_id_cache");
			if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
			var source = this.domain + "/usi_load.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
			this.load_script(source, callback);
			if (typeof(usi_commons.usi_loads) === "undefined") {
                usi_commons.usi_loads = new Map();
            }
            usi_commons.usi_loads[usiSiteID] = usiSiteID;
		},
		load_precapture:function(usiQS, usiSiteID, callback) {
			var source = this.domain + "/hound/monitor.jsp?qs=" + usiQS + "&siteID=" + usiSiteID + "&domain=" + encodeURIComponent(this.domain);
			this.load_script(source, callback);
		},
		load_mail:function(qs, siteID, callback) {
			var source = this.domain + "/mail.jsp?qs=" + qs + "&siteID=" + siteID + "&domain=" + encodeURIComponent(this.domain);
			this.load_script(source, callback);
		},
		send_prod_rec:function(siteID, info, real_time) {
			var result = false;
			try {
				var data = [siteID, info.name, info.link, info.pid, info.price, info.image];
				if (data.indexOf(undefined) == -1) {
					var queryString = [siteID, info.name.replace(/\|/g, "&#124;"), info.link, info.pid, info.price, info.image].join("|");
					if (info.extra) queryString += "|" + info.extra;
					var filetype = real_time ? "jsp" : "js";
					this.load_script(this.domain + "/active/pv2." + filetype + "?" + encodeURIComponent(queryString));
					result = true;
				}
			} catch (e) {
				this.report_error(e);
				result = false;
			}
			return result;
		},
		report_error:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
			    return;
            }
            usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack));
			usi_commons.log_error(err.message);
			usi_commons.dir(err);
		},
		gup_or_get_cookie: function(name, expireSeconds, forceCookie) {
			if (typeof usi_cookies === 'undefined') {
				usi_commons.log_error('usi_cookies is not defined');
				return;
			}
			expireSeconds = (expireSeconds || usi_cookies.expire_time.day);
			if (name == "usi_enable") expireSeconds = usi_cookies.expire_time.hour;
			var value = null;
			var qsValue = usi_commons.gup(name);
			if (qsValue !== '') {
				value = qsValue;
				usi_cookies.set(name, value, expireSeconds, forceCookie);
			} else {
				value = usi_cookies.get(name);
			}
			return (value || '');
		}
	};
}if("undefined"==typeof usi_cookies&&(usi_cookies={expire_time:{minute:60,hour:3600,two_hours:7200,four_hours:14400,day:86400,week:604800,two_weeks:1209600,month:2592e3,year:31536e3,never:31536e4},max_cookies_count:15,max_cookie_length:1e3,update_window_name:function(e,o,i){try{var n=-1;if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n=t.getTime()}var r=window.top||window,s=0;null!=o&&-1!=o.indexOf("=")&&(o=o.replace(new RegExp("=","g"),"USIEQLS")),null!=o&&-1!=o.indexOf(";")&&(o=o.replace(new RegExp(";","g"),"USIPRNS"));for(var u=r.name.split(";"),c="",a=0;a<u.length;a++){var l=u[a].split("=");3==l.length?(l[0]==e&&(l[1]=o,l[2]=n,s=1),null!=l[1]&&"null"!=l[1]&&(c+=l[0]+"="+l[1]+"="+l[2]+";")):""!=u[a]&&(c+=u[a]+";")}0==s&&(c+=e+"="+o+"="+n+";"),r.name=c}catch(e){}},flush_window_name:function(e){try{for(var o=window.top||window,i=o.name.split(";"),n="",t=0;t<i.length;t++){var r=i[t].split("=");3==r.length&&(0==r[0].indexOf(e)||(n+=i[t]+";"))}o.name=n}catch(e){}},get_from_window_name:function(e){try{for(var o=(window.top||window).name.split(";"),i=0;i<o.length;i++){var n=o[i].split("=");if(3==n.length){if(n[0]==e)if(-1!=(t=n[1]).indexOf("USIEQLS")&&(t=t.replace(new RegExp("USIEQLS","g"),"=")),-1!=t.indexOf("USIPRNS")&&(t=t.replace(new RegExp("USIPRNS","g"),";")),!("-1"!=n[2]&&usi_cookies.datediff(n[2])<0))return"undefined"==typeof usi_cookieless&&usi_cookies.create_cookie(n[0],t,usi_cookies.datediff(n[2])/1e3),usi_results=[t,n[2]],usi_results}else if(2==n.length){var t;if(n[0]==e)return-1!=(t=n[1]).indexOf("USIEQLS")&&(t=t.replace(new RegExp("USIEQLS","g"),"=")),-1!=t.indexOf("USIPRNS")&&(t=t.replace(new RegExp("USIPRNS","g"),";")),usi_results=[t,(new Date).getTime()+6048e5],usi_results}}}catch(e){}return null},datediff:function(e){return e-(new Date).getTime()},count_cookies:function(e){return e=e||"usi_",usi_cookies.search_cookies(e).length},root_domain:function(){try{var e=document.domain.split("."),o=e[e.length-1];if("com"==o||"net"==o||"org"==o||"us"==o||"co"==o||"ca"==o)return e[e.length-2]+"."+e[e.length-1]}catch(e){}return document.domain},create_cookie:function(e,o,i){if(!1!==navigator.cookieEnabled){var n="";if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n="; expires="+t.toGMTString()}var r="samesite=none;";0==location.href.indexOf("https://")&&(r+="secure;");var s=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(s=usi_parent_domain),document.cookie=e+"="+encodeURIComponent(o)+n+"; path=/;domain="+s+"; "+r}},read_cookie:function(e){if(!1===navigator.cookieEnabled)return null;for(var o=e+"=",i=document.cookie.split(";"),n=0;n<i.length;n++){for(var t=i[n];" "==t.charAt(0);)t=t.substring(1,t.length);if(0==t.indexOf(o))return decodeURIComponent(t.substring(o.length,t.length))}return null},del:function(e){usi_cookies.set(e,null,-100)},get:function(e){var o=null,i=usi_cookies.get_from_window_name(e);if(null!=i&&i.length>1)try{o=decodeURIComponent(i[0])}catch(e){return i[0]}else o=usi_cookies.read_cookie(e);return null==o?null:o},get_json:function(e){var o=null,i=usi_cookies.get(e);if(null==i)return null;try{o=JSON.parse(i)}catch(e){i=i.replace(/\\"/g,'"');try{o=JSON.parse(JSON.parse(i))}catch(e){try{o=JSON.parse(i)}catch(e){}}}return o},search_cookies:function(e){e=e||"";var o=[];return document.cookie.split(";").forEach(function(i){var n=i.split("=")[0].trim();""!==e&&0!==n.indexOf(e)||o.push(n)}),o},set:function(e,o,i,n){"undefined"!=typeof usi_nevercookie&&(n=!1),void 0===i&&(i=-1);try{o=o.replace(/(\r\n|\n|\r)/gm,"")}catch(e){}if("undefined"==typeof usi_windownameless&&usi_cookies.update_window_name(e+"",o+"",i),"undefined"==typeof usi_cookieless||n||null==o){if(null!=o){if(null==usi_cookies.read_cookie(e))if(!n)if(usi_cookies.search_cookies("usi_").length+1>usi_cookies.max_cookies_count)return void usi_cookies.report_error('Set cookie "'+e+'" failed. Max cookies count is '+usi_cookies.max_cookies_count);o.length>usi_cookies.max_cookie_length&&(usi_cookies.report_error('Cookie "'+e+'" truncated ('+o.length+"). Max single-cookie length is "+usi_cookies.max_cookie_length),o=o.substring(0,usi_cookies.max_cookie_length-1))}usi_cookies.create_cookie(e,o,i)}},set_json:function(e,o,i,n){var t=JSON.stringify(o).replace(/^"/,"").replace(/"$/,"");usi_cookies.set(e,t,i,n)},flush:function(e){e=e||"usi_";var o,i,n,t=document.cookie.split(";");for(o=0;o<t.length;o++)0==(i=t[o]).trim().toLowerCase().indexOf(e)&&(n=i.trim().split("=")[0],usi_cookies.del(n));usi_cookies.flush_window_name(e)},print:function(){for(var e=document.cookie.split(";"),o="",i=0;i<e.length;i++){var n=e[i];0==n.trim().toLowerCase().indexOf("usi_")&&(console.log(n.trim()+" (cookie)"),o+=","+n.trim().toLowerCase().split("=")[0]+",")}var t=(window.top||window).name.split(";");for(i=0;i<t.length;i++){var r=t[i].split("=");if(3==r.length&&0==r[0].indexOf("usi_")&&-1==o.indexOf(","+r[0]+",")){var s=r[1];-1!=s.indexOf("USIEQLS")&&(s=s.replace(new RegExp("USIEQLS","g"),"=")),-1!=s.indexOf("USIPRNS")&&(s=s.replace(new RegExp("USIPRNS","g"),";")),console.log(r[0]+"="+s+" (window.name)")}}},value_exists:function(){var e,o;for(e=0;e<arguments.length;e++)if(""===(o=usi_cookies.get(arguments[e]))||null===o||"null"===o||"undefined"===o)return!1;return!0},report_error:function(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}},"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.gup))try{""!=usi_commons.gup("usi_email_id")&&usi_cookies.set("usi_email_id",usi_commons.gup("usi_email_id").split(".")[0],Number(usi_commons.gup("usi_email_id").split(".")[1]),!0)}catch(e){usi_commons.report_error(e)}if (typeof usi_dom === 'undefined') {
    usi_dom = {};
    usi_dom.get_elements = function(selector, element) {
        var elements = [];
        element = (element || document);
        elements = Array.prototype.slice.call(element.querySelectorAll(selector));
        return elements;
    };
    usi_dom.count_elements = function(selector, element) {
        element = (element || document);
        return usi_dom.get_elements(selector, element).length;
    };
    usi_dom.get_nth_element = function(ordinal, selector, element) {
        var nthElement = null;
        element = (element || document);
        var elements = usi_dom.get_elements(selector, element);
        if (elements.length >= ordinal) {
            nthElement = elements[ordinal - 1];
        }
        return nthElement;
    };
    usi_dom.get_first_element = function(selector, element) {
        if ((selector || '') === '') {
            return null;
        }
        element = (element || document);
        if (Object.prototype.toString.call(selector) === '[object Array]') {
            var selectedElement = null;
            for (var selectorIndex = 0; selectorIndex < selector.length; selectorIndex++) {
                var selectorItem = selector[selectorIndex];
                selectedElement = usi_dom.get_first_element(selectorItem, element);
                if (selectedElement != null) {
                    break;
                }
            }
            return selectedElement;
        } else {
            return element.querySelector(selector);
        }
    };
    usi_dom.get_element_text_no_children = function(element, doCleanString) {
        var content = '';
        if (doCleanString == null) {
            doCleanString = false;
        }
        element = (element || document);
        if (element != null && element.childNodes != null) {
            for (var i = 0; i < element.childNodes.length; ++i) {
                if (element.childNodes[i].nodeType === 3) {
                    content += element.childNodes[i].textContent;
                }
            }
        }
        if (doCleanString === true) {
            content = usi_dom.clean_string(content);
        }
        return content.trim();
    };
    usi_dom.clean_string = function(content) {
        if (typeof content !== 'string') {
            return;
        }
        content = content.replace(/[\u2010-\u2015\u2043]/g, '-');
        content = content.replace(/[\u2018-\u201B]/g, "'");
        content = content.replace(/[\u201C-\u201F]/g, '"');
        content = content.replace(/\u2024/g, '.');
        content = content.replace(/\u2025/g, '..');
        content = content.replace(/\u2026/g, '...');
        content = content.replace(/\u2044/g, '/');
        var nonAsciiChars = /[^\x20-\xFF\u0100-\u017F\u0180-\u024F\u20A0-\u20CF]/g;
        return content.replace(nonAsciiChars, '').trim();
    };
    usi_dom.encode = function(content) {
        if (typeof content !== 'string') {
            return;
        }
        var encodedContent = encodeURIComponent(content);
        encodedContent = encodedContent.replace(/[-_.!~*'()]/g, function(r) {
            return '%' + r.charCodeAt(0).toString(16).toUpperCase();
        });
        return encodedContent;
    };
    usi_dom.get_closest = function(element, selector) {
        element = (element || document);
        if (typeof Element.prototype.matches !== 'function') {
            Element.prototype.matches =
                Element.prototype.matchesSelector ||
                Element.prototype.mozMatchesSelector ||
                Element.prototype.msMatchesSelector ||
                Element.prototype.oMatchesSelector ||
                Element.prototype.webkitMatchesSelector ||
                function(s) {
                    var matches = (this.document || this.ownerDocument).querySelectorAll(s);
                    var matchIndex = matches.length;
                    while (--matchIndex >= 0 && matches.item(matchIndex) !== this) {}
                    return matchIndex > -1;
                };
        }
        for (; element != null && element !== document; element = element.parentNode) {
            if (element.matches(selector)) {
                return element;
            }
        }
        return null;
    };
    usi_dom.get_classes = function(element) {
        var classes = [];
        if (element != null && element.classList != null) {
            classes = Array.prototype.slice.call(element.classList);
        }
        return classes;
    };
    usi_dom.add_class = function(element, className) {
        if (element != null) {
            var classes = usi_dom.get_classes(element);
            if (classes.indexOf(className) === -1) {
                classes.push(className);
                element.className = classes.join(' ');
            }
        }
    };
    usi_dom.string_to_decimal = function(stringContent) {
        var decimalValue = null;
        if (typeof stringContent === 'string') {
            try {
                var testValue = parseFloat(stringContent.replace(/[^0-9\.-]+/g, ''));
                if (isNaN(testValue) === false) {
                    decimalValue = testValue;
                }
            } catch (err) {
                usi_commons.log('Error: ' + err.message);
            }
        }
        return decimalValue;
    };
    usi_dom.string_to_integer = function(stringContent) {
        var integerValue = null;
        if (typeof stringContent === 'string') {
            try {
                var testValue = parseInt(stringContent.replace(/[^0-9-]+/g, ''));
                if (isNaN(testValue) === false) {
                    integerValue = testValue;
                }
            } catch (err) {
                usi_commons.log('Error: ' + err.message);
            }
        }
        return integerValue;
    };
    usi_dom.get_currency_string_from_content = function(stringContent) {
        if (typeof stringContent !== 'string') {
            return '';
        }
        try {
            stringContent = stringContent.trim();
            var currencyPattern = /^([^$]*?)($(?:[\,\,]?\d{1,3})+(?:\.\d{2})?)(.*?)$/;
            var currencyMatches = (stringContent.match(currencyPattern) || []);
            if (currencyMatches.length === 4) {
                return currencyMatches[2];
            } else {
                return '';
            }
        } catch (err) {
            usi_commons.log('Error: ' + err.message);
            return '';
        }
    };
    usi_dom.get_absolute_url = (function() {
        var a;
        return function(url) {
            a = (a || document.createElement('a'));
            a.href = url;
            return a.href;
        };
    })();
    usi_dom.format_number = function(number, decimalPlaces) {
        var formattedNumber = '';
        if (typeof number === 'number') {
            decimalPlaces = (decimalPlaces || 0);
            var workingNumber = number.toFixed(decimalPlaces);
            var numberParts = workingNumber.split(/\./g);
            if (numberParts.length == 1 || numberParts.length == 2) {
                var numberPortion = numberParts[0];
                formattedNumber = numberPortion.replace(/./g, function(c, i, a) {
                    return i && c !== '.' && ((a.length - i) % 3 === 0) ? ',' + c : c;
                });
                if (numberParts.length == 2) {
                    formattedNumber += '.' + numberParts[1];
                }
            }
        }
        return formattedNumber;
    };
    usi_dom.format_currency = function(number, languageCode, options) {
        var formattedCurrency = '';
        number = Number(number);
        if (isNaN(number) === false) {
            if (typeof Intl == 'object' && typeof Intl.NumberFormat == 'function') {
                languageCode = languageCode || 'en-US';
                options = options || {
                    style: 'currency',
                    currency: 'USD'
                };
                formattedCurrency = number.toLocaleString(languageCode, options);
            } else {
                formattedCurrency = number;
            }
        }
        return formattedCurrency;
    };
    usi_dom.to_decimal_places = function(numberValue, decimalPlaces) {
        if (numberValue != null && typeof numberValue === 'number' && decimalPlaces != null && typeof decimalPlaces === 'number') {
            if (decimalPlaces == 0) {
                return parseFloat(Math.round(numberValue));
            }
            var multiplier = 10;
            for (var i = 1; i < decimalPlaces; i++) {
                multiplier *= 10;
            }
            return parseFloat(Math.round(numberValue * multiplier) / multiplier);
        } else {
            return null;
        }
    };
    usi_dom.trim_string = function(stringValue, maxLength, trimmedText) {
        stringValue = (stringValue || '');
        trimmedText = (trimmedText || '');
        if (stringValue.length > maxLength) {
            stringValue = stringValue.substring(0, maxLength);
            if (trimmedText !== '') {
                stringValue += trimmedText;
            }
        }
        return stringValue;
    };
    usi_dom.attach_event = function(eventName, func, element) {
        var attachToElement = usi_dom.find_supported_element(eventName, element);
        usi_dom.detach_event(eventName, func, attachToElement);
        if (attachToElement.addEventListener) {
            attachToElement.addEventListener(eventName, func, false);
        } else {
            attachToElement.attachEvent('on' + eventName, func);
        }
    };
    usi_dom.detach_event = function(eventName, func, element) {
        var removeFromElement = usi_dom.find_supported_element(eventName, element);
        if (removeFromElement.removeEventListener) {
            removeFromElement.removeEventListener(eventName, func, false);
        } else {
            removeFromElement.detachEvent('on' + eventName, func);
        }
    };
    usi_dom.find_supported_element = function(eventName, element) {
        element = (element || document);
        if (element === window) {
            return window;
        } else if (usi_dom.is_event_supported(eventName, element) === true) {
            return element;
        } else {
            if (element === document) {
                return window;
            } else {
                return usi_dom.find_supported_element(eventName, document);
            }
        }
    };
    usi_dom.is_event_supported = function(eventName, element) {
        return (element != null && typeof element['on' + eventName] !== 'undefined');
    };
    usi_dom.is_defined = function(testObj, propertyPath) {
        if (testObj == null) {
            return false;
        }
        if ((propertyPath || '') === '') {
            return false;
        }
        var isDefined = true;
        var currentObj = testObj;
        var properties = propertyPath.split('.');
        properties.forEach(function(propertyName) {
            if (isDefined === true) {
                if (currentObj == null || typeof currentObj !== 'object' || currentObj.hasOwnProperty(propertyName) === false) {
                    isDefined = false;
                } else {
                    currentObj = currentObj[propertyName];
                }
            }
        });
        return isDefined;
    };
    usi_dom.observe = (function(element, options, callback) {
        var url = location.href;
        var defaultOptions = {
            onUrlUpdate: false,
            observerOptions: {
                childList: true,
                subtree: true
            }
        };
        var MutationObserver = window.MutationObserver || window.WebkitMutationObserver;
        options = options || defaultOptions;
        return function(element, callback) {
            var observer = null;
            var callbackHandler = function() {
                var currentUrl = location.href;
                if (options.onUrlUpdate && currentUrl !== url) {
                    callback();
                    url = currentUrl;
                } else {
                    callback();
                }
            };
            if (MutationObserver) {
                observer = new MutationObserver(function(mutations) {
                    var currentUrl = location.href;
                    var hasMutations = mutations[0].addedNodes.length || mutations[0].removedNodes.length;
                    if (hasMutations && options.onUrlUpdate && currentUrl !== url) {
                        callback();
                        url = currentUrl;
                    } else if (hasMutations) {
                        callback();
                    }
                });
                observer.observe(element, options.observerOptions);
            } else if (window.addEventListener) {
                element.addEventListener('DOMNodeInserted', callbackHandler, false);
                element.addEventListener('DOMNodeRemoved', callbackHandler, false);
            }
            return observer;
        };
    })();
    usi_dom.params_to_object = function(paramsString) {
        var paramsObj = {};
        if ((paramsString || '') != '') {
            var params = paramsString.split('&');
            params.forEach(function(param) {
                var paramParts = param.split('=');
                if (paramParts.length === 2) {
                    paramsObj[decodeURIComponent(paramParts[0])] = decodeURIComponent(paramParts[1]);
                } else if (paramParts.length === 1) {
                    paramsObj[decodeURIComponent(paramParts[0])] = null;
                }
            });
        }
        return paramsObj;
    };
    usi_dom.object_to_params = function(obj) {
        var params = [];
        if (obj != null) {
            for (var key in obj) {
                if (obj.hasOwnProperty(key) === true) {
                    params.push(encodeURIComponent(key) + '=' + (obj[key] == null ? '' : encodeURIComponent(obj[key])));
                }
            }
        }
        return params.join('&');
    };
    usi_dom.interval_with_timeout = function(iterationFunction, timeoutCallback, completeCallback, options) {
        if (typeof iterationFunction !== 'function') {
            throw new Error('usi_dom.interval_with_timeout(): iterationFunction must be a function');
        }
        if (timeoutCallback == null) {
            timeoutCallback = function(timeoutResult) {
                return timeoutResult;
            }
        } else if (typeof timeoutCallback !== 'function') {
            throw new Error('usi_dom.interval_with_timeout(): timeoutCallback must be a function');
        }
        if (completeCallback == null) {
            completeCallback = function(completeResult) {
                return completeResult;
            }
        } else if (typeof completeCallback !== 'function') {
            throw new Error('usi_dom.interval_with_timeout(): completeCallback must be a function');
        }
        options = (options || {});
        var intervalMS = (options.intervalMS || 20);
        var timeoutMS = (options.timeoutMS || 2000);
        if (typeof intervalMS !== 'number') {
            throw new Error('usi_dom.interval_with_timeout(): intervalMS must be a number');
        }
        if (typeof timeoutMS !== 'number') {
            throw new Error('usi_dom.interval_with_timeout(): timeoutMS must be a number');
        }
        var completionIsRunning = false;
        var intervalStartDate = new Date();
        var interval = setInterval(function() {
            var elapsedMS = ((new Date()) - intervalStartDate);
            if (elapsedMS >= timeoutMS) {
                clearInterval(interval);
                var timeoutResult = {
                    elapsedMS: elapsedMS
                };
                return timeoutCallback(timeoutResult);
            } else {
                if (completionIsRunning === false) {
                    completionIsRunning = true;
                    iterationFunction(function(isComplete, completeResult) {
                        completionIsRunning = false;
                        if (isComplete === true) {
                            clearInterval(interval);
                            completeResult = (completeResult || {});
                            completeResult.elapsedMS = ((new Date()) - intervalStartDate);
                            return completeCallback(completeResult);
                        }
                    });
                }
            }
        }, intervalMS);
    };
    usi_dom.load_external_stylesheet = function(url, id, callback) {
        if ((url || '') !== '') {
            if ((id || '') === '') {
                id = 'usi_stylesheet_' + ((new Date()).getTime());
            }
            var result = {
                url: url,
                id: id
            };
            var headElement = document.getElementsByTagName("head")[0];
            if (headElement != null) {
                var linkElement = document.createElement('link');
                linkElement.type = 'text/css';
                linkElement.rel = 'stylesheet';
                linkElement.id = result.id;
                linkElement.href = url;
                usi_dom.attach_event('load', function() {
                    if (callback != null) {
                        return callback(null, result);
                    }
                }, linkElement);
                headElement.appendChild(linkElement);
            }
        } else {
            if (callback != null) {
                return callback(null, result);
            }
        }
    };
    usi_dom.ready = function(callback) {
        if (typeof (document.readyState) != "undefined" && document.readyState === "complete") {
            callback();
        } else if (window.addEventListener) {
            window.addEventListener('load', callback, true);
        } else if (window["attachEvent"]) {
            window["attachEvent"]('onload', callback);
        } else {
            setTimeout(callback, 5000);
        }
    };
    usi_dom.fit_text = function (els, options) {
        if (!options) options = {};
        var defaultSettings = {
            multiLine: true,
            minFontSize: 0.1,
            maxFontSize: 20,
            widthOnly: false,
        };
        var settings = {};
        for(var key in defaultSettings){
            if(options.hasOwnProperty(key)){
                settings[key] = options[key];
            } else {
                settings[key] = defaultSettings[key];
            }
        }
        var elType = Object.prototype.toString.call(els);
        if (elType !== '[object Array]' && elType !== '[object NodeList]' &&
            elType !== '[object HTMLCollection]'){
            els = [els];
        }
        function processItem(el, settings){
            var innerSpan, originalHeight, originalHTML, originalWidth, originalFontSize;
            var low, mid, high;
            function innerHeight(el){
                var style = window.getComputedStyle(el, null);
                return (el.clientHeight -
                    parseInt(style.getPropertyValue('padding-top'), 10) -
                    parseInt(style.getPropertyValue('padding-bottom'), 10)) / originalFontSize;
            }
            function innerWidth(el){
                var style = window.getComputedStyle(el, null);
                return (el.clientWidth -
                    parseInt(style.getPropertyValue('padding-left'), 10) -
                    parseInt(style.getPropertyValue('padding-right'), 10)) / originalFontSize;
            }
            originalHTML = el.innerHTML;
            originalFontSize = parseInt(window.getComputedStyle(el, null).getPropertyValue('font-size'), 10);
            originalWidth = innerWidth(el);
            originalHeight = innerHeight(el);
            if (!originalWidth || (!settings.widthOnly && !originalHeight)) {
                if (!settings.widthOnly) usi_commons.log('Set a static height and width on the target element ' + el.outerHTML);
                else usi_commons.log('Set a static width on the target element ' + el.outerHTML);
            }
            if (originalHTML.indexOf('textFitted') === -1) {
                innerSpan = document.createElement('span');
                innerSpan.className = 'textFitted';
                innerSpan.style['display'] = 'inline-block';
                innerSpan.innerHTML = originalHTML;
                el.innerHTML = '';
                el.appendChild(innerSpan);
            } else {
                innerSpan = el.querySelector('span.textFitted');
            }
            if (!settings.multiLine) {
                el.style['white-space'] = 'nowrap';
            }
            low = settings.minFontSize;
            high = settings.maxFontSize;
            var size = low;
            var max_loops = 1000;
            while (low <= high && max_loops > 0) {
                max_loops--;
                mid = (high + low) - 0.1;
                innerSpan.style.fontSize = mid + 'em';
                if ((innerSpan.scrollWidth / originalFontSize) <= originalWidth && (settings.widthOnly || (innerSpan.scrollHeight / originalFontSize) <= originalHeight)){
                    size = mid;
                    low = mid + 0.1;
                } else {
                    high = mid - 0.1;
                }
            }
            if (innerSpan.style.fontSize !== size + 'em') innerSpan.style.fontSize = size + 'em';
        }
        for(var i = 0; i < els.length; i++){
            processItem(els[i], settings);
        }
    };
}
if (window.usi_app === undefined) {
	try {
		usi_app = {};
	
		usi_app.main = function () {
			usi_app.url = location.href.toLowerCase();
			usi_app.gb_cart = usi_app.url.indexOf('locale=en_gb') > -1;
			usi_app.ie_cart = usi_app.url.indexOf('locale=en_ie') > -1;
			usi_app.store_page = usi_app.url.indexOf('displaythreepgcheckoutaddresspaymentinfopage') > -1 ||
					usi_app.url == "https://store.eu.vive.com/drhm/store";
			usi_app.receipt_page = usi_app.url.indexOf("thankyoupage") > -1;
			usi_app.cart = usi_app.url.indexOf('threepgcheckoutshoppingcartpage') > -1;
			usi_app.visited_ie = !!usi_cookies.get('usi_ie');
			usi_app.visited_gb = !!usi_cookies.get('usi_gb');
			usi_app.can_launch = !!usi_cookies.get('usi_can_launch');
	
			if (usi_app.cart && usi_app.url.indexOf('en_gb') > -1) {
				usi_cookies.set('usi_gb', 'true', usi_cookies.expire_time.day);
			} else if (usi_app.cart && usi_app.url.indexOf('en_ie') > -1) {
				usi_cookies.set('usi_ie', 'true', usi_cookies.expire_time.day);
			}
	
			if (usi_app.cart) {
				usi_app.check_products();
				usi_app.set_cart_data(usi_app.get_cart_data());
			}
	
			usi_app.load();
		};
	
		usi_app.check_products = function() {
			if (usi_app.gb_cart && usi_app.has_vive_product()) {
				usi_cookies.set('usi_can_launch', 'true', usi_cookies.expire_time.day);
			}
		};
	
		usi_app.get_cart_data = function() {
			var cartData = usi_app.get_new_cart();
			var cartItems = usi_dom.get_elements('.dr_oddRow, .dr_evenRow');
			if (usi_dom.get_elements('.dr_oddRow, .dr_evenRow').length > 0 && usi_dom.get_first_element('.cart-total .cart-price-col') != null) {
				var subtotal = usi_dom.get_first_element('.cart-total .cart-price-col').innerText.trim();
		
				cartItems.forEach(function(item) {
					var prod = {
						image: usi_dom.get_first_element('img', item).src,
						name: usi_dom.get_first_element('h4', item).innerText,
						price: usi_dom.get_first_element('.dr_price', item).innerText
					};
					if (prod.price.indexOf("\n")!= -1) {
						prod.price = prod.price.substring(prod.price.indexOf("\n"));
					}
					cartData.products.push(prod);
				});
		
				cartData.subtotal = subtotal;
			}
	
			return cartData;
		};
	
		usi_app.get_new_cart = function() {
			usi_commons.log('Retrieving new cart');
	
			return {
				subtotal: 0,
				products: []
			};
		};
	
		usi_app.set_cart_data = function(data) {
			usi_commons.log('Saving cart data...');
			usi_commons.log(data);
			usi_cookies.set('usi_cart', JSON.stringify(data), usi_cookies.expire_time.week);
		};
	
		// Have to store a cookie to differentiate
		// between different locales on store page
		usi_app.load = function() {
			if (usi_app.store_page && usi_app.visited_gb && usi_app.can_launch) {
				usi_commons.load_precapture('uYI9DC994dUIpwIEWiJDQWs', '19502');
			} else if (usi_app.store_page && usi_app.visited_ie && usi_app.can_launch) {
				usi_commons.load_precapture('i9DtlYINKWMHJ32OI4spDpw', '19500');
			}
		};
	
		// Only returns true if it is the only product
		usi_app.has_vive_product = function() {
			var hasViveProduct = false;
			var productImgs = usi_dom.get_elements('.cart-product-thumb');
	
			productImgs.forEach(function(image) {
				if (image.src.toLowerCase().indexOf('vive') != -1) {
					usi_commons.log('Vive found');
					hasViveProduct = true;
				}
			});
	
			return hasViveProduct;
		};
		usi_app.main();
	} catch(err) {
		usi_commons.report_error(err);
	}
}