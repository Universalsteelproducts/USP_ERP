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
<form name="searchform" action="<@ofbizUrl>UpdatePoIssue</@ofbizUrl>#topform" method="post">
	<input type="hidden" name="UPDATE_MODE" value=""/>

	<!-- Vendor Info -->
	<div class="screenlet">
		<!-- Vendor Info -->
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">${uiLabelMap.vendor}</li>
			</ul>
			<br class="clear"/>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.vendor}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<@htmlTemplate.lookupField value="${vendorId!}" formName="searchform" name="vendorId" id="vendorId" fieldFormName="LookupVendor"/>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.orderDate}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<@htmlTemplate.renderDateTimeField name="fromDate" event="" action="" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" value="" size="25" maxlength="50" id="orderDate" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
						<span class="tooltip">
							(${uiLabelMap.PurchaseWillBeSetToNow})
						</span>
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.vendorAddr}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="vendorAddr" value="" size="60" maxlength="255"/>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.priceTerm}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="vendorAddr" value="" size="25" maxlength="255"/>
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.email}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="email" name="email" value="" size="25" maxlength="255"/>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.freightTerm}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="freightTerm" value="" size="25" maxlength="255"/>
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.tel}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="tel" value="" size="25" maxlength="255"/>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.paymentTerm}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="vendorAddr" value="" size="25" maxlength="255"/>
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.fax}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="fax" value="" size="25" maxlength="255"/>
					</td>
					<td class="label" width="13%" align="right">
						${uiLabelMap.downPayment}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						$ <input type="text" name="downPayment" value="" size="23" maxlength="255"/>
					</td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.remark}
					</td>
					<td width="2%">&nbsp;</td>
					<td colspan="4">
						<textarea name="remark" rows="3"></textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- PO Info -->
	<div class="screenlet">
		<!-- PO Info -->
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">${uiLabelMap.poInfo}</li>
			</ul>
			<br class="clear"/>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.poNo}
					</td>
					<td width="1%">&nbsp;</td>
					<td colspan="4">
						<input type="text" name="poNo" value="" size="25" maxlength="255" disabled="disabled"/>
					</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.shipmentMonth}
					</td>
					<td width="1%">&nbsp;</td>
					<td colspan="4">
						<input type="text" name="shipmentMonth" value="" size="25" maxlength="255"/>
					</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.totalQuantity}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="totalQuantity" value="" size="25" maxlength="255"/>
						<select name="quantityType" size="1">
							<option value="MT">MT</option>
							<option value="ST">ST</option>
							<option value="FT">FT</option>
							<option value="LBS">LBS</option>
						</select>
					</td>
					<td class="label" width="12%" align="right">
						${uiLabelMap.totalPoAmount}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="35%">
						<input type="text" name="totalPoAmount" value="" size="23" maxlength="255"/>
						<select name="priceType" size="1">
							<option value="MT">$/MT</option>
							<option value="ST">$/ST</option>
							<option value="FT">$/FT</option>
							<option value="LBS">$/LBS</option>
						</select>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- LOT Info -->
	<div class="screenlet">
		<!-- PO Info -->
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">${uiLabelMap.lotInfo}</li>
			</ul>
			<br class="clear"/>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.lot}
					</td>
					<td width="1%"></td>
					<td colspan="7">
						<select name="lotNo" size="1">
							<option value="LOT1">LOT1</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.destination}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="shipmentMonth" value="" size="25" maxlength="255"/>
					</td>
					<td class="label" width="12%" align="right">
						${uiLabelMap.coilDescription}
					</td>
					<td width="1%">&nbsp;</td>
					<td colspan="4">
						<select name="quantityType" style="width:19%;">
							<option value="MT">MT</option>
							<option value="ST">ST</option>
							<option value="FT">FT</option>
							<option value="LBS">LBS</option>
						</select>
						<input type="text" name="shipmentMonth" value="" style="width:80%;" size="25" maxlength="255"/>
					</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.totalQuantity}
					</td>
					<td width="1%">&nbsp;</td>
					<td colspan="7">
						<div>
							<ui>
								<select name="quantityType" style="width:20%;">
									<option value="MT">MT</option>
									<option value="ST">ST</option>
									<option value="FT">FT</option>
									<option value="LBS">LBS</option>
								</select>
								<select name="quantityType" style="width:20%;">
									<option value="MT">MT</option>
									<option value="ST">ST</option>
									<option value="FT">FT</option>
									<option value="LBS">LBS</option>
								</select>
								<select name="quantityType" style="width:20%;">
									<option value="MT">MT</option>
									<option value="ST">ST</option>
									<option value="FT">FT</option>
									<option value="LBS">LBS</option>
								</select>
								<select name="quantityType" style="width:20%;">
									<option value="MT">MT</option>
									<option value="ST">ST</option>
									<option value="FT">FT</option>
									<option value="LBS">LBS</option>
								</select>
								<select name="quantityType" style="width:19%;">
									<option value="MT">MT</option>
									<option value="ST">ST</option>
									<option value="FT">FT</option>
									<option value="LBS">LBS</option>
								</select>
							</ui>
							<ui>
								<input type="text" name="shipmentMonth" value="" style="width:20%;" size="25" maxlength="255" disabled="disabled"/>
								<input type="text" name="shipmentMonth" value="" style="width:20%;" size="25" maxlength="255" disabled="disabled"/>
								<input type="text" name="shipmentMonth" value="" style="width:20%;" size="25" maxlength="255" disabled="disabled"/>
								<input type="text" name="shipmentMonth" value="" style="width:20%;" size="25" maxlength="255" disabled="disabled"/>
								<input type="text" name="shipmentMonth" value="" style="width:19%;" size="25" maxlength="255" disabled="disabled"/>
							</ui>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.coilMaxWeight}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="shipmentMonth" value="" size="25" maxlength="255"/>
					</td>
					<td class="label" width="12%" align="right">
						${uiLabelMap.coilId}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="shipmentMonth" value="" size="25" maxlength="255"/>
					</td>
					<td class="label" width="12%" align="right">
						${uiLabelMap.guageControllYield}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="shipmentMonth" value="" size="25" maxlength="255"/>
					</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.packaging}
					</td>
					<td width="1%">&nbsp;</td>
					<td colspan="4">
						<select name="quantityType" style="width:19%;">
							<option value="MT">MT</option>
							<option value="ST">ST</option>
							<option value="FT">FT</option>
							<option value="LBS">LBS</option>
						</select>
						<input type="text" name="shipmentMonth" value="" style="width:80%;" size="25" maxlength="255"/>
					</td>
					<td class="label" width="12%" align="right">
						${uiLabelMap.classes}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<select name="quantityType" style="width:70%;">
							<option value="MT">MT</option>
							<option value="ST">ST</option>
							<option value="FT">FT</option>
							<option value="LBS">LBS</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.customer}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<@htmlTemplate.lookupField value="${customerId!}" formName="searchform" name="customerId" id="customerId" fieldFormName="LookupCustomer"/>
					</td>
					<td class="label" width="12%" align="right">
						${uiLabelMap.otherDetails}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="shipmentMonth" value="" size="25" maxlength="255"/>
					</td>
					<td class="label" width="12%" align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
				</tr>
			</table>
			<hr />
			<div>
				<ul style="display:none;">
					<table class="basic-table" cellspacing="0">
						<tr>
							<td class="label" width="12%" align="right">
								${uiLabelMap.orderQuantity}
							</td>
							<td width="1%">&nbsp;</td>
							<td width="20%">
								<input type="text" name="totalQuantity" value="" size="25" maxlength="255"/>
								<select name="quantityType" size="1">
									<option value="MT">MT</option>
									<option value="ST">ST</option>
									<option value="FT">FT</option>
									<option value="LBS">LBS</option>
								</select>
							</td>
							<td class="label" width="12%" align="right">
								${uiLabelMap.otherDetails}
							</td>
							<td width="1%">&nbsp;</td>
							<td width="20%">
								<input type="text" name="totalQuantity" value="" size="25" maxlength="255"/>
								<select name="quantityType" size="1">
									<option value="MT">MT</option>
									<option value="ST">ST</option>
									<option value="FT">FT</option>
									<option value="LBS">LBS</option>
								</select>
							</td>
							<td class="label" width="12%" align="right">&nbsp;</td>
							<td width="1%">&nbsp;</td>
							<td width="20%">&nbsp;</td>
						</tr>
					</table>
				</ul>
				<ul style="display:display;">
					<table class="basic-table" cellspacing="0">
						<tr>
							<td class="label" width="12%" align="right">
								${uiLabelMap.paintBrand}
							</td>
							<td width="1%">&nbsp;</td>
							<td width="20%">
								<input type="text" name="totalQuantity" value="" size="25" maxlength="255"/>
							</td>
							<td class="label" width="12%" align="right">
								${uiLabelMap.paintType}
							</td>
							<td width="1%">&nbsp;</td>
							<td width="20%">
								<input type="text" name="totalQuantity" value="" size="25" maxlength="255"/>
							</td>
							<td class="label" width="12%" align="right">
								${uiLabelMap.unitQuantity}
							</td>
							<td width="1%">&nbsp;</td>
							<td width="20%">
								<input type="text" name="totalQuantity" value="" size="25" maxlength="255"/>
								<select name="quantityType" size="1">
									<option value="MT">MT</option>
									<option value="ST">ST</option>
									<option value="FT">FT</option>
									<option value="LBS">LBS</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="label" width="12%" align="right">
								${uiLabelMap.paintCode}
							</td>
							<td width="1%">&nbsp;</td>
							<td width="20%">
								<input type="text" name="totalQuantity" value="" size="25" maxlength="255"/>
							</td>
							<td class="label" width="12%" align="right">
								${uiLabelMap.color}
							</td>
							<td width="1%">&nbsp;</td>
							<td width="20%">
								<input type="text" name="totalQuantity" value="" size="25" maxlength="255"/>
							</td>
							<td class="label" width="12%" align="right">
								${uiLabelMap.unitPrice}
							</td>
							<td width="1%">&nbsp;</td>
							<td width="20%">
								<input type="text" name="totalQuantity" value="" size="25" maxlength="255"/>
								<select name="quantityType" size="1">
									<option value="MT">MT</option>
									<option value="ST">ST</option>
									<option value="FT">FT</option>
									<option value="LBS">LBS</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="label" width="12%" align="right">
								${uiLabelMap.paintCoatingThickness}
							</td>
							<td width="1%">&nbsp;</td>
							<td colspan="4">
								<select name="paintCoatingThickness" style="width:19%;">
									<option value="MT">$/MT</option>
									<option value="ST">$/ST</option>
									<option value="FT">$/FT</option>
									<option value="LBS">$/LBS</option>
								</select>
								<input type="text" name="shipmentMonth" value="" style="width:80%;" size="25" maxlength="255"/>
							</td>
							<td class="label" width="12%" align="right">&nbsp;</td>
							<td width="1%">&nbsp;</td>
							<td width="20%">&nbsp;</td>
						</tr>
					</table>
				</ul>
				<ul>
					<table class="basic-table" cellspacing="0">
						<tr>
							<td class="label" width="30%" align="right">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td width="1%">&nbsp;</td>
							<td colspan="7">
								<input type="button" value="${uiLabelMap.addLot}" class="buttontext"/>
								<input type="button" value="${uiLabelMap.addColor}" class="buttontext"/>
							</td>
						</tr>
					</table>
				</ul>
				<hr />
				<ul>
					<table class="basic-table" cellspacing="0">
						<tr class="header-row">
							<td>
								${uiLabelMap.lotNo}
							</td>
							<td>
								${uiLabelMap.destination}
							</td>
							<td>
								${uiLabelMap.coilDescription}
							</td>
							<td>
								${uiLabelMap.coilGrade}
							</td>
							<td>
								${uiLabelMap.coatingWeight}
							</td>
							<td>
								${uiLabelMap.type}
							</td>
							<td>
								${uiLabelMap.gauge}
							</td>
							<td>
								${uiLabelMap.width}
							</td>
							<td>
								${uiLabelMap.coilMaxWeight}
							</td>
							<td>
								${uiLabelMap.coilId}
							</td>
							<td>
								${uiLabelMap.gaugeControlYield}
							</td>
							<td>
								${uiLabelMap.packaging}
							</td>
							<td>
								${uiLabelMap.customer}
							</td>
							<td>
								${uiLabelMap.otherDetails}
							</td>
							<td>
								${uiLabelMap.quantity}
							</td>
							<td>
								${uiLabelMap.price}
							</td>
							<td>
								${uiLabelMap.paintBrand}
							</td>
							<td>
								${uiLabelMap.paintType}
							</td>
							<td>
								${uiLabelMap.paintCode}
							</td>
							<td>
								${uiLabelMap.color}
							</td>
							<td>
								${uiLabelMap.paintCoatingThickness}
							</td>
							<td>&nbsp;</td>
							<td>&nbsp;&nbsp;&nbsp;</td>
			            </tr>
			            <tr>
			            	<td>
								LOT1
							</td>
							<td>
								destination
							</td>
							<td>
								coilDescription
							</td>
							<td>
								coilGrade
							</td>
							<td>
								coatingWeight
							</td>
							<td>
								type
							</td>
							<td>
								gauge
							</td>
							<td>
								width
							</td>
							<td>
								coilMaxWeight
							</td>
							<td>
								coilId
							</td>
							<td>
								gaugeControlYield
							</td>
							<td>
								packaging
							</td>
							<td>
								customer
							</td>
							<td>
								otherDetails
							</td>
							<td>
								quantity
							</td>
							<td>
								price
							</td>
							<td>
								paintBrand
							</td>
							<td>
								paintType
							</td>
							<td>
								paintCode
							</td>
							<td>
								color
							</td>
							<td>
								paintCoatingThickness
							</td>
							<td>
								<input type="button" value="${uiLabelMap.delete}" class="buttontext"/>
							</td>
							<td>
								<input type="button" value="${uiLabelMap.update}" class="buttontext"/>
							</td>
			            </tr>
					</table>
				</ul>
			</div>
		</div>
	</div>
	<div>
		<ul>
			<input type="submit" value="${uiLabelMap.submit}" class="buttontext"/>
		</ul>
	</div>
</form>
