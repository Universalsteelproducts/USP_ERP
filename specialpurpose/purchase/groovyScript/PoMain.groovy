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

poNReferenceList = []
poNReference = [:]

poList = []
referenceList = []

newCodeList = []
newCodeMap = [:]
codeList = from("Code").queryList()

//poList = from("PoMaster").where("poStatus", "PE").queryList()
poList = from("PoMaster").queryList()
poList.each { poInfo ->
	poNReference.putAll(poInfo)

	referenceList = from("Reference").where("poNo", poInfo.poNo).queryList()
	referenceList.each { referenceInfo ->
		poNReference.putAll(referenceInfo)
		poNReferenceList.add(poNReference)
		poNReference = [:]
		poNReference.putAll(poInfo)
	}
	poNReference = [:]
}

context.poNReferenceList = poNReferenceList
context.codeList = codeList
context.newCodeList = [["22":"22", "33":"33"],["22":"232", "33":"333"]]

/*
context.lotInfoList = lotInfoList
context.updateMode =  updateMode
context.totalQuantity = totalQuantity
context.totalPrice = totalPrice
context.totalQuantityUnit = totalQuantityUnit
context.totalPriceUnit = totalPriceUnit
*/