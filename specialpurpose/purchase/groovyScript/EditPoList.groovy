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
import org.apache.ofbiz.entity.GenericValue
import java.text.SimpleDateFormat

poCommonInfo = [:]
poInfo = [:]
vendorInfo = [:]
lotInfoList = []
lotList = []
codeList = []
codeList = from("Code").orderBy("codeGroup", "sort").queryList()

poNo = parameters.poNo
newPoNo = ""
crudMode = "CR"
nowTs = UtilDateTime.nowTimestamp()
poCommonInfo.put("orderDate", nowTs)
if(poNo) {
	poCommonInfo = [:]
	poInfo = from("PoMaster").where("poNo", poNo).queryOne()
	vendorId = poInfo.get("vendorId").trim();
	vendorInfo = from("Vendor").where("vendorId", vendorId).queryOne()
	poCommonInfo.putAll(poInfo)
	poCommonInfo.putAll(vendorInfo)

	if(context.crudMode != null && context.crudMode != "") {
		crudMode = context.crudMode
		poCommonInfo.put("orderDate", nowTs)
		poCommonInfo.put("poStatus", "PE")
	} else {
		crudMode = "UR"
	}

	lotList = select("lotNo").from("Reference").where("poNo", poNo).distinct().queryList()
}

context.poCommonInfo = poCommonInfo
context.codeList = codeList
context.crudMode =  crudMode
context.lotList =  lotList