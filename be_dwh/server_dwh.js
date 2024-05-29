const express = require("express");
const sql = require("mssql");

const app = express();
const port = 3214;

// Cấu hình kết nối đến SQL Server
const config = {
  user: "sa",
  password: "root",
  server: "DESKTOP-0A2CLAB", // hoặc địa chỉ IP của máy chủ SQL Server
  database: "cubes_htttql",
  options: {
    encrypt: false, // Nếu bạn sử dụng kết nối bảo mật, hãy đặt encrypt thành true
  },
};

// Middleware để cho phép CORS
app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS, PUT, PATCH, DELETE");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
  next();
});

// Route để lấy dữ liệu từ SQL Server
app.get("/api/:table_name", (req, res) => {
  const table_name = req.params.table_name;
  const querys = req.query;
  let conditions = Object.entries(querys)
    .filter(([key, value]) => key !== "orderby_desc" && key !== "orderby" && key !== "limit")
    .reduce((obj, [key, value]) => {
      obj[key] = value;
      return obj;
    }, {});
  console.log(conditions);
  const orderby = querys["orderby"] || querys["orderby_desc"];
  const byDesc = !!querys["orderby_desc"] ? " Desc" : "";
  const limit = querys["limit"] ? parseInt(querys["limit"]) : null; // Lấy giới hạn từ query string, nếu không có, mặc định là null
  sql
    .connect(config)
    .then((pool) => {
      let where = "";
      let params = {};

      // Tạo điều kiện WHERE dựa trên các tham số từ query string
      if (conditions) {
        where = " WHERE 1=1 ";
        const conditionKeys = Object.keys(conditions);
        conditionKeys.forEach((key, index) => {
          where += `AND ${key} = @${key}`;
          params[key] = { type: sql.VarChar, value: conditions[key] };
          if (index < conditionKeys.length - 1) {
            where += " ";
          }
        });
      }

      const sql_query = `SELECT ${table_name}.* FROM ${table_name}
                          ${where}
                          ${orderby ? "ORDER BY " + orderby + byDesc : ""}
                          ${limit ? "OFFSET 0 ROWS FETCH NEXT " + limit + " ROWS ONLY" : ""}`; // Thêm giới hạn nếu có
      console.log(sql_query);

      const request = pool.request();

      // Truyền các tham số vào truy vấn SQL
      Object.keys(params).forEach((key) => {
        request.input(key, params[key].type, params[key].value);
      });

      return request.query(sql_query);
    })
    .then((result) => {
      res.json(result.recordset);
    })
    .catch((err) => {
      console.error("Error occurred:", err);
      res.status(500).json({ error: "An error occurred while fetching data" });
    });
});
// Khởi động máy chủ
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
