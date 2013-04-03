package com.epay.model;

import java.util.List;

public class Page<T> {

	private int currentPage;
	private int pageSize;
	private int totalCount;
	private int totalPage;
	private int previousPage;
	private int nextPage;
	private boolean hasPreviousPage;
	private boolean hasNextPage;
	private int beginIndex;
	private List<T> content;
	public static final int DEFUALT_PAGE_SIZE = 15;
	public static final int DEFUALT_PAGE = 1;

	public Page(int currentPage, int pageSize, int totalCount) {
		this.currentPage = currentPage > 0 ? currentPage : DEFUALT_PAGE;
		this.pageSize = pageSize > 0 ? pageSize : DEFUALT_PAGE_SIZE;
		this.totalCount = totalCount;
		previousPage = this.currentPage - 1;
		if (previousPage < 1) {
			hasPreviousPage = false;
			previousPage = 1;
		} else {
			hasPreviousPage = true;
		}
		totalPage = ((totalCount + this.pageSize) - 1) / this.pageSize;
		nextPage = this.currentPage + 1;
		if (nextPage > totalPage) {
			hasNextPage = false;
			nextPage = totalPage;
		} else {
			hasNextPage = true;
		}
		beginIndex = (this.currentPage - 1) * this.pageSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getPreviousPage() {
		return previousPage;
	}

	public void setPreviousPage(int previousPage) {
		this.previousPage = previousPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public boolean isHasPreviousPage() {
		return hasPreviousPage;
	}

	public void setHasPreviousPage(boolean hasPreviousPage) {
		this.hasPreviousPage = hasPreviousPage;
	}

	public boolean isHasNextPage() {
		return hasNextPage;
	}

	public void setHasNextPage(boolean hasNextPage) {
		this.hasNextPage = hasNextPage;
	}

	public int getBeginIndex() {
		return beginIndex;
	}

	public void setBeginIndex(int beginIndex) {
		this.beginIndex = beginIndex;
	}

	public List<T> getContent() {
		return content;
	}

	public void setContent(List<T> content) {
		this.content = content;
	}
}
