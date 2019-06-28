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
			dom: "flrtp",
			"scrollY": true,
	        "scrollX": true,
// 	        "pageLength": 25,
	        fixedHeader: true,
// 	        fixedColumns: {
// 	            leftColumns: 5
// 	        },
	        order: [[1, 'asc']],
	        rowGroup: {
	            startRender: null,
	            endRender: function ( rows, group ) {
	                var sumUnitPrice = rows
	                    .data()
	                    .pluck(22)
	                    .reduce( function (a, b) {
	                    	a = (a == null || a == "") ? 0 : a;
	                    	b = (b == null || b == "") ? 0 : b;
	                        return parseFloat(a) + parseFloat(b);
	                    }, 0);
	                sumUnitPrice = $.fn.dataTable.render.number(',', '.', 2, '$').display( sumUnitPrice );

	                return $('<tr/>')
	                    .append( '<td colspan="22">Sub Total for ['+group+']</td>' )
	                    .append( '<td class="dt-body-right">'+sumUnitPrice+'</td>' )
	                    .append( '<td colspan="4"></td>' );
	            },
	            dataSrc: 1
	        },
// 			rowGroup: {
// 	            dataSrc: 1
// 	        },
	        "columnDefs": [
	            {
	                "render": function ( data, type, row ) {
	                    return "LOT" + data;
	                },
	                "targets": 2,
	                "width" : "60px"
	            },
	            {
	                "render": function ( data, type, row ) {
	                    return "<a href='<@ofbizUrl>EditPo?poNo=" + data + "</@ofbizUrl>' class='buttontext'>" + data + "</a>";
	                },
	                "targets": 1
	            },
	            {
	            	"render": function ( data, type, row ) {
					<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "STEEL_TYPE">
							if("${codeInfo.code}" == $.trim(row[7])) {
								data = "${codeInfo.codeName!}";
							}
							</#if>
						</#list>
					</#if>
						return data;
					},
	                "targets": 7,
	                "width": "100px"
	            },
	            {
	            	"targets": 17,
	        		"render": function ( data, type, row ) {
        			<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "COIL_MAX_WEIGHT">
							if("${codeInfo.code}" == $.trim(row[18])) {
								data = "${codeInfo.codeName!}";
							}
							</#if>
						</#list>
					</#if>
            			return data;
	                },
	  				"width" : "110px"
	        	},
	        	{
	        		"targets": 25,
	        		"render": function ( data, type, row ) {
        			<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "PAINT_COATING_THICKNESS">
							if("${codeInfo.code}" == $.trim(row[25])) {
								data = "${codeInfo.codeName!}";
							}
							</#if>
						</#list>
					</#if>
            			return data;
	                },
	  				"width" : "250px"
	        	},
	            { "width": "100px", "targets": [0,9,10,13,14,15,16,20] },
	            { "width": "200px", "targets": 19 },
	            { "width": "150px", "targets": [23,24,26] },
	            {
	            	"width": "100px",
	            	"targets": 22,
	            	"render" : function ( data, type, row ) {
	            		var newData = "";
	        			if(data != null && data != "") {
	        				newData =  "$ " + Number(data).format(2);
	                	} else {
	                		newData =  "";
	                	}
	        			return newData;
	                },
	                "className" : "dt-right"
	            }
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
						<#if codeInfo.codeGroup == "STEEL_TYPE">
         					<#if codeInfo.code == lotInfo.steelType! >
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
						<#if codeInfo.codeGroup == "PAINT_BRAND">
         					<#if codeInfo.code == lotInfo.paintBrand! >
         						${codeInfo.codeName!}
         					</#if>
         				</#if>
        			</#list>
        		</#if>
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
				<#if codeList??>
					<#list codeList as codeInfo>
						<#if codeInfo.codeGroup == "COIL_MAX_WEIGHT">
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
				${lotInfo.priceTerm!}
			</td>

			<td>
				${lotInfo.mtcVerificationStatus!}
			</td>
			<td>
				${lotInfo.paintCoatingThickness!}
			</td>
			<td>
				${lotInfo.lastUpdatedStamp!?string("yyyy-MM-dd")}
			</td>
		</tr>
		</#list>
	</#if>
	</tbody>
	<tfoot>
	</tfoot>
</table>