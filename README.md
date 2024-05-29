# Project Overview

## server.py

Chạy chương trình ETL để chuyển đổi dữ liệu từ OLTP sang OLAP.

## gen_script_sql

Chứa các đoạn mã Python giúp tạo ra các lệnh để tạo tất cả các cube từ fact và tạo procedure giúp cập nhật cube mỗi khi fact được cập nhật.

## be_dwh

Chương trình tạo API để lấy dữ liệu từ các cubes.

### Cài đặt và chạy

1. Cài đặt các gói cần thiết:
   ```bash
   npm install
   ```
2. Chạy chương trình:
   ```bash
   node server_dwh.js
   ```

## Hướng dẫn chi tiết

### server.py

1. **Mô tả:**
   - Chương trình ETL (Extract, Transform, Load) để chuyển đổi và tải dữ liệu từ hệ thống OLTP (Online Transaction Processing) sang hệ thống OLAP (Online Analytical Processing).
2. **Cách sử dụng:**
   - Đảm bảo bạn đã cấu hình đúng các thông tin kết nối cơ sở dữ liệu trong script.
   - Chạy script bằng Python:
     ```bash
     python server.py
     ```

### gen_script_sql

1. **Mô tả:**
   - Chứa các đoạn mã Python để tự động tạo các lệnh SQL cần thiết cho việc xây dựng và cập nhật các cubes.
   - Các lệnh SQL sẽ được tạo ra và có thể được sử dụng để cấu hình cơ sở dữ liệu OLAP.

### be_dwh

1. **Mô tả:**
   - Tạo API để truy xuất dữ liệu từ các cubes trong hệ thống OLAP.
2. **Cài đặt:**
   - Cài đặt các gói cần thiết với npm:
     ```bash
     npm install
     ```
3. **Chạy chương trình:**
   - Khởi chạy server Node.js:
     ```bash
     node server_dwh.js
     ```
