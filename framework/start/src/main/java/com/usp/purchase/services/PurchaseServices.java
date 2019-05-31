/*******************************************************************************
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
 *******************************************************************************/
package com.usp.purchase.services;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ofbiz.base.util.Debug;
import org.apache.ofbiz.base.util.UtilGenerics;
import org.apache.ofbiz.base.util.UtilMisc;
import org.apache.ofbiz.base.util.UtilProperties;
import org.apache.ofbiz.base.util.UtilValidate;
import org.apache.ofbiz.entity.Delegator;
import org.apache.ofbiz.entity.GenericEntityException;
import org.apache.ofbiz.entity.GenericValue;
import org.apache.ofbiz.entity.condition.EntityCondition;
import org.apache.ofbiz.entity.condition.EntityOperator;
import org.apache.ofbiz.entity.util.EntityQuery;
import org.apache.ofbiz.entity.util.EntityUtilProperties;
import org.apache.ofbiz.party.contact.ContactMechWorker;
import org.apache.ofbiz.service.DispatchContext;
import org.apache.ofbiz.service.ServiceUtil;

public class PurchaseServices {

    public static final String module = PurchaseServices.class.getName();

    public static Map<String, Object> searchVendor(DispatchContext dctx, Map<String, ?> context) {
    	Delegator delegator = dctx.getDelegator();
        Map<String, Object> result = ServiceUtil.returnSuccess();

        try {
            // Check if the country is a country group and get recursively the
            // states
        	Map<String, Object> vendorInfo = new HashMap<String, Object>();
        	vendorInfo = EntityQuery.use(delegator)
		               .from("Vendor")
		               .where("vendorId", context.get("vendorId"))
		               .queryOne();

        	result.put("vendorInfo", vendorInfo);

        } catch (GenericEntityException e){
            Debug.logError(e, "Cannot lookup Vendor ", module);
        }

        return result;
    }

    public static Map<String, Object> searchCustomer(DispatchContext dctx, Map<String, ?> context) {
    	Delegator delegator = dctx.getDelegator();
        Map<String, Object> result = ServiceUtil.returnSuccess();

        try {
            // Check if the country is a country group and get recursively the
            // states
        	Map<String, Object> customerInfo = new HashMap<String, Object>();
        	customerInfo = EntityQuery.use(delegator)
		               .from("Customer")
		               .where("customerId", context.get("customerId"))
		               .queryOne();

        	result.put("customerInfo", customerInfo);

        } catch (GenericEntityException e){
            Debug.logError(e, "Cannot lookup Customer ", module);
        }

        return result;
    }

    public static Map<String, Object> createPOList(HttpServletRequest request, HttpServletResponse response) {
    	Map<String, Object> result = ServiceUtil.returnSuccess();
    	Delegator delegator = (Delegator) request.getAttribute("delegator");

        Map<String, Object> vendorInfo = UtilGenerics.checkMap(request.getParameter("vendorInfo"));
        Map<String, Object> poInfo = UtilGenerics.checkMap(request.getParameter("poInfo"));
        List<GenericValue> lotInfo = UtilGenerics.checkList(request.getParameter("lotInfo"));

        Debug.logInfo("in createPOList111, " + lotInfo.size(), null);

        Debug.logInfo("in createPOList222, " + vendorInfo.toString(), null);
        Debug.logInfo("in createPOList222, " + poInfo.toString(), null);
        Debug.logInfo("in createPOList222, " + lotInfo.toString(), null);

        return result;
    }

    public static Map<String, Object> createNUpdateVendorNPoInfo(DispatchContext dctx, Map<String, ? extends Object> context) {
        Map<String, Object> result = ServiceUtil.returnSuccess();
        Delegator delegator = dctx.getDelegator();
        try {
            GenericValue createVendorNPoInfo = delegator.makeValue("PoMaster");
            createVendorNPoInfo.setPKFields(context);
            createVendorNPoInfo.setNonPKFields(context);
            createVendorNPoInfo = delegator.createOrStore(createVendorNPoInfo);
//            result.put("result", createVendorNPoInfo);
		    Debug.logInfo("in createVendorNPoInfo, " + createVendorNPoInfo.toString(), null);
        } catch (GenericEntityException e) {
            Debug.logError(e, module);
            return ServiceUtil.returnError("Error in creating record in OfbizDemo entity ........" +module);
        }

        return result;
    }

    public static Map<String, Object> cancelPo(DispatchContext dctx, Map<String, ? extends Object> context) {
        Map<String, Object> result = ServiceUtil.returnSuccess();
        Delegator delegator = dctx.getDelegator();
        try {
            GenericValue createVendorNPoInfo = delegator.makeValue("PoMaster");
            createVendorNPoInfo.set("poNo", context.get("poNo"));
            createVendorNPoInfo.set("poStatus", context.get("poNo"));
            delegator.store(createVendorNPoInfo);
//            result.put("result", createVendorNPoInfo);
		    Debug.logInfo("in createVendorNPoInfo, " + createVendorNPoInfo.toString(), null);
        } catch (GenericEntityException e) {
            Debug.logError(e, module);
            return ServiceUtil.returnError("Error in creating record in OfbizDemo entity ........" +module);
        }

        return result;
    }

