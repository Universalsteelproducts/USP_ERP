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
import java.sql.Timestamp;
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

import org.apache.ofbiz.base.conversion.JSONConverters;
import org.apache.ofbiz.base.util.Debug;
import org.apache.ofbiz.base.util.StringUtil;
import org.apache.ofbiz.base.util.UtilDateTime;
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
import org.json.JSONArray;
import org.json.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Splitter;

public class PurchaseServices {

    public static final String module = PurchaseServices.class.getName();

    public static Map<String, Object> CRUDPoList(DispatchContext dctx, Map<String, ?> context) {
    	Delegator delegator = dctx.getDelegator();
        Map<String, Object> result = ServiceUtil.returnSuccess();
        GenericValue userLogin = (GenericValue) context.get("userLogin");

        String crudMode = context.get("crudMode") == null ? "" : (String) context.get("crudMode");
    	String searchPoNo = context.get("searchPoNo") == null ? "" : (String) context.get("searchPoNo");
    	Timestamp searchOrderFromDate = (Timestamp) context.get("searchOrderFromDate");
    	Timestamp searchOrderToDate = UtilDateTime.getDayEnd((Timestamp) context.get("searchOrderToDate"));
        String searchVendorId = context.get("searchVendorId") == null ? "" : (String) context.get("searchVendorId");
        String searchCustomerId = context.get("searchCustomerId") == null ? "" : (String) context.get("searchCustomerId");
        String searchPort = context.get("searchPort") == null ? "" : (String) context.get("searchPort");
        String searchGrade = context.get("searchGrade") == null ? "" : (String) context.get("searchGrade");
        String searchCoatingWeight = context.get("searchCoatingWeight") == null ? "" : (String) context.get("searchCoatingWeight");
        String searchSurfaceCoilType = context.get("searchSurfaceCoilType") == null ? "" : (String) context.get("searchSurfaceCoilType");
        String searchGauge = context.get("searchGauge") == null ? "" : (String) context.get("searchGauge");
        String searchWidth = context.get("searchWidth") == null ? "" : (String) context.get("searchWidth");
        String draw = "";

        List<Map<String, Object>> resultList = new LinkedList<Map<String,Object>>();
        if (userLogin != null) {
        	String userLoginId = (String) userLogin.get("userLoginId");

	        try {
	        	if("R".equals(crudMode)) {
		        	List<EntityCondition> poConditionList = UtilMisc.<EntityCondition>toList(
		                    EntityCondition.makeCondition("orderDate", EntityOperator.GREATER_THAN_EQUAL_TO, searchOrderFromDate),
		                    EntityCondition.makeCondition("orderDate", EntityOperator.LESS_THAN_EQUAL_TO, searchOrderToDate));

		        	if(!"".equals(searchPoNo)) {
		        		poConditionList.add(EntityCondition.makeCondition("poNo", EntityOperator.IN, searchPoNo));
		        	}
		        	if(!"".equals(searchVendorId)) {
		        		poConditionList.add(EntityCondition.makeCondition("vendorId", EntityOperator.EQUALS, searchVendorId));
		        	}

		            EntityCondition poListCondition = EntityCondition.makeCondition(poConditionList, EntityOperator.AND);

		        	List<GenericValue> poMasterList = EntityQuery.use(delegator)
				               .from("PoMaster")
				               .where(poListCondition)
				               .queryList();

		        	Map<String, Object> conditionMap = new HashMap<String, Object>();
					if(!"".equals(searchCustomerId)) {
						conditionMap.put("customerId", searchCustomerId);
					}
					if(!"".equals(searchPort)) {
						conditionMap.put("port", searchPort);
					}
					if(!"".equals(searchGrade)) {
						conditionMap.put("grade", searchGrade);
					}
					if(!"".equals(searchCoatingWeight)) {
						conditionMap.put("coatingWeight", searchCoatingWeight);
					}
					if(!"".equals(searchSurfaceCoilType)) {
						conditionMap.put("surfaceCoilType", searchSurfaceCoilType);
					}
					if(!"".equals(searchGauge)) {
						conditionMap.put("gauge", searchGauge);
					}
					if(!"".equals(searchWidth)) {
						conditionMap.put("width", searchWidth);
					}

		        	for(GenericValue poMasterInfo : poMasterList) {
		        		List<GenericValue> referenceList = poMasterInfo.getRelated("Reference", conditionMap, null, false);
		        		if(referenceList.size() > 0) {
			        		for(GenericValue referenceInfo : referenceList) {
			        			Map<String, Object> resultMap = new HashMap<String, Object>();
			            		resultMap.putAll(poMasterInfo);
			            		resultMap.putAll(referenceInfo);
			            		resultList.add(resultMap);
			        		}
		        		}
		        	}
//	        	} else if("U".equals(crudMode) || "C".equals(crudMode)) {
	        	} else {
	        		draw = context.get("draw") == null ? "" : (String) context.get("draw");
	        		String reqData = (String) context.get("reqData");
	        		JSONArray data = new JSONArray(reqData);//jsonarray 형태로
	                Map<String, Object> resultMap = new HashMap<String, Object>();

	                GenericValue createNUpdatePoInfo = delegator.makeValue("PoMaster");
	                GenericValue createNUpdateReferenceInfo = delegator.makeValue("Reference");

	                if(data.length() > 0) {
	                	for(int i=0 ; data.length() > i ; i++) {
	                		JSONObject jsonobj = data.getJSONObject(i);
	                		Map<String, Object> map = new HashMap<String, Object>();

	                	    Iterator<String> keysItr = jsonobj.keys();
	                	    while(keysItr.hasNext()) {
	                	        String key = keysItr.next();
	                	        Object value = new Object();
	                	        if("etd".equals(key) || "eta".equals(key)
	                	        		|| "lastUpdatedStamp".equals(key)) {
	                	        	Timestamp tempT = (Timestamp) jsonobj.get(key);
	                	        	value = tempT;
	                	        } else if("orderQuantity".equals(key) || "quantity".equals(key)
	                	        		|| "price".equals(key) || "commissionUnitPrice".equals(key)) {
	                	        	value = (jsonobj.get(key) == null || "".equals(jsonobj.get(key)) ? 0 : Integer.parseInt((String)jsonobj.get(key)));
	                	        } else {
	                	        	value = jsonobj.get(key);
	                	        }
	                	        map.put(key, value);
	                	    }

	                		createNUpdatePoInfo.setPKFields(map);
	    	                createNUpdatePoInfo.setNonPKFields(map);
	    	                createNUpdateReferenceInfo.setPKFields(map);
	    	                createNUpdateReferenceInfo.setNonPKFields(map);

	    	                if("C".equals(crudMode)) {
	    	                	createNUpdatePoInfo.set("createUserId", userLoginId);
	    	                	createNUpdateReferenceInfo.set("createUserId", userLoginId);
	    	                } else if("U".equals(crudMode)) {
	    	                	createNUpdatePoInfo.set("lastUpdateUserId", userLoginId);
	    	                	createNUpdateReferenceInfo.set("lastUpdateUserId", userLoginId);
	    	                }

	    	                createNUpdatePoInfo = delegator.createOrStore(createNUpdatePoInfo);
	    	                createNUpdateReferenceInfo = delegator.createOrStore(createNUpdateReferenceInfo);
	    	                Debug.logInfo("3in createNUpdatePoInfo," + createNUpdatePoInfo.toString(), null);
	    	                Debug.logInfo("4in createNUpdatePoInfo," + createNUpdateReferenceInfo.toString(), null);

	    	                resultMap.putAll(createNUpdatePoInfo);
	    	                resultMap.putAll(createNUpdateReferenceInfo);
	    	                resultList.add(resultMap);

	    	                createNUpdatePoInfo.clear();
	    	                createNUpdateReferenceInfo.clear();
	                	}
	                }
	        	}
	        } catch (GenericEntityException e){
	            Debug.logError(e, "Cannot Search PoList ", module);
	        }
        }
        result.put("data", resultList);
        result.put("draw", draw);
        result.put("recordsTotal", resultList.size());
        result.put("recordsFiltered", resultList.size());

        return result;
    }

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
            result.put("result", createVendorNPoInfo);
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

            createReferenceInfo = delegator.createOrStore(createReferenceInfo);
            result.put("result", createReferenceInfo);
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