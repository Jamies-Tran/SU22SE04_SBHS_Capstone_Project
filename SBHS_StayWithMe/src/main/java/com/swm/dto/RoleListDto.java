package com.swm.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class RoleListDto {
	List<RoleDto> roleList;
}
