let db = require('../db/index')

exports.buttonDiv=(req,res)=>{
    var sql="select * from message_buttonDiv";
    db.query(sql,(err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data);
    })
}
exports.message=(req,res)=>{
    var sql="select * from message_message";
    db.query(sql,(err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data);
    })
}