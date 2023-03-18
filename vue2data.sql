SET SQL_SAFE_UPDATES = 0;
create database vuedatabase;


drop table if exists users;
create table users(
	userid int auto_increment primary key,
	username varchar(50),
    password varchar(50),
    email varchar(30),
    phone varchar(11),
    address varchar(30) default '北京',
    headimg varchar(50) default 'h2.jpg',
    vip varchar(50) default 'A',
    community varchar(20) default '社区lv.1',
    myintroduce text,
    myintroduceicon varchar(30) default 'iconfont icon-youliaobiji'
);
drop trigger if exists insertuser;
delimiter $$
create trigger insertuser before insert on users for each row
begin
    insert into userothers values (new.userid,new.username,'粉丝',1);
    insert into userothers values (new.userid,new.username,'关注',0);
    insert into userothers values (new.userid,new.username,'获赞',0);
    insert into userothers values (new.userid,new.username,'点赞',0);
end $$
delimiter ;
insert into users (userid,username,password,email,phone,address,headimg,vip) values
				(1000,'买西瓜的猪','wangjie2002','2465140491@qq.com','19143657909','浙江','h1.jpg','C'),
				(1001,'世界真大想看看','jiangwang2002','2465140491@qq.com','19143657909','成都','h3.jpg','A');



drop table if exists userothers;
create table userothers(
	userid int,
	username varchar(50),
    text varchar(20),
    count int
);

drop table if exists vipcategory;
create table vipcategory(
	categoryid char(1) primary key,
    vipname varchar(20),
    iconcolor varchar(20),
    bgc varchar(20)
);

insert into vipcategory(categoryid,vipname,iconcolor,bgc) values
	('A','普通会员','#6cb2f8','#548ee2'),
    ('B','白银会员','#6dabfe','#97ccfe'),
    ('C','黄金会员','#ecb966','#f9cb92'),
    ('D','铂金会员','#64b7cd','#95d7e5'),
    ('E','钻石会员','#3f22a0','#7351c2'),
    ('F','金钻会员','#182876','#5332a3'),
    ('G','黑钻会员','#22211c','#40311c');

drop table if exists home_tab1;
create table home_tab1(
	name varchar(50),
	icon varchar(50),
    bgc varchar(50),
    color varchar(30),
    goto varchar(30) default '/Land'
);
insert into home_tab1(name,bgc,icon,color) values
    ('酒店', '#fa6554', 'iconfont icon-jiudian', '#ffffff' ),
    ('机票', '#3f8bfa', 'iconfont icon-jipiao', '#ffffff' ),
    ('火车票', '#5f83ff', 'iconfont icon-huochepiao', '#ffffff' ),
    ('旅游', '#21bcaf', 'iconfont icon-icon_xinyong_xianxing_jijin-140', '#ffffff' ),
    ('攻略/景点', '#ff8d3b', 'iconfont icon-gonglve', '#ffffff' ),
    ('民宿/客栈', '#fef2f5', 'iconfont icon-kezhangongyu', '#fc755f' ),
    ('机+酒', '#f0f8fe', 'iconfont icon-jiudian1', '#4290fa' ),
    ('汽车/船票', '#f2f4ff', 'iconfont icon-qichezhan', '#7b81ff' ),
    ('门票/活动', '#ecfbf8', 'iconfont icon-menpiao', '#48cfb6' ),
    ('美食', '#fff9f3', 'iconfont icon-daocha', '#ff9c3d' ),
    ('特价/爆款', '#fef2f5', 'iconfont icon-baokuan', '#fc755f' ),
    ('接送机/包车', '#f0f8fe', 'iconfont icon-lvyoubaochedingdan', '#4290fa' ),
    ('租车', '#f2f4ff', 'iconfont icon-chuzuche', '#7b81ff' ),
    ('周边游', '#ecfbf8', 'iconfont icon-zhoubianyou', '#48cfb6' ),
    ('购物/免税', '#fff9f3', 'iconfont icon-gouwu', '#ff9c3d' );

drop table if exists home_tab2;
create table home_tab2(
	name varchar(50),
	icon varchar(50),
    bgc varchar(50),
    color varchar(30),
    goto varchar(30) default '/Land'
);
insert into home_tab2(name,bgc,icon,color) values
	('一日游','#ffffff', 'iconfont icon-qizhi','#3fcbb7' ),
	('向导/包车','#ffffff', 'iconfont icon-zujianxiangdao','#3fcbb7' ),
    ('保险','#ffffff', 'iconfont icon-baoxian','#3fcbb7' ),
	('微领队','#ffffff', 'iconfont icon-34qizhi','#3fcbb7' ),
	('定制游','#ffffff', 'iconfont icon-dingzhiyou','#3fcbb7' ),
	('外币兑换','#ffffff', 'iconfont icon-duihuanwaibi','#3fcbb7' ),
	('WiFi电话卡','#ffffff', 'iconfont icon-wifi','#3fcbb7' ),
	('行李寄送','#ffffff', 'iconfont icon-hangliyouxiansongda','#3fcbb7' ),
	('携程门店','#ffffff', 'iconfont icon-mendian','#3fcbb7' ),
	('旅拍/跟拍','#ffffff', 'iconfont icon-paizhao1','#3fcbb7' ),
	('航班助手','#ffffff', 'iconfont icon-hangbandongtai','#3fcbb7' ),
	('紧急救援','#ffffff', 'iconfont icon-EmergencySOS','#fb7153' ),
	('借钱','#ffffff', 'iconfont icon-jieqian','#ff8431' ),
	('签证','#ffffff', 'iconfont icon-qianzhengfuwu','#4fd4b7' ),
	('企业差旅','#ffffff', 'iconfont icon-chalvfeibaoxiao','#759ace' ),
	('加盟合作','#ffffff', 'iconfont icon-men','#759ace' ),
	('核酸检测','#ffffff', 'iconfont icon-hesuanjiance','#759ace' ),
	('旅游扶贫','#ffffff', 'iconfont icon-fupinqingkuang','#759ace' ),
	('数字藏品','#ffffff', 'iconfont icon-cangpinjianding','#759ace' ),
	('携程公益','#ffffff', 'iconfont icon-liebiaodaohang_gongyi','#f24e41' );
    
drop table if exists landmark_classify;
create table landmark_classify(
	id int auto_increment primary key,
	img varchar(50),
    text varchar(50)
);
insert into landmark_classify(img,text) values
	('land1.png','演出展览'),
    ('land2.png','滑雪'),
    ('land3.png','赏秋景'),
    ('land4.png','亲子同乐'),
    ('land5.png','自然风光');

drop table if exists landmark_categories;
create table landmark_categories(
	categoryid varchar(20),
    categoryname varchar(30)
);
insert into landmark_categories values
	('A','人气景点'),
    ('B','亲子同乐'),
    ('C','亲近大自然'),
    ('D','船行航程'),
    ('E','毕业旅行'),
    ('F','节假日推荐景点'),
    ('G','网红打卡地');

