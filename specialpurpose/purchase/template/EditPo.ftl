<#--
  total / orderquantity control 다시
  function 들 공통화 작업
-->
<#--
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
-->

<script type="text/javascript">
	$(function() {
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
	});

	jQuery(document).ready(function() {
		/***************************************************************************
	     ******************			Common Control				********************
	     ***************************************************************************/
		var checkNull = function(str) {
			if(str == null) {
				return "";
			} else {
				return str;
			}
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
	 				var gridOrderQuantity = parseFloat(tableObj.rows(i).data().pluck("orderQuantity")[0]);
	 				var gridUnitQuantity = parseFloat(tableObj.rows(i).data().pluck("unitQuantity")[0]);
	 				var gridUnitPrice = parseFloat(tableObj.rows(i).data().pluck("unitPrice")[0]);

	 				if(i == 0) {
	 					totalQuantityUnit = tableObj.rows(i).data().pluck("quantityUnit")[0];
	 					totalPriceUnit = tableObj.rows(i).data().pluck("priceUnit")[0];
	 				}

	 				if(gridSteelType == "PPGL" || gridSteelType == "PPGI") {
	 					totalQuantity += gridUnitQuantity;

 						if(lotNo == gridLotNo) {
							groupUnitQuantity += gridUnitQuantity;
						}
	 				} else {
	 					totalQuantity += gridOrderQuantity;
	 				}

	 				totalPrice += gridUnitPrice;
				}
	 		}

	 		$("#" + totalQuantityId).val(totalQuantity.format());
	 		$("#" + totalPriceId).val(totalPrice.format(2));
	 		$("#vendorNPoInfo #quantityUnit").val(totalQuantityUnit);
	 		$("#vendorNPoInfo #priceUnit").val(totalPriceUnit);

	 		if(steelType == "PPGL" || steelType == "PPGI") {
	 			$("#colspanTag #orderQuantity").val(groupUnitQuantity);
	 		}
	 	};

		var inputInit = function(id) {
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

		var addRow = function(id, rowMap) {
			var tagTmp = "";
			$("#" + id + " :input").each(function() {
				if($(this).attr("name") != "commissionUnitPriceUnit" && $(this).attr("name") != "orderQuantityUnit"
						&& $(this).attr("name") != "coilDesc") {
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
			if(steelType == "PPGL" || steelType == "PPGI") {
				rowMap["orderQuantity"] = "0";
			}

			return rowMap;
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

		/***************************************************************************
	     ******************				Init Table				********************
	     ***************************************************************************/
	    var poListTable = $("#lotColoList").DataTable({
			//dom: "Bfrtip",
			//dom : "frtip",
			dom : "lfrtip",
			processing : true,
			scrollY : true,
			scrollX : true,
			fixedHeader : true,
			ajax : {
				"type"	: "POST",
				"url"	: '<@ofbizUrl>CRUPoList</@ofbizUrl>',
				"data"	: function(d) {
					d.crudMode = $("#crudMode").val();
					d.poNo = $("#poNo").val();
				}
			},
			columns : [
	            {
					"data" : "lotNo",
					"render" : function ( data, type, row ) {
						return "LOT" + checkNull(data);
	  				},
	  				"width": "45px",
	  				"className" : "align-middle"
	            },
	            {
					"data" : "destination",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						var $select = $("<select></select>", {
							"id" : "destination",
							"value" : data
						});
						var $option = "<option value=''></option>";
					<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "DESTINATION">
						$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
							</#if>
						</#list>
					</#if>

						$select.append($option);
						$select.find("[value='" + data + "']").attr("selected", "selected");
						$select.attr("class", "destination");
						return $select.prop("outerHTML");
					},
	  				"width" : "150px"
	            },
	            {
					"data" : "steelType",//"coilDescription",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						var $select = $("<select></select>", {
							"id" : "steelType",
							"value" : data
						});
						var $option = "<option value=''></option>";
					<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "STEEL_TYPE">
						$option += "<option value='${codeInfo.code!}' data-desc='${codeInfo.attribute1!}'>${codeInfo.codeName!}</option>";
							</#if>
						</#list>
					</#if>

						$select.append($option);
						$select.find("[value='" + data + "']").attr("selected", "selected");
						$select.attr("class", "steelType");
						return $select.prop("outerHTML");
					},
	  				"width" : "70px"
	            },
	            {
	            	"data" : "grade",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "grade",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "GRADE">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
	            	</#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "grade");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "50px"
	            },
	            {
					"data" : "gradeDesc",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						return "<input type='text' id='gradeDesc' name='gradeDesc' value='" + data + "'/>";
					},
	  				"width" : "150px"
	            },
	            {
	            	"data" : "coatingWeight",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "coatingWeight",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
	            	<#if codeList??>
		            	<#list codeList as codeInfo>
			            	<#if codeInfo.codeGroup == "COATING_WEIGHT">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
			            	</#if>
		            	</#list>
	            	</#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "coatingWeight");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "90px"
	            },
	            {
					"data" : "coatingWeightDesc",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						return "<input type='text' id='coatingWeightDesc' name='coatingWeightDesc' value='" + data + "'/>";
					},
	  				"width" : "160px"
	            },
	            {
	            	"data" : "surfaceCoilType",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "surfaceCoilType",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "SURFACE_COIL_TYPE">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "surfaceCoilType");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "110px"
	            },
	            {
					"data" : "surfaceCoilTypeDesc",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						return "<input type='text' id='surfaceCoilTypeDesc' name='surfaceCoilTypeDesc' value='" + data + "'/>";
					},
	  				"width" : "160px"
	            },
	            {
	            	"data" : "gauge",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "gauge",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "GAUGE">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		           	 		</#if>
		            	</#list>
		           	</#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "gauge");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "50px"
	            },
	            {
	            	"data" : "gaugeUnit",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "gaugeUnit",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "GAUGE_UNIT">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "gaugeUnit");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "70px"
	            },
	            {
					"data" : "gaugeDesc",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						return "<input type='text' id='gaugeDesc' name='gaugeDesc' value='" + data + "'/>";
					},
	  				"width" : "150px"
	            },
	            {
	            	"data" : "width",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "width",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "WIDTH">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "width");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "50px"
	            },
	            {
					"data" : "widthDesc",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						return "<input type='text' id='widthDesc' name='widthDesc' value='" + data + "'/>";
					},
	  				"width" : "150px"
	            },
	            {
	            	"data" : "coilMaxWeight",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "coilMaxWeight",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "COIL_MAX_WEIGHT">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "coilMaxWeight");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
					"data" : "innerDiameter",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						return "<input type='text' id='innerDiameter' name='innerDiameter' value='" + data + "'/>";
					},
	  				"width" : "100px"
	            },
	            {
					"data" : "gaugeControlYield",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						return "<input type='text' id='gaugeControlYield' name='gaugeControlYield' value='" + data + "'/>";
					},
	  				"width" : "130px"
	            },
	            {
	            	"data" : "packaging",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "packaging",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PACKAGING">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "packaging");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "70px"
	            },
	            {
	            	"data" : "packagingDesc",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
	                	return "<input type='text' id='packagingDesc' name='packagingDesc' value='" + data + "'/>";
	                },
	  				"width" : "150px"
	            },
	            {
	            	"data" : "businessClass",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "businessClass",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "BUSINESS_CLASS">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "businessClass");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "90px"
	            },
	            {
					"data" : "customerName",
					"render": function ( data, type, row ) {
						return checkNull(data);
					},
	  				"width" : "250px"
	            },
	            {
	            	"data" : "otherDetail",
	                "render": function ( data, type, row ) {
	                	data = checkNull(data);
						return "<textarea name='otherDetail' id='otherDetail'>" + data + "</textarea>";
					},
	  				"width" : "170px"
	            },
	            {
	            	"data" : "barge",
	            	"className" : "dt-body-center",
	                "render": function ( data, type, row ) {
	                	data = checkNull(data);
						return "<input type='checkbox' name='barge' id='barge' value='" + data + "' />";
					},
	  				"width" : "50px"
	            },
	            {
	            	"data" : "orderQuantity",
	                "render": function ( data, type, row ) {
	                	if(data != null && data != "") {
	                		data =  Number(checkNull(data)).format();
	                	} else {
	                		data =  "";
	                	}
						return "<input type='text' id='orderQuantity' style='text-align:right;' name='orderQuantity' value='" + data + "'/>";
					},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "orderQuantityUnit",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "orderQuantityUnit",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "QUANTITY_UNIT">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	var unit = "";
		            	if(row.orderQuantityUnit == null || row.orderQuantityUnit == "") {
		            		unit = row.quantityUnit;
		            	} else {
		            		unit = row.orderQuantityUnit;
		            	}

		            	$select.append($option);
		            	$select.find("[value='" + unit + "']").attr("selected", "selected");
		            	$select.attr("class", "orderQuantityUnit");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "unitQuantity",
	                "render": function ( data, type, row ) {
	                	if(data != null && data != "") {
	                		data =  Number(checkNull(data)).format();
	                	} else {
	                		data =  "";
	                	}
						return "<input type='text' id='unitQuantity' style='text-align:right;' name='unitQuantity' value='" + data + "'/>";
					},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "quantityUnit",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "quantityUnit",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "QUANTITY_UNIT">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + row.quantityUnit + "']").attr("selected", "selected");
		            	$select.attr("class", "quantityUnit");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "unitPrice",
	                "render": function ( data, type, row ) {
	                	if(data != null && data != "") {
	                		data =  Number(checkNull(data)).format(2);
	                	} else {
	                		data =  "";
	                	}
						return "<input type='text' id='unitPrice' style='text-align:right;' name='unitPrice' value='" + data + "'/>";
					},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "priceUnit",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "priceUnit",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PRICE_UNIT">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + row.priceUnit + "']").attr("selected", "selected");
		            	$select.attr("class", "priceUnit");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "commissionUnitPrice",
	                "render": function ( data, type, row ) {
	                	if(data != null && data != "") {
	                		data =  Number(checkNull(data)).format(2);
	                	} else {
	                		data =  "";
	                	}
						return "<input type='text' id='commissionUnitPrice' style='text-align:right;' name='commissionUnitPrice' value='" + data + "'/>";
					},
	  				"width" : "130px"
	            },
	            {
	            	"data" : "commissionUnitPriceUnit",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "commissionUnitPriceUnit",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PRICE_UNIT">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + row.priceUnit + "']").attr("selected", "selected");
		            	$select.attr("class", "commissionUnitPriceUnit");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "160px"
	            },
	            {
	            	"data" : "paintBrand",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "paintBrand",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PAINT_BRAND">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "paintBrand");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "paintCode",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "paintCode",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PAINT_CODE">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "paintCode");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "paintColor",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "paintColor",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PAINT_COLOR">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "paintColor");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "paintCoatingThickness",
	                "render": function ( data, type, row ) {
	                	data = checkNull(data);
						return "<input type='text' id='paintCoatingThickness' name='paintCoatingThickness' value='" + data + "'/>";
					},
	  				"width" : "150px"
	            },
	            {
					"data" : "referenceSeq",
					"render": function ( data, type, row ) {
						return checkNull(data);
					},
					"visible": false
	            },
	            {
					"data" : "referenceNo",
					"render": function ( data, type, row ) {
						return checkNull(data);
					},
					"visible": false
	            },
	            {
					"data" : "ppglNo",
					"render": function ( data, type, row ) {
						return checkNull(data);
					},
					"visible": false
	            },
	            {
					"data" : "partialYN",
					"render": function ( data, type, row ) {
						return checkNull(data);
					},
					"visible": false
	            },
	            {
					"data" : "partialNo",
					"render": function ( data, type, row ) {
						return checkNull(data);
					},
					"visible": false
	            },
	            {
	            	"data" : "customerId",
	            	"render": function ( data, type, row ) {
						return checkNull(data);
					},
	            	"visible": false
	            }
			],
			rowCallback : function( row, data, displayNum, displayIndex, dataIndex ) {
				 $('input#barge', row).prop( 'checked', data.barge == "Y" );
			},
			drawCallback : function(settings) {
				totalPriceNQuantity(this.api(), "totalQuantity", "totalPoAmount");
			}
