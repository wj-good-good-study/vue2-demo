<!-- 我的 -->
<template>
    <div class='my' style="overflow:hidden;" ref="my">
        <div class="top" ref="top">
            <div class="topNav" ref="topNav" v-show="showNav">
                <ul>
                    <router-link :to="t.path" tag="li" v-for="t in topList1" :key="t.id">
                        <i :class="t.icon" style="font-size:30px;"></i>
                    </router-link>
                </ul>
            </div>
            <div class="topNav2" ref="topNav2" v-show="!showNav">
                <div class="topel">
                    <el-tabs v-model="activeName" @tab-click="handleClick">
                        <el-tab-pane label="我的携程" name="myxiecheng"></el-tab-pane>
                        <el-tab-pane label="个人主页" name="myself"></el-tab-pane>
                    </el-tabs>
                </div>
                <div class="returntop" @click="returntop">
                    <i class="iconfont icon-huidaodingbu"></i>
                    <span>回到顶部</span>
                </div>
            </div>
            <div class="user">
                <Userdiv></Userdiv>
            </div>
        </div>
        <div class="content">
            <div class="eltab">
                <el-tabs v-model="activeName" @tab-click="handleClick">
                    <el-tab-pane label="我的携程" name="myxiecheng">
                        <div class="mylabel">
                            <ul class="mylabel_ul1">
                                <li class="mylabel_li1" v-for="t in tabList1" :key="t.id"
                                    :style="{backgroundColor:t.bgc,color:t.color}" @click="gotoOrders">
                                    <i :class="t.icon" style="font-size: 35px;"></i>
                                    <p style="font-size: 14px;color:black;">{{t.name}}</p>
                                </li>
                            </ul>
                        </div>
                        <div class="mylabel">
                            <ul class="mylabel_ul1">
                                <router-link class="mylabel_li1" to="/Home" tag="li" v-for="(n,index) in numberList"
                                    :key="index">
                                    <h3>{{n.number}}</h3>
                                    <p style="font-size: 14px;">{{n.text}}</p>
                                </router-link>
                            </ul>
                        </div>
                        <div class="mylabel" style="display:flex;justify-content: center;align-items: center;" v-for="(v,index) in vip" :key="index">
                            <div class="left" >
                                <router-link tag="div" to="" class="left_top" :style="{backgroundColor:v.bgc}">
                                    <i :class="v.icon" :style="{color:v.color}"></i>
                                    <span style="font-weight:600;">{{v.title}}</span>
                                </router-link>
                                <div class="left_buttom">
                                    <router-link tag="div" to="">
                                        <div style="font-size: 13px;text-align:center;color:#c8baa3;margin-top: 7px;">
                                            {{v.text}}</div>
                                    </router-link>
                                </div>
                            </div>
                            <div class="myswiper">
                                <el-carousel direction="vertical" :autoplay="true" style="height: 80%;width: 90%;">
                                    <el-carousel-item v-for="(s,index) in swiperList" :key="index">
                                        <h4 style="font-size:16px;">{{s.title}}</h4>
                                        <p style="font-size:12px;color: #9a9a9a;">{{s.text}}</p>
                                    </el-carousel-item>
                                </el-carousel>
                            </div>
                            <div class="travel" :style="{color:v.travelColor,backgroundColor:v.travelBgc}">
                                <i :class="v.travelIcon" style="font-size: 40px;"></i>
                                <h6 >{{v.travelText}}</h6>
                            </div>
                        </div>
                        <div class="mylabel" style="height:100px;">
                            <div class="wallet_top">
                                <div style="display:inline-flex;">
                                    <h4>钱包</h4>
                                    <p style="font-size:13px;margin-left: 5px;">礼品卡·现金></p>
                                </div>
                                <span>
                                    去实名
                                </span>
                            </div>
                            <ul class="wallet_bottom">
                                <router-link to="/Home" tag="li" v-for="(w,index) in walletList" :key="index">
                                    <span style="font-size:20px;font-weight:700;">{{w.top}}<span
                                            style="font-size:13px;font-weight:normal;">{{w.unit}}</span></span>
                                    <p style="font-size:14px;">{{w.center}}</p>
                                    <span style="font-size:10px;color:#9A9A9A;">{{w.bottom}}</span>
                                </router-link>
                            </ul>
                        </div>
                        <div class="mylabel" style="height:170px;">
                            <div class="tool_top">
                                <div style="display:inline-flex;">
                                    <h4>我的工具</h4>
                                </div>
                                <span style="font-size:12px">
                                    全部工具>
                                </span>
                            </div>
                            <div class="tool_bottom">
                                <ul class="tool_bottom_ul">
                                    <router-link class="tool_bottom_li" v-for="(t,index) in toolList" :key="index"
                                        :style="{color:t.iconColor}" tag="li" to="/Home">
                                        <i :class="t.icon" style="font-size: 30px;"></i>
                                        <span>{{t.text}}</span>
                                    </router-link>
                                </ul>
                            </div>
                        </div>
                        <div class="mycard">
                            我的卡片
                        </div>
                        <div class="mycards">
                            <div class="mycards_card">
                                <Card :cardList="vipcenterList">
                                    <div class="img">
                                        <img :src="vipcenterList.pic" alt="">
                                    </div>
                                    <div class="vipcentertext">
                                        <h4>{{vipcenterList.bigtext}}</h4>
                                        <p style="font-size: 10px;color: #808183;">{{vipcenterList.smalltext}}</p>
                                    </div>
                                </Card>
                            </div>
                            <div class="mycards_card">
                                <Card :cardList="hotList">
                                    <ul class="hotdiv">
                                        <router-link to="/Home" tag="li" v-for="(h,index) in hotList.children"
                                            :key="index" class="hotdiv_li">
                                            <i :class="h.icon" :style="{color:h.iconColor,fontSize:'40px'}"></i>
                                            <p style="font-size:13px;">{{h.text}}</p>
                                        </router-link>
                                    </ul>
                                </Card>
                            </div>
                            <div class="mycards_card">
                                <Card :cardList="moneyList">
                                    <div class="img">
                                        <img :src="moneyList.pic" alt="">
                                    </div>
                                    <div class="moneytext">
                                        <h4>{{moneyList.bigtext}}</h4>
                                        <p style=" font-size: 10px;color: #808183;">{{moneyList.smalltext}}</p>
                                    </div>
                                </Card>
                            </div>
                            <div class="mycards_card">
                                <Card :cardList="creditList">
                                    <router-link to="/Home" tag="div" class="creditdiv">
                                        <p>{{creditList.line1}}</p>
                                        <p style="color:#eb722c;font-size:20px;font-weight: 900;">
                                            {{creditList.line2}}
                                        </p>
                                        <p>{{creditList.line3}}</p>
                                        <p>{{creditList.line4}}</p>
                                    </router-link>
                                    <router-link to="/Home" tag="div" class="credittext">
                                        查看详情
                                    </router-link>
                                </Card>
                            </div>
                            <div class="mycards_card">
                                <Card :cardList="financeList">
                                    <ul class="finacediv">
                                        <router-link to="/Home" tag="li" v-for="(f,index) in financeList.lines"
                                            :key="index">
                                            <p style="font-size:14px;font-weight: 500;">{{f.line1}}</p>
                                            <p style="font-size:12px;color: #808183;">{{f.line2}}</p>
                                        </router-link>
                                    </ul>
                                    <router-link to="/Home" tag="div" class="finacetext">
                                        <p>{{financeList.line3}}</p>
                                    </router-link>
                                </Card>
                            </div>
                            <div class="mycards_card" style="display:flex;justify-content:center;">
                                <ul class="otherul">
                                    <router-link to="/Home" tag="li" v-for="o in otherCard" :key="o.id"
                                        class="otherli">
                                        <i :class="o.icon" :style="{color:o.color,fontSize:'30px'}"></i>
                                        <div>
                                            <h4>{{o.line1}}</h4>
                                            <p style="color:#808183;font-size:12px;">{{o.line2}}</p>
                                        </div>
                                    </router-link>
                                </ul>
                            </div>
                        </div>
                    </el-tab-pane>
                    <el-tab-pane label="个人主页" name="myself">
                        <div style="width:100%;height:100vh;">
                            <van-empty image="search" description="空空如也" />
                        </div>
                    </el-tab-pane>
                </el-tabs>
            </div>
        </div>
        <BottomNav></BottomNav>
    </div>
