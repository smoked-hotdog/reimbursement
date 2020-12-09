package com.andzro.reimbursement.admin.core;

import com.andzro.reimbursement.admin.infrastructure.repository.Admin;

import java.util.List;

public interface AdminService {

    Admin getAdmin(Long adminId);

    List<Admin> getAdminList();

    Admin createAdmin(Admin admin);

    Admin updateAdmin(Admin admin);
}
