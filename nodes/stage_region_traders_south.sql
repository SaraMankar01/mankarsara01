      INSERT INTO [TABLEOWNER].[stage_region_traders_south]
      ( hk_h_region
      , region_id
      , regiondescription
      , dss_change_hash_region_lroc_traders_south
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_region_traders_south.regionid AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_region 
           , load_region_traders_south.regionid AS region_id 
           , load_region_traders_south.regiondescription AS regiondescription 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_region_traders_south.regiondescription AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_region_lroc_traders_south 
           , load_region_traders_south.dss_record_source AS dss_record_source 
           , load_region_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_region_traders_south] load_region_traders_south
      ;