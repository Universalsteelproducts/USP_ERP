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
		 ******************			Common Control				********************
		 ***************************************************************************/
		var poListTable = $("#poList").DataTable({
			dom : "Blfrtip",
			processing : true,
			scrollY : true,
	        scrollX : true,
	        fixedHeader : true,
	        fixedColumns : {
	            leftColumns: 3
	        },
			order: [
				[1, 'desc'],
				[2, 'asc'],
				[3, 'asc']
			],
	        ajax : {
	        	"type"		: "POST",
	            "url"		: '<@ofbizUrl>RUPoList</@ofbizUrl>',
	            "data"		: function(d) {
	            	d.draw = "0";
	            	d.crudMode = $("#crudMode").val();
	            	d.searchPoNo = $("#searchPoNo").val();
	            	d.searchOrderFromDate = $("#searchOrderFromDate").val();
	            	d.searchOrderToDate = $("#searchOrderToDate").val();
	            	d.searchVendorId = $("input[name=searchVendorId]").val();
	            	d.searchCustomerId = $("input[name=searchCustomerId]").val();
	            	d.searchPort = $("#searchPort").val();
	            	d.searchGrade = $("#searchGrade").val();
	            	d.searchCoatingWeight = $("#searchCoatingWeight").val();
	            	d.searchSurfaceCoilType = $("#searchSurfaceCoilType").val();
	            	d.searchGauge = $("#searchGauge").val();
	            	d.searchWidth = $("#searchWidth").val();
	            }
	        },
	        columns : [
	        	{
	        		"data" : "poStatus",
        			"render": function ( data, type, row ) {
        				var $select = $("<select></select>", {
        	                "id" : "poStatus",
        	                "value" : data
        	            });
        				var $option = $("#poStatusTemp").html();
       	                $select.append($option);
       	             	$select.find("[value='" + data + "']").attr("selected", "selected");
       	             	$select.attr("class", "poStatus");
            			return $select.prop("outerHTML");
	                }
	        	},
	        	{
	        		"data" : "poNo",
	        		"render": function ( data, type, row ) {
	        			return "<a href='<@ofbizUrl>EditPo?poNo=" + data + "</@ofbizUrl>' class='buttontext'>" + data + "</a>";
	                }
	        	},
	        	{
	        		"data" : "lotNo",
	        		"render": function ( data, type, row ) {
	                    return "<b>LOT" + data + "</b>";
	                },
	                "width" : "60px"
	        	},
	        	{
	        		"data" : "referenceNo",
	        		"render": function ( data, type, row ) {
	                    return "<b>" + data + "</b>";
	                }
	        	},
// 	        	{
// 	        		"data" : "etd",
// 	  				"width" : "70px"
// 	  			},
// 	        	{
// 	  				"data" : "eta",
// 	  				"width" : "70px"
// 	  			},
	        	{
	  				"data" : "vessel",
	  				"width" : "150px"
	  			},
	        	{
	  				"data" : "port",
	  				"width" : "70px"
	  			},
	        	{
	  				"data" : "steelType",
	  				"width" : "70px"
	  			},
	        	{
	        		"data" : "grade",
	        		"render": function ( data, type, row ) {
	        			var returnStr = "";
       				<#if codeList??>
    					<#list codeList as codeInfo>
    						<#if codeInfo.codeGroup == "GRADE">
             					if("${codeInfo.code}" == $.trim(data)) {
             						returnStr = "${codeInfo.codeName!}";
             					}
             				</#if>
            			</#list>
            		</#if>
            			return returnStr;
	                }
	        	},
	        	{
	        		"data" : "coatingWeight",
	        		"render": function ( data, type, row ) {
	        			var returnStr = "";
       				<#if codeList??>
    					<#list codeList as codeInfo>
    						<#if codeInfo.codeGroup == "COATING_WEIGHT">
             					if("${codeInfo.code}" == $.trim(data)) {
             						returnStr = "${codeInfo.codeName!}";
             					}
             				</#if>
            			</#list>
            		</#if>
            			return returnStr;
	                },
	  				"width" : "100px"
	        	},
	        	{
	        		"data" : "surfaceCoilType",
	        		"render": function ( data, type, row ) {
	        			var returnStr = "";
       				<#if codeList??>
    					<#list codeList as codeInfo>
    						<#if codeInfo.codeGroup == "SURFACE_COIL_TYPE">
             					if("${codeInfo.code}" == $.trim(data)) {
             						returnStr = "${codeInfo.codeName!}";
             					}
             				</#if>
            			</#list>
            		</#if>
            			return returnStr;
	                },
	  				"width" : "100px"
	        	},
	        	{
	        		"data" : "gauge",
	        		"render": function ( data, type, row ) {
	        			var returnStr = "";
       				<#if codeList??>
    					<#list codeList as codeInfo>
    						<#if codeInfo.codeGroup == "GAUGE">
             					if("${codeInfo.code}" == $.trim(data)) {
             						returnStr = "${codeInfo.codeName!}";
             					}
             				</#if>
            			</#list>
            		</#if>
            			return returnStr;
	                }
	        	},
	        	{
	        		"data" : "width",
	        		"render": function ( data, type, row ) {
	        			var returnStr = "";
       				<#if codeList??>
    					<#list codeList as codeInfo>
    						<#if codeInfo.codeGroup == "WIDTH">
             					if("${codeInfo.code}" == $.trim(data)) {
             						returnStr = "${codeInfo.codeName!}";
             					}
             				</#if>
            			</#list>
            		</#if>
            			return returnStr;
	                }
	        	},
	        	{
	        		"data" : "paintBrand",
	        		"render": function ( data, type, row ) {
	        			var returnStr = "";
       				<#if codeList??>
    					<#list codeList as codeInfo>
    						<#if codeInfo.codeGroup == "PAINT_BRAND">
             					if("${codeInfo.code}" == $.trim(data)) {
             						returnStr = "${codeInfo.codeName!}";
             					}
             				</#if>
            			</#list>
            		</#if>
            			return returnStr;
	                },
	  				"width" : "100px"
	        	},
	        	{
	        		"data" : "paintCode",
	  				"width" : "100px"
	        	},
	        	{
	        		"data" : "paintColor",
	        		"width": "200px",
	        		"render": function ( data, type, row ) {
	        			var returnStr = "";
       				<#if codeList??>
    					<#list codeList as codeInfo>
    						<#if codeInfo.codeGroup == "PAINT_COLOR">
             					if("${codeInfo.code}" == $.trim(data)) {
             						returnStr = "${codeInfo.codeName!}";
             					}
             				</#if>
            			</#list>
            		</#if>
            			return returnStr;
	                }
	        	},
	        	{
	        		"data" : "paintType",
	        		"render": function ( data, type, row ) {
	        			var returnStr = "";
       				<#if codeList??>
    					<#list codeList as codeInfo>
    						<#if codeInfo.codeGroup == "PAINT_TYPE">
             					if("${codeInfo.code}" == $.trim(data)) {
             						returnStr = "${codeInfo.codeName!}";
             					}
             				</#if>
            			</#list>
            		</#if>
            			return returnStr;
	                },
	  				"width" : "100px"
	        	},
	        	{
	        		"data" : "coilMaxWeight",
	        		"render": function ( data, type, row ) {
	        			var returnStr = "";
       				<#if codeList??>
    					<#list codeList as codeInfo>
    						<#if codeInfo.codeGroup == "COIL_MAX_WEIGHT">
             					if("${codeInfo.code}" == $.trim(data)) {
             						returnStr = "${codeInfo.codeName!}";
             					}
             				</#if>
            			</#list>
            		</#if>
            			return returnStr;
	                },
	  				"width" : "110px"
	        	},
	        	{
	        		"data" : "innerDiameter",
	  				"width" : "100px"
	        	},
	        	{
	        		"data" : "packaging",
	        		"width": "200px",
	        		"render": function ( data, type, row ) {
	        			var returnStr = "";
        			<#if codeList??>
       					<#list codeList as codeInfo>
       						<#if codeInfo.codeGroup == "PACKAGING">
                					if("${codeInfo.code}" == $.trim(data)) {
                						returnStr = "${codeInfo.codeName!}";
                					}
                				</#if>
               			</#list>
               		</#if>
               			return returnStr;
   	                }
	        	},
	        	{
	        		"data" : "businessClass",
        			"render": function ( data, type, row ) {
        				var returnStr = "";
          			<#if codeList??>
       					<#list codeList as codeInfo>
       						<#if codeInfo.codeGroup == "BUSINESS_CLASS">
                					if("${codeInfo.code}" == $.trim(data)) {
                						returnStr = "${codeInfo.codeName!}";
                					}
                				</#if>
               			</#list>
               		</#if>
               			return returnStr;
   	                },
	  				"width" : "100px"
	        	},
	        	{
	        		"data" : "customerId",
	  				"width" : "100px"
	        	},
	        	{
	        		"data" : "unitPrice",
	        		"render" : function ( data, type, row ) {
	        			var newData = "";
	        			if(data != null && data != "") {
	        				newData =  "$ " + Number(data).format(2);
	                	} else {
	                		newData =  "";
	                	}
	        			return newData;
	                },
	                "className" : "dt-right",
	  				"width" : "100px"
	        	},
	        	{
	        		"data" : "priceTerm",
	        		"width": "200px"
	        	},
	        	{
	        		"data" : "mtcDocFileYN",
	        		"render": function ( data, type, row ) {
	        			var returnStr = "";
       				<#if codeList??>
    					<#list codeList as codeInfo>
    						<#if codeInfo.codeGroup == "PAINT_BRAND">
             					if("${codeInfo.code}" == $.trim(data)) {
             						returnStr = "${codeInfo.codeName!}";
             					}
             				</#if>
            			</#list>
            		</#if>
            			return returnStr;
	                },
	  				"width" : "140px"
	        	},
	        	{
	        		"data" : "paintCoatingThickness",
	        		"render": function ( data, type, row ) {
	        			var returnStr = "";
       				<#if codeList??>
    					<#list codeList as codeInfo>
    						<#if codeInfo.codeGroup == "PAINT_COATING_THICKNESS">
             					if("${codeInfo.code}" == $.trim(data)) {
             						returnStr = "${codeInfo.codeName!}";
             					}
             				</#if>
            			</#list>
            		</#if>
            			return returnStr;
	                },
	  				"width" : "250px"
	        	},
	        	{
	        		"data" : "lastUpdateUserId",
	  				"width" : "100px"
	        	},
	        	{
	        		"data" : "lastUpdatedStamp",
	        		"render" : function ( data, type, row ) {
	        			var date = new Date(data);
	        			var d = date.getDate();
	        			if(d < 10) {
	        				d = "0" + d;
	        			}
	        			var m = date.getMonth();
        				m += 1;
	        			if(m < 10) {
	        				m = "0" + m;
	        			}
	        			var y = date.getFullYear();

						return y + "-" + m + "-" + d;
	        		}
	        	},
// 	        	{
// 	        		"data" : "",
// 	        		"render": function ( data, type, row ) {
// 	        			return "<a href='<@ofbizUrl>EditPo?poNo=" + row.poNo + "&crudMode=CL</@ofbizUrl>' class='buttontext'>CLONE</a>";
// 	                },
// 	                "orderable" : false
// 	        	},
	        	{
	        		"data" : "referenceSeq",
	        		"visible": false,
	        	},
	        	{
	        		"data" : "ppglNo",
	        		"visible": false,
	        	}
	        ]
		});

