package com.swm.service;

import java.util.List;

import com.swm.entity.RoleEntity;

public interface IRoleService {
	RoleEntity findRoleByName(String name);
	
	RoleEntity createRole(RoleEntity role);
	
	void addRoleList(List<RoleEntity> roleList);
}
