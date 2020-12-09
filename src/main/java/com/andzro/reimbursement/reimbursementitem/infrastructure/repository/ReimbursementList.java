package com.andzro.reimbursement.reimbursementitem.infrastructure.repository;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@Setter
public class ReimbursementList {
    @Id
    private Boolean approved;
    private List<ReimbursementItem> reimbursementItems;
    private LocalDateTime createdAt;
}
