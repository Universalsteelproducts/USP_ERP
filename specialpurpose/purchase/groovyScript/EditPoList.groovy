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

poCommonInfo = [:]
poInfo = [:]
vendorInfo = [:]
lotInfoList = []
totalQuantity = BigDecimal.ZERO
totalPrice = BigDecimal.ZERO
totalQuantityUnit = ""
totalPriceUnit = ""
codeList = []
codeList = from("Code").queryList()

poNo = parameters.poNo
updateMode = "C"
if(poNo) {
	poInfo = from("PoMaster").where("poNo", poNo).queryOne()
	vendorId = poInfo.get("vendorId").trim();
	vendorInfo = from("Vendor").where("vendorId", vendorId).queryOne()
	lotInfoList = from("Reference").where("poNo", poNo).queryList()
	poCommonInfo.putAll(poInfo)
	poCommonInfo.putAll(vendorInfo)

	lotInfoList.each { lotInfo ->
    	if(lotInfo.coilDescription == "PPGI" || lotInfo.coilDescription == "PPGL") {
    		totalQuantity += lotInfo.unitQuantity
    	} else {
    		totalQuantity += lotInfo.orderQuantity
    	}
    	totalPrice += lotInfo.unitPrice
	}

	totalQuantityUnit = lotInfoList[0].quantityUnit
	totalPriceUnit = lotInfoList[0].priceUnit

	updateMode = "U"
}

context.poCommonInfo = poCommonInfo
context.lotInfoList = lotInfoList
context.codeList = codeList
context.updateMode =  updateMode
context.totalQuantity = totalQuantity
context.totalPrice = totalPrice
context.totalQuantityUnit = totalQuantityUnit
context.totalPriceUnit = totalPriceUnit