INSERT INTO [TABLEOWNER].[stage_product_sales] WITH ( TABLOCK )
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
     load_product.product_id,
     load_product.product_code,
     load_product.product_name,
     load_product.product_description,
     load_product.product_line_code,
     load_product_line.product_line_description,
     2 sales_source,
     load_product.product_group_code,
     load_product_group.product_group_description,
     load_product.product_sub_group_code,
     load_product_sub_group.product_sub_group_description,
     load_product.barcode_value,
     load_product.vendor_id,
     load_product.dimension_uom,
     load_product.dimension_1,
     load_product.dimension_2,
     load_product.dimension_3,
     load_product.volume_uom,
     load_product.volume,
     load_product.weight_uom,
     load_product.weight,
     load_product.auto_reorder_flag,
     load_product.auto_reorder_amount,
     load_product.creating_employee_id,
     load_product.created_datetime,
     load_product.last_change_employee_id,
     load_product.last_change_datetime,
     @v_dss_create_time,
     @v_dss_update_time
   FROM [TABLEOWNER].[load_product] load_product
   JOIN [TABLEOWNER].[load_product_line] load_product_line
     ON load_product.product_line_code = load_product_line.product_line_code
   JOIN [TABLEOWNER].[load_product_group] load_product_group
     ON load_product.product_group_code = load_product_group.product_group_code
   JOIN [TABLEOWNER].[load_product_sub_group] load_product_sub_group
     ON load_product.product_group_code = load_product_sub_group.product_group_code
    AND load_product.product_sub_group_code = load_product_sub_group.product_sub_group_code