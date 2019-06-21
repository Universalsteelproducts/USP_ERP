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
package com.usp.testdemo.services;

import java.util.Iterator;
import java.util.Map;
import java.util.stream.Stream;

import org.apache.ofbiz.base.util.Debug;
import org.apache.ofbiz.entity.Delegator;
import org.apache.ofbiz.entity.GenericEntityException;
import org.apache.ofbiz.entity.GenericValue;
import org.apache.ofbiz.service.DispatchContext;
import org.apache.ofbiz.service.ServiceUtil;

public class TestDemoServices {

    public static final String module = TestDemoServices.class.getName();

    public static Map<String, Object> createTestDemo2(DispatchContext dctx, Map<String, ? extends Object> context) {
        Map<String, Object> result = ServiceUtil.returnSuccess();
        Delegator delegator = dctx.getDelegator();
        try {
            GenericValue testDemo = delegator.makeValue("TestDemoJoinTest");


//            *** Map에 담겨있는 key, value 출력 시 사용할 수 있는 로직
//
//            Debug.log("===========================================================");
//            Debug.log("!@!@!@!@! = " + testDemo.size());
//            Debug.log("===========================================================");
//
//            // 1. using Iterator
//    		Iterator<String> itr = testDemo.keySet().iterator();
//    		while (itr.hasNext()) {
//    			Debug.log("111===========================================================");
//				Debug.log(itr.next());
//				Debug.log("111===========================================================");
//    		}
//
//    		// 2. For-each Loop
//    		for (String key : testDemo.keySet()) {
//    			Debug.log("222===========================================================");
//				Debug.log(key);
//				Debug.log("222===========================================================");
//    		}
//
//    		// 3. Java 8 - Collection.iterator() + Iterator.forEachRemaining()
//    		//forEachRemaining는 while(hasNext())를 포함하고 있다.
//    		Debug.log("333===========================================================");
//    		testDemo.keySet().iterator()
//    				.forEachRemaining(Debug::log);
//    		Debug.log("333===========================================================");
//
//    		// 4. Java 8 - Collection.stream() + Stream.forEach()
//    		Debug.log("444===========================================================");
//    		testDemo.keySet().stream()
//    				.forEach(Debug::log);
//    		Debug.log("444===========================================================");
//
//    		// Java 8 - Stream.of() + Collection.toArray() + Stream.forEach()
//    		Debug.log("555===========================================================");
//    		Stream.of(testDemo.keySet().toArray()).forEach(System.out::println);
//    		Debug.log("555===========================================================");
//
//    		// 5. Convert to String
//    		Debug.log("666===========================================================");
//    		Debug.log(testDemo.keySet().toString());
//    		Debug.log("666===========================================================");
//
//    		// Java 8
//    		Stream.of(testDemo.keySet().toString())
//    				.forEach(System.out::println);
//
//            for (String keys : testDemo.keySet())
//            {
//            	Debug.log("===========================================================");
//            	System.out.println(keys);
//            	System.out.println(testDemo.get(keys));
//            	Debug.log("===========================================================");
//            }

            // Auto generating next sequence of ofbizDemoId primary key
            // ofbizDemo.setNextSeqId();
		    testDemo.setPKFields(context);
		    // Setting up all non primary key field values from context map
		    testDemo.setNonPKFields(context);

		    Debug.log("==========This is my first Java Service implementation in Apache OFBiz. OfbizDemo record created successfully with testDemoId:"+testDemo.getString("testDemoId"));
		    // Creating record in database for OfbizDemo entity for prepared value
		    testDemo = delegator.create(testDemo);
//		    result.put("testDemoId", testDemo.getString("testDemoId"));
            Debug.log("==========This is my first Java Service implementation in Apache OFBiz. OfbizDemo record created successfully with testDemoId:"+testDemo.getString("testDemoId"));
        } catch (GenericEntityException e) {
            Debug.logError(e, module);
            return ServiceUtil.returnError("Error in creating record in OfbizDemo entity ........" +module);
        }

        return result;
    }
}