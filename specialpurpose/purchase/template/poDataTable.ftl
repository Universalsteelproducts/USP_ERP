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
		$("#poList").DataTable({
			//dom: "Bfrtip",
			dom: "flrtpB",
			"scrollY": true,
	        "scrollX": true,
// 	        "pageLength": 25,
	        fixedHeader: true,
// 	        fixedColumns: {
// 	            leftColumns: 5
// 	        },
	        orderFixed: [[1, 'asc']],
	        rowGroup: {
	            dataSrc: 1
	        },
	        "columnDefs": [
	            {
	                "render": function ( data, type, row ) {
	                    return "LOT" + data;
	                },
	                "targets": 2
	            },
	            {
	                "render": function ( data, type, row ) {
	                    return "<a href='<@ofbizUrl>EditPo?poNo=" + data + "</@ofbizUrl>' class='buttontext'>" + data + "</a>";
	                },
	                "targets": 1
	            },
	            { "width": "100px", "targets": [0,7,9,10,13,14,16,19,21,23] },
	            {
	            	"width": "100px",
	            	"targets": 18,
	            	"render" : function ( data, type, row ) {
	        			if(data != null && data != "") {
	                		data =  "$ " + Number(data).format(2);
	                	} else {
	                		data =  "";
	                	}
	        			return data;
	                },
	                "className" : "dt-right"
	            },
	            { "width": "150px", "targets": [24,25,26] },
	            { "width": "200px", "targets": 15 },
	            { "width": "200px", "targets": 20 },
	            { "width": "200px", "targets": 22 }
	        ],
	        buttons: [
	            'excel'
	        ]
		});

// 		testfunc();
	});

