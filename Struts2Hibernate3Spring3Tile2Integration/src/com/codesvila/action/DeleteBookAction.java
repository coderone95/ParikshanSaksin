package com.codesvila.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.LibraryBean;
import com.codesvila.service.LibraryService;
import com.codesvila.utils.CommonUtility;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class DeleteBookAction  extends ActionSupport implements ModelDriven<LibraryBean> {
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Autowired
	private LibraryBean libraryBean;
	@Autowired
	private LibraryService libraryService;
	private List<LibraryBean> books;
	
	@Override
	public LibraryBean getModel() {
		// TODO Auto-generated method stub
		return libraryBean;
	}

	public List<LibraryBean> getBooks() {
		return books;
	}

	public void setBooks(List<LibraryBean> books) {
		this.books = books;
	}
	
	public String deleteBook()
	{
		books = CommonUtility.createLibraryBeanList(libraryService.getBookList());
		for(LibraryBean lb : books)
		{
			if(lb.getId() == libraryBean.getId())
			{
				libraryService.deleteBook(libraryBean.getId());
				addActionMessage("Book Deleted Successfully!!");
				return "success";	
			}
			
		}
		addActionError("Invalid Book ID");
		return "failure";
	}
	

}
