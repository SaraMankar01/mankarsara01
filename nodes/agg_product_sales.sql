   TRUNCATE TABLE [TABLEOWNER].[agg_product_sales];

  INSERT INTO [TABLEOWNER].[agg_product_sales]
  (
    dim_product_key
  , dim_order_date_key
  , quantity
  , dss_update_time
  )
  SELECT
    dim_product.dim_product_key
  , dim_order_date.dim_order_date_key
  , SUM(fact_order_detail.quantity)
  , GETDATE()
  FROM
    [TABLEOWNER].[fact_order_detail] fact_order_detail
  , [TABLEOWNER].[dim_product] dim_product
  , [TABLEOWNER].[dim_order_date] dim_order_date
  WHERE fact_order_detail.dim_product_key = dim_product.dim_product_key
  AND   fact_order_detail.dim_order_date_key = dim_order_date.dim_order_date_key
  GROUP BY
    dim_product.dim_product_key
  , dim_order_date.dim_order_date_key