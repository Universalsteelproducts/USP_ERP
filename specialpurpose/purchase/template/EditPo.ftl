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
	var initCrudMode = "${crudMode}";
	jQuery(document).ready(function() {
		/***************************************************************************
	     ******************			Common Control				********************
	     ***************************************************************************/

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
		            	var $select = $("<select></select>", {
			            	"id" : "gaugeControlYield",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "GUAGE_CONTROL_YIELD">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "gaugeControlYield");
		            	return $select.prop("outerHTML");
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
// 	            {
// 	            	"data" : "orderQuantity",
// 	                "render": function ( data, type, row ) {
// 	                	if(data != null && data != "") {
// 	                		data =  checkNull(data).format();
// 	                	} else {
// 	                		data =  "";
// 	                	}
// 						return "<input type='text' id='orderQuantity' style='text-align:right;' name='orderQuantity' value='" + data + "'/>";
// 					},
// 	  				"width" : "100px"
// 	            },
// 	            {
// 	            	"data" : "orderQuantityUnit",
// 	            	"render": function ( data, type, row ) {
// 	            		data = checkNull(data);
// 		            	var $select = $("<select></select>", {
// 			            	"id" : "orderQuantityUnit",
// 			            	"value" : data
// 		            	});
// 		            	var $option = "<option value=''></option>";
// 		            <#if codeList??>
// 		            	<#list codeList as codeInfo>
// 		            		<#if codeInfo.codeGroup == "QUANTITY_UNIT">
// 		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
// 		            		</#if>
// 		            	</#list>
// 		            </#if>

// 		            	var unit = "";
// 		            	if(row.orderQuantityUnit == null || row.orderQuantityUnit == "") {
// 		            		unit = row.quantityUnit;
// 		            		row.orderQuantityUnit = row.quantityUnit;
// 		            	} else {
// 		            		unit = row.orderQuantityUnit;
// 		            	}

// 		            	$select.append($option);
// 		            	$select.find("[value='" + unit + "']").attr("selected", "selected");
// 		            	$select.attr("class", "orderQuantityUnit");
// 		            	return $select.prop("outerHTML");
// 	            	},
// 	  				"width" : "100px"
// 	            },
	            {
	            	"data" : "unitQuantity",
	                "render": function ( data, type, row ) {
	                	if(data != null && data != "") {
	                		data =  checkNull(data).format();
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
	                		data =  checkNull(data).format(2);
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
	            	"data" : "totalPrice",
	                "render": function ( data, type, row ) {
						return "$ " + (row.unitPrice*row.unitQuantity);
					},
					"className" : "dt-body-right",
	  				"width" : "100px"
	            },
	            {
	            	"data" : "commissionUnitPrice",
	                "render": function ( data, type, row ) {
	                	if(data != null && data != "") {
	                		data =  checkNull(data).format(2);
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

		            	row.commissionUnitPriceUnit = row.priceUnit;
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
// 		            	var steelType = row.steelType;
// 		            	if(steelType != "PPGI" && steelType != "PPGL") {
// 		            		$select.attr("disabled", "disabled");
// 		            	}
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
// 		            	var steelType = row.steelType;
// 		            	if(steelType != "PPGI" && steelType != "PPGL") {
// 		            		$select.attr("disabled", "disabled");
// 		            	}
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
// 		            	var steelType = row.steelType;
// 		            	if(steelType != "PPGI" && steelType != "PPGL") {
// 		            		$select.attr("disabled", "disabled");
// 		            	}
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "paintType",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "paintType",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PAINT_TYPE">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "paintType");
// 		            	var steelType = row.steelType;
// 		            	if(steelType != "PPGI" && steelType != "PPGL") {
// 		            		$select.attr("disabled", "disabled");
// 		            	}
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "paintCoatingThickness",
	                "render": function ( data, type, row ) {
	                	data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "paintCoatingThickness",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PAINT_COATING_THICKNESS">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "paintCoatingThickness");
// 		            	var steelType = row.steelType;
// 		            	if(steelType != "PPGI" && steelType != "PPGL") {
// 		            		$select.attr("disabled", "disabled");
// 		            	}
		            	return $select.prop("outerHTML");
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
				if(initCrudMode == "CL") {
					var poNo = generatePoNo();
					var lotNo = data.lotNo;
					data.poNo = poNo + "11";
					data.referenceNo = poNo + "11" + lotNo + "00";
					data.referenceSeq = "";
					data.createUserId = "";
					data.createdStamp = "";
					data.createdTxStamp = "";
					data.lastUpdateUserId = "";
					data.lastUpdatedStamp = "";
					data.lastUpdatedTxStamp = "";
				}
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

			var val;
			var valType = typeof $(this).val();
			var type = typeof poListTable.cell( $(this).parent() ).data();
			if(type == "number") {
				if(valType == "string") {
					val = Number($(this).val().replace(/\,/g, ""));
				} else {
					val = Number($(this).val());
				}
			} else {
				val = $(this).val();
			}
			poListTable.cell( $(this).parent() ).data(val).draw();
		});

		// column value update
		$("#lotColoList").on("keyup", ":input", function() {
			var id = $(this).attr("id");
			if(id == "unitQuantity") {
				$(this).objectFormat({format : "int"});
				var colIdx = poListTable.cell( $(this).parent() ).index().column;
			}
		});

		if(initCrudMode == "CL") {
	    	var poNo = generatePoNo();
	    	$("#vendorNPoInfo #poNo").val(poNo+"11");
		}
	    /***************************************************************************
	     ******************			InputBox Control			********************
	     ***************************************************************************/
		$('#vendorFax').usPhoneFormat({
			format: '(xxx) xxx-xxxx',
		});
		$('#vendorTel').usPhoneFormat({
			format: '(xxx) xxx-xxxx',
		});
		$("#downPayment").on("change", function() {
			$(this).val($(this).val().format(2));
		});
		$('#vendorEmail').on("change", function() {
			var returnTF = $(this).emailFormat();
			if(!returnTF) {
				alert("Invalid Format");
				$(this).focus();
				return;
			}
		});
		$("#lotCommonInfo #unitQuantity").on("keyup", function() {
			var returnTF = $(this).objectFormat({format : "int"});
		});
		$("#lotCommonInfo #unitPrice,#lotCommonInfo #commissionUnitPrice" +
			",#colorDetail #unitPrice,#colorDetail #commissionUnitPrice").on("keyup", function() {
			var returnTF = $(this).objectFormat({format : "float"});
		});
		$("#lotCommonInfo #unitQuantity").on("change", function() {
			$(this).val($(this).val().format());
		});
		$("#lotCommonInfo #unitPrice,#lotCommonInfo #commissionUnitPrice" +
				",#colorDetail #unitPrice,#colorDetail #commissionUnitPrice").on("change", function() {
			$(this).val($(this).val().format(2));
		});

	    /***************************************************************************
	     ******************			SelectBox Control			********************
	     ***************************************************************************/
	    $("#lotCommonInfo #steelType").on("change", function() {
			$("#coilDesc").val($(this).find(":selected").data("desc"));

			if($(this).val() == "PPGL" || $(this).val() == "PPGI") {
				$("#giglTag").hide();
// 				$("#hideTag1,#hideTag2,#hideTag3,#hideTag4,#hideTag5,#hideTag6").hide();
// 				$("#lotCommonInfo #orderQuantity").attr("disabled", true);
// 				$("#lotCommonInfo #orderQuantity").val("0");
// 				$("#lotCommonInfo #orderQuantityUnit").attr("disabled", true);
// 				$("#lotCommonInfo #orderQuantityUnit").val("").attr("selected", true).trigger("change");
// 				$("#colspanTag").attr("colspan", "4");
				$("#colorDetail").show();

				$("#lotCommonInfo #coilDesc").attr("disabled", true);
			} else {
				$("#giglTag").show();
// 				$("#hideTag1,#hideTag2,#hideTag3,#hideTag4,#hideTag5,#hideTag6").show();
// 				$("#lotCommonInfo #orderQuantity").attr("disabled", false);
// 				$("#lotCommonInfo #orderQuantity").val("0");
// 				$("#lotCommonInfo #orderQuantityUnit").attr("disabled", false);
// 				$("#lotCommonInfo #orderQuantityUnit").val("").attr("selected", true).trigger("change");
// 				$("#colspanTag").attr("colspan", "");
				$("#colorDetail").hide();
				if($(this).val() == "OTHER") {
					$("#lotCommonInfo #coilDesc").attr("disabled", false);
				} else {
					$("#lotCommonInfo #coilDesc").attr("disabled", true);
				}
			}
		});

	    $("#lotCommonInfo #quantityUnit,#lotCommonInfo #priceUnit,#colorDetail #quantityUnit,#colorDetail #priceUnit").on("change", function() {
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

// 			if($("#lotCommonInfo #coatingWeight").val()=="G90" && $("#lotCommonInfo #gauge").val()=="18" && $("#lotCommonInfo #width").val()=="43") {
// 				$("#lotCommonInfo #gaugeControlYield").val("test");
// 			} else {
// 				$("#lotCommonInfo #gaugeControlYield").val("");
// 			}
		});

	    // vendor Id 변경시 실행
	    $("input[name=vendorId]").on("change lookup:changed", function() {
		    var vendorId = $(this).val();
		    var crudMode = $("#crudMode").val();

		    if(crudMode != "CL") {
			    if(vendorId != null && vendorId != "") {
				    jQuery.ajax({
				    	url: '<@ofbizUrl>/searchVendor</@ofbizUrl>',
				    	type: 'POST',
				    	data: {"vendorId" : vendorId},
				    	error: function(msg) {
				    		showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
				    	},
				    	success: function(data) {
				    		if(data.resultState == "success") {
					    		if(data.vendorInfo != null) {
							    	$.each(data.vendorInfo, function(index, value) {
								    	if(index == "remark") {
								    		$("#vendorNPoInfo #remark").val(value);
								    	} else {
								    		$("input[name=" + index + "]").val("");
									    	$("input[name=" + index + "]").val(value);
									    	$("input[name=" + index + "]").effect("highlight", {}, 3000);
								    	}
							    	});

							    	$('#vendorTel').change();
							    	$('#vendorFax').change();

							    	var nowDate = new Date();
							    	var year = nowDate.getFullYear().toString().substr(-2);;
							    	var month = (1 + nowDate.getMonth());
							    	month = month >= 10 ? month : '0' + month;
							    	var day = nowDate.getDate();
							    	day = day >= 10 ? day : '0' + day;

							    	var poNo = year + month + day + $("#vendorInitials").val();
							    	$("#vendorNPoInfo #poNo").val(poNo);
					    		} else {
					    			$("#vendorInitials").val("");
							    	$("#vendorAddr").val("");
							    	$("#priceTerm").val("");
							    	$("#vendorEmail").val("");
							    	$("#freightTerm").val("");
							    	$("#vendorTel").val("");
							    	$("#paymentTerm").val("");
							    	$("#vendorFax").val("");
							    	$("#downPayment").val("");
							    	$("#remark").val("");
					    		}
				    		}
				    	}
			    	});
			    } else {
			    	$("#vendorInitials").val("");
			    	$("#vendorAddr").val("");
			    	$("#priceTerm").val("");
			    	$("#vendorEmail").val("");
			    	$("#freightTerm").val("");
			    	$("#vendorTel").val("");
			    	$("#paymentTerm").val("");
			    	$("#vendorFax").val("");
			    	$("#downPayment").val("");
			    	$("#remark").val("");
			    }
		    }
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
		    		if(data.resultState == "success") {
			    		$("input[name=customerName]").val(data.customerInfo.customerName);
		    		}
		    	}
	    	});
		});

	    $("#lotCommonInfo #lotNo").on("change", function() {
	    	var lotNo = $(this).val();
	    	if($(this).val() == "") {
	    		editPoInputInit("lotCommonInfo");
	    		$(this).val("").prop("selected", "selected");
	    	} else {
		    	var tableSize = poListTable.rows().data().length;
		    	var count = 0;
		    	if(tableSize > 0) {
			    	for(var i=0 ; tableSize > i ; i++) {
			    		if(count > 0) {
			    			break;
			    		}

			    		var rowLotNo = poListTable.rows(i).data().pluck("lotNo")[0];
		 				if(lotNo == rowLotNo) {
		 					$("#lotCommonInfo :input").each(function() {
		 						if($(this).prop("type") != "button") {
			 						if($(this).attr("name") != "unitPrice" && $(this).attr("name") != "commissionUnitPrice"
			 								&& $(this).attr("name") != "coilDesc" && $(this).attr("name") != "barge") {
			 							$(this).val(poListTable.rows(i).data().pluck($(this).attr("name"))[0]);
			 						}
		 						}
		 					});
		 					$('#lotCommonInfo #steelType').change();
		 					count++;
		 				}
					}
		    	}

		    	totalPriceNQuantity(poListTable, "totalQuantity", "totalPoAmount");
		    	$(this).val( lotNo ).prop("selected", "selected");
	    	}
	    });

	    /***************************************************************************
	     ******************				Button Control			********************
	     ***************************************************************************/
		$("#addLot").on("click", function() {
			var lotIdx = $("#lotNo option").size();
			lotIdx = lotIdx >= 10 ? lotIdx : '0' + lotIdx;
			$("#lotCommonInfo #lotNo").append("<option value='" + lotIdx + "'>LOT" + lotIdx + "</option>");

			editPoInputInit("lotCommonInfo");
			editPoInputInit("colorDetail");

			$("#lotCommonInfo #lotNo option:eq(" + lotIdx + ")").attr("selected", true);
	    });

	    $("#addColor").on("click", function() {
	    	var crudMode = $("#crudMode").val();
	    	if(crudMode == "CR") {
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
	    	}

			var steelType = $("#lotCommonInfo #steelType").val();

			var rowMap = new Object();

			if(steelType == "PPGL" || steelType == "PPGI") {
				rowMap = addRow("lotCommonInfo", rowMap);
// 				rowMap["orderQuantity"] = "";
				rowMap = addRow("colorDetail", rowMap);
				editPoInputInit("colorDetail");
			} else {
				rowMap = addRow("lotCommonInfo", rowMap);
				editPoInputInit("colorDetail");
				var unit = rowMap["priceUnit"];
				var unitPrice = rowMap["unitPrice"];
				var unitQuantity = rowMap["unitQuantity"];
				var commissionUnitPrice = rowMap["commissionUnitPrice"];
				rowMap = addRow("colorDetail", rowMap);
				rowMap["unitQuantity"] = unitQuantity;
				rowMap["quantityUnit"] = unit;
				rowMap["priceUnit"] = unit;
				rowMap["unitPrice"] = unitPrice;
				rowMap["commissionUnitPrice"] = commissionUnitPrice;
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
	    		var returnFalse = 0;
	    		for(var i=0 ; selectRowData.length > i ; i++) {
					var data = selectRowData[i];
					var referenceSeq = data["referenceSeq"];

					if(referenceSeq == null || referenceSeq == "") {
				    	poListTable.row(selectRow[i]).remove().draw();
						returnFalse++;
					} else {
						poListTable.row(selectRow[i]).remove().draw();
					}
	    		}

	    		if(returnFalse > 0) {
	    			return false;
	    		}

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
						} else {
							alert("PO Delete Fail");
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
			    	var partialYN = "Y";
				    for(var key in data) {
						if(key != "undefined") {
							if(key == "partialYN") {
								if(data[key] == "Y") {
									partialYN = "N";
									break;
								}
							}
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
								var partialReferenceNo = poNo + $.trim(currLotNo) + "02";
								data[key] = $.trim(orgReferenceNo);
								newDataMap[key] = $.trim(partialReferenceNo);
							} else if(key == "unitQuantity") {
								var steeltype = data["steeltype"];
								if(steeltype != "PPGL" && steeltype != "PPGI") {
									var unitQuantity = parseFloat(data["unitQuantity"]);
									if(unitQuantity > 0) {
										data[key] = unitQuantity / 2;
										newDataMap[key] = data[key];
									}
								}
							} else if(key == "referenceSeq") {
								data[key] = $.trim(data["referenceSeq"]);
								newDataMap[key] = "";
							} else {
								data[key] = $.trim(data[key]);
								newDataMap[key] = $.trim(data[key]);
							}
						}
					}

				    if(partialYN == "N") {
				    	alert("Partial Not Allowed");
				    	return false;
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
	    	var mode = "";
			if(crudMode == "CR" || crudMode == "CL") {
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
	    			if(data.successStr == "success") {
	    				if(mode == "U") {
	    					alert("PO Update Completed");
	    				} else if(mode == "C") {
	    					alert("PO Create Completed");
	    				}

	    				$('#referenceForm').attr("action", "<@ofbizUrl>EditPo?poNo=" + $("#poNo").val() + "</@ofbizUrl>");
						$('#referenceForm').submit();
					} else {
						if(mode == "U") {
							alert("PO Update Fail");
	    				} else if(mode == "C") {
	    					alert("PO Create Fail");
	    				}
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
					alert(JSON.stringify(data.data));
					alert(JSON.stringify(data.data.length));
					if(status == "success") {
						alert("PO Cancel Completed");
						$('#referenceForm').attr('action', "<@ofbizUrl>EditPo?poNo=" + $("#poNo").val() + "</@ofbizUrl>").submit();
					}
				}
			});
	    });

	    $("#allClear").on("click", function() {
			editPoInputInit("vendorNPoInfo");
			editPoInputInit("lotCommonInfo");

			$("#lotColoList tbody").children().remove();
	    });

	    $("#duplicate").on("click", function() {
	    	$('#duplicateForm').attr("action", "<@ofbizUrl>EditPo?poNo=" + $("#poNo").val() + "&crudMode=CL</@ofbizUrl>");
			$('#duplicateForm').submit();
	    });
	});
</script>

<input type="hidden" name="crudMode" id="crudMode" value="${crudMode}"/>

<form name="vendorNPoInfo" id="vendorNPoInfo" method="post">
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
					<#if crudMode == "UR">
						${poCommonInfo.vendorId!}
					<#else>
						<!-- set_multivalues -->
						<@htmlTemplate.lookupField value="${poCommonInfo.vendorId!}" formName="vendorNPoInfo" name="vendorId" id="vendorId" fieldFormName="LookupVendor" position="center" />
					</#if>
						<input type="hidden" name="vendorInitials" id="vendorInitials" value="${poCommonInfo.vendorInitials!}" size="25" maxlength="255"/>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.orderDate}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
					<#if crudMode == "UR">
						${poCommonInfo.orderDate!}
					<#else>
						<!-- set_multivalues -->
						<@htmlTemplate.renderDateTimeField name="orderDate" event="" action="" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" value="${poCommonInfo.orderDate!}" size="25" maxlength="50" id="orderDate" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
					</#if>
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.vendorAddr}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
					<#if crudMode == "UR">
						${poCommonInfo.vendorAddr!}
					<#else>
						<input type="text" name="vendorAddr" id="vendorAddr" value="${poCommonInfo.vendorAddr!}" size="60" maxlength="255"/>
					</#if>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.priceTerm}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
					<#if crudMode == "UR">
						${poCommonInfo.priceTerm!}
					<#else>
						<input type="text" name="priceTerm" id="priceTerm" value="${poCommonInfo.priceTerm!}" size="25" maxlength="255"/>
					</#if>
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.email}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
					<#if crudMode == "UR">
						${poCommonInfo.vendorEmail!}
					<#else>
						<input type="text" name="vendorEmail" id="vendorEmail" value="${poCommonInfo.vendorEmail!}" size="25" maxlength="255"/>
					</#if>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.freightTerm}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
					<#if crudMode == "UR">
						${poCommonInfo.freightTerm!}
					<#else>
						<input type="text" name="freightTerm" id="freightTerm" value="${poCommonInfo.freightTerm!}" size="25" maxlength="255"/>
					</#if>
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.tel}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
					<#if crudMode == "UR">
						${poCommonInfo.vendorTel!}
					<#else>
						<input type="text" name="vendorTel" id="vendorTel" value="${poCommonInfo.vendorTel!}" size="25" maxlength="255"/>
					</#if>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.paymentTerm}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
					<#if crudMode == "UR">
						${poCommonInfo.paymentTerm!}
					<#else>
						<input type="text" name="paymentTerm" id="paymentTerm" value="${poCommonInfo.paymentTerm!}" size="25" maxlength="255"/>
					</#if>
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.fax}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
					<#if crudMode == "UR">
						<span id="testTel">
							${poCommonInfo.vendorFax!}
						</span>
					<#else>
						<input type="text" name="vendorFax" id="vendorFax" value="${poCommonInfo.vendorFax!}" size="25" maxlength="255"/>
					</#if>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.downPayment}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
					<#if crudMode == "UR">
						${poCommonInfo.downPayment?default(0)?string(',##0.00')}
					<#else>
						$ <input type="text" name="downPayment" id="downPayment" value='' size="23" maxlength="255" style="text-align:right;" />
					</#if>
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
						<input type="text" name="poNo" id="poNo" size="25" maxlength="255" value="${poNo!}" />