drop table if exists landmark_content;
create table landmark_content(
	contentid int primary key,
    contentname varchar(200),
    img varchar(200),
    shortaddress varchar(20),
    redspan varchar(255),
    discusscount int,
    hot double,
    picjson json,
    span varchar(50),
    opentime varchar(50),
    closetime varchar(50),
    longaddress varchar(255),
    price int,
    grade double,
    categoryid varchar(50)
);
#'寓教于乐近亲小动物',5964,7.2,'[{"id":0,"img":"dwsj1.jpg"},{"id":1,"img":"dwsj2.jpg"},{"id":2,"img":"dwsj3.jpg"}]','萌萌动物','09:30','16:30','杭州市杭富路九龙大道1号',
insert into landmark_content values
	(10070,'杭州宋城','songcheng.png','杭州','看《宋城千古情》演出',19458,8.0,'[{"id":0,"img":"sc1.jpg"},{"id":1,"img":"sc2.jpg"},{"id":2,"img":"sc3.jpg"}]','看演出','10:30','21:00','杭州市西湖区之江路148号',300,4.6,'A&B&E&F&G' ),
    (10071,'杭州动物园','dongwuyuan.png','杭州','观看精彩的动物杂技表演',3791,6.8,'[{"id":0,"img":"dwy1.jpg"},{"id":1,"img":"dwy2.jpg"},{"id":2,"img":"dwy3.jpg"}]','萌萌动物','07:00','17:00','杭州市虎跑路40号',20,4.7,'A&B' ),
    (10072,'千岛湖中心湖区','qiandaohuzhongxinhuqu.png','建德','乘船领略山河锦绣',6864,6.4,'[{"id":0,"img":"qdh1.jpg"},{"id":1,"img":"qdh2.jpg"},{"id":2,"img":"qdh3.jpg"}]','游山玩水','08:00','15:30','淳安县千岛湖镇梦姑路千岛湖中心湖区游船码头',185,4.3,'A&E'),
    (10073,'杭州野生动物世界','yeshengdongwushijie.png','杭州','寓教于乐近亲小动物',5964,7.2,'[{"id":0,"img":"dwsj1.jpg"},{"id":1,"img":"dwsj2.jpg"},{"id":2,"img":"dwsj3.jpg"}]','萌萌动物','09:30','16:30','杭州市杭富路九龙大道1号',210,4.6,'A&B&E&F'),
    (10074,'杭州长乔极地海洋公园','changqiaojidihaiyanggongyuan.png','杭州','亲近了解可爱的海洋生物',10147,6.8,'[{"id":0,"img":"hygy1.jpg"},{"id":1,"img":"hygy2.jpg"},{"id":2,"img":"hygy3.jpg"}]','嗨玩乐园','09:00','17:00','杭州市萧山区湘湖路777号',350,4.5,'A&B&F'),
    (10075,'垂云通天河','chuiyuntongtianhe.png','桐庐','乘小船穿梭地下暗河',5432,6.6,'[{"id":0,"img":"tth1.jpg"},{"id":1,"img":"tth2.jpg"},{"id":2,"img":"tth3.jpg"}]','亲近大自然','03:30','16:00','杭州市桐庐县瑶琳镇东琳村景区',108,4.3,'A&B&C&F&G'),
    (10076,'千岛湖东南湖区','qiandaohudongnanhuqu.png','淳安','岛屿众多，花开四季',3192,5.8,'[{"id":0,"img":"qdh4.jpg"},{"id":1,"img":"qdh5.jpg"},{"id":2,"img":"qdh6.jpg"}]','萌萌动物','08:00','15:00','杭州市淳安县千岛湖风景区',185,4.5,'B&C'),
    (10077,'大奇山国家森林公园','daqishanguojiasenlingongyuan.png','桐庐','适合休闲游览综合性森林公园',3215,6.0,'[{"id":0,"img":"dqs1.jpg"},{"id":1,"img":"dqs2.jpg"}]','亲近大自然','08:30','16:00','杭州市桐庐县大奇山国家森林公园',46,4.5,'C&E&F'),
    (10078,'西湖游船','xihuyouchuan.png','杭州','坐船领略西湖别样美貌',3103,7.2,'[{"id":0,"img":"xhyc1.jpg"},{"id":1,"img":"xhyc2.jpg"},{"id":2,"img":"xhyc3.jpg"}]','亲近大自然','07:30','16:30','杭州市上城区湖滨路15号二公园码头',55,4.5,'C&D'),
    (10079,'大明山景区','damingshan.png','杭州','探万米岩洞走悬空栈道',2994,7.2,'[{"id":0,"img":"dms1.png"},{"id":1,"img":"dms2.png"},{"id":2,"img":"dms3.png"}]','亲近大自然','07:30','17:00','杭州市临安区清凉峰镇白果村横溪桥158号',25,4.6,'C&E'),
    (10080,'西溪国家湿地公园','xixiguojiashidi.png','杭州','坐船漫游芦苇荡',15207,7.7,'[{"id":0,"img":"xxsd1.jpg"},{"id":1,"img":"xxsd2.jpg"},{"id":2,"img":"xxsd3.jpg"},{"id":3,"img":"xxsd4.jpg"}]','亲近大自然','08:00','17:30','杭州市西湖区天目山路518号',70,4.6,'C&D&E&F&G' ),
    (10081,'钱塘江夜游','qiantangjiangyeyou.png','杭州','乘游船赏两岸湖光山色',589,6.4,'[{"id":0,"img":"qtj1.jpg"},{"id":1,"img":"qtj2.jpg"},{"id":2,"img":"qtj3.jpg"}]','亲近大自然','09:00','22:00','杭州市江汉路闻涛路交叉口滨江码头水上旅游服务中心',85,4.4,'D'),
    (10082,'京杭大运河杭州景区','jinghangdayunhehangzhou.png','杭州','世界文化遗产',1033,6.2,'[{"id":0,"img":"jhdyh1.jpg"},{"id":1,"img":"jhdyh2.jpg"},{"id":2,"img":"jhdyh3.jpg"}]','亲近大自然','09:00','20:20','杭州市京杭大运河余杭塘栖至钱塘江段',110,4.5,'D'),
    (10083,'杭州湘湖游船','xianghuyouchuan.png','杭州','乘船领略湘湖萧山静谧风光',509,7.2,'[{"id":0,"img":"xh1.jpg"}]','游船观光','09:00','16:30','杭州市萧山区风情大道2758号浙江湘湖旅游度假区内',27,4.6,'D' ),
    (10084,'良渚古城遗址公园','liangzhuyizhi.png','良渚','欣赏良渚时期的珍贵文物',692,6.0,'[{"id":0,"img":"lz1.jpg"},{"id":1,"img":"lz2.jpg"},{"id":2,"img":"lz3.jpg"}]','文化古迹','09:00','17:00','杭州市余杭区凤都路与104国道交叉口西北200米',50,4.4,'G'),
    (10085,'雷峰塔','leifengta.png','杭州','拍西湖全貌赏塔楼倩影',6262,7.1,'[{"id":0,"img":"lft1.jpg"},{"id":1,"img":"lft2.jpg"},{"id":2,"img":"lft3.jpg"}]','文化古迹','08:00','17:30','杭州市西湖区南山路15号',40,4.5,'G'),
    (10086,'杭州开元森泊度假酒店','kaiyuansenbo.png','杭州','住宿餐饮游乐度假区',3797,6.7,'[{"id":0,"img":"kysb1.png"},{"id":1,"img":"kysb2.png"},{"id":2,"img":"kysb3.png"}]','度假村','10:00','18:00','杭州市先山区湘湖路1515号',60,4.9,'G');

