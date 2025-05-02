package org.myweb.first.inout.model.dto;

import java.sql.Date;

public class InOutVoice implements java.io.Serializable {
	private static final long serialVersionUID = -532640774794378721L;
	
	private String inoutvoiceId;
	private String inoutvoiceName;
	private String inoutvoiceType;
	private String orderId;
	private String workerId;
	private String warehouseId;
	private Date createdAt;
	
	public InOutVoice() {
		super();
	}

	public InOutVoice(String inoutvoiceId, String inoutvoiceName, String inoutvoiceType, String orderId,
			String workerId, String warehouseId, Date createdAt) {
		super();
		this.inoutvoiceId = inoutvoiceId;
		this.inoutvoiceName = inoutvoiceName;
		this.inoutvoiceType = inoutvoiceType;
		this.orderId = orderId;
		this.workerId = workerId;
		this.warehouseId = warehouseId;
		this.createdAt = createdAt;
	}

	public String getInoutvoiceId() {
		return inoutvoiceId;
	}

	public void setInoutvoiceId(String inoutvoiceId) {
		this.inoutvoiceId = inoutvoiceId;
	}

	public String getInoutvoiceName() {
		return inoutvoiceName;
	}

	public void setInoutvoiceName(String inoutvoiceName) {
		this.inoutvoiceName = inoutvoiceName;
	}

	public String getInoutvoiceType() {
		return inoutvoiceType;
	}

	public void setInoutvoiceType(String inoutvoiceType) {
		this.inoutvoiceType = inoutvoiceType;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getWorkerId() {
		return workerId;
	}

	public void setWorkerId(String workerId) {
		this.workerId = workerId;
	}

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "InOutVoice [inoutvoiceId=" + inoutvoiceId + ", inoutvoiceName=" + inoutvoiceName + ", inoutvoiceType="
				+ inoutvoiceType + ", orderId=" + orderId + ", workerId=" + workerId + ", warehouseId=" + warehouseId
				+ ", createdAt=" + createdAt + "]";
	}
	
	
	

}
