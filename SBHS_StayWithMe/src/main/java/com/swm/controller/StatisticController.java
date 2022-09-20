package com.swm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.swm.entity.SystemStatisticEntity;
import com.swm.service.ISystemStatisticService;

@RestController
@RequestMapping("/api/statistic")
public class StatisticController {
	
	@Autowired
	private ISystemStatisticService systemStatisticService;
	
	
//	@PostMapping
//	@PreAuthorize("hasRole('ROLE_ADMIN')")
//	public ResponseEntity<?> createSystemStatistic() {
//		systemStatisticService.createSystemStatistic(new SystemStatisticEntity());
//		
//		return new ResponseEntity<>(HttpStatus.CREATED);
//	}
}
