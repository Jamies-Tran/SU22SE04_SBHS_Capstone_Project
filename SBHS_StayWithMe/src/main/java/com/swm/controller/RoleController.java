package com.swm.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.swm.converter.RoleConverter;
import com.swm.dto.RoleListDto;
import com.swm.entity.RoleEntity;
import com.swm.service.IRoleService;

@RestController
@RequestMapping("/role")
public class RoleController {
	@Autowired
	private IRoleService roleService;

	@Autowired
	private RoleConverter roleConverter;

	@PostMapping
	public ResponseEntity<?> createAccountRole(@RequestBody RoleListDto role) {
		List<RoleEntity> roleList = role.getRoleList().stream().map(r -> roleConverter.roleEntityConvert(r))
				.collect(Collectors.toList());
		roleService.addRoleList(roleList);

		return new ResponseEntity<>(HttpStatus.OK);
	}
}
