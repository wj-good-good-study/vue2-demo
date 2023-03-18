//操作数据库
let db = require('../db/index')

exports.getusers = (req, res) => {
    var sql = 'select * from users'
    db.query(sql, (err, data) => {
        if(err) {
            return res.send('错误：' + err.message)
        }
        res.send(data)
    })
}

exports.adduser = (req, res) => {  
    var sql = 'insert into users (username,password,email,phone) values (?,?,?,?)'
    db.query(sql, [req.query.username, req.query.password, req.query.email, req.query.phone], (err, data) => {
        if(err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200,
            message: '添加成功'
        })
    })
}