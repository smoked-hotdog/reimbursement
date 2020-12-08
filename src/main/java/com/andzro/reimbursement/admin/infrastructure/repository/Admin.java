package com.andzro.reimbursement.admin.infrastructure.repository;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Date;

@Entity
@Getter
@Setter
public class Admin {
    @Id
    private int admin_id;
    private String first_name;
    private String last_name;
    private String email;]
}
