INSERT INTO [TABLEOWNER].[stage_product_sales2] WITH ( TABLOCK )
   (
     product_id,
     product_code,
     product_name,
     product_description,
     product_line_code,
     product_line_description,
     sales_source,
     product_group_code,
     product_group_description,
     product_sub_group_code,
     product_sub_group_description,
     barcode_value,
     vendor_id,
     dimension_uom,
     dimension_1,
     dimension_2,
     dimension_3,
     volume_uom,
     volume,
     weight_uom,
     weight,
     auto_reorder_flag,
     auto_reorder_amount,
     creating_employee_id,
     created_datetime,
     last_change_employee_id,
     last_change_datetime,
     dss_create_time,
     dss_update_time
   )
   SELECT
     load_product_sales2.product_id,
     load_product_sales2.product_code,
     load_product_sales2.product_name,
     load_product_sales2.product_description,
     load_product_sales2.product_line_code,
     load_product_line_sales2.product_line_description,
     3 sales_source,
     load_product_sales2.product_group_code,
     load_product_group_sales2.product_group_description,
     load_product_sales2.product_sub_group_code,
     load_product_sub_group_sales2.product_sub_group_description,
     load_product_sales2.barcode_value,
     load_product_sales2.vendor_id,
     load_product_sales2.dimension_uom,
     load_product_sales2.dimension_1,
     load_product_sales2.dimension_2,
     load_product_sales2.dimension_3,
     load_product_sales2.volume_uom,
     load_product_sales2.volume,
     load_product_sales2.weight_uom,
     load_product_sales2.weight,
     load_product_sales2.auto_reorder_flag,
     load_product_sales2.auto_reorder_amount,
     load_product_sales2.creating_employee_id,
     load_product_sales2.created_datetime,
     load_product_sales2.last_change_employee_id,
     load_product_sales2.last_change_datetime,
     @v_dss_create_time,
     @v_dss_update_time
   FROM [TABLEOWNER].[load_product_sales2] load_product_sales2
   JOIN [TABLEOWNER].[load_product_line_sales2] load_product_line_sales2
     ON load_product_sales2.product_line_code = load_product_line_sales2.product_line_code
   JOIN [TABLEOWNER].[load_product_group_sales2] load_product_group_sales2
     ON load_product_sales2.product_group_code = load_product_group_sales2.product_group_code
   JOIN [TABLEOWNER].[load_product_sub_group_sales2] load_product_sub_group_sales2
     ON load_product_sales2.product_sub_group_code = load_product_sub_group_sales2.product_sub_group_code
    AND load_product_sales2.product_group_code = load_product_sub_group_sales2.product_group_code