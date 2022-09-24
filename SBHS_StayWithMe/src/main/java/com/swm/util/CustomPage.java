package com.swm.util;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class CustomPage<T> {
	private int page;
	private int size;
	private List<T> results;
	
	public List<T> of() {
		List<T> paginationResult = new ArrayList<T>();
		int startedIndex = this.page * this.size;
		int indexCountDown = 0;
		while(indexCountDown < size && startedIndex < this.results.size()) {
			paginationResult.add(results.get(startedIndex));
			startedIndex = startedIndex + 1;
			indexCountDown = indexCountDown + 1;
		}
		
		return paginationResult;
	}
	
	public int totalPages() {
		int totalPages = 0;
		int totalElements = this.results.size();
		while(totalElements > 0) {
			totalPages = totalPages + 1;
			totalElements = totalElements - this.size;
		}
		
		return totalPages;
	}
}
