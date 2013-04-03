package com.epay.util;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.epay.model.Proceeds;
import com.epay.model.RefillLog;
import com.epay.model.TradeLog;
import com.epay.model.User;
import com.epay.service.LogService;

public class ExcelUtils {
	
	public static HSSFWorkbook export(List dataList, int type) {
		HSSFWorkbook workbook = null;
		if (type == LogService.TRADE_LOG) {
			workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet("交易记录");
			setSheetColumnWidth(sheet);
			HSSFCellStyle style = createTitleStyle(workbook);
			if (dataList != null && dataList.size() > 0) {
				// 创建第一行标题,标题名字的本地信息通过resources从资源文件中获取
				HSSFRow row = sheet.createRow(0);// 建立新行
				createCell(row, 0, style, HSSFCell.CELL_TYPE_STRING, "序号");
				createCell(row, 1, style, HSSFCell.CELL_TYPE_STRING, "交易账户");
				createCell(row, 2, style, HSSFCell.CELL_TYPE_STRING, "交易金额");
				createCell(row, 3, style, HSSFCell.CELL_TYPE_STRING, "交易时间");
				createCell(row, 4, style, HSSFCell.CELL_TYPE_STRING, "交易类型");
				createCell(row, 5, style, HSSFCell.CELL_TYPE_STRING, "交易用户");
				createCell(row, 6, style, HSSFCell.CELL_TYPE_STRING, "地市");
				createCell(row, 7, style, HSSFCell.CELL_TYPE_STRING, "交易号码");
				createCell(row, 8, style, HSSFCell.CELL_TYPE_STRING, "交易结果");
				createCell(row, 9, style, HSSFCell.CELL_TYPE_STRING, "日志");
				// 给excel填充数据
				for (int i = 0; i < dataList.size(); i++) {
					// 将dataList里面的数据取出来，假设这里取出来的是Model,也就是某个javaBean的意思啦
					TradeLog model = (TradeLog) dataList.get(i);
					HSSFRow row1 = sheet.createRow(i + 1);// 建立新行
					createCell(row1, 0, style, HSSFCell.CELL_TYPE_STRING, i + 1);
					if (model.getAccountNumber() != null) {
						createCell(row1, 1, style, HSSFCell.CELL_TYPE_STRING, model.getAccountNumber());
					}
					if (model.getTradeAmount() != 0D) {
						createCell(row1, 2, style, HSSFCell.CELL_TYPE_STRING, model.getTradeAmount());
					}
					if (model.getTradeTime() != null) {
						createCell(row1, 3, style, HSSFCell.CELL_TYPE_STRING, DateFormatUtils.format(model.getTradeTime(), "yyyy-MM-dd HH:mm:ss"));
					}
					
					if (model.getNumberType() == 0) {
						createCell(row1, 4, style, HSSFCell.CELL_TYPE_STRING, "QQ币");
					} else if (model.getNumberType() == 1) {
						createCell(row1, 4, style, HSSFCell.CELL_TYPE_STRING, "黄金岛");
					} else {
						createCell(row1, 4, style, HSSFCell.CELL_TYPE_STRING, "未知");
					}
					
					if (model.getUserId() != null) {
						createCell(row1, 5, style, HSSFCell.CELL_TYPE_STRING, model.getUserId());
					}
					if (model.getAreaCode() != null) { 
						createCell(row1, 6, style, HSSFCell.CELL_TYPE_STRING, model.getAreaCode());
					}
					if (model.getTradeNumber() != null) {
						createCell(row1, 7, style, HSSFCell.CELL_TYPE_STRING, model.getTradeNumber());
					}
					createCell(row1, 8, style, HSSFCell.CELL_TYPE_STRING, model.getTradeResult() == 0 ? "成功" : "失败");
					if (model.getFailMsg() != null) {
						createCell(row1, 9, style, HSSFCell.CELL_TYPE_STRING, model.getFailMsg());
					}
				}
			}
		} else if (type == LogService.REFILL_LOG) {
			// 这里的数据即时你要从后台取得的数据
			// 创建工作簿实例
			workbook = new HSSFWorkbook();
			// 创建工作表实例
			HSSFSheet sheet = workbook.createSheet("记录");
			// 设置列宽
			setSheetColumnWidth(sheet);
			// 获取样式
			HSSFCellStyle style = createTitleStyle(workbook);
			if (dataList != null && dataList.size() > 0) {
				// 创建第一行标题,标题名字的本地信息通过resources从资源文件中获取
				HSSFRow row = sheet.createRow(0);// 建立新行
				createCell(row, 0, style, HSSFCell.CELL_TYPE_STRING, "序号");
				createCell(row, 1, style, HSSFCell.CELL_TYPE_STRING, "账户");
				createCell(row, 2, style, HSSFCell.CELL_TYPE_STRING, "充值类型");
				createCell(row, 3, style, HSSFCell.CELL_TYPE_STRING, "充值金额");
				createCell(row, 4, style, HSSFCell.CELL_TYPE_STRING, "充值时间");
				createCell(row, 5, style, HSSFCell.CELL_TYPE_STRING, "充值结果");
				createCell(row, 6, style, HSSFCell.CELL_TYPE_STRING, "日志");
				createCell(row, 7, style, HSSFCell.CELL_TYPE_STRING, "操作用户");
				// 给excel填充数据
				for (int i = 0; i < dataList.size(); i++) {
					// 将dataList里面的数据取出来，假设这里取出来的是Model,也就是某个javaBean的意思啦
					RefillLog model = (RefillLog) dataList.get(i);
					HSSFRow row1 = sheet.createRow(i + 1);// 建立新行
					createCell(row1, 0, style, HSSFCell.CELL_TYPE_STRING, i + 1);
					if (model.getAccountNumber() != null)
						createCell(row1, 1, style, HSSFCell.CELL_TYPE_STRING, model.getAccountNumber());
					if (model.getAccountId() != 0) {
						createCell(row1, 2, style, HSSFCell.CELL_TYPE_STRING, model.getAmount());
					}
					
					if (model.getFillType() == 0) {
						createCell(row1, 3, style, HSSFCell.CELL_TYPE_STRING, "QQ币");
					} else if (model.getFillType() == 1) {
						createCell(row1, 3, style, HSSFCell.CELL_TYPE_STRING, "黄金岛");
					}
					
					if (model.getAmount() != 0D)
						createCell(row1, 4, style, HSSFCell.CELL_TYPE_STRING, DateFormatUtils.format(model.getTime(), "yyyy-MM-dd HH:mm:ss"));
					createCell(row1, 5, style, HSSFCell.CELL_TYPE_STRING, model.getResult() == 0 ? "成功" : "失败");
					if (model.getMsg() != null)
						createCell(row1, 6, style, HSSFCell.CELL_TYPE_STRING, model.getMsg());
					if (model.getUserId() != null)
						createCell(row1, 7, style, HSSFCell.CELL_TYPE_STRING, model.getUserId());
				}
			} else {
				createCell(sheet.createRow(0), 0, style, HSSFCell.CELL_TYPE_STRING, "查无资料");
			}
		} else if (type == LogService.USER_TYPE) {
			workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet("用户列表");
			setSheetColumnWidth(sheet);
			HSSFCellStyle style = createTitleStyle(workbook);
			if (dataList != null && dataList.size() > 0) {
				// 创建第一行标题,标题名字的本地信息通过resources从资源文件中获取
				HSSFRow row = sheet.createRow(0);// 建立新行
				createCell(row, 0, style, HSSFCell.CELL_TYPE_STRING, "序号");
				createCell(row, 1, style, HSSFCell.CELL_TYPE_STRING, "用户名");
				createCell(row, 2, style, HSSFCell.CELL_TYPE_STRING, "用户类型");
				createCell(row, 3, style, HSSFCell.CELL_TYPE_STRING, "地市编码");
				createCell(row, 4, style, HSSFCell.CELL_TYPE_STRING, "所属账户");
				createCell(row, 5, style, HSSFCell.CELL_TYPE_STRING, "业务名称");
				// 给excel填充数据
				for (int i = 0; i < dataList.size(); i++) {
					// 将dataList里面的数据取出来，假设这里取出来的是Model,也就是某个javaBean的意思啦
					User model = (User) dataList.get(i);
					HSSFRow row1 = sheet.createRow(i + 1);// 建立新行
					createCell(row1, 0, style, HSSFCell.CELL_TYPE_STRING, i + 1);
					if (model.getUserId() != null) {
						createCell(row1, 1, style, HSSFCell.CELL_TYPE_STRING, model.getUserId());
					}
					
					if (model.getType() == 0) {
						createCell(row1, 2, style, HSSFCell.CELL_TYPE_STRING, "普通用户");
					} else if (model.getType() == 1) {
						createCell(row1, 2, style, HSSFCell.CELL_TYPE_STRING, "管理员");
					} else if (model.getType() == 2) {
						createCell(row1, 2, style, HSSFCell.CELL_TYPE_STRING, "操作管理员");
					} else if (model.getType() == 3) {
						createCell(row1, 2, style, HSSFCell.CELL_TYPE_STRING, "财务管理员");
					}
					
					if (model.getAreaCode() != null) {
						createCell(row1, 3, style, HSSFCell.CELL_TYPE_STRING, model.getAreaCode());
					}
					if (model.getAccountNumber() != null) {
						createCell(row1, 4, style, HSSFCell.CELL_TYPE_STRING, model.getAccountNumber());
					}
					if (model.getBizType() != null) {
						if (model.getBizType().equals("1")) {
							createCell(row1, 5, style, HSSFCell.CELL_TYPE_STRING, "QQ币");
						} else if (model.getBizType().equals("2")) {
							createCell(row1, 5, style, HSSFCell.CELL_TYPE_STRING, "黄金岛");
						} else if (model.getBizType().equals("1|2")) {
							createCell(row1, 5, style, HSSFCell.CELL_TYPE_STRING, "QQ币；黄金岛");
						}
					} else {
						createCell(row1, 5, style, HSSFCell.CELL_TYPE_STRING, "");
					}
				}
			}
		} else if (type == LogService.PROCEEDS_TYPE) {
			workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet("记录");
			setSheetColumnWidth(sheet);
			HSSFCellStyle style = createTitleStyle(workbook);
			if (dataList != null && dataList.size() > 0) {
				// 创建第一行标题,标题名字的本地信息通过resources从资源文件中获取
				HSSFRow row = sheet.createRow(0);// 建立新行
				createCell(row, 0, style, HSSFCell.CELL_TYPE_STRING, "序号");
				createCell(row, 1, style, HSSFCell.CELL_TYPE_STRING, "新增日期");
				createCell(row, 2, style, HSSFCell.CELL_TYPE_STRING, "账户名");
				createCell(row, 3, style, HSSFCell.CELL_TYPE_STRING, "业务名称");
				createCell(row, 4, style, HSSFCell.CELL_TYPE_STRING, "打款金额");
				createCell(row, 5, style, HSSFCell.CELL_TYPE_STRING, "打款日期");
				// 给excel填充数据
				for (int i = 0; i < dataList.size(); i++) {
					// 将dataList里面的数据取出来，假设这里取出来的是Model,也就是某个javaBean的意思啦
					Proceeds model = (Proceeds) dataList.get(i);
					HSSFRow row1 = sheet.createRow(i + 1);// 建立新行
					createCell(row1, 0, style, HSSFCell.CELL_TYPE_STRING, i + 1);
					if (model.getCreateTime() != null)
						createCell(row1, 1, style, HSSFCell.CELL_TYPE_STRING, model.getCreateTime());
					if (model.getAccountName() != null) {
						createCell(row1, 2, style, HSSFCell.CELL_TYPE_STRING, model.getAccountName());
					}
					
					if (StringUtils.isNotEmpty(model.getBizType()) && model.getBizType().equals("0")) {
						createCell(row1, 3, style, HSSFCell.CELL_TYPE_STRING, "QQ币");
					} else if (StringUtils.isNotEmpty(model.getBizType()) && model.getBizType().equals("1")) {
						createCell(row1, 3, style, HSSFCell.CELL_TYPE_STRING, "黄金岛");
					}
					
					if (StringUtils.isNotEmpty(model.getTransferMoney())) {
						createCell(row1, 4, style, HSSFCell.CELL_TYPE_STRING, model.getTransferMoney());
					}
					
					if (StringUtils.isNotEmpty(model.getTransferDate())) {
						createCell(row1, 5, style, HSSFCell.CELL_TYPE_STRING, model.getTransferDate());
					}
				}
			} else {
				createCell(sheet.createRow(0), 0, style, HSSFCell.CELL_TYPE_STRING, "查无资料");
			}
		}
		return workbook;
	}

/*	public static HSSFWorkbook exportExcel(List dataList) throws Exception {
		HSSFWorkbook workbook = null;
		try {
			// 这里的数据即时你要从后台取得的数据
			// 创建工作簿实例
			workbook = new HSSFWorkbook();
			// 创建工作表实例
			HSSFSheet sheet = workbook.createSheet("记录");
			// 设置列宽
			setSheetColumnWidth(sheet);
			// 获取样式
			HSSFCellStyle style = createTitleStyle(workbook);
			if (dataList != null && dataList.size() > 0) {
				// 创建第一行标题,标题名字的本地信息通过resources从资源文件中获取
				HSSFRow row = sheet.createRow(0);// 建立新行
				createCell(row, 0, style, HSSFCell.CELL_TYPE_STRING, "序号");
				createCell(row, 1, style, HSSFCell.CELL_TYPE_STRING, "账户");
				createCell(row, 2, style, HSSFCell.CELL_TYPE_STRING, "充值金额");
				createCell(row, 3, style, HSSFCell.CELL_TYPE_STRING, "充值时间");
				createCell(row, 4, style, HSSFCell.CELL_TYPE_STRING, "充值结果");
				createCell(row, 5, style, HSSFCell.CELL_TYPE_STRING, "日志");
				createCell(row, 6, style, HSSFCell.CELL_TYPE_STRING, "操作用户");
				// 给excel填充数据
				for (int i = 0; i < dataList.size(); i++) {
					// 将dataList里面的数据取出来，假设这里取出来的是Model,也就是某个javaBean的意思啦
					RefillLog model = (RefillLog) dataList.get(i);
					HSSFRow row1 = sheet.createRow(i + 1);// 建立新行
					createCell(row1, 0, style, HSSFCell.CELL_TYPE_STRING, i + 1);
					if (model.getUserId() != null)
						createCell(row1, 1, style, HSSFCell.CELL_TYPE_STRING, model.getAccountId());
					if (model.getAccountId() != 0)
						createCell(row1, 2, style, HSSFCell.CELL_TYPE_STRING, model.getAmount());
					if (model.getAmount() != 0D)
						createCell(row1, 3, style, HSSFCell.CELL_TYPE_STRING, DateFormatUtils.format(model.getTime(), "yyyy-MM-dd HH:mm:ss"));
					createCell(row1, 4, style, HSSFCell.CELL_TYPE_STRING, model.getResult() == 0 ? "成功" : "失败");
					if (model.getMsg() != null)
						createCell(row1, 5, style, HSSFCell.CELL_TYPE_STRING, model.getMsg());
					if (model.getUserId() != null)
						createCell(row1, 6, style, HSSFCell.CELL_TYPE_STRING, model.getUserId());
				}
			} else {
				createCell(sheet.createRow(0), 0, style, HSSFCell.CELL_TYPE_STRING, "查无资料");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return workbook;

	}
*/
	private static void setSheetColumnWidth(HSSFSheet sheet) {

		// 根据你数据里面的记录有多少列，就设置多少列

		sheet.setColumnWidth(0, 3000);

		sheet.setColumnWidth(1, 8000);

		sheet.setColumnWidth(2, 3000);

		sheet.setColumnWidth(3, 8000);

		sheet.setColumnWidth(4, 8000);

		sheet.setColumnWidth(5, 5000);

		sheet.setColumnWidth(6, 5000);

		sheet.setColumnWidth(7, 5000);

	}

	// 设置excel的title样式

	private static HSSFCellStyle createTitleStyle(HSSFWorkbook wb) {
		HSSFFont boldFont = wb.createFont();
		boldFont.setFontHeight((short) 200);
		HSSFCellStyle style = wb.createCellStyle();
		style.setFont(boldFont);
		style.setDataFormat(HSSFDataFormat.getBuiltinFormat("###,##0.00"));
		return style;
	}

	// 创建Excel单元格

	private static void createCell(HSSFRow row, int column, HSSFCellStyle style,
			int cellType, Object value) {
		HSSFCell cell = row.createCell(column);
		if (style != null) {
			cell.setCellStyle(style);
		}
		switch (cellType) {
		case HSSFCell.CELL_TYPE_BLANK: {
		}
			break;
		case HSSFCell.CELL_TYPE_STRING: {
			cell.setCellValue(value.toString());
		}
			break;
		case HSSFCell.CELL_TYPE_NUMERIC: {
			cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
			cell.setCellValue(Double.parseDouble(value.toString()));
		}
			break;
		default:
			break;
		}
	}

	
}