drop table if exists landmark_tickets;
create table landmark_tickets(
	contentid int,
    ticketid long,
    title varchar(255),
    requirement varchar(255),
    give varchar(255),
    span1 varchar(255),
    span2 varchar(255),
    span3 varchar(255),
    sold int,
    price double
);
insert into landmark_tickets values
	(10070,10070001,'《宋城千古情》演出票(含杭州宋城景区)【亲子票1大1小(限1成人+1优待人群)】','','赠最高减￥60酒店券','可订明日','有条件退','无需取票',943,520),
    (10070,10070002,'《宋城千古情》演出票(含杭州宋城景区)【家庭票2大1小(限2成人+1优待人群)】','','赠最高减￥60酒店券','可订明日','有条件退','无需取票',1043,800),
    (10070,10070003,'《宋城千古情》演出票(含杭州宋城景区)(成人票)','','赠最高减￥60酒店券','可订明日','有条件退','无需取票',10943,300),
    (10070,10070004,'《宋城千古情》演出票(含杭州宋城景区)(限量豪华沙发席、演员献茶1杯)(成人票)','','赠最高减￥60酒店券','可订明日','有条件退','无需取票',343,580),
    (10070,10070005,'《宋城千古情》演出票(含杭州宋城景区)(观众席-14：00)【学生票(大学生)】','','赠最高减￥60酒店券','可订明日','有条件退','无需取票',233,220),
    (10071,10071001,'成人票','身高150cm(不含)以上','赠最高减￥60酒店券','可订明日','无忧退','无需取票',17004,20),
    (10071,10071002,'优待票(儿童/学生/老人)','6周岁(不含)-18周岁(含)未成年人；1.2米(不含)-1.5米(含)的未成年人；中国境内全日制大学本科及以下学历学生凭学生证；60周岁(含)-69周岁(含)老年人凭老年证或身份证','赠最高减￥60酒店券','可订明日','无忧退','无需取票',4943,10),
	(10072,10072001,'成人票','年龄19周岁(含)~59周岁(含)','赠最高减￥60酒店券','可订明日','随时退','无需取票',12004,185),
    (10072,10072002,'儿童票','身高120cm(不含)~150cm(含)','赠最高减￥60酒店券','可订明日','随时退','无需取票',1004,100),
    (10072,10072003,'成人票(上海市民专享)','年龄19周岁(含)~59周岁(含)','赠最高减￥60酒店券','可订明日','随时退','无需取票',604,120),
    (10072,10072004,'不限人群(浙江省内市民专享)','凭浙江省内公安机关签发的身份证或居住证，未持身份证的儿童凭随行监护人居民户口簿办理','赠最高减￥60酒店券','可订明日','随时退','无需取票',233,120),
    (10073,10073001,'成人票','身高150cm(含)以上','赠最高减￥60酒店券','可订明日','有条件退','无需取票',27004,210),
    (10073,10073002,'优待票(儿童/老人/军人等)','儿童1.2米(不含)~1.5米(不含)；现役军人凭有效证件；三十年教龄的老师凭有效证件；70周岁(含)以上老人凭有效证件；残疾人凭有效证件','赠最高减￥60酒店券','可订明日','有条件退','无需取票',2004,140),
    (10073,10073003,'学生票(大学生票)','全日制在读大学生凭有效证件','赠最高减￥60酒店券','可订明日','有条件退','无需取票',604,170),
    (10074,10074001,'成人票','身高140cm(含)以上','赠最高减￥60酒店券','可订明日','无忧退','无需取票',18004,350),
    (10074,10074002,'优待票(儿童/老人/残疾人/教师/现役军人)','身高1.0-1.4米(含)儿童；70周岁及以上长者；残疾人；30年及以上教龄教师；现役军人。购买优惠票除儿童外，其他人员入馆需要出示相关证件。年满70周岁老人、未满16周岁少儿，须在成年监护人陪同下，方可入园游玩','赠最高减￥60酒店券','可订明日','无忧退','无需取票',4004,299),
	(10075,10075001,'垂云通天河游船票(成人票)','','赠最高减￥60酒店券','可订明日','无忧退','无需取票',9004,108),
	(10075,10075002,'垂云通天河游船票(儿童票)','','赠最高减￥60酒店券','可订明日','无忧退','无需取票',1004,54),
    (10075,10075003,'垂云通天河游船票(老人票)','','赠最高减￥60酒店券','可订明日','无忧退','无需取票',1004,86),
    (10076,10076001,'成人票','年龄19周岁(含)~59周岁(含)','赠最高减￥60酒店券','可订明日','随时退','无需取票',12004,185),
    (10076,10076002,'儿童票','身高120cm(不含)~150cm(含)','赠最高减￥60酒店券','可订明日','随时退','无需取票',1004,100),
    (10076,10076003,'成人票(上海市民专享)','年龄19周岁(含)~59周岁(含)','赠最高减￥60酒店券','可订明日','随时退','无需取票',604,120),
    (10076,10076004,'不限人群(浙江省内市民专享)','凭浙江省内公安机关签发的身份证或居住证，未持身份证的儿童凭随行监护人居民户口簿办理','赠最高减￥60酒店券','可订明日','随时退','无需取票',133,120),
    (10077,10077001,'儿童票','身高120cm(不含)~150cm(不含)','赠最高减￥60酒店券','可订明日','有条件退','无需取票',1004,26),
    (10077,10077002,'老人票','年龄60周岁(含)~69周岁(含)','赠最高减￥60酒店券','可订明日','有条件退','无需取票',1004,26),
    (10077,10077003,'学生票(大学生)','全日制在读大学生凭有效证件','赠最高减￥60酒店券','可订明日','有条件退','无需取票',2204,26),
    (10077,10077004,'学生票(高中及以下)','全日制高中及以下学历在校学生凭本人有效证件购买','赠最高减￥60酒店券','可订明日','有条件退','无需取票',304,26),
    (10078,10078001,'成人票','身高150cm(不含)以上','赠最高减￥60酒店券','可订明日','无忧退','无需取票',4204,55),
    (10078,10078002,'儿童票','身高120cm(含)~150cm(含)','赠最高减￥60酒店券','可订明日','无忧退','无需取票',204,27.5),
    (10078,10078003,'学生票','全日制本科及以下学历在校学生凭有效证件','赠最高减￥60酒店券','可订明日','无忧退','无需取票',504,45),
    (10079,10079001,'成人票','身高150cm(含)以上','赠最高减￥60酒店券','可订明日','','无需取票',2204,95),
    (10079,10079002,'不分入园时间【儿童票】','身高120cm(不含)~150cm(不含)','赠最高减￥60酒店券','可订明日','有条件退','无需取票',204,59),
    (10079,10079003,'不分入园时间【成人票】','身高150cm(含)以上','赠最高减￥60酒店券','可订明日','有条件退','无需取票',1204,25),
    (10080,10080001,'成人票','年龄19周岁(含)~59周岁(含)','赠最高减￥60酒店券','可订明日','随时退','无需取票',3204,70),
    (10080,10080002,'不限人群','身高120cm(不含)以上','赠最高减￥60酒店券','可订明日','随时退','无需取票',45,145),
    (10081,10081001,'钱印/梦航号(成人票)','','赠最高减￥60酒店券','可订明日','有条件退','需取票',3204,85),
    (10081,10081002,'钱印/梦航号(儿童票)','','赠最高减￥60酒店券','可订明日','有条件退','无需取票',204,69),
    (10081,10081003,'凤山烟雨号(钱运游)(成人票)','','赠最高减￥60酒店券','可订11月29日','有条件退','需取票',404,138),
    (10081,10081004,'凤山烟雨号(钱运游)(亲子票1大1小)','','赠最高减￥60酒店券','可订11月29日','有条件退','需取票',40,237),
    (10081,10081005,'凤山烟雨号(钱运游)(家庭票2大1小)','','赠最高减￥60酒店券','可订11月29日','有条件退','需取票',79,375),
    (10081,10081006,'凤山烟雨号(钱运游)(儿童票)','','赠最高减￥60酒店券','可订11月29日','有条件退','需取票',12,79),
    (10082,10082001,'成人票','优待人群以外人群','赠最高减￥60酒店券','可订明日','','',604,110),
    (10082,10082002,'儿童票','身高120cm(含)~150cm(不含)','赠最高减￥60酒店券','可订明日','有条件退','需取票',21,60),
    (10082,10082003,'亲子票1大1小','1成人+1儿童身高120cm(含)~150cm(不含)','赠最高减￥60酒店券','可订明日','','',63,170),
    (10082,10082004,'双人票','优待以外人群','赠最高减￥60酒店券','可订明日','随时退','无需取票',86,220),
    (10083,10083001,'成人票','身高150cm(不含)以上','赠最高减￥60酒店券','可订明日','无忧退','无需取票',330,55),
    (10083,10083002,'优待票(儿童/老人)','儿童限制身高为1.2米(含)~1.5米(含)；老年人限制年龄为70周岁(含)以上','赠最高减￥60酒店券','可订明日','无忧退','无需取票',43,30),
    (10084,10084001,'成人票','年龄18周岁(含)以上','赠最高减￥60酒店券','可订明日','随时退','无需取票',2001,50),
    (10084,10084002,'优待票(儿童/学生/老人)','6周岁(含)~18周岁(不含)之间有成年人监护的青少年儿童；全日制大学本科及以下学历学生(凭本人有效学生证件)；60周岁(含)至70周岁(不含)的老人；','赠最高减￥60酒店券','可订明日','随时退','无需取票',591,25),
	(10085,10085001,'成人票','年龄18周岁(含)以上','赠最高减￥60酒店券','可订11月28日','有条件退','无需取票',1,40),
    (10085,10085002,'雷峰塔+西湖游船(登三潭印月岛)(成人票)','船只为休闲船(含登三潭印月岛)','赠最高减￥60酒店券','可订明日','随时退','需取票',661,90),
    (10085,10085003,'雷峰塔门票+西湖外事环湖游船(成人票)','','赠最高减￥60酒店券','可订明日','随时退','需取票',1001,70),
    (10085,10085004,'雷峰塔+岳王庙景区门票(成人票)','','赠最高减￥60酒店券','可订明日','随时退','需取票',1661,60),
    (10085,10085005,'雷峰塔+印象西湖《最忆是杭州》演出(成人票)','','赠最高减￥60酒店券','可订明日','不可退','需取票',111,360),
    (10086,10086001,'亲子票1大1小','1成人+1儿童','赠最高减￥60酒店券','可订明日','无忧退','无需取票',661,238),
    (10086,10086002,'成人票(陪同票)','身高150cm(不含)以上','赠最高减￥60酒店券','可订明日','无忧退','无需取票',461,60),
    (10086,10086003,'儿童票','身高80cm(含)~150cm(含)','赠最高减￥60酒店券','可订明日','无忧退','无需取票',661,188);
    