// 			buttons: [
// 				{
// 					text: 'Delete',
// 					fn: function() {
// 					},
// 					className: 'btn btn-primary'
// 			    }
// 			]
	    });

		// 그리드 Row 클릭 이벤트
		$('#lotColoList tbody').on( 'dblclick', 'tr', function () {
	        $(this).toggleClass('selected');
	    } );

		// 그리드 Column 클릭 이벤트
		$("#lotColoList tbody").on( 'click', 'td', function () {
		    var idx = poListTable.cell( this ).index().column;
		    var title = poListTable.column( idx ).header();
			if(idx == 22) {
				var checkYN = $(this).find(":input").prop("checked");
				if(checkYN) {
					poListTable.cell( this ).data("Y").draw();
				} else {
					poListTable.cell( this ).data("N").draw();
				}
		    }
		} );

		// column value update
		$("#lotColoList").on("change", ":input,textarea,select,check", function() {
// 			var colIdx = poListTable.cell( $(this).parent() ).index().column;
// 			var rowIdx = poListTable.cell( $(this).parent() ).index().row;
			poListTable.cell( $(this).parent() ).data($(this).val()).draw();
		});

	    /***************************************************************************
	     ******************			InputBox Control			********************
	     ***************************************************************************/

	    /***************************************************************************
	     ******************			SelectBox Control			********************
	     ***************************************************************************/
	    $("#lotCommonInfo #steelType").on("change", function() {
			$("#coilDesc").val($(this).find(":selected").data("desc"));

			if($(this).val() == "PPGL" || $(this).val() == "PPGI") {
				$("#hideTag1,#hideTag2,#hideTag3,#hideTag4,#hideTag5,#hideTag6").hide();
				$("#lotCommonInfo #orderQuantity").attr("disabled", true);
				$("#lotCommonInfo #orderQuantity").val("0");
				$("#lotCommonInfo #orderQuantityUnit").attr("disabled", true);
				$("#lotCommonInfo #orderQuantityUnit").val("").attr("selected", true).trigger("change");
				$("#colspanTag").attr("colspan", "4");
				$("#colorDetail").show();

				$("#lotCommonInfo #coilDesc").attr("disabled", true);
			} else {
				$("#hideTag1,#hideTag2,#hideTag3,#hideTag4,#hideTag5,#hideTag6").show();
				$("#lotCommonInfo #orderQuantity").attr("disabled", false);
				$("#lotCommonInfo #orderQuantity").val("0");
				$("#lotCommonInfo #orderQuantityUnit").attr("disabled", false);
				$("#lotCommonInfo #orderQuantityUnit").val("").attr("selected", true).trigger("change");
				$("#colspanTag").attr("colspan", "");
				$("#colorDetail").hide();

				if($(this).val() == "OTHER") {
					$("#lotCommonInfo #coilDesc").attr("disabled", false);
				} else {
					$("#lotCommonInfo #coilDesc").attr("disabled", true);
				}
			}
		});

	    $("#lotCommonInfo #orderQuantityUnit,#lotCommonInfo #priceUnit,#colorDetail #quantityUnit").on("change", function() {
			$("#vendorNPoInfo select[name$=uantityUnit]").val($(this).val()).attr("selected", true);
			$("#lotCommonInfo select[name$=uantityUnit]").val($(this).val()).attr("selected", true);
			$("#colorDetail select[name$=uantityUnit]").val($(this).val()).attr("selected", true);
			$("#vendorNPoInfo select[name$=riceUnit]").val($(this).val()).attr("selected", true);
			$("#lotCommonInfo select[name$=riceUnit]").val($(this).val()).attr("selected", true);
			$("#colorDetail select[name$=riceUnit]").val($(this).val()).attr("selected", true);
		});

	    $("#lotCommonInfo #grade,#coatingWeight,#surfaceCoilType,#gauge,#width,#packaging").on("change", function() {
			var id = $(this).attr("id");

			if($(this).val() == "OTHER") {
				if(id == "grade") {
					$("#lotCommonInfo #gradeDesc").attr("disabled", false);
					$("#lotCommonInfo #gradeDesc").focus();
				} else if(id == "coatingWeight") {
					$("#lotCommonInfo #coatingWeightDesc").attr("disabled", false);
					$("#lotCommonInfo #coatingWeightDesc").focus();
				} else if(id == "surfaceCoilType") {
					$("#lotCommonInfo #surfaceCoilTypeDesc").attr("disabled", false);
					$("#lotCommonInfo #surfaceCoilTypeDesc").focus();
				} else if(id == "gauge") {
					$("#lotCommonInfo #gaugeDesc").attr("disabled", false);
					$("#lotCommonInfo #gaugeDesc").focus();
				} else if(id == "width") {
					$("#lotCommonInfo #widthDesc").attr("disabled", false);
					$("#lotCommonInfo #widthDesc").focus();
				} else if(id == "packaging") {
					$("#lotCommonInfo #packagingDesc").attr("disabled", false);
					$("#lotCommonInfo #packagingDesc").focus();
				}
			} else {
				if(id == "grade") {
					$("#lotCommonInfo #gradeDesc").val("");
					$("#lotCommonInfo #gradeDesc").attr("disabled", true);
				} else if(id == "coatingWeight") {
					$("#lotCommonInfo #coatingWeightDesc").val("");
					$("#lotCommonInfo #coatingWeightDesc").attr("disabled", true);
				} else if(id == "surfaceCoilType") {
					$("#lotCommonInfo #surfaceCoilTypeDesc").val("");
					$("#lotCommonInfo #surfaceCoilTypeDesc").attr("disabled", true);
				} else if(id == "gauge") {
					$("#lotCommonInfo #gaugeDesc").val("");
					$("#lotCommonInfo #gaugeDesc").attr("disabled", true);
				} else if(id == "width") {
					$("#lotCommonInfo #widthDesc").val("");
					$("#lotCommonInfo #widthDesc").attr("disabled", true);
				} else if(id == "packaging") {
					$("#lotCommonInfo #packagingDesc").val("");
					$("#lotCommonInfo #packagingDesc").attr("disabled", true);
				}
			}

			if($("#lotCommonInfo #coatingWeight").val()=="G90" && $("#lotCommonInfo #gauge").val()=="18" && $("#lotCommonInfo #width").val()=="43") {
				$("#lotCommonInfo #gaugeControlYield").val("test");
			} else {
				$("#lotCommonInfo #gaugeControlYield").val("");
			}
		});

	    // vendor Id 변경시 실행
	    $("input[name=vendorId]").on("change lookup:changed", function() {
		    var vendorId = $(this).val();

		    jQuery.ajax({
		    	url: '<@ofbizUrl>/searchVendor</@ofbizUrl>',
		    	type: 'POST',
		    	data: {"vendorId" : vendorId},
		    	error: function(msg) {
		    		showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
		    	},
		    	success: function(data) {
			    	$.each(data.vendorInfo, function(index, value) {
				    	if(index == "remark") {
				    		$("#vendorNPoInfo #remark").val(value);
				    	} else {
					    	$("input[name=" + index + "]").val(value);
					    	$("input[name=" + index + "]").effect("highlight", {}, 3000);
				    	}
			    	});

			    	var nowDate = new Date();
			    	var year = nowDate.getFullYear().toString().substr(-2);;
			    	var month = (1 + nowDate.getMonth());
			    	month = month >= 10 ? month : '0' + month;
			    	var day = nowDate.getDate();
			    	day = day >= 10 ? day : '0' + day;

			    	var poNo = year + month + day + $("#vendorInitials").val();
			    	$("#vendorNPoInfo #poNo").val(poNo);
		    	}
	    	});
		});

	 	// customer Id 변경시 실행
	    $("input[name=customerId]").on("change lookup:changed", function() {
		    var customerId = $(this).val();

		    jQuery.ajax({
		    	url: '<@ofbizUrl>/searchCustomer</@ofbizUrl>',
		    	type: 'POST',
		    	data: {"customerId" : customerId},
		    	error: function(msg) {
		    		showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
		    	},
		    	success: function(data) {
			    	$("input[name=customerName]").val(data.customerInfo.customerName);
		    	}
	    	});
		});

	    $("#lotCommonInfo #lotNo").on("change", function() {
	    	var lotNo = $(this).val();
	    	if($(this).val() == "") {
	    		inputInit("lotCommonInfo");
	    	} else {
		    	var trCnt = $("#lotColoList tbody tr").size()/2;
		    	var headTrCnt = 2;
		    	var lotCommonInfo;
		    	var trId = "";
		    	if(trCnt > 0) {
			    	inputInit("lotCommonInfo");
			    	$(this).val( lotNo ).prop("selected", "selected");

			    	for(var i=0 ; trCnt > i ; i++) {
				    	if($("#lotColoList tbody tr").eq(i*2).find("#lotNo").val() == lotNo) {
					    	trId = $("#lotColoList tbody tr").eq(i*2).attr("id");
					    	trId = trId.substring(0, (trId.lastIndexOf("_")+1));
					    	break;
				    	}
			    	}

			    	for(var j=0 ; headTrCnt > j ; j++) {
				    	$("#" + trId + (j+1) + " :input").each(function() {
					    	if($("#lotCommonInfo input[name=" + $(this).attr("name") + "]")) {
						    	if($(this).prop("type") == "checkbox") {
							    	if($(this).prop("checked")) {
							    		$("#lotCommonInfo input[name=" + $(this).attr("name") + "]").prop("checked", true).val("Y");
							    	} else {
							    		$("#lotCommonInfo input[name=" + $(this).attr("name") + "]").prop("checked", false).val("N");
							    	}
						    	} else if($(this).prop("type") == "select-one") {
							    	$("#lotCommonInfo select[name=" + $(this).attr("name") + "]").val( $(this).val() ).prop("selected", "selected");
							    	if($(this).attr("name") == "steelType") {
							    		$("#lotCommonInfo select[name=" + $(this).attr("name") + "]").trigger("change");
							    	}
						    	} else {
							    	if($(this).attr("name") == "unitPrice" || $(this).attr("name") == "orderQuantity"
							    		|| $(this).attr("name") == "unitQuantity" || $(this).attr("name") == "commissionUnitPrice" ) {
								    	if($(this).val() >= 0) {
								    		$("#lotCommonInfo input[name=" + $(this).attr("name") + "]").val( $(this).val() );
								    	} else {
								    		$("#lotCommonInfo input[name=" + $(this).attr("name") + "]").val( "0" );
								    	}
							    	} else {
								    	if($(this).attr("name") == "lotNo") {
								    		$("#lotCommonInfo select[name=" + $(this).attr("name") + "]").val( $(this).val() ).prop("selected", "selected");
								    	} else {
								    		$("#lotCommonInfo input[name=" + $(this).attr("name") + "]").val( $(this).val() );
								    	}
							    	}
						    	}
					    	}
				    	});
			    	}
			    	totalPriceNQuantity(poListTable, "totalQuantity", "totalPoAmount");
		    	} else {
			    	inputInit("lotCommonInfo");
			    	$(this).val( lotNo ).prop("selected", "selected");
		    	}
	    	}
	    });

	    /***************************************************************************
	     ******************				Button Control			********************
	     ***************************************************************************/
		$("#addLot").on("click", function() {
			var lotIdx = $("#lotNo option").size();
			lotIdx = lotIdx >= 10 ? lotIdx : '0' + lotIdx;
			$("#lotCommonInfo #lotNo").append("<option value='" + lotIdx + "'>LOT" + lotIdx + "</option>");

			inputInit("lotCommonInfo");
			inputInit("colorDetail");

			$("#lotCommonInfo #lotNo option:eq(" + lotIdx + ")").attr("selected", true);
	    });

	    $("#addColor").on("click", function() {
	    	if($("input[name=vendorId]").val() == null || $("input[name=vendorId]").val() == "") {
				alert("Select Vendor");
				return false;
			}

			if($("#vendorNPoInfo #poNo").val() == null || $("#vendorNPoInfo #poNo").val() == "") {
				alert("Select Vendor");
				return false;
			}

			if($("#lotCommonInfo #lotNo").val() == "") {
				alert("Select LOT");
				return false;
			}

			var steelType = $("#lotCommonInfo #steelType").val();

			var rowMap = new Object();

			if(steelType == "PPGL" || steelType == "PPGI") {
				rowMap = addRow("lotCommonInfo", rowMap);
				rowMap["orderQuantity"] = "";
				rowMap = addRow("colorDetail", rowMap);
				inputInit("colorDetail");
			} else {
				rowMap = addRow("lotCommonInfo", rowMap);
				inputInit("colorDetail");
				var unit = rowMap["priceUnit"];
				rowMap = addRow("colorDetail", rowMap);
				rowMap["quantityUnit"] = unit;
				rowMap["priceUnit"] = unit;
			}

			poListTable.row.add(rowMap).columns.adjust().draw();

			var index = 0,
	        rowCount = poListTable.data().length-1,
	        insertedRow = poListTable.row(rowCount).data(),
	        tempRow;

		    for (var i=rowCount;i>index;i--) {
		        tempRow = poListTable.row(i-1).data();
		        poListTable.row(i).data(tempRow);
		        poListTable.row(i-1).data(insertedRow);
		    }
		    //refresh the page
		    poListTable.page(0).draw(false);

			totalPriceNQuantity(poListTable, "totalQuantity", "totalPoAmount");
	    });

	    $("#deleteRow").on("click", function() {
	    	var selectRow = poListTable.rows( '.selected' ).indexes();
	    	var selectRowData = poListTable.rows( '.selected' ).data();
	    	if(selectRowData.length > 0) {
		    	poListTable.rows(selectRow).remove().draw();
		    	var reqArray = makeArrayData(selectRowData);

		    	jQuery.ajax({
		    		url: '<@ofbizUrl>CRUPoList</@ofbizUrl>',
		    		type: 'POST',
		    		data: {
						"crudMode" : "D",
						"reqData" : JSON.stringify(reqArray)
					},
			    	error: function(msg) {
			    		showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
		    		},
		    		success: function(data, status) {
						if(data.successStr == "success") {
							alert("PO Delete Completed");
						}
		    		}
		    	});
	    	}
	    });

	    $("#partial").on("click", function() {

// 	    	var index = poListTable.row(this).index(),
// 	        rowCount = poListTable.data().length-1,
// 	        insertedRow = poListTable.row(rowCount).data(),
// 	        tempRow;

// 		    for (var i=rowCount;i>index;i--) {
// 		        tempRow = poListTable.row(i-1).data();
// 		        poListTable.row(i).data(tempRow);
// 		        poListTable.row(i-1).data(insertedRow);
// 		    }
// 		    //refresh the page
// 		    poListTable.page(0).draw(false);

// 			var colIdx = poListTable.cell( $(this).parent() ).index().column;
// 			var rowIdx = poListTable.cell( $(this).parent() ).index().row;
// 			["referenceNo"] = referenceNo;
// 			rowMap["ppglNo"] = "";
// 			rowMap["partialYN"] = "N";
// 			rowMap["partialNo"] = "00";

			var poNo = $("#poNo").val();
			var lotNo = $("#lotList").val();
			poListTable.rows().every( function ( rowIdx, tableLoop, rowLoop ) {
				var newDataMap = new Object();
			    var data = this.data();
			    var currLotNo = data["lotNo"];

			    if(lotNo == currLotNo) {
				    for(var key in data) {
						if(key != "undefined") {
							if(key == "lotNo") {
								var orgLotNo = $.trim(currLotNo) + "-01";
								var partialLotNo = $.trim(currLotNo) + "-02";
								data[key] = $.trim(orgLotNo);
								newDataMap[key] = $.trim(partialLotNo);
							} else if(key == "partialYN") {
								data[key] = $.trim("Y");
								newDataMap[key] = $.trim("N");
							} else if(key == "partialNo") {
								data[key] = "01";
								newDataMap[key] = "02";
							} else if(key == "referenceNo") {
								var orgReferenceNo = poNo + $.trim(currLotNo) + "01";
								var partialReferenceNo = $.trim(currLotNo) + "02";
								data[key] = $.trim(orgReferenceNo);
								newDataMap[key] = $.trim(partialReferenceNo);
							}  else if(key == "orderQuantity") {
								var steeltype = data["steeltype"];
								if(steeltype != "PPGL" && steeltype != "PPGI") {
									var orderQuantity = parseFloat(data["orderQuantity"]);
									if(orderQuantity > 0) {
										data[key] = orderQuantity / 2;
									}
								}
							} else {
								data[key] = $.trim(data[key]);
								newDataMap[key] = $.trim(data[key]);
							}
						}
					}

				    this.data(data);
				    poListTable.row.add(newDataMap).columns.adjust().draw();
			    }
			});
	    });

	    $("#submitBtn").on("click", function() {
	    	var reqData = poListTable.rows().data();
	    	var reqArray = makeArrayData(reqData);

	    	var crudMode = $("#crudMode").val();
			if(crudMode == "CR") {
				mode = "C";
			} else if(crudMode == "UR") {
				mode = "U";
			}

			jQuery.ajax({
	    		url: '<@ofbizUrl>CRUPoList</@ofbizUrl>',
	    		type: 'POST',
	    		data: $("#vendorNPoInfo").serialize() + "&crudMode=" + mode + "&reqData=" + JSON.stringify(reqArray),
		    	error: function(msg) {
		    		showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
	    		},
	    		success: function(data, status) {
					if(status == "success") {
						alert("PO Update Completed");
					}
	    		}
	    	});
	    });

	    $("#cancelBtn").on("click", function() {
			jQuery.ajax({
		        url: '<@ofbizUrl>RUPoList</@ofbizUrl>',
		        type: 'POST',
		        data: {
					"crudMode" : "SU",
					"reqData" : JSON.stringify([{"poNo" : "${poNo!}", "poStatus" : "CC"}])
				},
		        async: false,
				error: function(msg) {
					showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
	            },
				success: function(data, status) {
					if(status == "success") {
						alert("PO Cancel Completed");
					}
				}
			});
	    });

	    $("#allClear").on("click", function() {
			inputInit("vendorNPoInfo");
			inputInit("lotCommonInfo");

			$("#referenceForm").children().remove();
			$("#lotColoList tbody").children().remove();
	    });
	});
