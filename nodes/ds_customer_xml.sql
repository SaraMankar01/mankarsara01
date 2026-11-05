MERGE INTO [TABLEOWNER].[ds_customer_xml]
  USING (
    SELECT 
           load_customer_xml.code AS code
         , load_customer_xml.name AS name
         , load_customer_xml.cat_code AS cat_code
         , load_customer_xml.grp_code AS grp_code
         , load_customer_xml.subgrp AS subgrp
         , load_customer_xml.source_sales AS source_sales
         , vers.dss_version
    FROM [TABLEOWNER].[load_customer_xml] load_customer_xml
    LEFT OUTER JOIN (
      SELECT code
           , MAX(dss_version) dss_version
      FROM [TABLEOWNER].[ds_customer_xml] ds_customer_xml
      GROUP BY code
    ) AS vers
    ON    load_customer_xml.code = vers.code
  ) AS changes 
  ON (
          ds_customer_xml.code = changes.code
      AND ds_customer_xml.dss_current_flag = 'Y'
  )
  WHEN MATCHED THEN 
  UPDATE 
  SET        dss_update_time = @v_current_datetime
  WHEN NOT MATCHED THEN 
  INSERT 
  (       code
        , name
        , cat_code
        , grp_code
        , subgrp
        , source_sales
        , dss_start_date
        , dss_end_date
        , dss_current_flag
        , dss_version
        , dss_create_time
        , dss_update_time
  )
  VALUES 
  (       code
        , name
        , cat_code
        , grp_code
        , subgrp
        , source_sales
        , CASE WHEN changes.dss_version IS NULL
               THEN CAST('01-JAN-1900' AS datetime)
               ELSE CAST(ISNULL(NULLIF(@v_DS_Customer_Process_Date,''),CONVERT(VARCHAR,GETDATE(),112)) AS DATETIME)
          END
        , CAST('31-DEC-2999' AS datetime)
        , 'Y'
        , CASE WHEN changes.dss_version IS NULL
               THEN 1
               ELSE changes.dss_version +1
          END
        , @v_current_datetime
        , @v_current_datetime
  );