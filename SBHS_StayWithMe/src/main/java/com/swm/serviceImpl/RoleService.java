package com.swm.serviceImpl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.swm.entity.RoleEntity;
import com.swm.exception.DuplicateResourceException;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.IRoleRepository;
import com.swm.service.IRoleService;

@Service
public class RoleService implements IRoleService{

	@Autowired
	private IRoleRepository roleRepo;
	
	private Date currentDate = new Date();
	
	@Override
	public RoleEntity findRoleByName(String name) {
		RoleEntity role = roleRepo.findRoleByName(name).orElseThrow(() -> new ResourceNotFoundException(name, "Role not found"));
		
		return role;
	}

	@Override
	public RoleEntity createRole(RoleEntity role) {
		if(roleRepo.findRoleByName(role.getName()).isPresent()) {
			throw new DuplicateResourceException(role.getName(), "Role exist");
		}
		UserDetails createdBy = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		role.setCreatedDate(currentDate);
		role.setCreatedBy(createdBy.getUsername());
		RoleEntity rolePersisted = roleRepo.save(role);
		
		return rolePersisted;
	}

	@Override
	public void addRoleList(List<RoleEntity> roleList) {
		roleList.forEach(r -> {
			r.setCreatedDate(currentDate);
		});
		roleRepo.saveAll(roleList);
		
	}

}
