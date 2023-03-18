//配置路由
let express = require('express')
let router = express.Router()
let user = require('./api/users')
let home = require('./api/home')
let land = require('./api/landmark')
let my = require('./api/my')
let com = require('./api/community')
let mes=require('./api/message')
let orderitems=require('./api/orderitems')

router.get('/users/getusers', user.getusers)
router.get('/users/adduser', user.adduser)
router.get('/home/gettab1', home.gettab1)
router.get('/home/gettab2', home.gettab2)
router.get('/home/getlbt_img', home.getlbt_img)
router.get('/home/gethuodong', home.gethuodong)
router.get('/home/getwaterfull', home.getwaterfull)
router.get('/home/getdiscuss', home.getdiscuss)
router.get('/home/updatezan', home.updatezan)
router.get('/home/gethost', home.gethost)
router.get('/home/insertdis', home.insertdis)
router.get('/home/getattention', home.getattention)
router.get('/home/change_attention', home.change_attention)


router.get('/landmark/getclassify', land.getclassify)
router.get('/landmark/getcategories', land.getcategories)
router.get('/landmark/getcontent', land.getcontent)
router.get('/landmark/getrecommend', land.getrecommend)
router.get('/landmark/gettickets', land.gettickets)
router.get('/landmark/getMaxOrderid', land.getMaxOrderid)
router.get('/landmark/save', land.save)


router.get('/message/buttonDiv',mes.buttonDiv)
router.get('/message/message',mes.message)


router.get('/my/gettopnav1', my.gettopnav1)
router.get('/my/gettabList1', my.gettabList1)
router.get('/my/getnumberList', my.getnumberList)
router.get('/my/getvipList', my.getvipList)
router.get('/my/getswiperList', my.getswiperList)
router.get('/my/getuserothers', my.getuserothers)
router.get('/my/getwalletList', my.getwalletList)
router.get('/my/gettoolList', my.gettoolList)
router.get('/my/getotherCard', my.getotherCard)
router.get('/my/getrecommmend', my.getrecommmend)
router.get('/my/getconsultation', my.getconsultation)

router.get('/orderitems/getorderitems',orderitems.getorderitems)
router.get('/orderitems/changeflag',orderitems.changeflag)
router.get('/orderitems/deleteOrders',orderitems.deleteOrders)

router.get('/community/updatezan',com.updatezan)
router.get('/community/getgroupdata',com.getgroupdata)
router.get('/community/gethotdata',com.gethotdata)

module.exports = router
