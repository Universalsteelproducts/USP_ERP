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
  jQuery(document).ready(function(){
    /***************************************************************************
     ******************				Init Table				********************
     ***************************************************************************/
    var poListTable = $("#lotColoList").DataTable({
		//dom: "Bfrtip",
		//dom : "frtip",
		dom : "lBfrtip",
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
					return "LOT" + data;
  				},
  				"width": "35px"
            },
            {
				"data" : "destination",
				"render": function ( data, type, row ) {
					var $select = $("<select></select>", {
						"id" : "destination",
						"value" : data
					});
					var $option = "";
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "DESTINATION">
					$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
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
					var $select = $("<select></select>", {
						"id" : "steelType",
						"value" : data
					});
					var $option = "";
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "STEEL_TYPE">
					$option += "<option value='${codeInfo.codeName!}' data-desc='${codeInfo.attribute1!}'>${codeInfo.codeName!}</option>";
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
	            	var $select = $("<select></select>", {
		            	"id" : "grade",
		            	"value" : data
	            	});
	            	var $option = "";
	            <#if codeList??>
	            	<#list codeList as codeInfo>
	            		<#if codeInfo.codeGroup == "GRADE">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
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
					return "<input type='text' id='gradeDesc' name='gradeDesc' value='" + data + "'/>";
				},
  				"width" : "150px"
            },
            {
            	"data" : "coatingWeight",
            	"render": function ( data, type, row ) {
	            	var $select = $("<select></select>", {
		            	"id" : "coatingWeight",
		            	"value" : data
	            	});
	            	var $option = "";
            	<#if codeList??>
	            	<#list codeList as codeInfo>
		            	<#if codeInfo.codeGroup == "COATING_WEIGHT">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
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
					return "<input type='text' id='coatingWeightDesc' name='coatingWeightDesc' value='" + data + "'/>";
				},
  				"width" : "160px"
            },
            {
            	"data" : "surfaceCoilType",
            	"render": function ( data, type, row ) {
	            	var $select = $("<select></select>", {
		            	"id" : "surfaceCoilType",
		            	"value" : data
	            	});
	            	var $option = "";
	            <#if codeList??>
	            	<#list codeList as codeInfo>
	            		<#if codeInfo.codeGroup == "SURFACE_COIL_TYPE">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
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
					return "<input type='text' id='surfaceCoilTypeDesc' name='surfaceCoilTypeDesc' value='" + data + "'/>";
				},
  				"width" : "160px"
            },
            {
            	"data" : "gauge",
            	"render": function ( data, type, row ) {
	            	var $select = $("<select></select>", {
		            	"id" : "gauge",
		            	"value" : data
	            	});
	            	var $option = "";
	            <#if codeList??>
	            	<#list codeList as codeInfo>
	            		<#if codeInfo.codeGroup == "GAUGE">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
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
	            	var $select = $("<select></select>", {
		            	"id" : "gaugeUnit",
		            	"value" : data
	            	});
	            	var $option = "";
	            <#if codeList??>
	            	<#list codeList as codeInfo>
	            		<#if codeInfo.codeGroup == "GAUGE_UNIT">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
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
					return "<input type='text' id='gaugeDesc' name='gaugeDesc' value='" + data + "'/>";
				},
  				"width" : "150px"
            },
            {
            	"data" : "width",
            	"render": function ( data, type, row ) {
	            	var $select = $("<select></select>", {
		            	"id" : "width",
		            	"value" : data
	            	});
	            	var $option = "";
	            <#if codeList??>
	            	<#list codeList as codeInfo>
	            		<#if codeInfo.codeGroup == "WIDTH">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
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
					return "<input type='text' id='widthDesc' name='widthDesc' value='" + data + "'/>";
				},
  				"width" : "150px"
            },
            {
            	"data" : "coilMaxWeight",
            	"render": function ( data, type, row ) {
	            	var $select = $("<select></select>", {
		            	"id" : "coilMaxWeight",
		            	"value" : data
	            	});
	            	var $option = "";
	            <#if codeList??>
	            	<#list codeList as codeInfo>
	            		<#if codeInfo.codeGroup == "COIL_MAX_WEIGHT">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
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
					return "<input type='text' id='innerDiameter' name='innerDiameter' value='" + data + "'/>";
				},
  				"width" : "100px"
            },
            {
				"data" : "gaugeControlYield",
				"render": function ( data, type, row ) {
					return "<input type='text' id='gaugeControlYield' name='gaugeControlYield' value='" + data + "'/>";
				},
  				"width" : "130px"
            },
            {
            	"data" : "packaging",
            	"render": function ( data, type, row ) {
	            	var $select = $("<select></select>", {
		            	"id" : "packaging",
		            	"value" : data
	            	});
	            	var $option = "";
	            <#if codeList??>
	            	<#list codeList as codeInfo>
	            		<#if codeInfo.codeGroup == "PACKAGING">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
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
                	return "<input type='text' id='packagingDesc' name='packagingDesc' value='" + data + "'/>";
                },
  				"width" : "150px"
            },
            {
            	"data" : "businessClass",
            	"render": function ( data, type, row ) {
	            	var $select = $("<select></select>", {
		            	"id" : "businessClass",
		            	"value" : data
	            	});
	            	var $option = "";
	            <#if codeList??>
	            	<#list codeList as codeInfo>
	            		<#if codeInfo.codeGroup == "BUSINESS_CLASS">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
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
            { "data" : "customerNm" },
            {
            	"data" : "otherDetail",
                "render": function ( data, type, row ) {
					return "<textarea name='otherDetail' id='otherDetail'>" + data + "</textarea>";
				},
  				"width" : "170px"
            },
            {
            	"data" : "barge",
            	"className" : "dt-body-center",
                "render": function ( data, type, row ) {
					return "<input type='checkbox' name='barge' id='barge' value='" + data + "' />";
				},
  				"width" : "50px"
            },
            {
            	"data" : "orderQuantity",
                "render": function ( data, type, row ) {
					return "<input type='text' id='orderQuantity' name='orderQuantity' value='" + data + "'/>";
				},
  				"width" : "100px"
            },
            {
            	"data" : "",
            	"render": function ( data, type, row ) {
	            	var $select = $("<select></select>", {
		            	"id" : "orderQuantityUnit",
		            	"value" : data
	            	});
	            	var $option = "";
	            <#if codeList??>
	            	<#list codeList as codeInfo>
	            		<#if codeInfo.codeGroup == "QUANTITY_UNIT">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
	            		</#if>
	            	</#list>
	            </#if>

	            	$select.append($option);
	            	$select.find("[value='" + row.quantityUnit + "']").attr("selected", "selected");
	            	$select.attr("class", "orderQuantityUnit");
	            	return $select.prop("outerHTML");
            	},
  				"width" : "100px"
            },
            {
            	"data" : "unitPrice",
                "render": function ( data, type, row ) {
					return "<input type='text' id='unitPrice' name='unitPrice' value='" + data + "'/>";
				},
  				"width" : "100px"
            },
            {
            	"data" : "priceUnit",
            	"render": function ( data, type, row ) {
	            	var $select = $("<select></select>", {
		            	"id" : "priceUnit",
		            	"value" : data
	            	});
	            	var $option = "";
	            <#if codeList??>
	            	<#list codeList as codeInfo>
	            		<#if codeInfo.codeGroup == "PRICE_UNIT">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
	            		</#if>
	            	</#list>
	            </#if>

	            	$select.append($option);
	            	$select.find("[value='" + data + "']").attr("selected", "selected");
	            	$select.attr("class", "priceUnit");
	            	return $select.prop("outerHTML");
            	},
  				"width" : "100px"
            },
            {
            	"data" : "commissionUnitPrice",
                "render": function ( data, type, row ) {
					return "<input type='text' id='commissionUnitPrice' name='commissionUnitPrice' value='" + data + "'/>";
				},
  				"width" : "130px"
            },
            {
            	"data" : "",
            	"render": function ( data, type, row ) {
	            	var $select = $("<select></select>", {
		            	"id" : "commissionUnitPriceUnit",
		            	"value" : data
	            	});
	            	var $option = "";
	            <#if codeList??>
	            	<#list codeList as codeInfo>
	            		<#if codeInfo.codeGroup == "PRICE_UNIT">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
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
	            	var $select = $("<select></select>", {
		            	"id" : "paintBrand",
		            	"value" : data
	            	});
	            	var $option = "";
	            <#if codeList??>
	            	<#list codeList as codeInfo>
	            		<#if codeInfo.codeGroup == "PAINT_BRAND">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
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
	            	var $select = $("<select></select>", {
		            	"id" : "paintCode",
		            	"value" : data
	            	});
	            	var $option = "";
	            <#if codeList??>
	            	<#list codeList as codeInfo>
	            		<#if codeInfo.codeGroup == "PAINT_CODE">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
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
	            	var $select = $("<select></select>", {
		            	"id" : "paintColor",
		            	"value" : data
	            	});
	            	var $option = "";
	            <#if codeList??>
	            	<#list codeList as codeInfo>
	            		<#if codeInfo.codeGroup == "PAINT_COLOR">
	            	$option += "<option value='${codeInfo.codeName!}'>${codeInfo.codeName!}</option>";
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
					return "<input type='text' id='paintCoatingThickness' name='paintCoatingThickness' value='" + data + "'/>";
				},
  				"width" : "150px"
            },
            {
				"data" : "referenceSeq",
				"visible": false
            },
            {
				"data" : "referenceNo",
				"visible": false
            },
            {
				"data" : "ppglNo",
				"visible": false
            },
            {
				"data" : "partialYN",
				"visible": false
            },
            {
				"data" : "partialNo",
				"visible": false
            },
            {
            	"data" : "customerId",
            	"visible": false
            }
		],
		rowCallback : function( row, data, displayNum, displayIndex, dataIndex ) {
			 $('input.barge', row).prop( 'checked', data.active == "Y" );
		},
		buttons: [
			'excel'
		]
    });

    /***************************************************************************
     ******************			Common Control				********************
     ***************************************************************************/
    var inputInit = function(id) {
      $("#" + id + " :input").each(function() {
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
            } else {
              $(this).val("");
            }
          }
        }
      });
    };

    var inputValSet = function(id) {
      var tagTmp = "";
      $("#" + id + " :input").each(function() {
        if($(this).prop("type") == "checkbox") {
          if($(this).prop("checked")) {
            $("input[name=" + $(this).attr("name") + "]").last().prop("checked", true);
            $("input[name=" + $(this).attr("name") + "]").last().val("Y");
          } else {
            $("input[name=" + $(this).attr("name") + "]").last().prop("checked", false);
            $("input[name=" + $(this).attr("name") + "]").last().val("N");
          }
        } else if($(this).prop("type") == "select-one") {
          if($(this).attr("id") == "orderQuantityUnit") {
            $("#lotInfo select[name=quantityUnit]").last().val( $(this).val() ).prop("selected", true);
            $("select[name=" + $(this).attr("name") + "]").last().val( $(this).val() ).prop("selected", "selected");
          } else if($(this).attr("id") == "unitPriceUnit") {
            $("#lotInfo select[name=priceUnit]").last().val( $(this).val() ).prop("selected", true);
          } else if($(this).attr("id") == "lotNo") {
            $("#lotInfo #lotNo").last().val( $(this).val() );
            $("#lotInfo #lotNoDesc").last().val( $(this).find("option:selected").text() );
          } else {
            $("select[name=" + $(this).attr("name") + "]").last().val( $(this).val() ).prop("selected", true);
          }
        } else {
          if($(this).attr("name") == "unitPrice" || $(this).attr("name") == "orderQuantity"
              || $(this).attr("name") == "unitQuantity" || $(this).attr("name") == "commissionUnitPrice" ) {
            if($(this).val() > 0) {
              var steelType = $("#lotCommonInfo #steelType").val();
              if(steelType == "PPGL" || steelType == "PPGI") {
                if($(this).attr("name") != "orderQuantity") {
                  $("input[name=" + $(this).attr("name") + "]").last().val( $(this).val() );
                }
              } else {
                $("input[name=" + $(this).attr("name") + "]").last().val( $(this).val() );
              }
            } else {
              $("input[name=" + $(this).attr("name") + "]").last().val( "0" );
            }
          } else {
            $("input[name=" + $(this).attr("name") + "]").last().val( $(this).val() );
          }
        }
      });
    };

    var addRow = function(tableId, trTempId, headerRowCnt) {
      if($("input[name=vendorId]").val() == null || $("input[name=vendorId]").val() == "") {
        alert("Select Vendor");
        return;
      }

      if($("#vendorNPoInfo #poNo").val() == null || $("#vendorNPoInfo #poNo").val() == "") {
        alert("Select Vendor");
        return;
      }

      if($("#lotCommonInfo #lotNo").val() == "") {
        alert("Select LOT");
        return;
      }

      // table Row 추가
// 			var trCnt = $("#" + tableId + " tr").size() - (parseInt(headerRowCnt)*2);
// 			var rowCount = 0;
// 			var rowClass = "1";
// 			var trTag = "";

// 			if(trCnt > 0) {
// 				rowCount = parseInt($("#rowCount").val()) + 1;
// 				rowClass = $("#rowClass").val();
// 			}
// 			$("#rowCount").val(rowCount);

// 			if(rowClass == "1") {
// 				for(var i=0 ; parseInt(headerRowCnt) > i ; i++) {
// 					trTag = "<tr id='trRow_" + rowCount + "_" + (i+1) + "'>";
// 					$("#" + tableId).append(trTag + $("#" + trTempId + (i+1)).html() + "</tr>");
// 				}

// 				rowClass = "2";
// 			} else {
// 				for(var i=0 ; parseInt(headerRowCnt) > i ; i++) {
// 					trTag = "<tr id='trRow_" + rowCount + "_" + (i+1) + "' class='alternate-row'>";
// 					$("#" + tableId).append(trTag + $("#" + trTempId + (i+1)).html() + "</tr>");
// 				}

// 				rowClass = "1";
// 			}
// 			$("#rowClass").val(rowClass);

// 			var referenceNo = $("#vendorNPoInfo #poNo").val() + $("#lotCommonInfo #lotNo").val() + "00";
// 			$("#trRow_" + rowCount + "_1").find("#referenceNo").val(referenceNo);

// 			$("#trRow_" + rowCount + "_1").find("#selectedItem").on("click", function() {
// 			    if ($(this).prop("checked")) {
// 			    	for(var i=0 ; parseInt(headerRowCnt) > i ; i++) {
// 			    		if ($("#trRow_" + rowCount + "_" + (i+1)).hasClass("")) {
// 				        	$("#trRow_" + rowCount + "_" + (i+1)).removeClass();
// 				        	$("#trRow_" + rowCount + "_" + (i+1)).addClass("selected");
// 				        } else if ($("#trRow_" + rowCount + "_" + (i+1)).hasClass("alternate-row")) {
// 				        	$("#trRow_" + rowCount + "_" + (i+1)).removeClass();
// 				            $("#trRow_" + rowCount + "_" + (i+1)).addClass("alternate-rowSelected");
// 				        }
// 					}
// 			    } else {
// 			    	for(var i=0 ; parseInt(headerRowCnt) > i ; i++) {
// 			    		if ($("#trRow_" + rowCount + "_" + (i+1)).hasClass("selected")) {
// 				        	$("#trRow_" + rowCount + "_" + (i+1)).removeClass();
// 				        	$("#trRow_" + rowCount + "_" + (i+1)).addClass("");
// 				        } else if ($("#trRow_" + rowCount + "_" + (i+1)).hasClass("alternate-rowSelected")) {
// 				        	$("#trRow_" + rowCount + "_" + (i+1)).removeClass();
// 				        	$("#trRow_" + rowCount + "_" + (i+1)).addClass("alternate-row");
// 				        }
// 					}
// 			    }
// 			});
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
     ******************			InputBox Control			********************
     ***************************************************************************/

    /***************************************************************************
     ******************			SelectBox Control			********************
     ***************************************************************************/
    $("#lotCommonInfo #steelType").on("change", function() {
      $("#coilDesc").val($(this).find(":selected").data("desc"));

      if($(this).val() == "PPGL" || $(this).val() == "PPGI") {
        $("#hideTag1,#hideTag2,#hideTag3,#hideTag4,#hideTag5,#hideTag6").hide();
// 				$("#giglTag").hide();
        $("#lotCommonInfo #orderQuantity").attr("disabled", true);
        $("#lotCommonInfo #orderQuantity").val("0");
        $("#lotCommonInfo #orderQuantityUnit").attr("disabled", true);
        $("#lotCommonInfo #orderQuantityUnit").val("").attr("selected", true).trigger("change");
        $("#colspanTag").attr("colspan", "4");
        $("#colorDetail").show();

        $("#lotCommonInfo #coilDesc").attr("disabled", true);
      } else {
        $("#hideTag1,#hideTag2,#hideTag3,#hideTag4,#hideTag5,#hideTag6").show();
// 				$("#giglTag").show();
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

    $("#lotCommonInfo #orderQuantityUnit,#unitPriceUnit,#colorDetail #unitQuantityUnit").on("change", function() {

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
        $("#lotCommonInfo #guageControlYield").val("test");
      } else {
        $("#lotCommonInfo #guageControlYield").val("");
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
          totalPriceNQuantity("lotColoList", 2, "unitQuantity", "unitPrice",  "totalQuantity", "totalPoAmount");
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
      var steelType = $("#lotCommonInfo #steelType").val();
      addRow("lotColoList", "tableAddRow", 2);

      inputValSet("lotCommonInfo");
      if(steelType == "PPGL" || steelType == "PPGI") {
        inputValSet("colorDetail");
      }

      inputInit("colorDetail");

      totalPriceNQuantity("lotColoList", 2, "unitQuantity", "unitPrice",  "totalQuantity", "totalPoAmount");
    });

    $("#submitBtn").on("click", function() {
      jQuery.ajax({
        url: '<@ofbizUrl>/createNUpdateVendorNPoInfo</@ofbizUrl>',
        type: 'POST',
        async: false,
        data: $("#vendorNPoInfo").serialize(),
        error: function(msg) {
                showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
            },
        success: function(data, status) {
          if(status == "success") {
            var trCnt = $("#lotColoList tbody tr").size()/2;
            var headTrCnt = 2;
            var errorCnt = 0;

            for(var i=0 ; trCnt > i ; i++) {
              var trId = $("#lotColoList tbody tr").eq(i*2).attr("id");
              trId = trId.substring(0, (trId.lastIndexOf("_")+1));

              var tagTmp = "<input type='hidden' id='crudMode' name='crudMode' value='${crudMode}' />";
              tagTmp += "<input type='hidden' id='poNo' name='poNo' value='" + $("#vendorNPoInfo #poNo").val() + "' />";
              $("#referenceForm").append(tagTmp);
              tagTmp = "";

              for(var j=0 ; headTrCnt > j ; j++) {
                $("#" + trId + (j+1) + " :input").each(function() {
                  if($(this).prop("type") == "checkbox") {
                    if($(this).prop("checked") == true) {
                      tagTmp += "<input type='hidden' name='" + $(this).attr("name") + "' id='" + $(this).attr("name") + "' value='Y' />";
                    } else {
                      tagTmp += "<input type='hidden' name='" + $(this).attr("name") + "' id='" + $(this).attr("name") + "' value='N' />";
                    }
                  } else {
                    tagTmp += "<input type='hidden' name='" + $(this).attr("name") + "' id='" + $(this).attr("name") + "' value='" + $(this).val() + "' />";
                  }
                });

                $("#referenceForm").append(tagTmp);
                tagTmp = "";
              }

              jQuery.ajax({
                url: '<@ofbizUrl>/createNUpdateReferenceInfo</@ofbizUrl>',
                type: 'POST',
                async: false,
                data: $("#referenceForm").serialize(),
                error: function(msg) {
                        showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
                        errorCnt++;
                    },
                success: function(data, status) {
                  $("#referenceForm").children().remove();

                  if(status == "error") {
                    errorCnt++;
                  }
                }
              });
            }

            if(errorCnt == 0) {
              alert("PO Issue Completed");
            }
          }
        }
      });
// 			$("#vendorNPoInfo").attr("action", "<@ofbizUrl></@ofbizUrl>").submit();
    });

    $("#cancelBtn").on("click", function() {
      jQuery.ajax({
        url: '<@ofbizUrl>/createNUpdateVendorNPoInfo</@ofbizUrl>',
        type: 'POST',
        data: {"poNo" : "${poNo!}", "poStatus" : "CC"},
        async: false,
        error: function(msg) {
                showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
            },
        success: function(data, status) {
          alert("PO Cancel Completed");
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

  var totalPriceNQuantity = function(tableId, headTrCnt, quantityId, priceId,  totalQuantityId, totalPriceId) {

    var trCnt = $("#" + tableId + " tbody tr").size()/headTrCnt;
    var totalQuantity = 0;
    var totalPrice = 0;
    var groupUnitQuantity = 0;

    var lotNo = $("#lotCommonInfo #lotNo").val();
    var steelType = $("#lotCommonInfo #steelType").val();

    for(var i=0 ; trCnt > i ; i++) {
      var trId = $("#lotColoList tbody tr").eq(i*2).attr("id");
      trId = trId.substring(0, (trId.lastIndexOf("_")+1));

      var gridLotNo = $("#" + trId + "1 #lotNo").val();

      for(var j=0 ; headTrCnt > j ; j++) {
        $("#" + trId + + (j+1) + " :input").each(function() {
          if($("#" + trId + "1" + " #steelType").val() == "PPGL" || $("#" + trId + "1" + " #steelType").val() == "PPGI") {
            if($(this).attr("name") == quantityId) {
              totalQuantity += parseInt($(this).val());
              if(lotNo == gridLotNo) {
                groupUnitQuantity += parseInt($(this).val());
                gridLotNo = "";
              }
            }
          } else {
            if($(this).attr("name") == "orderQuantity") {
              totalQuantity += parseInt($(this).val());
            }
          }

          if($(this).attr("name") == priceId) {
            totalPrice += parseInt($(this).val());
          }
        });
      }
    }

    $("#" + totalQuantityId).val(totalQuantity);
    $("#" + totalPriceId).val(totalPrice);

    if(steelType == "PPGL" || steelType == "PPGI") {
      $("#colspanTag #orderQuantity").val(groupUnitQuantity);
    }
  };

  var orderQuantityCalc = function() {

  }

  function deleteRow(e, crudMode) {
    var trTag = e.parent().parent();
    var trId = trTag.attr("id");

    if(crudMode == "C") {
      var trCnt = parseInt(trId.substring((trId.length-1), trId.length));
      if(trCnt > 1) {
        trId = trId.substring(0, (trId.length-1));
        for(var i=trCnt ; i > 0 ; i--) {
          $("#" + trId + i).remove();
        }
      } else {
        $("#" + trId).remove();
      }

    }

    totalPriceNQuantity("lotColoList", 2, "unitQuantity", "unitPrice",  "totalQuantity", "totalPoAmount");
  }

  function updateRow(trId, crudMode) {
    var trCnt = 2;

    var tagTmp = "<input type='hidden' id='crudMode' name='crudMode' value='${crudMode}' />";
    tagTmp += "<input type='hidden' id='poNo' name='poNo' value='" + $("#vendorNPoInfo #poNo").val() + "' />";
    $("#referenceForm").append(tagTmp);
    tagTmp = "";

    for(var j=0 ; trCnt > j ; j++) {

      $("#" + trId + (j+1) + " :input").each(function() {
        tagTmp += "<input type='hidden' name='" + $(this).attr("name") + "' id='" + $(this).attr("name") + "' value='" + $(this).val() + "' />";
      });

      $("#referenceForm").append(tagTmp);
      tagTmp = "";
    }

    jQuery.ajax({
      url: '<@ofbizUrl>/createNUpdateReferenceInfo</@ofbizUrl>',
      type: 'POST',
      async: false,
      data: $("#referenceForm").serialize(),
      error: function(msg) {
              showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
          },
      success: function(data, status) {
        $("#referenceForm").children().remove();
        alert("PO Update Complete");
      }
    });
  }
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
		</#if>
			<input id="allClear" type="button" value="${uiLabelMap.allClear}" class="buttontext"/>
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
						<select name="quantityUnit" disabled="disabled">
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
						<select name="priceUnit" disabled="disabled">
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
	<#if crudMode == "RC">
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
							<select name="grade" id="grade" style="width:19%;">
								<option value="">--GRADE</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "GRADE">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
							<select name="coatingWeight" id="coatingWeight" style="width:19%;">
								<option value="">--COATING WEIGHT</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "COATING_WEIGHT">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
							<select name="surfaceCoilType" id="surfaceCoilType" style="width:19%;">
								<option value="">--SURFACE TYPE</option>
							<#if codeList??>
								<#list codeList as codeInfo>
									<#if codeInfo.codeGroup == "SURFACE_COIL_TYPE">
								<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
									</#if>
								</#list>
							</#if>
							</select>
							<select name="gauge" id="gauge" style="width:14%;">
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
							<select name="width" id="width" style="width:19%;">
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
							<input type="text" name="gradeDesc" id="gradeDesc" style="width:19%;" disabled="disabled"/>
							<input type="text" name="coatingWeightDesc" id="coatingWeightDesc" style="width:19%;" disabled="disabled"/>
							<input type="text" name="surfaceCoilTypeDesc" id="surfaceCoilTypeDesc" style="width:19%;" disabled="disabled"/>
							<input type="text" name="gaugeDesc" id="gaugeDesc" style="width:19%;" disabled="disabled"/>
							<input type="text" name="widthDesc" id="widthDesc" style="width:19%;" disabled="disabled"/>
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
					${uiLabelMap.guageControlYield}
				</td>
				<td width="1%">&nbsp;</td>
				<td width="20%">
					<input type="text" name="guageControlYield" id="guageControlYield" value="" size="25" maxlength="255" style="background-color:#EEEEEE;" readonly="readonly"/>
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
					<select name="unitPriceUnit" id="unitPriceUnit" size="1">
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
		<#if crudMode == "RC">
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
							<select name="unitQuantityUnit" id="unitQuantityUnit" size="1">
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
							<select name="unitPriceUnit" id="unitPriceUnit" size="1">
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
	<form name="lotInfo" id="lotInfo">
		<table class="display" id="lotColoList" name="lotColoList">
			<thead>
				<tr>
					<th rowspan="2">
						${uiLabelMap.lotNo}
					</th>
					<th rowspan="2">
						${uiLabelMap.destination}
					</th>
					<th rowspan="2">
						${uiLabelMap.steelType}
					</th>
					<th colspan="2">
						${uiLabelMap.grade}
					</th>
					<th colspan="2">
						${uiLabelMap.coatingWeight}
					</th>
					<th colspan="2">
						${uiLabelMap.surfaceCoilType}
					</th>
					<th colspan="3">
						${uiLabelMap.gauge}
					</th>
					<th colspan="2">
						${uiLabelMap.width}
					</th>
					<th rowspan="2">
						${uiLabelMap.coilMaxWeight}
					</th>
					<th rowspan="2">
						${uiLabelMap.innerDiameter}
					</th>
					<th rowspan="2">
						${uiLabelMap.gaugeControlYield}
					</th>
					<th colspan="2">
						${uiLabelMap.packaging}
					</th>
					<th rowspan="2">
						${uiLabelMap.businessClass}
					</th>
					<th rowspan="2">
						${uiLabelMap.customerNm}
					</th>
					<th rowspan="2">
						${uiLabelMap.otherDetails}
					</th>
					<th rowspan="2">
						${uiLabelMap.barge}
					</th>
					<th colspan="2">
						${uiLabelMap.orderQuantity}
					</th>
					<th colspan="2">
						${uiLabelMap.unitPrice}
					</th>
					<th colspan="2">
						${uiLabelMap.commissionUnitPrice}
					</th>
					<th rowspan="2">
						${uiLabelMap.paintBrand}
					</th>
					<th rowspan="2">
						${uiLabelMap.paintCode}
					</th>
					<th rowspan="2">
						${uiLabelMap.paintColor}
					</th>
					<th rowspan="2">
						${uiLabelMap.paintCoatingThickness}
					</th>
				</tr>
				<tr>
					<th>
						${uiLabelMap.grade}
					</th>
					<th>
						${uiLabelMap.gradeDesc}
					</th>
					<th>
						${uiLabelMap.coatingWeight}
					</th>
					<th>
						${uiLabelMap.coatingWeightDesc}
					</th>
					<th>
						${uiLabelMap.surfaceCoilType}
					</th>
					<th>
						${uiLabelMap.surfaceCoilTypeDesc}
					</th>
					<th>
						${uiLabelMap.gauge}
					</th>
					<th>
						${uiLabelMap.gaugeUnit}
					</th>
					<th>
						${uiLabelMap.gaugeDesc}
					</th>
					<th>
						${uiLabelMap.width}
					</th>
					<th>
						${uiLabelMap.widthDesc}
					</th>
					<th>
						${uiLabelMap.packaging}
					</th>
					<th>
						${uiLabelMap.packagingDesc}
					</th>
					<th>
						${uiLabelMap.orderQuantity}
					</th>
					<th>
						${uiLabelMap.orderQuantity} Unit
					</th>
					<th>
						${uiLabelMap.unitPrice}
					</th>
					<th>
						${uiLabelMap.priceUnit}
					</th>
					<th>
						${uiLabelMap.commissionUnitPrice}
					</th>
					<th>
						${uiLabelMap.commissionUnitPrice} Unit
					</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			<tfoot>
				<tr>
					<th>
						${uiLabelMap.lotNo}
					</th>
					<th>
						${uiLabelMap.destination}
					</th>
					<th>
						${uiLabelMap.steelType}
					</th>
					<th>
						${uiLabelMap.grade}
					</th>
					<th>
						${uiLabelMap.gradeDesc}
					</th>
					<th>
						${uiLabelMap.coatingWeight}
					</th>
					<th>
						${uiLabelMap.coatingWeightDesc}
					</th>
					<th>
						${uiLabelMap.surfaceCoilType}
					</th>
					<th>
						${uiLabelMap.surfaceCoilTypeDesc}
					</th>
					<th>
						${uiLabelMap.gauge}
					</th>
					<th>
						${uiLabelMap.gaugeUnit}
					</th>
					<th>
						${uiLabelMap.gaugeDesc}
					</th>
					<th>
						${uiLabelMap.width}
					</th>
					<th>
						${uiLabelMap.widthDesc}
					</th>
					<th>
						${uiLabelMap.coilMaxWeight}
					</th>
					<th>
						${uiLabelMap.innerDiameter}
					</th>
					<th>
						${uiLabelMap.gaugeControlYield}
					</th>
					<th>
						${uiLabelMap.packaging}
					</th>
					<th>
						${uiLabelMap.packagingDesc}
					</th>
					<th>
						${uiLabelMap.businessClass}
					</th>
					<th>
						${uiLabelMap.customerNm}
					</th>
					<th>
						${uiLabelMap.otherDetails}
					</th>
					<th>
						${uiLabelMap.barge}
					</th>
					<th>
						${uiLabelMap.orderQuantity}
					</th>
					<th>
						${uiLabelMap.orderQuantity} Unit
					</th>
					<th>
						${uiLabelMap.unitPrice}
					</th>
					<th>
						${uiLabelMap.priceUnit}
					</th>
					<th>
						${uiLabelMap.commissionUnitPrice}
					</th>
					<th>
						${uiLabelMap.commissionUnitPrice}
					</th>
					<th>
						${uiLabelMap.paintBrand}
					</th>
					<th>
						${uiLabelMap.paintCode}
					</th>
					<th>
						${uiLabelMap.paintColor}
					</th>
					<th>
						${uiLabelMap.paintCoatingThickness}
					</th>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<div>
	<ul>
	<#if crudMode == "RC">
		<input id="submitBtn" type="button" value="${uiLabelMap.submit}" class="buttontext"/>
	<#else>
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
