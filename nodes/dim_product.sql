MERGE INTO [TABLEOWNER].[dim_product]
  USING (
    SELECT 
           stage_product_sales.product_id AS product_id
         , stage_product_sales.product_code AS product_code
         , stage_product_sales.product_name AS product_name
         , stage_product_sales.product_description AS product_description
         , stage_product_sales.product_line_code AS product_line_code
         , stage_product_mrg.sales_source AS sales_source
         , stage_product_sales.product_line_description AS product_line_description
         , stage_product_sales.product_group_code AS product_group_code
         , stage_product_sales.product_group_description AS product_group_description
         , stage_product_sales.product_sub_group_code AS product_sub_group_code
         , stage_product_sales.product_sub_group_description AS product_sub_group_description
         , stage_product_sales.barcode_value AS barcode_value
         , stage_product_sales.vendor_id AS vendor_id
         , stage_product_sales.dimension_uom AS dimension_uom
         , stage_product_sales.dimension_1 AS dimension_1
         , stage_product_sales.dimension_2 AS dimension_2
         , stage_product_sales.dimension_3 AS dimension_3
         , stage_product_sales.volume_uom AS volume_uom
         , stage_product_sales.volume AS volume
         , stage_product_sales.weight_uom AS weight_uom
         , stage_product_sales.weight AS weight
         , stage_product_sales.auto_reorder_flag AS auto_reorder_flag
         , stage_product_sales.auto_reorder_amount AS auto_reorder_amount
         , stage_product_sales.creating_employee_id AS creating_employee_id
         , stage_product_sales.created_datetime AS created_datetime
         , stage_product_sales.last_change_employee_id AS last_change_employee_id
         , stage_product_sales.last_change_datetime AS last_change_datetime
    FROM [TABLEOWNER].[stage_product_mrg] stage_product_mrg
    JOIN [TABLEOWNER].[stage_product_sales] stage_product_sales
    ON stage_product_mrg.product_id = stage_product_sales.product_id
    EXCEPT
    SELECT dim_product.product_id  product_id
         , dim_product.product_code  product_code
         , dim_product.product_name  product_name
         , dim_product.product_description  product_description
         , dim_product.product_line_code  product_line_code
         , dim_product.sales_source  sales_source
         , dim_product.product_line_description  product_line_description
         , dim_product.product_group_code  product_group_code
         , dim_product.product_group_description  product_group_description
         , dim_product.product_sub_group_code  product_sub_group_code
         , dim_product.product_sub_group_description  product_sub_group_description
         , dim_product.barcode_value  barcode_value
         , dim_product.vendor_id  vendor_id
         , dim_product.dimension_uom  dimension_uom
         , dim_product.dimension_1  dimension_1
         , dim_product.dimension_2  dimension_2
         , dim_product.dimension_3  dimension_3
         , dim_product.volume_uom  volume_uom
         , dim_product.volume  volume
         , dim_product.weight_uom  weight_uom
         , dim_product.weight  weight
         , dim_product.auto_reorder_flag  auto_reorder_flag
         , dim_product.auto_reorder_amount  auto_reorder_amount
         , dim_product.creating_employee_id  creating_employee_id
         , dim_product.created_datetime  created_datetime
         , dim_product.last_change_employee_id  last_change_employee_id
         , dim_product.last_change_datetime  last_change_datetime
        FROM [TABLEOWNER].[dim_product]
  ) AS changes 
  ON (
          dim_product.product_id = changes.product_id
      AND dim_product.sales_source = changes.sales_source
  )
  WHEN MATCHED THEN 
  UPDATE 
  SET     product_code =  changes.product_code
        , product_name =  changes.product_name
        , product_description =  changes.product_description
        , product_line_code =  changes.product_line_code
        , product_line_description =  changes.product_line_description
        , product_group_code =  changes.product_group_code
        , product_group_description =  changes.product_group_description
        , product_sub_group_code =  changes.product_sub_group_code
        , product_sub_group_description =  changes.product_sub_group_description
        , barcode_value =  changes.barcode_value
        , vendor_id =  changes.vendor_id
        , dimension_uom =  changes.dimension_uom
        , dimension_1 =  changes.dimension_1
        , dimension_2 =  changes.dimension_2
        , dimension_3 =  changes.dimension_3
        , volume_uom =  changes.volume_uom
        , volume =  changes.volume
        , weight_uom =  changes.weight_uom
        , weight =  changes.weight
        , auto_reorder_flag =  changes.auto_reorder_flag
        , auto_reorder_amount =  changes.auto_reorder_amount
        , creating_employee_id =  changes.creating_employee_id
        , created_datetime =  changes.created_datetime
        , last_change_employee_id =  changes.last_change_employee_id
        , last_change_datetime =  changes.last_change_datetime
        , dss_update_time = @v_current_datetime
  WHEN NOT MATCHED THEN 
  INSERT 
  (       product_id
        , product_code
        , product_name
        , product_description
        , product_line_code
        , sales_source
        , product_line_description
        , product_group_code
        , product_group_description
        , product_sub_group_code
        , product_sub_group_description
        , barcode_value
        , vendor_id
        , dimension_uom
        , dimension_1
        , dimension_2
        , dimension_3
        , volume_uom
        , volume
        , weight_uom
        , weight
        , auto_reorder_flag
        , auto_reorder_amount
        , creating_employee_id
        , created_datetime
        , last_change_employee_id
        , last_change_datetime
        , dss_create_time
        , dss_update_time
  )
  VALUES 
  (       product_id
        , product_code
        , product_name
        , product_description
        , product_line_code
        , sales_source
        , product_line_description
        , product_group_code
        , product_group_description
        , product_sub_group_code
        , product_sub_group_description
        , barcode_value
        , vendor_id
        , dimension_uom
        , dimension_1
        , dimension_2
        , dimension_3
        , volume_uom
        , volume
        , weight_uom
        , weight
        , auto_reorder_flag
        , auto_reorder_amount
        , creating_employee_id
        , created_datetime
        , last_change_employee_id
        , last_change_datetime
        , @v_current_datetime
        , @v_current_datetime
  );