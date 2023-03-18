let db = require('../db/index')

exports.getorderitems = (req, res) => {
    if(req.query.flag==0){
        var sql='SELECT a.*,b.title as ticketname,c.contentname,b.span2 as span,b.contentid,c.redspan,c.longaddress,d.flagname FROM vuedatabase.my_orderitems a join landmark_tickets b using(ticketid) join landmark_content c using(contentid) join my_orderitems_flag d using(flagid) '
        db.query(sql, (err, data) => {
            if (err) {
                return res.send('错误：' + err.message)
            }
            res.send(data);
        })
    }else{
        var sql = 'SELECT a.*,b.title as ticketname,c.contentname,b.span2 as span,b.contentid,c.redspan,c.longaddress,d.flagname FROM vuedatabase.my_orderitems a join landmark_tickets b using(ticketid) join landmark_content c using(contentid) join my_orderitems_flag d using(flagid) where flagid=?'
        db.query(sql, [req.query.flag], (err, data) => {
            if (err) {
                return res.send('错误：' + err.message)
            }
            res.send(data);
        })
    }
}

exports.changeflag=(req,res)=>{
    var sql='update my_orderitems set flagid=? where orderid=? and ticketid=?'
    db.query(sql,[req.query.flagid,req.query.orderid,req.query.ticketid],(err,data)=>{
        if(err){
            return res.send('错误：'+err.message)
        }
        res.send({
            status: 200,
            message: '添加成功'
        });
    })
}

exports.deleteOrders=(req,res)=>{
    var sql='delete from my_orderitems where orderid=? and ticketid=?'
    db.query(sql,[req.query.orderid,req.query.ticketid],(err,data)=>{
        if(err){
            return res.send('错误：'+err.message)
        }
        res.send({
            status: 200,
            message: '操作成功'
        });
    })
}