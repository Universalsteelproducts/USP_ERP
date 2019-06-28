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

var makeArrayData = function(reqData) {
	var reqArray = new Array();
	for(var i=0 ; reqData.length > i ; i++) {
		var reqMap = new Object();
		var map = reqData[i];
		for(var key in map) {
			if(key != "undefined") {
				reqMap[key] = $.trim(map[key]);
			}
		}
		reqArray.push(reqMap);
	}

	return reqArray;
};

var totalPriceNQuantity = function(tableObj, totalQuantityId, totalPriceId) {
		var tableSize = tableObj.rows().data().length;
		var totalQuantity = 0;
		var totalPrice = 0;
		var groupUnitQuantity = 0;
		var lotNo = $("#lotCommonInfo #lotNo").val();
		var steelType = $("#lotCommonInfo #steelType").val();

		var totalQuantityUnit = "";
		var totalPriceUnit = "";

		if(tableSize > 0) {
			for(var i=0 ; tableSize > i ; i++) {
				var gridSteelType = tableObj.rows(i).data().pluck("steelType")[0];
				var gridLotNo = tableObj.rows(i).data().pluck("lotNo")[0];
//				var gridOrderQuantity = Number(tableObj.rows(i).data().pluck("orderQuantity")[0] >= 0 ? tableObj.rows(i).data().pluck("orderQuantity")[0] : 0);
				var gridUnitQuantity = Number(tableObj.rows(i).data().pluck("unitQuantity")[0] >= 0 ? tableObj.rows(i).data().pluck("unitQuantity")[0] : 0);
				var gridUnitPrice = parseFloat(tableObj.rows(i).data().pluck("unitPrice")[0] >= 0 ? tableObj.rows(i).data().pluck("unitPrice")[0] : 0);

				if(i == 0) {
					totalQuantityUnit = tableObj.rows(i).data().pluck("quantityUnit")[0];
					totalPriceUnit = tableObj.rows(i).data().pluck("priceUnit")[0];
				}

//				if(gridSteelType == "PPGL" || gridSteelType == "PPGI") {
					totalQuantity += gridUnitQuantity;

//					if(lotNo == gridLotNo) {
//						groupUnitQuantity += gridUnitQuantity;
//					}

					totalPrice += (gridUnitQuantity*gridUnitPrice);
//				} else {
//					totalQuantity += gridOrderQuantity;
//					totalPrice += (gridOrderQuantity*gridUnitPrice);
//				}
		}
		}

		$("#" + totalQuantityId).val(totalQuantity.format());
		$("#" + totalPriceId).val(totalPrice.format(2));
		$("#vendorNPoInfo #quantityUnit").val(totalQuantityUnit);
		$("#vendorNPoInfo #priceUnit").val(totalPriceUnit);

//		if(steelType == "PPGL" || steelType == "PPGI") {
//			$("#colspanTag #orderQuantity").val(groupUnitQuantity);
//		}
	};

var addRow = function(id, rowMap) {
	var tagTmp = "";
	$("#" + id + " :input").each(function() {
		if($(this).attr("name") != "commissionUnitPriceUnit" && $(this).attr("name") != "coilDesc") {
			if($(this).prop("type") == "checkbox") {
				if($(this).is(":checked")) {
					rowMap[$(this).attr("name")] = "Y";
				} else {
					rowMap[$(this).attr("name")] = "N";
				}
			} else {
				rowMap[$(this).attr("name")] = $(this).val();
			}
		}
	});

	rowMap["referenceSeq"] = "";
	var referenceNo = $("#vendorNPoInfo #poNo").val() + $("#lotCommonInfo #lotNo").val() + "00";
	rowMap["referenceNo"] = referenceNo;
	rowMap["ppglNo"] = "";
	rowMap["partialYN"] = "N";
	rowMap["partialNo"] = "00";
	rowMap["poStatus"] = "PE";

	var steelType = rowMap["steelType"];
//		if(steelType == "PPGL" || steelType == "PPGI") {
//			rowMap["orderQuantity"] = "0";
//		}

	return rowMap;
};

var generatePoNo = function() {
	var nowDate = new Date();
	var year = nowDate.getFullYear().toString().substr(-2);;
	var month = (1 + nowDate.getMonth());
	month = month >= 10 ? month : '0' + month;
	var day = nowDate.getDate();
	day = day >= 10 ? day : '0' + day;

	return (year + month + day + $("#vendorInitials").val());
};

// 체크박스 전체 선택
$("#allCheck").on("click", function(){
      if($("#allCheck").is(":checked")){
          $("input[name='selectedItem']").prop("checked", true);
      }else{
          $("input[name='selectedItem']").prop("checked", false);
      }
});

// 개별 체크박스 선택 시 전체 선택 체크 OR 체크해제
$("input:checkbox[name='selectedItem']").on("click", function() {
	var checkCnt = $("#lotColoList #selectedItem").size() - 1;
	var nonChkCnt = 0;

	if(checkCnt > 0) {
		for(var i=0 ; checkCnt > i ; i++) {
			if(!$("#lotColoList #selectedItem").eq(i).prop("checked")) {
				nonChkCnt++;
			}
		}

		if(nonChkCnt > 0) {
			$("input[name='allCheck']").prop("checked", false);
		} else {
			$("input[name='allCheck']").prop("checked", true);
		}
	}
});