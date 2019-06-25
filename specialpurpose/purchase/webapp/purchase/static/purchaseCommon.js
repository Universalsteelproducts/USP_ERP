/*
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
*/
Date.CultureInfo.formatPatterns.shortDate = "yyyy-MM-dd";

/**
 * emailFormat
 * 정규식 사용하여 이메일 check
 * @param options
 */
$.fn.emailFormat = function (options) {
	var filter = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	if(filter.test($(this).val())) {
		return true;
	} else {
		return false;
	}
}

/**
 * objectFormat
 * 정규식 사용하여 입력한 포멧만 허용
 * @param options -> format : Object type
 */
$.fn.objectFormat = function (options) {
	var params = $.extend({
        format: 'int',
        fixLeng : 0
    }, options);

	var filter, rep, reg;
	if(params.format == "int") {
		filter = /^-?\d*$/;
		reg = /^(-?)([0-9]*)([^0-9]*)([0-9]*)([^0-9]*)/;
		rep = "$1$2$4";
	} else if(params.format == "float") {
		filter = /^-?\d*[.,]?\d*$/;
		reg = /^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/;
		rep = "$1$2$3$5";
	} else if(params.format == "en") {
		filter = /^[a-zA-Z\s]+$/;
		reg = /[^a-zA-Z\s]+$/;
		rep = "";
	} else if(params.format == "sd") {
		filter = /^[a-zA-Z0-9\s]+$/;
		reg = /[^a-zA-Z0-9\s]+$/;
		rep = "";
	}

	if(filter != null && filter != "") {
		if(filter.test($(this).val().replace(/\,/g, ""))) {
			return true;
		} else {
			alert("Invalid Format");
			$(this).val($(this).val().replace(reg, rep));
			$(this).focus();
			return false;
		}
	}
}

/**
 * Number.prototype.format(n, x)
 *
 * @param integer n: length of decimal
 * @param integer x: length of sections
 */
Number.prototype.format = function(n, x) {
    var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
    return this.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
};

String.prototype.format = function(n, x) {
    var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
    return Number(this.replace(/\,/g, "")).toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
};

var checkNull = function(str) {
	if(str == null || str == undefined || str == "undefined" || str == "") {
		return "";
	} else {
		return str;
	}
};

var editPoInputInit = function(id) {
	$("#" + id + " :input").each(function() {
		if($(this).attr("name") != "lotNo") {
			if($(this).prop("type") == "select-one") {
				$(this).find("option:eq(0)").attr("selected", true);
				if($(this).attr("name") == "steelType") {
					$(this).trigger("change");
				}
			} else if($(this).prop("type") == "checkbox") {
				$(this).prop("checked", false);
			} else {
				if($(this).prop("type") != "button") {
					if($(this).attr("name") == "orderQuantity" || $(this).attr("name") == "unitPrice"
						|| $(this).attr("name") == "commissionUnitPrice" || $(this).attr("name") == "unitQuantity") {
						$(this).val("0");
					} else if($(this).attr("name") != "customerId") {
						$(this).val("");
					}
				}
			}
		}
	});
};

var inputInit = function(id) {
	$("#" + id + " :input").each(function() {
		if($(this).prop("type") == "select-one") {
			$(this).find("option:eq(0)").attr("selected", true);
		} else if($(this).prop("type") == "checkbox") {
			$(this).prop("checked", false);
		} else {
			if($(this).prop("type") != "button") {
				$(this).val("");
			}
		}
	});
};