/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
import org.apache.ofbiz.base.util.UtilDateTime

poCommonInfo = [:]
poInfo = [:]
vendorInfo = [:]
lotInfoList = []
lotList = []
totalQuantity = BigDecimal.ZERO
totalPrice = BigDecimal.ZERO
totalQuantityUnit = ""
totalPriceUnit = ""
codeList = []
codeList = from("Code").orderBy("codeGroup", "sort").queryList()

poNo = parameters.poNo
crudMode = "CR"
nowTs = UtilDateTime.nowTimestamp()
poCommonInfo.put("orderDate", nowTs)
if(poNo) {
	crudMode = "UR"
	nowTs = ""
	poCommonInfo = [:]
	poInfo = from("PoMaster").where("poNo", poNo).queryOne()
	vendorId = poInfo.get("vendorId").trim();
	vendorInfo = from("Vendor").where("vendorId", vendorId).queryOne()
	poCommonInfo.putAll(poInfo)
	poCommonInfo.putAll(vendorInfo)

	lotList = select("lotNo").from("Reference").where("poNo", poNo).distinct().queryList()

/*
	lotInfoList = from("Reference").where("poNo", poNo).queryList()
	if(lotInfoList.size() > 0) {
		lotInfoList.each { lotInfo ->
	    	if(lotInfo.steelType == "PPGI" || lotInfo.steelType == "PPGL") {
	    		totalQuantity += lotInfo.unitQuantity == null ? 0 : lotInfo.unitQuantity
	    	} else {
	    		totalQuantity += lotInfo.orderQuantity == null ? 0 : lotInfo.orderQuantity
	    	}
	    	totalPrice += lotInfo.unitPrice == null ? 0 : lotInfo.unitPrice
		}

		totalQuantityUnit = lotInfoList[0].quantityUnit
		totalPriceUnit = lotInfoList[0].priceUnit
	}
	lotInfo = delegator.getNextSeqId("referenceSeq")
*/
}

context.poCommonInfo = poCommonInfo
context.codeList = codeList
context.crudMode =  crudMode
context.lotList =  lotList
/*context.lotInfoList = lotInfoList
context.totalQuantity = totalQuantity
context.totalPrice = totalPrice
context.totalQuantityUnit = totalQuantityUnit
context.totalPriceUnit = totalPriceUnit*/