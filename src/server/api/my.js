let db = require('../db/index')

exports.gettopnav1=(req,res)=>{
    var sql='select * from my_topnav1'
    db.query(sql,(err,data)=>{
        if(err){
            return res.send('错误：'+err.message)
        }
        res.send(data)
    })
}
exports.gettabList1=(req,res)=>{
    var sql='select * from my_tabList1'
    db.query(sql,(err,data)=>{
        if(err){
            return res.send('错误：'+err.message)
        }
        res.send(data)
    })
}
exports.getnumberList=(req,res)=>{
    var sql='select * from my_numberList'
    db.query(sql,(err,data)=>{
        if(err){
            return res.send('错误：'+err.message)
        }
        res.send(data)
    })
}
exports.getvipList=(req,res)=>{
    var sql='select * from my_vipList'
    db.query(sql,(err,data)=>{
        if(err){
            return res.send('错误：'+err.message)
        }
        res.send(data)
    })
}
exports.getswiperList=(req,res)=>{
    var sql='select * from my_swiperList'
    db.query(sql,(err,data)=>{
        if(err){
            return res.send('错误：'+err.message)
        }
        res.send(data)
    })
}
exports.getuserothers=(req,res)=>{
    var sql='select * from userothers where userid=?'
    db.query(sql,[req.query.userid],(err,data)=>{
        if(err){
            return res.send('错误：'+err.message)
        }
        res.send(data)
    })
}
exports.getwalletList=(req,res)=>{
    var sql='select * from my_walletList'
    db.query(sql,(err,data)=>{
        if(err){
            return res.send('错误：'+err.message)
        }
        res.send(data)
    })
}
exports.gettoolList=(req,res)=>{
    var sql='select * from my_toolList'
    db.query(sql,(err,data)=>{
        if(err){
            return res.send('错误：'+err.message)
        }
        res.send(data)
    })
}
exports.getotherCard=(req,res)=>{
    var sql='select * from my_otherCard'
    db.query(sql,(err,data)=>{
        if(err){
            return res.send('错误：'+err.message)
        }
        res.send(data)
    })
}
exports.getrecommmend=(req,res)=>{
    var sql='select * from recommend_service'
    db.query(sql,(err,data)=>{
        if(err){
            return res.send('错误：'+err.message)
        }
        res.send(data)
    })
}
exports.getconsultation=(req,res)=>{
    var sql='select * from hot_consultation'
    db.query(sql,(err,data)=>{
        if(err){
            return res.send('错误：'+err.message)
        }
        res.send(data)
    })
}