drop table if exists home_lbt_img;
create table home_lbt_img(
	id int auto_increment primary key,
	img varchar(50)
);

insert into home_lbt_img (img) values
	('lbt_img/lbt1.png'),
    ('lbt_img/lbt2.png'),
    ('lbt_img/lbt3.png'),
    ('lbt_img/lbt4.png'),
    ('lbt_img/lbt5.png'),
    ('lbt_img/lbt6.png'),
    ('lbt_img/lbt7.png'),
    ('lbt_img/lbt8.png'),
    ('lbt_img/lbt9.png'),
    ('lbt_img/lbt10.png'),
    ('lbt_img/lbt11.png'),
    ('lbt_img/lbt12.png');

drop table if exists home_huodong;
create table home_huodong(
	id int auto_increment primary key,
	title varchar(50),
    text varchar(50),
    img varchar(50)
);
insert into home_huodong (title,text,img) values
	 ('现金红包','看笔记免费领','huodong/huodong1.png'),
	 ('奕星带你游','滕王阁','huodong/huodong2.png'),
	 ('打牌领话费','海量实物兑换','huodong/huodong3.png'),
	 ('周周乐','赢49999积分','huodong/huodong4.png'),
	 ('游游西瓜','叠出大西瓜','huodong/huodong5.png'),
	 ('游游大冒险','海量奖品','huodong/huodong6.png');

drop table if exists home_waterfull;
create table home_waterfull(
	waterfull_id int,
	waterfull_img varchar(50),
    waterfull_address varchar(50),
    waterfull_title varchar(50),
    waterfull_span1 varchar(50),
    head_img varchar(50),
    writerid int,
    writer varchar(50),
    waterfull_span2 varchar(50),
    waterfull_span_color varchar(50),
    waterfull_span_bgc varchar(50),
    goto varchar(50) default '/detail',
    detail_appraise varchar(50), #评价图片
    detail_pic json,
    detail_tags json,
    introduce text,
    publishtime varchar(50),
    detail_bottom json,
    zanicon varchar(20) default 'icon-dianzan',
    zanpeople json
);