</script>

<input type="hidden" name="crudMode" id="crudMode" value="${crudMode}"/>

<form name="vendorNPoInfo" id="vendorNPoInfo">
	<!-- Vendor Info -->
	<div>
		<ul align="right">
		<#if crudMode == "UR">
			<label class="label">
				Issue Date : ${poCommonInfo.createdStamp!?string("yyyy-MM-dd")},
				Last Updated Date : ${poCommonInfo.lastUpdatedStamp!?string("yyyy-MM-dd")}
			</label>
		<#else>
			<input id="allClear" type="button" value="${uiLabelMap.allClear}" class="buttontext"/>
		</#if>
		</ul>
	</div>
	<br />
	<div class="screenlet">
		<!-- Vendor Info -->
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">${uiLabelMap.vendor}</li>
			</ul>
			<br class="clear"/>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
					<td class="label" width="13%" align="right" >
						${uiLabelMap.vendor}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<!-- set_multivalues -->
						<@htmlTemplate.lookupField value="${poCommonInfo.vendorId!}" formName="vendorNPoInfo" name="vendorId" id="vendorId" fieldFormName="LookupVendor" position="center" />
						<input type="hidden" name="vendorInitials" id="vendorInitials" value="${poCommonInfo.vendorInitials!}" size="25" maxlength="255"/>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.orderDate}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<@htmlTemplate.renderDateTimeField name="orderDate" event="" action="" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" value="${poCommonInfo.orderDate!}" size="25" maxlength="50" id="orderDate" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.vendorAddr}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="vendorAddr" id="vendorAddr" value="${poCommonInfo.vendorAddr!}" size="60" maxlength="255"/>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.priceTerm}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="priceTerm" value="${poCommonInfo.priceTerm!}" size="25" maxlength="255"/>
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.email}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="vendorEmail" id="vendorEmail" value="${poCommonInfo.vendorEmail!}" size="25" maxlength="255"/>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.freightTerm}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="freightTerm" value="${poCommonInfo.freightTerm!}" size="25" maxlength="255"/>
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.tel}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="vendorTel" id="vendorTel" value="${poCommonInfo.vendorTel!}" size="25" maxlength="255"/>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.paymentTerm}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="paymentTerm" value="${poCommonInfo.paymentTerm!}" size="25" maxlength="255"/>
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.fax}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="vendorFax" id="vendorFax" value="${poCommonInfo.vendorFax!}" size="25" maxlength="255"/>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.downPayment}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						$ <input type="text" name="downPayment" value="${poCommonInfo.downPayment?default('0')}" size="23" maxlength="255" style="text-align:right;" />
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.remark}
					</td>
					<td width="2%">&nbsp;</td>
					<td colspan="4">
						<textarea name="remark" id="remark" rows="3">${poCommonInfo.remark!}</textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- PO Info -->
	<div class="screenlet">
		<!-- PO Info -->
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">
					${uiLabelMap.poInfo}
				</li>
			</ul>
			<br class="clear"/>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.poNo}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="35%" colspan="4">
						<input type="text" name="poNo" id="poNo" size="25" maxlength="255" value="${poNo!}" style="background-color:#EEEEEE;" readonly="readonly" />
					<#if crudMode == "R">
						<input type="hidden" name="poStatus" id="poStatus" value="PE" />
					<#else>
						<input type="hidden" name="poStatus" id="poStatus" value="${poCommonInfo.poStatus!}"/>
					</#if>
					</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.shipmentMonth}
					</td>
					<td width="1%">&nbsp;</td>
					<td colspan="4">
						<input type="text" name="shipmentMonth" value="${poCommonInfo.shipmentMonth!}" size="25" maxlength="255"/>
					</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.totalQuantity}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="totalQuantity" id="totalQuantity" value="${totalQuantity?default('0')}" style="text-align:right;background-color:#EEEEEE;" readonly="readonly" />
						<select name="quantityUnit" id="quantityUnit" disabled="disabled">
							<option value=""></option>
						<#if codeList??>
							<#list codeList as codeInfo>
								<#if codeInfo.codeGroup == "QUANTITY_UNIT">
							<option value="${codeInfo.code!}" <#if codeInfo.code == totalQuantityUnit! >selected="selected"</#if>>${codeInfo.codeName!}</option>
								</#if>
							</#list>
						</#if>
						</select>
					</td>
					<td class="label" width="12%" align="right">
						${uiLabelMap.totalPoAmount}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="totalPoAmount" id="totalPoAmount" value="${totalPrice?default('0')}" style="text-align:right;background-color:#EEEEEE;" readonly="readonly" />
						<select name="priceUnit" id="priceUnit" disabled="disabled">
							<option value=""></option>
						<#if codeList??>
							<#list codeList as codeInfo>
								<#if codeInfo.codeGroup == "PRICE_UNIT">
							<option value="${codeInfo.code!}" <#if codeInfo.code == totalPriceUnit! >selected="selected"</#if>>${codeInfo.codeName!}</option>
								</#if>
							</#list>
						</#if>
						</select>
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.internalNote}
					</td>
					<td width="2%">&nbsp;</td>
					<td colspan="4">
						<textarea name="internalNote" id="internalNote" rows="3">${poCommonInfo.internalNote!}</textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>

