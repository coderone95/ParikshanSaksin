package com.codesvila.service;

import java.util.List;

import com.codesvila.bean.LibraryBean;
import com.codesvila.model.Library;


public interface LibraryService {

	void saveBook(Library library);

	List<Library> getBookList();

	void deleteBook(int id);

	void updateBook(int id, LibraryBean libraryBean);

}