insert into home_waterfull (waterfull_id,writerid,writer,waterfull_img,waterfull_address,waterfull_title,waterfull_span1,head_img,waterfull_span2,waterfull_span_color,waterfull_span_bgc,detail_appraise,detail_pic,detail_tags,introduce,publishtime,detail_bottom,zanpeople) values
	(1,1001,'肆月3707','w_zhongshuge.png','钟书阁','杭州zui美网红书店钟书阁/误入魔幻森林','3460人对这篇有兴趣','head1.png','人文旅行达人','#cc8408','#fff9eb','youzhi.png','[{"picid":"0","img":"zhongshuge1.png"},{"picid":"1","img":"zhongshuge2.png"},{"picid":"2","img":"zhongshuge3.png"},{"picid":"3","img":"zhongshuge4.png"},{"picid":"4","img":"zhongshuge5.png"},{"picid":"5","img":"zhongshuge6.png"},{"picid":"6","img":"zhongshuge7.png"}]','[{"address":"杭州","type":""},{"address":"钟书阁","type":""}]','杭州zui美网红书店钟书阁/误入魔幻森林<br>真的是一个看书拍照两不误的最美书店<br>巧妙的设计，让人不禁想要走入其中<br>附上打卡小tips：<br>杭州zui美网红书店钟书阁/误入魔幻森林<br>杭州zui美网红书店钟书阁/误入魔幻森林<br>真的是一个看书拍照两不误的最美书店<br>巧妙的设计，让人不禁想要走入其中<br>附上打卡小tips：','2022-08-12','[{"name":"杭州·真实玩家攻略","icon":"iconfont icon-sousuo"},{"name":"杭州·必住酒店","icon":"iconfont icon-sousuo"},{"name":"杭州·必玩景点","icon":"iconfont icon-sousuo"},{"name":"杭州·省心跟团游","icon":"iconfont icon-sousuo"}]','[{"name":"小猪一号"},{"name":"小猪二号"},{"name":"小猪三号"},{"name":"小猪四号"}]'),
	(2,1002,'玩到那笑到那','w_dishini.png','上海','在迪士尼住了不下10次的城堡泳池民宿','235人已收藏','head5.png','自驾游达人','#cc8408','#fff9eb','jingxuan.png','[{"picid":"0","img":"dishini1.png"},{"picid":"1","img":"dishini2.png"},{"picid":"2","img":"dishini3.png"},{"picid":"3","img":"dishini4.png"},{"picid":"4","img":"dishini5.png"},{"picid":"5","img":"dishini6.png"},{"picid":"6","img":"dishini7.png"},{"picid":"7","img":"dishini8.png"}]','[{"address":"浦东新区","type":""},{"address":"栖梦民宿","type":""}]','迪士尼接送免费早餐许光汉同款城堡泳池民宿<br>迪士尼6.30号就恢复开园啦<br>之前每次去迪士尼都住这家民宿<br>纯白色的小别墅超大游泳池<br>院子和露台还可以看到迪士尼的烟花哦<br>而且#许光汉也住过这家我不允许有人不知道<br>纯白独栋三层别墅<br>前院是圣托里尼风，后院是摩洛哥风，肆意穿梭<br>感受不同风情<br>岩系洞穴风客厅不规则园拱落地大窗处处设计感<br>十足100%出片率<br>谁能抵挡院内超大泳池的诱惑<br>还有儿童泳池适合带小朋友来玩<br>更有吊椅、餐厅、书吧等各种好玩的区域<br>感觉像是一个小型游乐场','2022-07-23','[{"name":"上海·真实玩家攻略","icon":"iconfont icon-sousuo"},{"name":"上海·必住酒店","icon":"iconfont icon-sousuo"},{"name":"上海·必玩景点","icon":"iconfont icon-sousuo"},{"name":"上海·省心跟团游","icon":"iconfont icon-sousuo"}]','[]'),
	(3,1003,'长乐echo','w_jiangpandudong.png','成都','在湖畔独栋小屋吃火锅是什么样的体验在湖畔独栋小屋吃火锅是什么样的体验','6770人对这篇有兴趣','head6.png','签约旅行家','#cc8408','#fff9eb','jingxuan.png','[{"picid":"0","img":"h1.png"},{"picid":"1","img":"h2.png"},{"picid":"2","img":"h3.png"},{"picid":"3","img":"h4.png"},{"picid":"4","img":"h5.png"},{"picid":"5","img":"h6.png"}]','[{"address":"成都","type":""}]','这家生态火锅的地址是在郫都<br>超级多绿植环绕的一家生态火锅店<br>一进门仿佛自己在西双版纳度假<br>水雾飘渺的小湖處和绿树成荫的树木金<br>每个角度看都是别处一格的美 每个角度都超级出片<br>这家店光是占地面积就达到了4000平方米 很难不爱是周末节日带上家人 公司团建的不二首选<br>火箭鱿鱼<br>火锅界很流行的一道菜品 喜欢吃鱿鱼奥的必点<br>醒发的非常到位 脆嫩度不错<br>肉质很紧韧鲜美个头也大 可以闭眼点<br>清油脆毛肚<br>毛肚脆嫩爽口 推荐 入口Q弹又不失嚼劲<br>可以做清油毛肚的店铺屈指可数 很考验毛肚的新鲜程度<br>这家火锅店的环境 服务 真是没得说<br>在如此舒适的仙境中吃火锅<br>圣傍晚还会有精彩演出<br>小姐姐乘着游船表演歌曲演奏和精彩的民族舞蹈<br>大店名：七號水韵生态火锅（郫都店)<br>地址：郫都区太清路200号','2022-10-02','[{"name":"成都·真实玩家攻略","icon":"iconfont icon-sousuo"},{"name":"成都·必住酒店","icon":"iconfont icon-sousuo"},{"name":"成都·必玩景点","icon":"iconfont icon-sousuo"},{"name":"成都·省心跟团游","icon":"iconfont icon-sousuo"}]','[{"name":"小猪一号"},{"name":"小猪二号"},{"name":"小猪三号"}]'),
	(4,1004,'拽住星星的衣领','w_shengtuolini.png','大理白族自治州','走啊，我们去看爱琴海变成金色','1119人已收藏','head7.png','','','','jingxuan.png','[{"picid":"0","img":"s1.png"},{"picid":"1","img":"s2.png"},{"picid":"2","img":"s3.png"},{"picid":"3","img":"s4.png"},{"picid":"4","img":"s5.png"},{"picid":"5","img":"s6.png"},{"picid":"6","img":"s7.png"},{"picid":"7","img":"s8.png"}]','[{"address":"大理白族自治区","type":""},{"address":"大理松云悬崖酒店","type":""}]','坐落在大理 ◎海东镇理想邦，距离机场15分钟车程即可<br>酒店地理位置在海东镇属于 C 位，只有15间<br>苍山洱海迷人的景色尽收眼底。<br>这里是离云最近的地方、这里是大理的观景台、这里是东方的伊莫洛维里小镇、这里是东方的费罗斯特法尼都；这里每一个客房拥有希腊基克拉迪装饰风格，这里每个客房都拥有爱琴海的风韵、这里是我们大理的圣托里尼，来过你一定会爱上这里：<br>每间房内白色和蓝色是主要色调。今年再来大理终于订到了','2022-06-16','[{"name":"网红","icon":"iconfont icon-sousuo"},{"name":"文化旅游区","icon":"iconfont icon-sousuo"},{"name":"敦煌夜市攻略","icon":"iconfont icon-sousuo"},{"name":"敦煌夜市酒店","icon":"iconfont icon-sousuo"}]','[{"name":"小猪一号"},{"name":"小猪二号"},{"name":"小猪三号"},{"name":"小猪四号"}]'),
    (5,1001,'肆月3707','w_zhongshuge.png','钟书阁','copy杭州zui美网红书店钟书阁/误入魔幻森林','3460人对这篇有兴趣','head1.png','人文旅行达人','#cc8408','#fff9eb','youzhi.png','[{"picid":"0","img":"zhongshuge1.png"},{"picid":"1","img":"zhongshuge2.png"},{"picid":"2","img":"zhongshuge3.png"},{"picid":"3","img":"zhongshuge4.png"},{"picid":"4","img":"zhongshuge5.png"},{"picid":"5","img":"zhongshuge6.png"},{"picid":"6","img":"zhongshuge7.png"}]','[{"address":"杭州","type":""},{"address":"钟书阁","type":""}]','杭州zui美网红书店钟书阁/误入魔幻森林<br>真的是一个看书拍照两不误的最美书店<br>巧妙的设计，让人不禁想要走入其中<br>附上打卡小tips：<br>杭州zui美网红书店钟书阁/误入魔幻森林<br>杭州zui美网红书店钟书阁/误入魔幻森林<br>真的是一个看书拍照两不误的最美书店<br>巧妙的设计，让人不禁想要走入其中<br>附上打卡小tips：','2022-08-12','[{"name":"杭州·真实玩家攻略","icon":"iconfont icon-sousuo"},{"name":"杭州·必住酒店","icon":"iconfont icon-sousuo"},{"name":"杭州·必玩景点","icon":"iconfont icon-sousuo"},{"name":"杭州·省心跟团游","icon":"iconfont icon-sousuo"}]','[{"name":"小猪一号"},{"name":"小猪二号"},{"name":"小猪三号"},{"name":"小猪四号"}]'),
	(6,1002,'玩到那笑到那','w_dishini.png','上海','copy在迪士尼住了不下10次的城堡泳池民宿','235人已收藏','head5.png','自驾游达人','#cc8408','#fff9eb','jingxuan.png','[{"picid":"0","img":"dishini1.png"},{"picid":"1","img":"dishini2.png"},{"picid":"2","img":"dishini3.png"},{"picid":"3","img":"dishini4.png"},{"picid":"4","img":"dishini5.png"},{"picid":"5","img":"dishini6.png"},{"picid":"6","img":"dishini7.png"},{"picid":"7","img":"dishini8.png"}]','[{"address":"浦东新区","type":""},{"address":"栖梦民宿","type":""}]','迪士尼接送免费早餐许光汉同款城堡泳池民宿<br>迪士尼6.30号就恢复开园啦<br>之前每次去迪士尼都住这家民宿<br>纯白色的小别墅超大游泳池<br>院子和露台还可以看到迪士尼的烟花哦<br>而且#许光汉也住过这家我不允许有人不知道<br>纯白独栋三层别墅<br>前院是圣托里尼风，后院是摩洛哥风，肆意穿梭<br>感受不同风情<br>岩系洞穴风客厅不规则园拱落地大窗处处设计感<br>十足100%出片率<br>谁能抵挡院内超大泳池的诱惑<br>还有儿童泳池适合带小朋友来玩<br>更有吊椅、餐厅、书吧等各种好玩的区域<br>感觉像是一个小型游乐场','2022-07-23','[{"name":"上海·真实玩家攻略","icon":"iconfont icon-sousuo"},{"name":"上海·必住酒店","icon":"iconfont icon-sousuo"},{"name":"上海·必玩景点","icon":"iconfont icon-sousuo"},{"name":"上海·省心跟团游","icon":"iconfont icon-sousuo"}]','[]'),
	(7,1003,'长乐echo','w_jiangpandudong.png','成都','copy在湖畔独栋小屋吃火锅是什么样的体验在湖畔独栋小屋吃火锅是什么样的体验','6770人对这篇有兴趣','head6.png','签约旅行家','#cc8408','#fff9eb','jingxuan.png','[{"picid":"0","img":"h1.png"},{"picid":"1","img":"h2.png"},{"picid":"2","img":"h3.png"},{"picid":"3","img":"h4.png"},{"picid":"4","img":"h5.png"},{"picid":"5","img":"h6.png"}]','[{"address":"成都","type":""}]','这家生态火锅的地址是在郫都<br>超级多绿植环绕的一家生态火锅店<br>一进门仿佛自己在西双版纳度假<br>水雾飘渺的小湖處和绿树成荫的树木金<br>每个角度看都是别处一格的美 每个角度都超级出片<br>这家店光是占地面积就达到了4000平方米 很难不爱是周末节日带上家人 公司团建的不二首选<br>火箭鱿鱼<br>火锅界很流行的一道菜品 喜欢吃鱿鱼奥的必点<br>醒发的非常到位 脆嫩度不错<br>肉质很紧韧鲜美个头也大 可以闭眼点<br>清油脆毛肚<br>毛肚脆嫩爽口 推荐 入口Q弹又不失嚼劲<br>可以做清油毛肚的店铺屈指可数 很考验毛肚的新鲜程度<br>这家火锅店的环境 服务 真是没得说<br>在如此舒适的仙境中吃火锅<br>圣傍晚还会有精彩演出<br>小姐姐乘着游船表演歌曲演奏和精彩的民族舞蹈<br>大店名：七號水韵生态火锅（郫都店)<br>地址：郫都区太清路200号','2022-10-02','[{"name":"成都·真实玩家攻略","icon":"iconfont icon-sousuo"},{"name":"成都·必住酒店","icon":"iconfont icon-sousuo"},{"name":"成都·必玩景点","icon":"iconfont icon-sousuo"},{"name":"成都·省心跟团游","icon":"iconfont icon-sousuo"}]','[{"name":"小猪一号"},{"name":"小猪二号"},{"name":"小猪三号"}]'),
	(8,1004,'拽住星星的衣领','w_shengtuolini.png','大理白族自治州','copy走啊，我们去看爱琴海变成金色','1119人已收藏','head7.png','','','','jingxuan.png','[{"picid":"0","img":"s1.png"},{"picid":"1","img":"s2.png"},{"picid":"2","img":"s3.png"},{"picid":"3","img":"s4.png"},{"picid":"4","img":"s5.png"},{"picid":"5","img":"s6.png"},{"picid":"6","img":"s7.png"},{"picid":"7","img":"s8.png"}]','[{"address":"大理白族自治区","type":""},{"address":"大理松云悬崖酒店","type":""}]','坐落在大理 ◎海东镇理想邦，距离机场15分钟车程即可<br>酒店地理位置在海东镇属于 C 位，只有15间<br>苍山洱海迷人的景色尽收眼底。<br>这里是离云最近的地方、这里是大理的观景台、这里是东方的伊莫洛维里小镇、这里是东方的费罗斯特法尼都；这里每一个客房拥有希腊基克拉迪装饰风格，这里每个客房都拥有爱琴海的风韵、这里是我们大理的圣托里尼，来过你一定会爱上这里：<br>每间房内白色和蓝色是主要色调。今年再来大理终于订到了','2022-06-16','[{"name":"网红","icon":"iconfont icon-sousuo"},{"name":"文化旅游区","icon":"iconfont icon-sousuo"},{"name":"敦煌夜市攻略","icon":"iconfont icon-sousuo"},{"name":"敦煌夜市酒店","icon":"iconfont icon-sousuo"}]','[{"name":"小猪一号"},{"name":"小猪二号"},{"name":"小猪三号"},{"name":"小猪四号"}]');