    public static Map<String, Object> createNUpdateReferenceInfo(DispatchContext dctx, Map<String, ? extends Object> context) {
        Map<String, Object> result = ServiceUtil.returnSuccess();
        Delegator delegator = dctx.getDelegator();
        try {
        	String updateMode = (String)context.get("updateMode");
        	Debug.logInfo("******************************************* , " + updateMode, null);

            GenericValue createReferenceInfo = delegator.makeValue("Reference");
            createReferenceInfo.setPKFields(context);
            createReferenceInfo.setNonPKFields(context);
            Debug.logInfo("******************************************* , " + updateMode, null);
            if("C".equals(updateMode)) {
            	long seqNum = EntityQuery.use(delegator).from("Reference").queryCount();
            	long nextSeqNum = seqNum + 1;
            	Map<String, Long> sequenceNum = UtilMisc.toMap("referenceSeq", nextSeqNum);
            	createReferenceInfo.setFields(sequenceNum);

            	long ppglNum = EntityQuery.use(delegator).from("Reference")
            			.where("lotNo", createReferenceInfo.get("lotNo"), "poNo", createReferenceInfo.get("poNo"), "referenceNo", createReferenceInfo.get("referenceNo")).queryCount();
            	long nextPpglNum = ppglNum + 1;
            	Map<String, Long> ppglNumVal = UtilMisc.toMap("ppglNo", nextPpglNum);
            	createReferenceInfo.setFields(ppglNumVal);
            }

            Debug.log("in createVendorNPoInfo, " + createReferenceInfo.toString());
            Debug.logInfo("in createVendorNPoInfo, " + createReferenceInfo.toString(), null);
            System.out.println("******************************************* , " + createReferenceInfo.toString());
            createReferenceInfo = delegator.createOrStore(createReferenceInfo);
//            result.put("referenceSeq", createReferenceInfo.getString("referenceSeq"));
//            result.put("referenceNo", createReferenceInfo.getString("referenceNo"));
//		    result.put("lotNo", createReferenceInfo.getString("lotNo"));
//		    result.put("ppglNo", createReferenceInfo.getString("ppglNo"));
		    Debug.logInfo("in createReferenceInfo, " + createReferenceInfo.getString("referenceSeq"), null);
		    Debug.logInfo("in createReferenceInfo, " + createReferenceInfo.getString("referenceNo"), null);
		    Debug.logInfo("in createReferenceInfo, " + createReferenceInfo.getString("lotNo"), null);
		    Debug.logInfo("in createReferenceInfo, " + createReferenceInfo.getString("ppglNo"), null);
        } catch (GenericEntityException e) {
            Debug.logError(e, module);
            return ServiceUtil.returnError("Error in creating record in OfbizDemo entity ........" +module);
        }

        return result;
    }

    /**
	* RequestParam 정보를 List<LinkedHashMap<String, Object>>로 변환 함.
	*
	* @param request HttpServletRequest 객체.
	* @return List<LinkedHashMap<String, Object>> 변환 한 값.
	*/
	@SuppressWarnings("unchecked")
	public static List<LinkedHashMap<String, Object>> reqParamsConvList(HttpServletRequest request) {
		List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String, Object>>();

		Map<String,String[]> params = (Map<String,String[]>)request.getParameterMap();
		LinkedHashMap<String, Object> parameterValues = new LinkedHashMap<String, Object>();
		int maxIdx = 0;
		for (Map.Entry<String,String[]> entry : params.entrySet()) {
		    String k = entry.getKey();
		    String v[] = entry.getValue();
		    Object o = (v.length == 1) ? (String)v[0] : v;

		    if( maxIdx < v.length ) maxIdx = v.length;

		    parameterValues.put(k, o);
		}

		if( maxIdx > 1 ) {
			LinkedHashMap<String, Object> tmpMap = new LinkedHashMap<String, Object>();
			for( int idx=0; idx<maxIdx; idx++ ) {
			    for(String keyStr : parameterValues.keySet() ) {
				    if(parameterValues.get(keyStr) instanceof String[]) {
					    String[] arryValues = (String[])parameterValues.get(keyStr);
					    try {
					  	    tmpMap.put(keyStr, arryValues[idx]);
					    } catch(Exception e) {
					    	tmpMap.put(keyStr, "");
					    }
				    } else {
					  tmpMap.put(keyStr, parameterValues.get(keyStr));
				    }
			    }
			    list.add(tmpMap);
			    tmpMap = new LinkedHashMap<String, Object>();
			}
		} else {
			list.add(parameterValues);
		}

		return list;
	}

	/**
	* ajaxParams 정보를 List<LinkedHashMap<String, Object>>로 변환 함.
	*
	* @param Map<String, String[]> params 객체.
	* @return List<LinkedHashMap<String, Object>> 변환 한 값.
	*/
	@SuppressWarnings("unchecked")
	public static List<LinkedHashMap<String, Object>> ajaxParamsConvList(Map<String, String[]> params) {
		List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String, Object>>();
		LinkedHashMap<String, Object> parameterValues = new LinkedHashMap<String, Object>();
		int maxIdx = 0;
		for (Map.Entry<String,String[]> entry : params.entrySet()) {
		    String k = entry.getKey();
		    String v[] = entry.getValue();
		    Object o = (v.length == 1) ? (String)v[0] : v;

		    if( maxIdx < v.length ) maxIdx = v.length;

		    parameterValues.put(k, o);
		}

		if( maxIdx > 1 ) {
			LinkedHashMap<String, Object> tmpMap = new LinkedHashMap<String, Object>();
			for( int idx=0; idx<maxIdx; idx++ ) {
			    for(String keyStr : parameterValues.keySet() ) {
				    if(parameterValues.get(keyStr) instanceof String[]) {
					    String[] arryValues = (String[])parameterValues.get(keyStr);
					    try {
					  	    tmpMap.put(keyStr, arryValues[idx]);
					    } catch(Exception e) {
					    	tmpMap.put(keyStr, "");
					    }
				    } else {
					  tmpMap.put(keyStr, parameterValues.get(keyStr));
				    }
			    }
			    list.add(tmpMap);
			    tmpMap = new LinkedHashMap<String, Object>();
			}
		} else {
			list.add(parameterValues);
		}

		return list;
	}
}