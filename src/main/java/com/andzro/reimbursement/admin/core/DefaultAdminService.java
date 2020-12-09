package com.andzro.reimbursement.admin.core;

import com.andzro.reimbursement.admin.infrastructure.repository.Admin;

import java.util.List;

public class DefaultAdminService implements AdminService {

    private final AdminGateway adminGateway;

    @Override
    public Admin getAdmin(Long adminId) {
        return adminGateway.getAdmin(adminId).get();
    }

    @Override
    public List<Admin> getAdminList() {
        return null;
    }

    @Override
    public Admin createAdmin(Admin admin) {
        return null;
    }

    @Override
    public Admin updateAdmin(Admin admin) {
        return null;
    }
}