drop table if exists attention;
create table attention(
	userid int,
    attentionid int
);
insert into attention values 
	(1000,1001);
select * from attention;
delete from attention where userid=1000 and attentionid=1001;
insert into attention value(1000,1001);
select a.* from home_waterfull a join attention b on a.writerid = b.attentionid where b.userid=1000;
select a.* from (select 1 as flag,a.* from home_waterfull a join attention b on a.writerid = b.attentionid where userid='1000' union all select 0 as flag,a.* from home_waterfull a  where waterfull_id not in(select waterfull_id from home_waterfull a join attention b on a.writerid = b.attentionid where userid='1000')) as a where a.waterfull_id=2;
#<img :src="require('@/assets/img/'+w.img+'')" alt="">
#<img :src="require('@/assets/img/'+w.head+'')" alt="" style="width:30px;height:30px">
#:to="{path:w.goto,query:{myobject:JSON.stringify(w)}}" class="water_li">

drop table if exists discuss;
create table discuss(
	waterfullid int,
    headimg varchar(50),
    name varchar(50),
    text text,
    timestamp bigint,
    disdate date,
    address varchar(50),
    zanicon varchar(50) default 'icon-dianzan',
    zanpeople json
);
insert into discuss(waterfullid,headimg,name,text,timestamp,disdate,address,zanpeople) values
	(1,'h2.jpg','印度阿三','有空去看看',1666617904328,'2022-10-24','广东','[{"zanname":"买西瓜的猪"}]'),
    (2,'h2.jpg','君君体验馆','这个店贵吗',1660262400000,'2022-08-23','山东','[{"zanname":"买西瓜的猪2"},{"zanname":"买西瓜的猪22"}]'),
    (3,'head5.png','小夏旅行','这个很有意思',1664668800000,'2022-10-02','浙江','[{"zanname":"买西瓜的猪3"},{"zanname":"买西瓜的猪33"},{"zanname":"买西瓜的猪"}]'),
    (4,'head2.png','羊了个羊','这里好像是奔跑吧最近一季里面有一期他们到这里，最后结尾还放了主题歌的那一期',1657670400000,'2022-07-13','河南','[{"zanname":"买西瓜的猪4"}]'),
    (4,'head1.png','小太阳花世界的妈咪','一定要住系列',1658016000000,'2022-07-17','上海','[{"zanname":"买西瓜的猪4"},{"zanname":"买西瓜的猪"},{"zanname":"买西瓜的猪4"}]'),
    (4,'head4.png','月光潮男','环境让我爱了',1658188800000,'2022-07-19','福建','[{"zanname":"买西瓜的猪5"}]');


