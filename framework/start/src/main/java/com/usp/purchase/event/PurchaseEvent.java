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
package com.usp.purchase.event;

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

public class PurchaseEvent {

    public static final String module = PurchaseEvent.class.getName();

    public static Map<String, Object> CRUDPoList111(HttpServletRequest request, HttpServletResponse response) {
    	Map<String, Object> result = ServiceUtil.returnSuccess();
    	Delegator delegator = (Delegator) request.getAttribute("delegator");

    	String poNo = request.getParameter("searchPoNo") == null ? "" : request.getParameter("searchPoNo");
        String orderFromDate = request.getParameter("searchOrderFromDate") == null ? "" : request.getParameter("searchOrderFromDate");
        String orderToDate = request.getParameter("searchOrderToDate") == null ? "" : request.getParameter("searchOrderToDate");
        String vendorId = request.getParameter("searchVendorId") == null ? "" : request.getParameter("searchVendorId");
        String customerId = request.getParameter("searchCustomerId") == null ? "" : request.getParameter("searchCustomerId");
        String port = request.getParameter("searchPort") == null ? "" : request.getParameter("searchPort");
        String grade = request.getParameter("searchGrade") == null ? "" : request.getParameter("searchGrade");
        String coatingWeight = request.getParameter("searchCoatingWeight") == null ? "" : request.getParameter("searchCoatingWeight");
        String surfaceCoilType = request.getParameter("searchSurfaceCoilType") == null ? "" : request.getParameter("searchSurfaceCoilType");
        String gauge = request.getParameter("searchGauge") == null ? "" : request.getParameter("searchGauge");
        String width = request.getParameter("searchWidth") == null ? "" : request.getParameter("searchWidth");

        Debug.logInfo("poNo = " + poNo, null);
        Debug.logInfo("orderFromDate = " + orderFromDate, null);
        Debug.logInfo("orderToDate = " + orderToDate, null);
        Debug.logInfo("vendorId = " + vendorId, null);
        Debug.logInfo("customerId = " + customerId, null);
        Debug.logInfo("port = " + port, null);
        Debug.logInfo("grade = " + grade, null);

        Map<String, Object> data = new HashMap<String, Object>();
        data.put("ddd", "dddd");

        result.put("data", data);

        return result;
    }

}