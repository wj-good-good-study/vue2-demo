let db = require('../db/index')

exports.updatezan = (req, res) => {
    var sql = 'update home_waterfull set zanpeople=? where waterfull_id=?'
    db.query(sql, [req.query.zanpeople, req.query.waterfullid], (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200,
            message: '添加成功'
        });
    })
}
exports.getgroupdata = (req, res) => {
    var sql = 'select * from community_group'
    db.query(sql,(err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data);
    })
}
exports.gethotdata = (req, res) => {
    var sql = 'select * from community_square_hot'
    db.query(sql,(err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data);
    })
}