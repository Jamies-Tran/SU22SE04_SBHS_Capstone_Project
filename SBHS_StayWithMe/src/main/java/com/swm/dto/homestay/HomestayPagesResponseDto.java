package com.swm.dto.homestay;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class HomestayPagesResponseDto {
	private List<HomestayResponseDto> homestayListDto;
	private Integer totalPages;
}