// 		$('#poList tbody').on( 'dblclick', 'tr', function () {
// 			if ( $(this).hasClass('selected') ) {
// 	            $(this).removeClass('selected');
// 	        }
// 	        else {
// 	        	poListTable.$('tr.selected').removeClass('selected');
// 	            $(this).addClass('selected');
// 	        }
// 	    } );
		/***************************************************************************
		 ******************			Table change Event			********************
		 ***************************************************************************/

		/***************************************************************************
		 ******************			SelectBox Control			********************
		 ***************************************************************************/
		$("#poList").on("change", "select.poStatus",function() {
// 			console.log(poListTable.row().every());
// 			console.log(poListTable.rows().data());
			var reqData = poListTable.rows(this).data();
			var reqArray = new Array();
			for(var i=0 ; reqData.length > i ; i++) {
				var reqMap = new Object();
				var map = reqData[i];
				for(var key in map) {
					if(key == "poStatus") {
						reqMap[key] = $(this).val();
					} else {
						reqMap[key] = $.trim(map[key]);
					}
				}
				reqArray.push(reqMap);
			};

			jQuery.ajax({
				url: '<@ofbizUrl>RUPoList</@ofbizUrl>',
				type: 'POST',
				data: {
					"crudMode" : "SU",
					"reqData" : JSON.stringify(reqArray)
				},
				error: function(msg) {
		            showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
		        },
				success: function(data) {
					if(data.data.length > 0) {
						alert("PO Status Update Complete.");
						$("#searchBtn").click();
					} else {
						alert("PO Status Update Fail.");
					}
				}
			});
		});
		/***************************************************************************
		 ******************				Button Control			********************
		 ***************************************************************************/
		$("#searchBtn").on("click", function() {
			$("#crudMode").val("R");
			poListTable.ajax.reload();
		});
	});
