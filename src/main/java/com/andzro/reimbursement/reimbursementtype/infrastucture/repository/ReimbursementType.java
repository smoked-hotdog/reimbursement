package com.andzro.reimbursement.reimbursementtype.infrastucture.repository;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
@Getter
@Setter
public class ReimbursementType {
    @Id
    private String reimbursement_name;
    private String description;
}