<!-- 												<input type="text" name="poNo" id="poNo" size="25" maxlength="255" value="${poNo!}" style="background-color:#EEEEEE;" readonly="readonly" /> -->
					<#if crudMode == "R" || crudMode == "CR" || crudMode == "CL">
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
						<input type="text" name="totalQuantity" id="totalQuantity" value="${totalQuantity!}" style="text-align:right;background-color:#EEEEEE;" readonly="readonly" />
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
						<input type="text" name="totalPoAmount" id="totalPoAmount" value="${totalPrice!}" style="text-align:right;background-color:#EEEEEE;" readonly="readonly" />
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
		<table class="basic-table" cellspacing="0" id="lotCommonInfo">
			<tr>
				<td class="label" width="12%" align="right">
					${uiLabelMap.lot}
				</td>
				<td width="1%"></td>
				<td colspan="7">
				<#if crudMode != "CR">
					<select name="lotNo" id="lotNo" size="1">
						<option value="">--Select</option>
					<#if lotList??>
						<#list lotList as codeInfo>
		   				<option value="${codeInfo.lotNo!}">LOT${codeInfo.lotNo!}</option>
		       			</#list>
		       		</#if>
					</select>
				<#else>
					<select name="lotNo" id="lotNo" size="1">
						<option value="">--Select</option>
						<option value="01">LOT01</option>
					</select>
				</#if>
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
						<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
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
									<#if codeInfo.codeGroup == "WIDTH">
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
							<#if codeInfo.codeGroup == "COIL_MAX_WEIGHT">
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
					<select name="gaugeControlYield" id="gaugeControlYield" disabled="disabled">
						<option value="">--Selecet</option>
					<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "GUAGE_CONTROL_YIELD">
						<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
							</#if>
						</#list>
					</#if>
					</select>
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
					<form name="customerForm" id="customerForm" method="post">
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
					${uiLabelMap.unitQuantity}
				</td>
				<td width="1%">&nbsp;</td>
				<td width="20%"  id="colspanTag">
					<input type="text" name="unitQuantity" id="unitQuantity" value="0" style="text-align:right;" maxlength="255"/>
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
				<td class="label" width="12%" align="right" id="hideTag1">
					${uiLabelMap.unitPrice}
				</td>
				<td width="1%" id="hideTag2">&nbsp;</td>
				<td width="20%" id="hideTag3">
					<input type="text" name="unitPrice" id="unitPrice" value="0" maxlength="255" style="text-align:right;" />
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
					<input type="text" name="commissionUnitPrice" id="commissionUnitPrice" value="0" style="text-align:right;" maxlength="255"/>
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
		<div>
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
							${uiLabelMap.paintType}
						</td>
						<td width="1%">&nbsp;</td>
						<td width="20%">
							<select name="paintType">
								<option value="">--Select</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "PAINT_TYPE">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
						</td>
						<td class="label" width="12%" align="right">
							${uiLabelMap.paintCoatingThickness}
						</td>
						<td width="1%">&nbsp;</td>
						<td colspan="4">
							<select name="paintCoatingThickness" id="paintCoatingThickness" size="1">
								<option value="">--Select</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "PAINT_COATING_THICKNESS">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
						</td>
					</tr>
					<tr>
						<td class="label" width="12%" align="right">
							${uiLabelMap.unitQuantity}
						</td>
						<td width="1%">&nbsp;</td>
						<td width="20%">
							<input type="text" name="unitQuantity" value="0" maxlength="255" style="text-align:right;" />
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
							<input type="text" name="unitPrice" value="0" maxlength="255" style="text-align:right;" />
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
							<input type="text" name="commissionUnitPrice" id="commissionUnitPrice" value="0" style="text-align:right;"  maxlength="255"/>
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
	    </div>
	</div>
	<div>
		<ul style="text-align:right;">
		<#if crudMode != "CR" && crudMode != "CL">
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
	<form name="lotInfo" id="lotInfo" method="post">
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
<!-- 					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim}</th> -->
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.unitQuantity?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.unitPrice?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.totalPrice?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.commissionUnitPrice?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.paintBrand?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.paintCode?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.paintColor?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.paintType?trim}</th>
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
<!-- 					<th style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim}</th> -->
<!-- 					<th style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim} Unit</th> -->
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
<!-- 					<th style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim}</th> -->
<!-- 					<th style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim} Unit</th> -->
					<th style="vertical-align: middle;">${uiLabelMap.unitQuantity?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.quantityUnit?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.unitPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.priceUnit?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.totalPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.commissionUnitPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.commissionUnitPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintBrand?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintCode?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintColor?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintType?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintCoatingThickness?trim}</th>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<div>
	<ul>
	<#if crudMode == "CR" || crudMode == "CL">
		<input id="submitBtn" type="button" value="${uiLabelMap.submit}" class="buttontext"/>
	<#else>
		<input id="submitBtn" type="button" value="${uiLabelMap.update}" class="buttontext"/>
		<input id="duplicate" type="button" value="${uiLabelMap.duplicate}" class="buttontext"/>
		<input id="cancelBtn" type="button" value="${uiLabelMap.cancel}" class="buttontext"/>
    </#if>
	</ul>
</div>
<form id="referenceForm" name="referenceForm" method="post"></form>
<form id="duplicateForm" name="duplicateForm" method="post"></form>