drop table if exists community_square_hot;
create table community_square_hot(
	id int auto_increment primary key,
    icon varchar(50) default 'icon-canyuhuati',
    iconcolor varchar(50) default '#7bc1e2',
    title varchar(255),
    span varchar(255),
    spancolor varchar(50) default '#a8a8a8'
);
insert into community_square_hot (title,span) values
	('理想露营计划','2844次围观'),
    ('徒步看秋天','10.4w次围观'),
	('不出远门的小众景点','1.86w次围观'),
    ('城市街头风味安利','2999次围观'),
    ('桃花源般的乡村','1.6w次围观'),
    ('我见过的极致风景','3.7w次围观'),
    ('收集铁路沿线风景','5.99w次围观'),
    ('穿越时空去旅行','7.01w次围观'),
    ('就近旅行快乐就行','2.55w次围观'),
    ('听听本地人的忠告','6.3w次围观');


drop table if exists community_group;
create table community_group(
	id int auto_increment primary key,
    img varchar(50),
    title varchar(50),
    count1 int,
    span1 varchar(255) default '条帖子',
    count2 int,
    span2 varchar(255),
    spancolor varchar(20) default '#a8a8a8',
    icon varchar(20) default 'icon-youjiantou',
    iconcolor varchar(20) default 'black'
);

insert into community_group (img,title,count1,count2,span2) values
	('group1.png','溜娃大队',451426,3976,'位宝妈宝爸正在讨论'),
    ('group2.png','城市美食拉踩小组',1818,2817,'位吃货正在讨论'),
	('group3.png','就喜欢逛公园',4365,2412,'位公园艺术家正在讨论'),
    ('group4.png','拍照爱好者',4906,3946,'位大师正在讨论'),
    ('group5.png','去了还想去的地方',2575,2408,'位资深玩家正在讨论'),
	('group6.png','我们都爱自驾游',9769,3174,'位老司机正在讨论'),
    ('group7.png','我们都在江浙沪',593,1653,'位包邮区群众正在讨论'),
	('group8.png','一起去旅行',4319,3686,'位大可爱正在讨论'),
    ('group9.png','有问必答万事屋',518,4168,'位大师正在讨论'),
    ('group10.png','城市玩乐探险家',1290,1845,'位看客正在讨论'),
	('group11.png','民间露营大玩家',20374,468,'位露营玩家正在讨论'),
    ('group12.png','重庆小组',179790,1308,'位重庆小面正在讨论'),
	('group13.png','北京小组',4365,2412,'位炸酱面正在讨论'),
    ('group14.png','上海小组',4906,3946,'位小笼包正在讨论'),
    ('group15.png','成都小组',2575,2408,'位凉粉正在讨论'),
	('group16.png','三亚小组',9769,3174,'位椰子树正在讨论'),
    ('group17.png','新疆小组',593,1653,'位胡杨树正在讨论'),
	('group18.png','西藏小组',4319,3686,'位藏羚羊正在讨论'),
    ('group19.png','海岛爱好者',518,4168,'位贝壳正在讨论'),
    ('group20.png','博物馆观察员',1290,1845,'位馆长正在讨论');

drop table if exists message_buttonDiv;
create table message_buttonDiv(
	id int auto_increment primary key,
	icon varchar(50),
    iconcolor varchar(20),
    text varchar(30)
);
insert into message_buttonDiv(icon,iconcolor,text) values
	('icon-dingdan1','#56c4ff','订单出行'),
    ('icon-qunfengxiaoxitongzhi','#fe903d','互动消息'),
    ('icon-xiaoxitongzhifill','#fc6e23','账户通知'),
    ('icon-huiyuan','#b9883a','会员服务');

drop table if exists message_message;
create table message_message(
	id int auto_increment primary key,
    icon varchar(50),
    iconcolor varchar(20),
    iconbgc varchar(20),
    title varchar(255),
    time varchar(100),
    text varchar(255)
);
insert into message_message(icon,iconcolor,iconbgc,title,time,text) values
	('icon-quanzongdongtai','#fff','#ff7070','消息号动态','08:04','携程机票：日本、泰国、新加坡、马尔代夫机票最高直减400元！');

drop table if exists my_topnav1;
create table my_topnav1(
	id int auto_increment primary key,
	icon varchar(30),
    path varchar(50)
);

insert into my_topnav1(icon,path) values
	('iconfont icon-qiandao','/My' ),
    ('iconfont icon-zixun','/service' ),
    ('iconfont icon-31shezhi','/Set' ),
    ('iconfont icon-caidan2','/My' );
                    
drop table if exists my_tabList1;
create table my_tabList1(
	id int auto_increment primary key,	
    name varchar(30),
	icon varchar(80),
    color varchar(20),
    bgc varchar(20) default '#ffffff'
);
insert into my_tabList1(name,icon,color) values
	('全部订单','iconfont icon-quanbudingdan','#6db2ed'),
    ('待付款','iconfont icon-daifukuan','#f2b373'),
    ('未出行','iconfont icon-dingdan-daichuhang','#6bc1f1'),
    ('待点评','iconfont icon-dianping','#e7794d');

drop table if exists my_orderitems_flag;
create table my_orderitems_flag(
	flagid int primary key,
    flagname varchar(50)
);

insert into my_orderitems_flag values
	(1,'待付款'),
    (2,'未使用'),
    (3,'待评价'),
    (4,'交易成功'),
    (5,'已取消'),
    (6,'已退款');