<!-- LOT Info -->
<div class="screenlet">
	<!-- PO Info -->
	<div class="screenlet-title-bar">
		<ul>
			<li class="h3">
				${uiLabelMap.lotInfo}
			</li>
		</ul>
		<br class="clear"/>
	</div>
	<div class="screenlet-body">
	<#if crudMode == "CR">
		<table class="basic-table" cellspacing="0" id="lotCommonInfo">
			<tr>
				<td class="label" width="12%" align="right">
					${uiLabelMap.lot}
				</td>
				<td width="1%"></td>
				<td colspan="7">
					<select name="lotNo" id="lotNo" size="1">
						<option value="">--Select</option>
						<option value="01">LOT01</option>
					</select>
					<input type="button" id="addLot" value="${uiLabelMap.addLot}" class="buttontext" />
				</td>
			</tr>
			<tr>
				<td class="label" width="12%" align="right">
					${uiLabelMap.destination}
				</td>
				<td width="1%">&nbsp;</td>
				<td width="20%">
					<select name="destination" id="destination">
						<option value="">--Select</option>
					<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "DESTINATION">
						<option value="${codeInfo.code!}" data-desc="${codeInfo.attribute1!}">${codeInfo.destination!}</option>
							</#if>
						</#list>
					</#if>
					</select>
				</td>
				<td class="label" width="12%" align="right">
					${uiLabelMap.steelType}
				</td>
				<td width="1%">&nbsp;</td>
				<td colspan="4">
					<select name=steelType id="steelType" style="width:19%;">
						<option value="">--Select</option>
					<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "STEEL_TYPE">
						<option value="${codeInfo.code!}" data-desc="${codeInfo.attribute1!}">${codeInfo.codeName!}</option>
							</#if>
						</#list>
					</#if>
					</select>
					<input type="text" id="coilDesc" name="coilDesc" value="" style="width:80%;" disabled="disabled" />
				</td>
			</tr>
			<tr>
				<td class="label" width="12%" align="right">
					${uiLabelMap.coilSpec}
				</td>
				<td width="1%">&nbsp;</td>
				<td colspan="7">
					<div>
						<ul>
							<select name="grade" id="grade" style="width:20%;">
								<option value="">--GRADE</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "GRADE">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
							<select name="coatingWeight" id="coatingWeight" style="width:20%;">
								<option value="">--COATING WEIGHT</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "COATING_WEIGHT">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
							<select name="surfaceCoilType" id="surfaceCoilType" style="width:20%;">
								<option value="">--SURFACE TYPE</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "SURFACE_COIL_TYPE">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
							<select name="gauge" id="gauge" style="width:15%;">
								<option value="">--GAUGE</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "GAUGE">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
							<select name="gaugeUnit" id="gaugeUnit" style="width:5%;">
								<option value="">--GAUGE</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "GAUGE_UNIT">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
							<select name="width" id="width" style="width:18%;">
								<option value="">--WIDTH</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "WIDHT">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
						</ul>
						<ul>
							<input type="text" name="gradeDesc" id="gradeDesc" style="width:20%;" disabled="disabled"/>
							<input type="text" name="coatingWeightDesc" id="coatingWeightDesc" style="width:20%;" disabled="disabled"/>
							<input type="text" name="surfaceCoilTypeDesc" id="surfaceCoilTypeDesc" style="width:20%;" disabled="disabled"/>
							<input type="text" name="gaugeDesc" id="gaugeDesc" style="width:20.3%;" disabled="disabled"/>
							<input type="text" name="widthDesc" id="widthDesc" style="width:18%;" disabled="disabled"/>
						</ul>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label" width="12%" align="right">
					${uiLabelMap.coilMaxWeight}
				</td>
				<td width="1%">&nbsp;</td>
				<td width="20%">
					<select name="coilMaxWeight" id="coilMaxWeight">
						<option value="">--Selecet</option>
					<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "COIL_MAXWEIGHT">
						<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
							</#if>
						</#list>
					</#if>
					</select>
				</td>
				<td class="label" width="12%" align="right">
					${uiLabelMap.coilId}
				</td>
				<td width="1%">&nbsp;</td>
				<td width="20%">
					<input type="text" name="innerDiameter" id="innerDiameter" value="" size="25" maxlength="255"/>
				</td>
				<td class="label" width="12%" align="right">
					${uiLabelMap.gaugeControlYield}
				</td>
				<td width="1%">&nbsp;</td>
				<td width="20%">
					<input type="text" name="gaugeControlYield" id="gaugeControlYield" value="" size="25" maxlength="255" style="background-color:#EEEEEE;" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<td class="label" width="12%" align="right">
					${uiLabelMap.packaging}
				</td>
				<td width="1%">&nbsp;</td>
				<td colspan="4">
					<select name="packaging" id="packaging" style="width:30%;">
						<option value="">--Select</option>
					<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "PACKAGING">
						<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
							</#if>
						</#list>
					</#if>
					</select>
					<input type="text" name="packagingDesc" id="packagingDesc" value="" style="width:69%;" size="25" maxlength="255" disabled="disabled"/>
				</td>
				<td class="label" width="12%" align="right">
					${uiLabelMap.barge}
				</td>
				<td width="1%">&nbsp;</td>
				<td width="20%">
					<input type="checkbox" id="barge" name="barge" value="Y">
				</td>
			</tr>
			<tr>
				<td class="label" width="12%" align="right">
					${uiLabelMap.businessClass}
				</td>
				<td width="1%">&nbsp;</td>
				<td width="20%">
					<select name="businessClass" id="businessClass">
						<option value="">--Select</option>
					<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "BUSINESS_CLASS">
						<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
							</#if>
						</#list>
					</#if>
					</select>
				</td>
				<td class="label" width="12%" align="right">
					${uiLabelMap.customer}
				</td>
				<td width="1%">&nbsp;</td>
				<td width="20%">
					<form name="customerForm" id="customerForm">
						<@htmlTemplate.lookupField value="" formName="customerForm" name="customerId" id="customerId" fieldFormName="LookupCustomer" position="center" />
					</form>
					<input type="hidden" id="customerName" name="customerName" value="">
				</td>
				<td class="label" width="12%" align="right">&nbsp;</td>
				<td width="1%">&nbsp;</td>
				<td width="20%">&nbsp;</td>
			</tr>
			<tr>
				<td class="label" width="12%" align="right">
					${uiLabelMap.otherDetails}
				</td>
				<td width="1%">&nbsp;</td>
				<td colspan="7">
					<textarea name="otherDetail" id="otherDetail" rows="3"></textarea>
				</td>
			</tr>
			<tr id="giglTag">
				<td class="label" width="12%" align="right">
					${uiLabelMap.orderQuantity}
				</td>
				<td width="1%">&nbsp;</td>
				<td width="20%"  id="colspanTag">
					<input type="text" name="orderQuantity" id="orderQuantity" value="0" style="text-align:right;" size="25" maxlength="255"/>
					<select name="orderQuantityUnit" id="orderQuantityUnit" size="1">
						<option value="">--Select</option>
					<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "QUANTITY_UNIT">
						<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
							</#if>
						</#list>
					</#if>
					</select>
				</td>
				<td class="label" width="12%" align="right" id="hideTag1">
					${uiLabelMap.unitPrice}
				</td>
				<td width="1%" id="hideTag2">&nbsp;</td>
				<td width="20%" id="hideTag3">
					<input type="text" name="unitPrice" id="unitPrice" value="0" size="25" maxlength="255" style="text-align:right;" />
					<select name="priceUnit" id="priceUnit" size="1">
						<option value="">--Select</option>
					<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "PRICE_UNIT">
						<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
							</#if>
						</#list>
					</#if>
					</select>
				</td>
				<td class="label" width="12%" align="right" id="hideTag4">
					${uiLabelMap.commissionUnitPrice}
				</td>
				<td width="1%" id="hideTag5">&nbsp;</td>
				<td id="hideTag6">
					<input type="text" name="commissionUnitPrice" id="commissionUnitPrice" value="0" style="text-align:right;" "size="25" maxlength="255"/>
					<select name="commissionUnitPriceUnit" id="commissionUnitPriceUnit" size="1" disabled="disabled">
						<option value="">--Select</option>
					<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "PRICE_UNIT">
						<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
							</#if>
						</#list>
					</#if>
					</select>
				</td>
			</tr>
		</table>
		<hr />
	</#if>
		<div>
		<#if crudMode == "CR">
			<ul style="display:none;" id="colorDetail">
				<table class="basic-table" cellspacing="0">
					<tr>
						<td class="label" width="12%" align="right">
							${uiLabelMap.paintBrand}
						</td>
						<td width="1%">&nbsp;</td>
						<td width="20%">
							<select name="paintBrand">
								<option value="">--Select</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "PAINT_BRAND">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
						</td>
						<td class="label" width="12%" align="right">
							${uiLabelMap.paintCode}
						</td>
						<td width="1%">&nbsp;</td>
						<td width="20%">
							<select name="paintCode">
								<option value="">--Select</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "PAINT_CODE">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
						</td>
						<td class="label" width="12%" align="right">
							${uiLabelMap.paintColor}
						</td>
						<td width="1%">&nbsp;</td>
						<td width="20%">
							<select name="paintColor">
								<option value="">--Select</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "PAINT_COLOR">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
						</td>
					</tr>
					<tr>
						<td class="label" width="12%" align="right">
							${uiLabelMap.paintCoatingThickness}
						</td>
						<td width="1%">&nbsp;</td>
						<td colspan="7">
							<input type="text" name="paintCoatingThickness" value="" style="width:99%;" size="25" maxlength="255"/>
						</td>
					</tr>
					<tr>
						<td class="label" width="12%" align="right">
							${uiLabelMap.unitQuantity}
						</td>
						<td width="1%">&nbsp;</td>
						<td width="20%">
							<input type="text" name="unitQuantity" value="0" size="25" maxlength="255" style="text-align:right;" />
							<select name="quantityUnit" id="quantityUnit" size="1">
								<option value="">--Select</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "QUANTITY_UNIT">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
						</td>
						<td class="label" width="12%" align="right">
							${uiLabelMap.unitPrice}
						</td>
						<td width="1%">&nbsp;</td>
						<td width="20%">
							<input type="text" name="unitPrice" value="0" size="25" maxlength="255" style="text-align:right;" />
							<select name="priceUnit" id="priceUnit" size="1">
								<option value="">--Select</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "PRICE_UNIT">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
						</td>
						<td class="label" width="12%" align="right">
							${uiLabelMap.commissionUnitPrice}
						</td>
						<td width="1%">&nbsp;</td>
						<td>
							<input type="text" name="commissionUnitPrice" id="commissionUnitPrice" value="0" style="text-align:right;" size="25" maxlength="255"/>
						</td>
					</tr>
				</table>
			</ul>
			<ul>
				<table class="basic-table" cellspacing="0">
					<tr>
						<td class="label" style="width:87px;" align="right">&nbsp;</td>
						<td width="1%">&nbsp;</td>
						<td colspan="7">
							<input type="button" id="addColor" value="&dArr;&dArr;&dArr;&dArr;&dArr;&dArr;&dArr;&dArr;" class="buttontext" />
						</td>
					</tr>
				</table>
			</ul>
			<hr />
		</#if>
	    </div>
	</div>
	<div>
		<ul style="text-align:right;">
		<#if crudMode != "CR">
			<select name="lotList" id="lotList">
				<option value="">--Select</option>
			<#if lotList??>
				<#list lotList as codeInfo>
   				<option value="${codeInfo.lotNo!}">LOT${codeInfo.lotNo!}</option>
       			</#list>
       		</#if>
			</select>
			<input id="partial" type="button" value="${uiLabelMap.partial}" class="buttontext"/>
		</#if>
			<input id="deleteRow" type="button" value="${uiLabelMap.deleteRow}" class="buttontext"/>
		</ul>
	</div>
	<br />
	<form name="lotInfo" id="lotInfo">
		<table class="display cell-border stripe" id="lotColoList" name="lotColoList">
			<thead>
				<tr>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.lotNo?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.destination?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.steelType?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.grade?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.coatingWeight?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.surfaceCoilType?trim}</th>
					<th colspan="3" style="vertical-align: middle;">${uiLabelMap.gauge?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.width?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.coilMaxWeight?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.innerDiameter?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.gaugeControlYield?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.packaging?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.businessClass?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.customerName?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.otherDetails?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.barge?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.unitQuantity?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.unitPrice?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.commissionUnitPrice?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.paintBrand?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.paintCode?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.paintColor?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.paintCoatingThickness?trim}</th>
				</tr>
				<tr>
					<th style="vertical-align: middle;">${uiLabelMap.grade?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gradeDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.coatingWeight?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.coatingWeightDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.surfaceCoilType?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.surfaceCoilTypeDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gauge?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gaugeUnit?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gaugeDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.width?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.widthDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.packaging?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.packagingDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim} Unit</th>
					<th style="vertical-align: middle;">${uiLabelMap.unitQuantity?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.quantityUnit?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.unitPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.priceUnit?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.commissionUnitPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.commissionUnitPrice?trim} Unit</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			<tfoot>
				<tr>
					<th style="vertical-align: middle;">${uiLabelMap.lotNo?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.destination?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.steelType?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.grade?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gradeDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.coatingWeight?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.coatingWeightDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.surfaceCoilType?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.surfaceCoilTypeDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gauge?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gaugeUnit?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gaugeDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.width?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.widthDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.coilMaxWeight?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.innerDiameter?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gaugeControlYield?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.packaging?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.packagingDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.businessClass?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.customerName?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.otherDetails?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.barge?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim} Unit</th>
					<th style="vertical-align: middle;">${uiLabelMap.unitQuantity?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.quantityUnit?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.unitPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.priceUnit?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.commissionUnitPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.commissionUnitPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintBrand?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintCode?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintColor?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintCoatingThickness?trim}</th>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<div>
	<ul>
	<#if crudMode == "CR">
		<input id="submitBtn" type="button" value="${uiLabelMap.submit}" class="buttontext"/>
	<#else>
		<input id="submitBtn" type="button" value="${uiLabelMap.update}" class="buttontext"/>
		<input id="cancelBtn" type="button" value="${uiLabelMap.cancel}" class="buttontext"/>
    </#if>
	</ul>
