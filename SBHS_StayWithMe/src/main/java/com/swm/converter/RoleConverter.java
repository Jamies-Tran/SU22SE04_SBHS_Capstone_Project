package com.swm.converter;

import org.springframework.stereotype.Component;

import com.swm.dto.user.RoleDto;
import com.swm.entity.RoleEntity;
import com.swm.enums.AccountRole;

@Component
public class RoleConverter {
	
	
	public RoleEntity roleEntityConvert(RoleDto roleDto) {
		RoleEntity roleEntity = new RoleEntity();
		roleEntity.setName(AccountRole.valueOf(roleDto.getName()).name());
		if(roleDto.getCreatedBy() != null) {
			roleEntity.setCreatedBy(roleDto.getCreatedBy());
		}
		return roleEntity;
	}
	
	public RoleDto roleDtoConvert(RoleEntity roleEntity) {
		RoleDto roleDto = new RoleDto();
		roleDto.setName(AccountRole.valueOf(roleEntity.getName()).name());
		if(roleEntity.getCreatedBy() != null) {
			roleDto.setCreatedBy(roleEntity.getCreatedBy());
		}
		
		return roleDto;
	}
}