</template>

<script>
    const BottomNav=()=>import('@/components/mycomponents/BottomNav')
    const Userdiv=()=>import('@/components/myProject/My/userdiv')
    const Card=()=>import('@/components/myProject/My/card')
    import Vue from 'vue'
    import { Swipe, SwipeItem ,Empty} from 'vant';
    Vue.use(Swipe);
    Vue.use(Empty);
    Vue.use(SwipeItem);
    export default {
        components: { BottomNav, Userdiv, Card },
        data() {
            return {
                // user: { userHead: require('@/assets/img/head_img/h3.jpg'), name: '尊敬的携程用户', vipIcon: 'iconfont icon-kaitonghuiyuanyuan', vip: '普通会员', community: '社区 lv.1', text: '简单自我介绍，让你更受欢迎', textIcon: 'iconfont icon-youliaobiji', four: [{ name: '粉丝', count: 0 }, { name: '关注', count: 0 }, { name: '获赞', count: 0 }, { name: '赞过', count: 0 }] },
                activeName: 'myxiecheng',
                showNav: true,
                vip: [] /* icon: 'iconfont icon-kaitonghuiyuanyuan', color: '#64b2f7', title: '普通会员', bgc: '#f7e8d3', text: '查看会员权益 >' */ ,
                travel: { icon: 'iconfont icon-maozi-', text: '超值旅行家' },
                topList1: [
                    // { id: 0, icon: 'iconfont icon-qiandao' },
                    // { id: 1, icon: 'iconfont icon-zixun' },
                    // { id: 2, icon: 'iconfont icon-31shezhi' },
                    // { id: 3, icon: 'iconfont icon-caidan2' },
                ],
                tabList1: [
                    // { name: '全部订单', bgc: '#ffffff', icon: 'iconfont icon-quanbudingdan', color: '#6db2ed' },
                    // { name: '待付款', bgc: '#ffffff', icon: 'iconfont icon-daifukuan', color: '#f2b373' },
                    // { name: '未出行', bgc: '#ffffff', icon: 'iconfont icon-dingdan-daichuhang', color: '#6bc1f1' },
                    // { name: '待点评', bgc: '#ffffff', icon: 'iconfont icon-dianping', color: '#e7794d' },
                ],
                numberList: [
                    // { text: '我的收藏', number: 90 },
                    // { text: '浏览历史', number: 299 },
                    // { text: '积分', number: 2999 },
                    // { text: '优惠券', number: 19999 },
                ],
                swiperList: [
                    // { title: '携程1028周年庆', text: '领1028积分&100元酒店红包>' },
                    // { title: '比斯特会籍直通', text: '直升奕友会籍享会员礼' },
                    // { title: '添加携程福利管', text: '最高享￥688优惠券' },
                ],
                walletList: [
                    // { top: '1.08', unit: '万', center: '财富赚钱', bottom: '新人体验金' },
                    // { top: '1026', unit: '券', center: '拿去花', bottom: '先享后付' },
                    // { top: '20', unit: '万', center: '信用贷', bottom: '最高可借' },
                    // { top: '50', unit: '万', center: '白金卡', bottom: '最高额度' },
                ],
                toolList: [
                    // { icon: 'iconfont icon-shenfenzheng', iconColor: '#7a7a7a', text: '常用信息' },
                    // { icon: 'iconfont icon-liwulipinjiangpin-xianxing', iconColor: '#7a7a7a', text: '我的奖品' },
                    // { icon: 'iconfont icon-wodebaoxiao', iconColor: '#7a7a7a', text: '报销凭证' },
                    // { icon: 'iconfont icon-huanqiushangou', iconColor: '#7a7a7a', text: '旅行足迹' },
                    // { icon: 'iconfont icon-dingyue', iconColor: '#7a7a7a', text: '订阅管理' },
                    // { icon: 'iconfont icon-a-ziyuan81', iconColor: '#7a7a7a', text: '我的信用' },
                    // { icon: 'iconfont icon-qingdan', iconColor: '#7a7a7a', text: '出行清单' },
                    // { icon: 'iconfont icon-qiyeweixin', iconColor: '#7a7a7a', text: '企业微信' },
                ],
                vipcenterList:
                    { icon: 'iconfont icon-kaitonghuiyuanyuan', iconColor: '#eea766', text: '会员中心', pic: require('@/assets/img/my_img/vippic1.png'), bigtext: '大牌餐厅78元起', smalltext: '携程会员抢先订' }
                ,
                hotList:
                {
                    icon: 'iconfont icon-caidan2', iconColor: '#e36760', text: '热门推荐',
                    children: [
                        { icon: 'iconfont icon-xin-lihe', iconColor: '#7191fe', text: '领福利' },
                        { icon: 'iconfont icon-qipai', iconColor: '#e68586', text: '打牌赚话费' },
                        { icon: 'iconfont icon-xueshengtejia', iconColor: '#a66edf', text: '学生权益' },
                        { icon: 'iconfont icon-caidan', iconColor: '#66dbe0', text: '更多' },
                    ]
                }
                ,
                moneyList:
                    { icon: 'iconfont icon-hongbao', iconColor: '#ee495f', text: '现金红包', pic: require('@/assets/img/my_img/moneypic1.png'), bigtext: '看笔记，领现金', smalltext: '可提现至银行卡' }
                ,
                creditList:
                    { icon: 'iconfont icon-xinyongqia', iconColor: '#f0aa63', text: '联名信用卡', line1: '最高额度', line2: '￥20万', line3: '免年费', line4: '享大额订单立减金' }
                ,
                financeList:
                    { icon: 'iconfont icon-jinrongxingye', iconColor: '#efa566', text: '金融服务', lines: [{ line1: '最高可领20万消费信用额度', line2: '200,000.00' }, { line1: '免年费白金信用卡', line2: '最高20万额度/享机酒立减' }], line3: '查看详情' }
                ,
                otherCard: [
                    // { icon: 'iconfont icon-remai', iconColor: '#e56d5b', line1: '特卖直播', line2: '特价好货直播中' },
                    // { icon: 'iconfont icon-icon-test4', iconColor: '#3c9dfe', line1: '旅行路线', line2: '创建自己的行程' },
                    // { icon: 'iconfont icon-lvhangshe', iconColor: '#ed934a', line1: '旅行足迹', line2: '查看你的旅行成就' },
                    // { icon: 'iconfont icon-zhaoxiangji', iconColor: '#5eb7f8', line1: '创作激励计划', line2: '参与可享创作激励' }
                ]
            }
        },
        methods: {
            gettopnav1(){
                this.$axios.get('/my/gettopnav1').then(topnav1=>{
                    this.topList1=topnav1.data;
                }).catch(err => {
                    console.log("获取topnav1数据失败")
                })
            },
            gettabList1(){
                this.$axios.get('/my/gettabList1').then(tab1=>{
                    this.tabList1=tab1.data;
                }).catch(err => {
                    console.log("获取tabList1数据失败")
                })
            },
            getnumberList(){
                this.$axios.get('/my/getnumberList').then(number=>{
                    this.numberList=number.data;
                }).catch(err => {
                    console.log("获取numberList数据失败")
                })
            },
            getvipList(){
                this.$axios.get('/my/getvipList').then(vip=>{
                    this.vip=vip.data;
                    console.log('vip',vip.data);
                }).catch(err => {
                    console.log("获取vip数据失败")
                })
            },
            getswiperList(){
                this.$axios.get('/my/getswiperList').then(swipe=>{
                    this.swiperList=swipe.data;
                }).catch(err => {
                    console.log("获取swipe数据失败")
                })
            },
            getwalletList(){
                this.$axios.get('/my/getwalletList').then(wallet=>{
                    this.walletList=wallet.data;
                }).catch(err => {
                    console.log("获取walletList数据失败")
                })
            },
            gettoolList(){
                this.$axios.get('/my/gettoolList').then(tools=>{
                    this.toolList=tools.data;
                }).catch(err => {
                    console.log("获取toolList数据失败")
                })
            },
            getotherCard(){
                this.$axios.get('/my/getotherCard').then(card=>{
                    this.otherCard=card.data;
                }).catch(err => {
                    console.log("获取otherCard数据失败")
                })
            },
            gotoOrders(){
                if(this.$store.state.hostObj.host.length===0){
                    this.$router.push('/Login');
                }else{
                    this.$router.push({path:'/Orders'})
                }
            },
            handleClick(tab, event) {
                this.activeName = tab.name;
            },
            scrolltodo() {
                const topNavheight = this.$refs.topNav.offsetHeight;
                const top = this.$refs.top.offsetHeight;
                document.addEventListener('scroll', () => {
                    if (this.$refs.my) {
                        if (window.pageYOffset > 1 && window.pageYOffset < top - topNavheight) {
                            this.showNav = true;
                            this.$refs.topNav.style.background = 'white';
                        }
                        if (window.pageYOffset >= top - topNavheight) {
                            this.showNav = false;
                            this.$refs.topNav2.style.position = 'fixed';
                        }
                        if (window.pageYOffset === 0) {
                            this.showNav = true;
                            this.$refs.topNav.style.background = 'none';
                        }
                    }
                })
            },
            returntop() {
                window.scrollTo(0, 0)
            }
        },
        mounted() {
            this.gettopnav1();
            this.gettabList1();
            this.getnumberList();
            this.getvipList();
            this.getswiperList();
            this.getwalletList();
            this.gettoolList();
            this.getotherCard();
            this.scrolltodo();
        },
        deactivated() {
            this.$destroy();
        },
    }
