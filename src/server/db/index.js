//配置数据库
let mysql = require('mysql')

let db = mysql.createPool({
    host: '127.0.0.1',//数据库IP地址
    port: 3306,     
    user: 'root',          //数据库登录账号
    password: 'sql2008',      //数据库登录密码
    database: 'vuedatabase'       //要操作的数据库
})

module.exports = db
