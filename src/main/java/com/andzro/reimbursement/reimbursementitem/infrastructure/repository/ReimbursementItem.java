package com.andzro.reimbursement.reimbursementitem.infrastructure.repository;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Date;

@Entity
@Getter
@Setter
public class ReimbursementItem {
    @Id
    private Long reimbursement_item_id;
    private Double value;
    private String description;
    private Date receiptDate;
}
