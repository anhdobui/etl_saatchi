from utils import *

def gen_select_dims(dims,symbol=','):
 full_dim = []
 for dim in dims:
  full_dim.append(generate_FullHierarchyDimension(dim, symbol=symbol))
 return combinations_arrays(full_dim,symbol)
 

def gen_cube_name(prefix='cube_'):
 dimension_time = [[''],['date'],['year','quarter','month','day'],['year','week','day']]
 dimension_customer = [[''],['customer']]
 dimension_painting = [[''],['painting']]
 dimension_orders = [[''],['orders'],['status']]
 dimensions = [dimension_time,dimension_customer,dimension_painting,dimension_orders]
 return [prefix + cube for cube in gen_select_dims(dimensions,'_')]
# -------------------
dimension_time = [[''],['dd.date_id'],['dd.year','dd.quarter','dd.month','dd.day'],['dd.year','dd.week','dd.day']]
dimension_customer = [[''],['dc.customer_id']]
dimension_painting = [[''],['dp.painting_id']]
dimension_orders = [[''],['do.orders_id'],['do.status']]

dims_select = [dimension_time,dimension_customer,dimension_painting,dimension_orders]
# 
sql_results = []
query_choose_dims = gen_select_dims(dims_select)
database_fact_name = '[dwh_htttql].[dbo]'
database_cube_name = '[cubes_htttql].[dbo]'
cubes_table = gen_cube_name()
for i in range(len(query_choose_dims)):
 sql_final = f"""
            SELECT {query_choose_dims[i]+',' if query_choose_dims[i] != '' else ''} sum(fs.total_price) as total_price
            into {database_cube_name}.{cubes_table[i]}
            FROM {database_fact_name}.[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            {'group by ' + query_choose_dims[i] if query_choose_dims[i] != '' else ''};
            go     
            """
 sql_results.append(sql_final)
output_file = "output_create_cube.txt"
exportSQL(sql_results,output_file)