</script>

<div style="display:none;" id="poStatusTemp">
	<#if codeList??>
		<#list codeList as codeInfo>
			<#if codeInfo.codeGroup == "PO_STATUS">
	<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
			</#if>
		</#list>
	</#if>
</div>

<div class="page-title">
	<span>
		${uiLabelMap.po}
	</span>
</div>
<div class="button-bar">
	<a class="buttontext create" href="/purchase/control/EditPo">
		${uiLabelMap.newPo}
	</a>
</div>

<form name="searchForm" id="searchForm" method="post">
	<input type="hidden" name="noConditionFind" value="Y"/>
	<input type="hidden" name="crudMode" id="crudMode" value="R"/>
	<input type="hidden" name="data" id="data" value=""/>
	<!-- Search Condition -->
	<div class="screenlet">
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">${uiLabelMap.searchPoForm}</li>
			</ul>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
					<td class="label" align="right" >
						${uiLabelMap.poNo}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<!-- set_multivalues -->
						<input type="text" name="searchPoNo" id="searchPoNo" maxlength="255"/>
					</td>
					<td class="label" align="right" >
						${uiLabelMap.orderDate}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<@htmlTemplate.renderDateTimeField name="searchOrderFromDate" id="searchOrderFromDate" event="" action="" className="" alert="" title="Format: yyyy-MM-dd" value="${orderFromDate?string('yyyy-MM-dd')}" size="10" maxlength="10" dateType="date" shortDateInput=true timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
						~&nbsp;
						<@htmlTemplate.renderDateTimeField name="searchOrderToDate" id="searchOrderToDate" event="" action="" className="" alert="" title="Format: yyyy-MM-dd" value="${orderToDate?string('yyyy-MM-dd')}" size="10" maxlength="10" dateType="date" shortDateInput=true timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
					</td>
				</tr>
				<tr>
					<td class="label" align="right" >
						${uiLabelMap.vendor}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<!-- set_multivalues -->
						<@htmlTemplate.lookupField value="" formName="searchForm" name="searchVendorId" id="searchVendorId" fieldFormName="LookupVendor" position="center" />
					</td>
					<td class="label" align="right" >
						${uiLabelMap.customerId}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<!-- set_multivalues -->
						<@htmlTemplate.lookupField value="" formName="searchForm" name="searchCustomerId" id="searchCustomerId" fieldFormName="LookupCustomer" position="center" />
					</td>
				</tr>
				<tr>
					<td class="label" align="right">
						${uiLabelMap.port}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="searchPort" id="searchPort" maxlength="255"/>
					</td>
					<td class="label" align="right">
						${uiLabelMap.grade}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<select name="searchGrade" id="searchGrade" style="width:19%;">
							<option value="">--GRADE</option>
						<#if codeList??>
							<#list codeList as codeInfo>
								<#if codeInfo.codeGroup == "GRADE">
	          				<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
	          					</#if>
		        			</#list>
		        		</#if>
						</select>
					</td>
				</tr>
				<tr>
					<td class="label" align="right">
						${uiLabelMap.coatingWeight}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<select name="searchCoatingWeight" id="searchCoatingWeight">
							<option value="">--COATING WEIGHT</option>
						<#if codeList??>
							<#list codeList as codeInfo>
								<#if codeInfo.codeGroup == "COATING_WEIGHT">
	         				<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
		         				</#if>
		        			</#list>
		        		</#if>
						</select>
					</td>
					<td class="label" align="right">
						${uiLabelMap.surfaceCoilType}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<select name="searchSurfaceCoilType" id="searchSurfaceCoilType" style="width:19%;">
							<option value="">--TYPE</option>
						<#if codeList??>
							<#list codeList as codeInfo>
								<#if codeInfo.codeGroup == "SURFACE_COIL_TYPE">
	         				<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
		         				</#if>
		        			</#list>
		        		</#if>
						</select>
					</td>
				</tr>
				<tr>
					<td class="label" align="right">
						${uiLabelMap.gauge}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<select name="searchGauge" id="searchGauge" style="width:14%;">
							<option value="">--GAUGE</option>
						<#if codeList??>
							<#list codeList as codeInfo>
								<#if codeInfo.codeGroup == "GAUGE">
	         				<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
	         					</#if>
		        			</#list>
		        		</#if>
						</select>
					</td>
					<td class="label" align="right">
						${uiLabelMap.width}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<select name="searchWidth" id="searchWidth" style="width:19%;">
							<option value="">--WIDTH</option>
						<#if codeList??>
							<#list codeList as codeInfo>
								<#if codeInfo.codeGroup == "WIDHT">
	         				<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
	         					</#if>
		        			</#list>
		        		</#if>
						</select>
					</td>
				</tr>
				<tr>
					<td class="label" align="right">
						&nbsp;
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="button" id="searchBtn" value="${uiLabelMap.CommonFind}" class="buttontext" />
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>

