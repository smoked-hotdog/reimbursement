package com.andzro.reimbursement.employeeaccountlogs.repository;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
@Getter
@Setter
public class EmployeeAccountLogs {
    @Id
    Integer employee_account_log_id;
    Integer reimbursement_list_id;
    Integer employee_id;
    Double reimbursement_cost;
}
