let db = require('../db/index')

exports.getclassify = (req, res) => {
    var sql = 'select * from landmark_classify'
    db.query(sql, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data)
    })
}
exports.getcategories = (req, res) => {
    var sql = 'select * from landmark_categories'
    db.query(sql, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data)
    })
}
exports.getcontent = (req, res) => {
    if (req.query.categoryid == null) {
        var sql = 'select * from landmark_content where categoryid like "%A%"'
    } else {
        var sql = 'select * from landmark_content where categoryid like "%"?"%"'
    }
    db.query(sql, [req.query.categoryid], (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data);
    })
}
exports.getrecommend = (req, res) => {
    if (req.query.id) {
        var sql = 'select * from landmark_content where contentid=?';
    } else {
        var sql = 'select * from landmark_content';
    }
    db.query(sql, [req.query.id], (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data);
    })
}
exports.gettickets = (req, res) => {
    var sql = 'select * from landmark_tickets where contentid=?';
    db.query(sql, [req.query.id], (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data);
    })
}
exports.getMaxOrderid=(req,res)=>{
    var sql = 'select orderid from my_orderitems order by orderid desc limit 1';
    db.query(sql, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data);
    });
}
exports.save = (req, res) => {
    var sql = 'insert into my_orderitems value(?,?,?,?,?,?)';
    db.query(sql, [req.query.orderid,req.query.ticketid,req.query.unitprice,req.query.quantity,req.query.amount,req.query.flagid], (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200,
            message: '添加成功'
        });
    })
}