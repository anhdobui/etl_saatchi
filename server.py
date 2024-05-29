import mysql.connector
import pyodbc
import time
import logging
from datetime import datetime

# Cấu hình logging
logging.basicConfig(
    filename="etl_log.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
)

# Hàm kết nối MySQL
def connect_mysql():
    return mysql.connector.connect(
        host="localhost", user="root", password="root", database="coco"
    )

# Kết nối SQL Server
sqlserver_conn = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=DESKTOP-0A2CLAB;"
    "DATABASE=staging;"
    "UID=sa;"
    "PWD=root"
)
sqlserver_cursor = sqlserver_conn.cursor()

# Biến lưu trữ thời điểm cuối cùng quét dữ liệu cho từng bảng
last_sync_times = {
    "account": None,
    # "album": None,
    "cart": None,
    "cart_detail": None,
    "detail_received_log": None,
    "painting": None,
    # "painting_topic": None,
    "received_log": None,
    "topic": None,
    "orders": None
}

# Hàm kiểm tra xem bảng có trường modifieddate không
def has_modified_date(mysql_cursor, table_name):
    query = f"SHOW COLUMNS FROM {table_name} LIKE 'modifieddate'"
    mysql_cursor.execute(query)
    result = mysql_cursor.fetchone()
    return result is not None

def etl_process(table_name):
    try:
        # Kết nối lại MySQL trước khi thực hiện truy vấn
        mysql_conn = connect_mysql()
        mysql_cursor = mysql_conn.cursor(dictionary=True)

        last_sync_time = last_sync_times[table_name]
        if has_modified_date(mysql_cursor, table_name):
            if last_sync_time:
                query = f"SELECT * FROM {table_name} WHERE modifieddate > '{last_sync_time}'"
            else:
                query = f"SELECT * FROM {table_name}"
            mysql_cursor.execute(query)
            new_data = mysql_cursor.fetchall()
            etl_success_count = 0
            for row in new_data:
                columns = row.keys()
                columns_sql = ",".join(columns)
                placeholders = ",".join(["?" for _ in range(len(columns))])
                values = tuple([row[col] for col in columns])
                # Tạo câu lệnh INSERT INTO và UPDATE riêng biệt
                insert_query = f"INSERT INTO {table_name} ({columns_sql}) VALUES ({placeholders})"
                update_query = f"UPDATE {table_name} SET {', '.join([f'{col} = ?' for col in columns if col != 'id'])} WHERE id = ?"
                try:
                    sqlserver_cursor.execute(insert_query, values)
                    etl_success_count += 1
                except pyodbc.IntegrityError:
                    # Nếu xảy ra lỗi trùng lặp khóa chính, thực hiện cập nhật
                    update_values = tuple([row[col] for col in columns if col != 'id']) + (row['id'],)
                    sqlserver_cursor.execute(update_query, update_values)
                    etl_success_count += 1

            sqlserver_conn.commit()
            # Cập nhật thời gian chi tiết nhất có thể
            last_sync_times[table_name] = datetime.now().strftime("%Y-%m-%d %H:%M:%S.%f")
            # logging.info(
            #     f"ETL process for {table_name} successful. ETL'd {etl_success_count} records."
            # )

        # Đóng kết nối MySQL sau khi xử lý xong
        mysql_cursor.close()
        mysql_conn.close()
    except Exception as e:
        logging.error(f"Error in ETL process for {table_name}: {str(e)}")

# Vòng lặp vô hạn để liên tục quét và xử lý dữ liệu
while True:
    for table_name in list(last_sync_times.keys()):
        etl_process(table_name)
    time.sleep(5)
