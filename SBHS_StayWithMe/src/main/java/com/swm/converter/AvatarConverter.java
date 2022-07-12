package com.swm.converter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import com.swm.dto.AvatarDto;
import com.swm.entity.AvatarEntity;
import com.swm.service.IUserService;

@Component
public class AvatarConverter {
	
	@Autowired
	@Lazy
	private IUserService userService;
	
	public AvatarEntity avatarEntityConverter(AvatarDto avatar) {
		AvatarEntity avatarEntity = new AvatarEntity();
		avatarEntity.setPoster(userService.findUserByUsername(avatar.getPoster()));
		
		return avatarEntity;
	}
	
	public AvatarDto dtoConverter(AvatarEntity avatar) {
		AvatarDto avatarDto = new AvatarDto();
		avatarDto.setPoster(avatar.getPoster().getUsername());
		avatarDto.setUrl(avatar.getUrl());
		
		return avatarDto;
	}
}