</div>
<form id="referenceForm" name="referenceForm"></form>
<!-- <form id="testForm"> -->
<!-- 	<div class="screenlet"> -->
<!-- 		<div class="screenlet-title-bar"> -->
<!-- 			<ul> -->
<!-- 				<li class="h3">test</li> -->
<!-- 				<li></li> -->
<!-- 			</ul> -->
<!-- 			<br class="clear"/> -->
<!-- 		</div> -->
<!-- 		<div class="screenlet-body"> -->
<!-- 			<table width="100%" cellspacing="0" cellpadding="2" border="1" class="basic-table"> -->
<!-- 				<tr class="header-row"> -->
<!-- 					<td width="10%">${uiLabelMap.OrderItemId}</td> -->
<!-- 					<td width="25%">${uiLabelMap.ProductProduct}</td> -->
<!-- 					<td width="10%">${uiLabelMap.CommonQuantity}</td> -->
<!-- 					<td width="40%">${uiLabelMap.ProductQuantityNotAvailable}</td> -->
<!-- 					<td width="5%"> </td> -->
<!-- 				</tr> -->
<!-- 				<tr id="tableevenrow" style="display:none;"> -->
<!--               		<td width="10%"><input type="text" id="id1" name="id1" value="11" /></td> -->
<!-- 					<td width="25%"><input type="text" id="name1" name="name1" value="22" /></td> -->
<!-- 					<td width="10%"><input type="text" id="code1" name="code1" value="33" /></td> -->
<!-- 					<td width="40%"><input type="text" id="val1" name="val1" value="44" /></td> -->
<!-- 					<td width="5%"> </td> -->
<!--               	</tr> -->
<!--               	<tr id="tableevenrow" style="background-color:red;"> -->
<!--               		<td width="10%"><input type="text" id="id1" name="id1" value="11231" /></td> -->
<!-- 					<td width="25%"><input type="text" id="name1" name="name1" value="21232" /></td> -->
<!-- 					<td width="10%"><input type="text" id="code1" name="code1" value="31233" /></td> -->
<!-- 					<td width="40%"><input type="text" id="val1" name="val1" value="44123" /></td> -->
<!-- 					<td width="5%"> </td> -->
<!--               	</tr> -->
<!--               	<tr id="tableevenrow"> -->
<!--               		<td width="10%"><input type="text" id="id2" name="id2" value="11" /></td> -->
<!-- 					<td width="25%"><input type="text" id="name2" name="name2" value="22" /></td> -->
<!-- 					<td width="10%"><input type="text" id="code2" name="code2" value="33" /></td> -->
<!-- 					<td width="40%"><input type="text" id="val2" name="val2" value="44" /></td> -->
<!-- 					<td width="5%"> </td> -->
<!--               	</tr> -->
<!-- 			</table> -->
<!-- 		</div> -->
<!--     </div> -->
<!--     </form> -->
