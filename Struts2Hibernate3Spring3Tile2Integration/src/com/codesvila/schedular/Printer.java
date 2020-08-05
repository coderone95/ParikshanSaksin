package com.codesvila.schedular;

import java.util.Date;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
 
@Component("printer")
public class Printer {
	
	private static final Logger LOG = Logger.getLogger(Printer.class);
	
    public void print() {
        System.out.println("Executed Printing Job..." + new Date());
    	LOG.debug("Executed Printing Job..."+ new Date());
    }
}