</script>
<table id="poList" class="hover row-border">
	<thead>
		<tr>
			<th style="vertical-align: middle;">${uiLabelMap.poStatus}</th>
			<th style="vertical-align: middle;">${uiLabelMap.poNo}</th>
			<th style="vertical-align: middle;">${uiLabelMap.lotNo}</th>
			<th style="vertical-align: middle;">${uiLabelMap.etd}</th>
			<th style="vertical-align: middle;">${uiLabelMap.eta}</th>
			<th style="vertical-align: middle;">${uiLabelMap.vessel}</th>
			<th style="vertical-align: middle;">${uiLabelMap.port}</th>
			<th style="vertical-align: middle;">${uiLabelMap.steelType}</th>
			<th style="vertical-align: middle;">${uiLabelMap.grade}</th>
			<th style="vertical-align: middle;">${uiLabelMap.coatingWeight}</th>
			<th style="vertical-align: middle;">${uiLabelMap.surfaceCoilType}</th>
			<th style="vertical-align: middle;">${uiLabelMap.gauge}</th>
			<th style="vertical-align: middle;">${uiLabelMap.width}</th>
			<th style="vertical-align: middle;">${uiLabelMap.coilMaxWeight}</th>
			<th style="vertical-align: middle;">${uiLabelMap.innerDiameter}</th>
			<th style="vertical-align: middle;">${uiLabelMap.packaging}</th>
			<th style="vertical-align: middle;">${uiLabelMap.businessClass}</th>
			<th style="vertical-align: middle;">${uiLabelMap.customerId}</th>
			<th style="vertical-align: middle;">${uiLabelMap.unitPrice}</th>
			<th style="vertical-align: middle;">${uiLabelMap.paintCode}</th>
			<th style="vertical-align: middle;">${uiLabelMap.paintColor}</th>
			<th style="vertical-align: middle;">${uiLabelMap.paintType}</th>
			<th style="vertical-align: middle;">${uiLabelMap.priceTerm}</th>
			<th style="vertical-align: middle;">${uiLabelMap.paintBrand}</th>
			<th style="vertical-align: middle;">${uiLabelMap.mtcVerificationStatus}</th>
			<th style="vertical-align: middle;">${uiLabelMap.paintCoatingThickness}</th>
			<th style="vertical-align: middle;">${uiLabelMap.lastUpdateDate}</th>
		</tr>
	</thead>
	<tbody>
	<#if poNReferenceList??>
		<#list poNReferenceList as lotInfo>
		<tr>
			<td>
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "PO_STATUS">
         					<#if codeInfo.code == lotInfo.poStatus! >
         						${codeInfo.codeName!}
         					</#if>
         				</#if>
        			</#list>
        		</#if>
			</td>
			<td>
				${lotInfo.poNo!}
			</td>
			<td>
				${lotInfo.lotNo!}
			</td>
			<td>
				${lotInfo.etd!}
			</td>
			<td>
				${lotInfo.eta!}
			</td>
			<td>
				${lotInfo.vessel!}
			</td>
			<td>
				${lotInfo.port!}
			</td>
			<td>
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "COIL_DESCRIPTION">
         					<#if codeInfo.code == lotInfo.coilDescription! >
         						${codeInfo.codeName!}
         					</#if>
         				</#if>
        			</#list>
        		</#if>
			</td>
			<td>
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "GRADE">
         					<#if codeInfo.code == lotInfo.grade! >
         						${codeInfo.codeName!}
         					</#if>
         				</#if>
        			</#list>
        		</#if>
			</td>
			<td>
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "COATING_WEIGHT">
         					<#if codeInfo.code == lotInfo.coatingWeight! >
         						${codeInfo.codeName!}
         					</#if>
         				</#if>
        			</#list>
        		</#if>
			</td>
			<td>
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "SURFACE_COIL_TYPE">
         					<#if codeInfo.code == lotInfo.surfaceCoilType! >
         						${codeInfo.codeName!}
         					</#if>
         				</#if>
        			</#list>
        		</#if>
			</td>
			<td>
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "GAUGE">
         					<#if codeInfo.code == lotInfo.gauge! >
         						${codeInfo.codeName!}
         					</#if>
         				</#if>
        			</#list>
        		</#if>
			</td>
			<td>
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "WIDHT">
         					<#if codeInfo.code == lotInfo.width! >
         						${codeInfo.codeName!}
         					</#if>
         				</#if>
        			</#list>
        		</#if>
			</td>
			<td>
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "COIL_MAXWEIGHT">
         					<#if codeInfo.code == lotInfo.coilMaxWeight! >
         						${codeInfo.codeName!}
         					</#if>
         				</#if>
        			</#list>
        		</#if>
			</td>
			<td>
				${lotInfo.innerDiameter!}
			</td>
			<td>
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "PACKAGING">
         					<#if codeInfo.code == lotInfo.packaging! >
         						${codeInfo.codeName!}
         					</#if>
         				</#if>
        			</#list>
        		</#if>
			</td>
			<td>
				${lotInfo.businessClass!}
			</td>
			<td>
				${lotInfo.customerId!}
			</td>
			<td>
				${lotInfo.unitPrice!}
			</td>
			<td>
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "PAINT_CODE">
         					<#if codeInfo.code == lotInfo.paintCode! >
         						${codeInfo.codeName!}
         					</#if>
         				</#if>
        			</#list>
        		</#if>
			</td>
			<td>
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "PAINT_COLOR">
         					<#if codeInfo.code == lotInfo.paintColor! >
         						${codeInfo.codeName!}
         					</#if>
         				</#if>
        			</#list>
        		</#if>
			</td>
			<td>
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "PAINT_TYPE">
         					<#if codeInfo.code == lotInfo.paintType! >
         						${codeInfo.codeName!}
         					</#if>
         				</#if>
        			</#list>
        		</#if>
			</td>
			<td>
				${lotInfo.priceTerm!}
			</td>
			<td>
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "PAINT_BRAND">
         					<#if codeInfo.code == lotInfo.paintBrand! >
         						${codeInfo.codeName!}
         					</#if>
         				</#if>
        			</#list>
        		</#if>
			</td>
			<td>
				${lotInfo.mtcVerificationStatus!}
			</td>
			<td>
				${lotInfo.paintCoatingThickness!}
			</td>
			<td>
				${lotInfo.lastUpdateDate!}
			</td>
		</tr>
		</#list>
	</#if>
	</tbody>
	<tfoot>
	</tfoot>
</table>