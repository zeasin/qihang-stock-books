package cn.qihangerp.api.controller.oms;

import cn.qihangerp.api.request.PddTokenCreateBo;
import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.model.entity.OGoodsSku;
import com.alibaba.fastjson2.JSON;
import com.fasterxml.jackson.databind.exc.InvalidFormatException;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.NumberToTextConverter;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@RequestMapping("/shop/order")
@AllArgsConstructor
@RestController
public class ShopOrderImportController {
    @RequestMapping(value = "/order_import", method = RequestMethod.POST)
    public AjaxResult orderImport(@RequestParam("file") MultipartFile file,
                                  @RequestParam("shopId") Long shopId) throws IOException, InvalidFormatException {
        log.info("========导入店铺订单：{}", shopId);
        if(shopId == null){
            return AjaxResult.error("缺少参数：shopId");
        }
        String fileName = file.getOriginalFilename();
        String dir = System.getProperty("user.dir");
        String destFileName = dir + File.separator + "/import/uploadedfiles_" + fileName;
        System.out.println(destFileName);
        File destFile = new File(destFileName);
        file.transferTo(destFile);
        InputStream fis = null;
        fis = new FileInputStream(destFileName);
        if (fis == null) return AjaxResult.error("没有文件");

        Workbook workbook = null;

        try {
            if (fileName.toLowerCase().endsWith("xlsx")) {
                workbook = new XSSFWorkbook(fis);
            } else if (fileName.toLowerCase().endsWith("xls")) {
                workbook = new HSSFWorkbook(fis);
            }
            // workbook = new HSSFWorkbook(fis);
        } catch (Exception ex) {
            return AjaxResult.error(ex.getMessage());
        }

        if (workbook == null) return AjaxResult.error(502, "未读取到Excel文件");

        /****************开始处理excel****************/
        int success = 0;
        int fail = 0;
        Sheet sheet = null;
        try {
            sheet = workbook.getSheetAt(0);
            int lastRowNum = sheet.getLastRowNum();//最后一行索引
            Row row = null;

            for (int i = 1; i <= lastRowNum; i++) {
                row = sheet.getRow(i);
                //数据
                OGoodsSku sku = new OGoodsSku();
                for(int c=0;c<6;c++){
                    Cell cell = row.getCell(c);
                    String cellValue = "";
                    if (cell != null) {
                        if (cell.getCellType() == CellType.STRING) {
                            cellValue = cell.getStringCellValue().replace("\t", "");
                        } else if (cell.getCellType() == CellType.NUMERIC) {
                            cellValue = NumberToTextConverter.toText(cell.getNumericCellValue()).replace("\t", "");
                        }
                    }
                    if(c == 1) {
                        if(StringUtils.hasText(cellValue) ){
                            sku.setOuterErpGoodsId(cellValue);
                        }else {
                            sku.setOuterErpGoodsId("0");
                        }
                    }
                    if(StringUtils.hasText(cellValue)) {
                        if (c == 0) {
                            sku.setOuterErpSkuId(cellValue);
                        } else if (c == 2) {
                            sku.setSkuCode(cellValue);
                        } else if (c == 3) {
                            sku.setSkuName(cellValue);
                        } else if (c == 4) {
                            sku.setColorImage(cellValue);
                        } else if (c == 5) {
                            sku.setRemark(cellValue);
                        }
                    }
                }
//                goodsService.insertGoodsSku(sku);
                success++;
            }


        } catch (Exception ex) {
            fail++;
            ex.printStackTrace();
        }
        Map<String, Integer> result = new HashMap<>();
        result.put("success",success);
        result.put("fail",fail);
        return AjaxResult.success(result);
    }
}
