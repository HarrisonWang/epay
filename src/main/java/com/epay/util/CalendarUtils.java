package com.epay.util;

import java.util.Calendar;
import java.util.Date;

public class CalendarUtils {

	/**
	 * 判断当前两个日历是否为同一月
	 * @param c1 第一个日历
	 * @param c2 第二个日历
	 * @return true是同一月，false不是同一月
	 */
	public static boolean isSameMonth(Calendar c1, Calendar c2) {
		int month1 = c1.get(2);
		int month2 = c2.get(2);
		return month1 == month2;
	}

	/**
	 * 判断当前两个日期是否为同一月
	 * @param date1 第一个日期
	 * @param date2 第二个日期
	 * @return true是同一月，false不是同一月
	 */
	public static boolean isSameMonth(Date date1, Date date2) {
		Calendar c1 = Calendar.getInstance();
		c1.setTime(date1);
		Calendar c2 = Calendar.getInstance();
		c2.setTime(date2);
		int month1 = c1.get(2);
		int month2 = c2.get(2);
		return month1 == month2;
	}
}
