package com.andzro.reimbursement.employeeaccounts.repository;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Date;

@Entity
@Getter
@Setter
public class EmployeeAccounts {
    @Id
    private Integer employee_id;
    private Integer account_type_id;
    private Double current_balance;
    private Date created_at;
    private Date last_updated;
}