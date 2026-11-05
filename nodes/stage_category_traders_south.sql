      INSERT INTO [TABLEOWNER].[stage_category_traders_south]
      ( hk_h_category
      , category_name
      , categoryid
      , description
      , dss_change_hash_category_lroc_traders_south
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_categories_traders_south.categoryname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_category 
           , load_categories_traders_south.categoryname AS category_name 
           , load_categories_traders_south.categoryid AS categoryid 
           , load_categories_traders_south.description AS description 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_categories_traders_south.categoryid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_categories_traders_south.description AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_category_lroc_traders_south 
           , load_categories_traders_south.dss_record_source AS dss_record_source 
           , load_categories_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_categories_traders_south] load_categories_traders_south
      ;
