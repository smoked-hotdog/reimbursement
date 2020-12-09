package com.andzro.reimbursement.admin.core;

import com.andzro.reimbursement.admin.infrastructure.repository.Admin;

import java.util.List;
import java.util.Optional;

public interface AdminGateway {

    Optional<Admin> getAdmin(Long adminId); //Optional with Admin object, Optional with no Object

    List<Admin> getAdminList();

    Admin createAdmin(Admin admin);

    Optional<Admin> updateAdmin(Admin admin);
}