<!-- Search Result -->
<div class="screenlet">
	<table id="poList" class="hover cell-border stripe">
		<thead>
			<tr>
				<th style="vertical-align: middle;">${uiLabelMap.poStatus}</th>
				<th style="vertical-align: middle;">${uiLabelMap.poNo}</th>
				<th style="vertical-align: middle;">${uiLabelMap.lotNo}</th>
				<th style="vertical-align: middle;">${uiLabelMap.referenceNo}</th>
<!-- 					<th style="vertical-align: middle;">${uiLabelMap.etd}</th> -->
<!-- 					<th style="vertical-align: middle;">${uiLabelMap.eta}</th> -->
				<th style="vertical-align: middle;">${uiLabelMap.vessel}</th>
				<th style="vertical-align: middle;">${uiLabelMap.port}</th>
				<th style="vertical-align: middle;">${uiLabelMap.steelType}</th>
				<th style="vertical-align: middle;">${uiLabelMap.grade}</th>
				<th style="vertical-align: middle;">${uiLabelMap.coatingWeight}</th>
				<th style="vertical-align: middle;">${uiLabelMap.surfaceCoilType}</th>
				<th style="vertical-align: middle;">${uiLabelMap.gauge}</th>
				<th style="vertical-align: middle;">${uiLabelMap.width}</th>
				<th style="vertical-align: middle;">${uiLabelMap.paintBrand}</th>
				<th style="vertical-align: middle;">${uiLabelMap.paintCode}</th>
				<th style="vertical-align: middle;">${uiLabelMap.paintColor}</th>
				<th style="vertical-align: middle;">${uiLabelMap.paintType}</th>
				<th style="vertical-align: middle;">${uiLabelMap.coilMaxWeight}</th>
				<th style="vertical-align: middle;">${uiLabelMap.innerDiameter}</th>
				<th style="vertical-align: middle;">${uiLabelMap.packaging}</th>
				<th style="vertical-align: middle;">${uiLabelMap.businessClass}</th>
				<th style="vertical-align: middle;">${uiLabelMap.customerId}</th>
				<th style="vertical-align: middle;">${uiLabelMap.unitPrice}</th>
				<th style="vertical-align: middle;">${uiLabelMap.priceTerm}</th>
				<th style="vertical-align: middle;">${uiLabelMap.mtcVerificationStatus}</th>
				<th style="vertical-align: middle;">${uiLabelMap.paintCoatingThickness}</th>
				<th style="vertical-align: middle;">${uiLabelMap.lastUpdateUserId}</th>
				<th style="vertical-align: middle;">${uiLabelMap.lastUpdatedStamp}</th>
