package com.andzro.reimbursement.employee.repository;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
public class Employee {
    @Id
    Integer employee_id;
    String first_name;
    String last_name;
    String contact_number;
    Boolean regular;
    LocalDateTime created_at;
}
