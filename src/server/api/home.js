let db = require('../db/index')

exports.gettab1 = (req, res) => {
    var sql = 'select * from home_tab1'
    db.query(sql, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data)
    })
}
exports.gettab2 = (req, res) => {
    var sql = 'select * from home_tab2'
    db.query(sql, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data)
    })
}

exports.getlbt_img = (req, res) => {
    var sql = 'select * from home_lbt_img'
    db.query(sql, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data)
    })
}
exports.gethuodong = (req, res) => {
    var sql = 'select * from home_huodong'
    db.query(sql, (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data)
    })
}
exports.getwaterfull = (req, res) => {
    if (req.query.waterfullid === 'false') {
        var sql = 'select * from home_waterfull'
        db.query(sql, (err, data) => {
            if (err) {
                return res.send('错误：' + err.message)
            }
            res.send(data)
        })
    }else{
        var sql = 'select a.* from (select 1 as flag,a.* from home_waterfull a join attention b on a.writerid = b.attentionid where userid=? union all select 0 as flag,a.* from home_waterfull a  where waterfull_id not in(select waterfull_id from home_waterfull a join attention b on a.writerid = b.attentionid where userid=?)) as a where a.waterfull_id=?'
        db.query(sql,[req.query.userid,req.query.userid,req.query.waterfullid], (err, data) => {
            if (err) {
                return res.send('错误：' + err.message)
            }
            res.send(data)
        })
    }

}

exports.change_attention=(req,res)=>{
    if(req.query.flag==1){
        var sql='delete from attention where userid=? and attentionid=?'
    }else{
        var sql='insert into attention(userid,attentionid) value(?,?)'
    }
    db.query(sql,[req.query.userid,req.query.attentionid],(err,data)=>{
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200,
            message: '操作成功'
        });
    })
}

exports.getdiscuss = (req, res) => {
    var sql = 'select * from discuss where waterfullid=? order by timestamp desc'
    db.query(sql, [req.query.waterfullid], (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data);
    })
}

exports.getattention=(req,res)=>{
    var sql='select a.* from home_waterfull a join attention b on a.writerid = b.attentionid where userid=?';
    db.query(sql, [req.query.userid],(err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data);
    })
}

exports.updatezan = (req, res) => {
    var sql = 'update discuss set zanicon=?,zanpeople=? where waterfullid=? and timestamp= ?'
    db.query(sql, [req.query.zanicon, req.query.zanpeople, req.query.waterfullid, req.query.timestamp], (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200,
            message: '添加成功'
        });
    })
}

exports.gethost = (req, res) => {
    var sql = 'select a.*,b.* from users as a join vuedatabase.vipcategory as b on a.vip=b.categoryid where username=?'
    db.query(sql, [req.query.host], (err, data) => {
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send(data);
    })
}

exports.insertdis = (req, res) => {
    var sql = 'insert into discuss(waterfullid,headimg,name,text,timestamp,disdate,address) values (?,?,?,?,?,?,?)'
    // console.log(req.query.waterfullid,req.query.headimg,req.query.name,req.query.text,req.query.timestamp,req.query.disdate,req.query.address); 
    db.query(sql, [req.query.waterfullid, req.query.headimg, req.query.name, req.query.text, req.query.timestamp, req.query.disdate, req.query.address], (err, data) => {
        // console.log('err',err);
        if (err) {
            return res.send('错误：' + err.message)
        }
        res.send({
            status: 200,
            message: '添加成功'
        });
    })
}




