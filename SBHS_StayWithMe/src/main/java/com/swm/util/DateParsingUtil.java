package com.swm.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.swm.exception.ParseDateException;

public class DateParsingUtil {

	private static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	private static SimpleDateFormat simpleStatiscticDateFormat = new SimpleDateFormat("yyyy-MM"); 
	
	public static Date statisticYearMonthTime(Date date) {
		Date formatCurrentTime;
		try {
			formatCurrentTime = simpleStatiscticDateFormat.parse(simpleStatiscticDateFormat.format(date));
			return formatCurrentTime;
		} catch (ParseException e) {
			throw new ParseDateException(date.toString());
		}
		
	}

	public static Date parseDateTimeStr(String date) {
		try {
			Date parseDate = simpleDateFormat.parse(date);
			return parseDate;
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static Date formatDateTime(Date date) {
		try {
			Date parseDate = simpleDateFormat.parse(simpleDateFormat.format(date));
			return parseDate;
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static String parseDateTimeToStr(Date date) {
		String parseDate = simpleDateFormat.format(date);
		return parseDate;
	}

}