drop table if exists my_orderitems;
create table my_orderitems(
	orderid int,
    ticketid long,
    unitprice double,
    quantity int,
    amount double,
    flagid int
);

insert into my_orderitems(orderid,ticketid,unitprice,quantity,amount,flagid) values
	(10001,10070001,520,2,1040,4),
    (10002,10085003,70,3,210,2),
    (10003,10078003,45,2,90,1),
    (10004,10070003,300,1,300,3),
    (10005,10078003,45,1,45,5),
    (10006,10080002,145,1,145,6);

drop table if exists my_numberList;
create table my_numberList(
	id int auto_increment primary key,	
    text varchar(30),
	number int
);
insert into my_numberList(text,number) values
	('我的收藏',90),
    ('浏览历史',299),
    ('积分',2999),
    ('优惠券',19999);


drop table if exists my_vipList;
create table my_vipList(
	icon varchar(50),
    color varchar(20),
    title varchar(50),
    bgc varchar(20),
    text varchar(50),
    travelIcon varchar(50),
    travelColor varchar(20),
    travelText varchar(50),
    travelBgc varchar(20)
);
insert into my_vipList values('iconfont icon-kaitonghuiyuanyuan','#64b2f7','普通会员','#f7e8d3','查看会员权益 >','iconfont icon-maozi-','#ec9444','超值旅行家','#fdf7e7');

                    
drop table if exists my_swiperList;
create table my_swiperList(
	id int auto_increment primary key,	
    title varchar(255),
	text varchar(255)
);
insert into my_swiperList(title,text) values
	('携程1028周年庆','领1028积分&100元酒店红包>'),
    ('比斯特会籍直通','直升奕友会籍享会员礼'),
    ('添加携程福利管','最高享￥688优惠券');           

drop table if exists my_walletList;
create table my_walletList(
	id int auto_increment primary key,	
    top varchar(50),
	unit varchar(50),
    center varchar(50),
    bottom varchar(50)
);
insert into my_walletList(top,unit,center,bottom) values
	('1.08','万','财富赚钱','新人体验金'),       
    ('1026','券','拿去花','先享后付'),    
    ('20','万','信用贷','最高可借'),    
    ('50','万','白金卡','最高额度');
                    
drop table if exists my_toolList;
create table my_toolList(
	id int auto_increment primary key,	
    icon varchar(50),
    color varchar(20),
    text varchar(50)
);                    
                    
insert into my_toolList(icon,color,text) values
	('iconfont icon-shenfenzheng','#7a7a7a','常用信息'),
    ('iconfont icon-liwulipinjiangpin-xianxing','#7a7a7a','我的奖品'),
    ('iconfont icon-wodebaoxiao','#7a7a7a','报销凭证'),
    ('iconfont icon-huanqiushangou','#7a7a7a','旅行足迹'),
    ('iconfont icon-dingyue','#7a7a7a','订阅管理'),
	('iconfont icon-a-ziyuan81','#7a7a7a','我的信用'),
    ('iconfont icon-qingdan','#7a7a7a','出行清单'),
    ('iconfont icon-qiyeweixin','#7a7a7a','企业微信');

drop table if exists my_otherCard;
create table my_otherCard(
	id int auto_increment primary key,	
    icon varchar(50),
    color varchar(20),
    line1 varchar(50),
    line2 varchar(50)
);

insert into my_otherCard (icon,color,line1,line2) values
	('iconfont icon-remai','#e56d5b','特卖直播','特价好货直播中'),
    ('iconfont icon-icon-test4','#3c9dfe','旅行路线','创建自己的行程'),
    ('iconfont icon-lvhangshe','#ed934a','旅行足迹','查看你的旅行成就'),
    ('iconfont icon-zhaoxiangji','#5eb7f8','创作激励计划','参与可享创作激励');

drop table if exists recommend_service;
create table recommend_service(
	id int,
    icon varchar(50),
    icon_color varchar(20),
    text varchar(50),
    goto varchar(50) default ''
);
insert into recommend_service (id,icon,icon_color,text) values
	(1,'icon-hangbandongtai','#62a1f1','航班助手'),
    (2,'icon-huochepiao','#62a1f1','停运查询'),
    (3,'icon-wodebaoxiao','#ff8431','发票报销'),
    (4,'icon-xietongzhihuidaping','#3fcbb7','车站大屏'),
    (5,'icon-EmergencySOS','#fb7153','紧急支援'),
    (6,'iconfont icon-34qizhi','#3fcbb7','微领队'),
    (7,'icon-quanbudingdan','#62a1f1','出行订单'),
    (8,'icon-weibiaoti556','#ff8431','翻译'),
    (9,'icon-xiaoxitongzhifill','#fb7153','疫情公告'),
    (10,'icon-menpiao','#fb7153','领卷中心'),
    (11,'icon-duihuanqingkuang','#3fcbb7','权益兑换'),
    (12,'icon-ziliaochayue-01','#62a1f1','车站查询'),
    (13,'icon-shafa','#62a1f1','火车贵宾厅'),
    (14,'icon-zhuanxiangdijia','#fb7153','低价机票'),
    (15,'icon-xueshengtejia','#62a1f1','学生认证'),
    (16,'icon-diqiu','#62a1f1','飞行足迹'),
    (17,'icon-hesuanjiance','#3fcbb7','核酸检测'),
    (18,'icon-guibinting','#62a1f1','值机选座'),
    (19,'icon-baoxian','#3fcbb7','旅行保险'),
    (20,'icon-gonglve','#3fcbb7','飞行贴士'),
    (21,'icon-jipiao1','#62a1f1','国内机票'),
    (22,'icon-guojijipiao','#fb7153','国际/地区机票'),
    (23,'icon-jiudian','#fb7153','国内酒店'),
    (24,'icon-kezhangongyu','#fb7153','民宿'),
    (25,'icon-huochepiao','#3fcbb7','国内火车票'),
    (26,'icon-qiugoutejiajipiao','#3fcbb7','门票/一日游'),
    (27,'icon-huiyuanzhongxin','#ff8431','会员中心'),
    (28,'icon-jinrong-','#ff8431','金融');

drop table if exists hot_consultation;
create table hot_consultation(
	id int,
    title varchar(50),
    children json
);
insert into hot_consultation values
	(1,'国内机票','[{"span":"查看乘客信息"},{"span":"我要改签"},{"span":"我要退票"},{"span":"查询退款进度"},{"span":"酒店问题"},{"span":"申请航变全退"}]'),
    (2,'酒店','[{"span":"查看支付信息"},{"span":"我要修改订单"},{"span":"我要取消订单"},{"span":"我要开发票"},{"span":"前台客房服务"},{"span":"如何查询点评"}]'),
    (3,'火车票','[{"span":"怎么查询历史订单"},{"span":"为什么查询不到车次"},{"span":"退票如何退款"},{"span":"车站联系方式"},{"span":"退票手续费如何收取"},{"span":"防疫指南"}]'),
    (4,'跟团游','[{"span":"疫情期间各地出行政策查询"},{"span":"乘机防疫指南"},{"span":"因疫情取消会有损失吗"},{"span":"景点门票咨询"},{"span":"出境游可以去吗"},{"span":"签证产品咨询"}]');










                    
                    
                    