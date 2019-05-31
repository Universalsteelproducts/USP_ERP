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

function deleteRow(e, updateMode) {
	var trTag = e.parent().parent();
	var trId = trTag.attr("id");

	if(updateMode == "C") {
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
}

function updateRow(e, updateMode) {
	var trTag = e.parent().parent();
	var trId = trTag.attr("id");
	alert($('#lotInfo').serialize());
}

function cancelPO(updateMode) {
	if(updateMode == "C") {
		jQuery.ajax({
			url: 'getInvoiceRunningTotal',
			type: 'POST',
			data: $('#trId').serialize(),
			async: false,
			success: function(data) {
			    jQuery('#showInvoiceRunningTotal').html(data.invoiceRunningTotal);
			}
		});
	}
}

function selectedRowClass(e, rowCount, headerRowCnt) {
	if (e.prop("checked")) {
    	for(var i=0 ; parseInt(headerRowCnt) > i ; i++) {
    		if ($("#trRow_" + rowCount + "_" + (i+1)).hasClass("")) {
	        	$("#trRow_" + rowCount + "_" + (i+1)).removeClass();
	        	$("#trRow_" + rowCount + "_" + (i+1)).addClass("selected");
	        } else if ($("#trRow_" + rowCount + "_" + (i+1)).hasClass("alternate-row")) {
	        	$("#trRow_" + rowCount + "_" + (i+1)).removeClass();
	            $("#trRow_" + rowCount + "_" + (i+1)).addClass("alternate-rowSelected");
	        }
		}
    } else {
    	for(var i=0 ; parseInt(headerRowCnt) > i ; i++) {
    		if ($("#trRow_" + rowCount + "_" + (i+1)).hasClass("selected")) {
	        	$("#trRow_" + rowCount + "_" + (i+1)).removeClass();
	        	$("#trRow_" + rowCount + "_" + (i+1)).addClass("");
	        } else if ($("#trRow_" + rowCount + "_" + (i+1)).hasClass("alternate-rowSelected")) {
	        	$("#trRow_" + rowCount + "_" + (i+1)).removeClass();
	        	$("#trRow_" + rowCount + "_" + (i+1)).addClass("alternate-row");
	        }
		}
    }
};

function set_custom_value(vendorId) {
	jQuery.ajax({
		url: '<@ofbizUrl>/searchVendor</@ofbizUrl>',
		type: 'POST',
		data: {"vendorId" : vendorId},
		error: function(msg) {
            showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
        },
		success: function(data) {
		    $.each(data.vendorInfo, function(index, value) {
				if(index == "vendorNm" || index == "vendorAddr" || index == "vendorEmail"
						|| index == "vendorTel" || index == "vendorFax") {
					$("input[name=" + index + "]").val(value);
					$("input[name=" + index + "]").effect("highlight", {}, 3000);
				}
		    });
		}
	});

	set_value(vendorId);
}