</script>

<style >
    .top {
        position: absolute;
        width: 100%;
        height: auto;
        background: inherit;
        background-image: radial-gradient(#eff4fa, #d4e4f3, #deeaf6);
    }

    .topNav {
        width: 100%;
        height: 35px;
        margin-bottom: 20px;
        position: fixed;
        z-index: 1000;
    }

    .topNav ul {
        float: right;
        margin-right: 4%;
    }

    .topNav li {
        display: inline-block;
        margin: 5px;
    }

    .topNav2 {
        width: 100%;
        height: 40px;
        /* display: none; */
        z-index: 1000;
        background-color: white;
        overflow: hidden;

    }

    .topel {
        width: 40%;
        height: auto;
        float: left;
    }

    .returntop {
        width: auto;
        height: 30px;
        background-color: #e7f5ff;
        color: #4574cc;
        border-radius: 50px;
        float: right;
        line-height: 30px;
        margin-top: 5px;
    }

    .user {
        width: 92%;
        margin: 0 auto;
    }

    .content {
        position: relative;
        margin-top: 48%;
        width: 100%;
        height: auto;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        background-image: linear-gradient(180deg, #ffffff 2%, #f8f8f8 8%, #ededed);
    }

    .eltab {
        height: auto;
        width: 100%;
        margin: 10px auto;
        padding-bottom: 50px;
    }

    .eltab .el-tabs__nav-scroll {
        width: 155px;
        margin: 0 auto;
    }

    .mylabel {
        overflow: hidden;
        width: 92%;
        height: 70px;
        margin: 0 auto;
        border-radius: 10px;
        background-color: #ffffff;
        margin-bottom: 10px;
    }

    .mylabel_ul1 {
        display: flex;
        width: 92%;
        margin: 0 auto;
    }

    .mylabel_li1 {
        display: flex;
        flex: 20%;
        height: 60px;
        padding: 4px 0;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .left {
        width: 30%;
        height: 100%;
        display: flex;
        flex-direction: column;
    }

    .left_top {
        display: flex;
        line-height: 35px;
        border-bottom-right-radius: 10px;
        justify-content: center;
        align-items: center;
    }

    .left_bottom {
        display: flex;
        justify-content: center;
    }

    .myswiper {
        width: 50%;
        height: 80%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .myswiper p {
        width: 90%;
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
    }

    .myswiper .van-swipe__indicators--vertical {
        display: none;
    }

    .travel {
        display: flex;
        height: 100%;
        width: 20%;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .wallet_top,
    .tool_top {
        height: auto;
        width: 92%;
        display: flex;
        margin: 0 auto;
        padding-top: 10px;
        line-height: 20px;
        justify-content: space-between;

    }

    .wallet_top span {
        background: #f5f5f5;
        color: #878787;
        font-size: 12px;
        height: 20px;
        border-radius: 10px;
        padding: 1px 4px;
    }

    .wallet_bottom {
        display: flex;
        width: 92%;
        margin: 0 auto;
        height: 75%;
        justify-content: center;
        align-items: center;
    }

    .wallet_bottom li {
        flex: 25%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .tool_bottom {
        height: 80%;
    }

    .tool_bottom_ul {
        margin: 0 auto;
        width: 92%;
        height: auto;
        border-radius: 20px;
        display: flex;
        flex-wrap: wrap;
        overflow: hidden;
    }

    .tool_bottom_li {
        display: flex;
        flex: 25%;
        height: 60px;
        padding: 4px 0;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .mycard {
        width: 92%;
        margin: 0 auto;
        margin-bottom: 10px;
        font-size: 16px;
        font-weight: 600;
    }

    .mycards {
        width: 92%;
        height: auto;
        margin: 0 auto;
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        flex-wrap: wrap;
    }

    .mycards_card {
        width: 48%;
        height: auto;
        margin-bottom: 10px;
        background-color: white;
        border-radius: 10px;
    }

    .img {
        display: flex;
        width: 85%;
        height: 65%;
        border-radius: 10px;
        overflow: hidden;
        justify-content: center;
        margin: 0 auto;
    }

    .img img {
        background-image: 100%;
    }

    .moneytext,
    .vipcentertext {
        width: 85%;
        height: auto;
        margin: 0 auto;
        text-align: left;
    }

    .hotdiv {
        width: 100%;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-wrap: wrap;
    }

    .hotdiv_li {
        display: flex;
        flex: 40%;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .creditdiv {
        width: 92%;
        height: 70%;
        margin: 0 auto;
        border-radius: 10px;
        background-color: #f7f8fa;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }

    .creditdiv p {
        margin-top: 3px;
        color: #808183;
        font-size: 12px;
    }

    .credittext,
    .finacetext {
        margin-top: 5%;
        text-align: center;
        color: #5e92d7;
    }

    .finacediv {
        border-bottom: 1px solid #f7f7f7;
        width: 92%;
        margin: 0 auto;
        height: 70%;
    }

    .finacediv p {
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
    }

    .otherul {
        width: 92%;
        height: auto;
        margin: 10px auto 0 auto;
        display: flex;
        justify-content: left;
        flex-direction: column;
    }

    .otherli {
        display: flex;
        flex: 25%;
    }
</style>