<!-- 				<th style="vertical-align: middle;"></th> -->
			</tr>
		</thead>
		<tbody>
		</tbody>
		<tfoot>
			<tr>
				<th style="vertical-align: middle;">${uiLabelMap.poStatus}</th>
				<th style="vertical-align: middle;">${uiLabelMap.poNo}</th>
				<th style="vertical-align: middle;">${uiLabelMap.lotNo}</th>
				<th style="vertical-align: middle;">${uiLabelMap.referenceNo}</th>
<!-- 					<th style="vertical-align: middle;">${uiLabelMap.etd}</th> -->
<!-- 					<th style="vertical-align: middle;">${uiLabelMap.eta}</th> -->
				<th style="vertical-align: middle;">${uiLabelMap.vessel}</th>
				<th style="vertical-align: middle;">${uiLabelMap.port}</th>
				<th style="vertical-align: middle;">${uiLabelMap.steelType}</th>
				<th style="vertical-align: middle;">${uiLabelMap.grade}</th>
				<th style="vertical-align: middle;">${uiLabelMap.coatingWeight}</th>
				<th style="vertical-align: middle;">${uiLabelMap.surfaceCoilType}</th>
				<th style="vertical-align: middle;">${uiLabelMap.gauge}</th>
				<th style="vertical-align: middle;">${uiLabelMap.width}</th>
				<th style="vertical-align: middle;">${uiLabelMap.paintBrand}</th>
				<th style="vertical-align: middle;">${uiLabelMap.paintCode}</th>
				<th style="vertical-align: middle;">${uiLabelMap.paintColor}</th>
				<th style="vertical-align: middle;">${uiLabelMap.paintType}</th>
				<th style="vertical-align: middle;">${uiLabelMap.coilMaxWeight}</th>
				<th style="vertical-align: middle;">${uiLabelMap.innerDiameter}</th>
				<th style="vertical-align: middle;">${uiLabelMap.packaging}</th>
				<th style="vertical-align: middle;">${uiLabelMap.businessClass}</th>
				<th style="vertical-align: middle;">${uiLabelMap.customerId}</th>
				<th style="vertical-align: middle;">${uiLabelMap.unitPrice}</th>
				<th style="vertical-align: middle;">${uiLabelMap.priceTerm}</th>
				<th style="vertical-align: middle;">${uiLabelMap.mtcVerificationStatus}</th>
				<th style="vertical-align: middle;">${uiLabelMap.paintCoatingThickness}</th>
				<th style="vertical-align: middle;">${uiLabelMap.lastUpdateUserId}</th>
				<th style="vertical-align: middle;">${uiLabelMap.lastUpdatedStamp}</th>
<!-- 				<th style="vertical-align: middle;"></th> -->
			</tr>
		</tfoot>
	</table>
</div>
