package com.andzro.reimbursement.reimbursementitem.infrastructure.repository;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Date;

@Entity
@Getter
@Setter
public class ReimbursementLog  {
    @Id
    private int id;
    private int reimbursement_list_id;
    private boolean approved;
    private String reason;
    private Date created_at;
    private int admin_id;
}
