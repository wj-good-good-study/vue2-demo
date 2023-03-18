<!-- 景点门票 -->
<template>
    <div>
        <div class="landmark">
            <div class="lhead">
                <div class="ltitle">
                    <div class="ltitle_left" @click="back">
                        ⬅
                    </div>
                    <div class="ltitle_center">
                        <h6>{{title}}</h6>
                    </div>
                    <div class="ltitle_right">
                        <i class="iconfont icon-gouwuchekong" style="font-size:25px;" @click="shopcar"></i>
                    </div>
                </div>
                <div class="linput" v-for="(i,index) in inputdata" :key="index">
                    <div class="linput_left">
                        <span>
                            {{i.address}}
                            <i :class="'iconfont '+i.downicon"></i>
                        </span>
                    </div>
                    <div class="linput_center">
                        <i :class="'iconfont '+i.research" style="font-size: 18px;color:#999999;"></i>
                    </div>
                    <div class="linput_right">
                        <div class="myswiper">
                            <el-carousel direction="vertical" :autoplay="true"
                                style="height: 25px;width: 90%;display: block;">
                                <el-carousel-item v-for="t in inputdata[0].children" :key="t.id">
                                    <p style="font-size:14px;color: #999999">{{t.text}}</p>
                                </el-carousel-item>
                            </el-carousel>
                        </div>
                    </div>
                </div>
            </div>
            <div class="lbody">
                <div class="classify">
                    <router-link class="classifydiv" v-for="(c,index) in classifyList" :key="index" tag="div"
                        to="/Home">
                        <img :src="require('@/assets/img/landmark_img/'+c.img+'')">
                        <h3 style="font-size:16px;">{{c.text}}</h3>
                    </router-link>
                </div>
                <div class="tabs">
                    <van-tabs v-model="activeName" @click="getcontent" animated class="vanttabs">
                        <van-tab v-for="(c,index) in categories" :title="c.categoryname" :name="c.categotyname">
                            <ul>
                                <router-link class="tabsdiv" v-for="con in contentList" :key="con.id" tag="li"
                                :to="{path:'/Tickets_detail',query:{id:con.contentid}}">
                                    <div class="tabdiv">
                                        <img :src="require('@/assets/img/landmark_img/'+con.img+'')">
                                        <h3>{{con.contentname}}</h3>
                                        <div class="tab_bottom">
                                            <div class="bottom_left">
                                                ￥<span style="font-size:17px;">{{con.price}}</span>
                                                <span style="color:#666666;">起</span>
                                            </div>
                                            <div class="bottom_right">
                                                {{con.grade}}分
                                            </div>
                                        </div>
                                    </div>
                                </router-link>
                            </ul>
                        </van-tab>
                    </van-tabs>
                    <div class="tabs_more">
                        <router-link to="/Home" tag="a" style="color:#0086f6">
                            查看更多 ＞
                        </router-link>
                    </div>
                </div>
                <div class="gray"></div>
                <div class="recommend">
                    <h1>精彩推荐</h1>
                    <div class="recommend_bigdiv">
                        <router-link class="recommend_smalldiv" v-for="r in recommendList" :key="r.contentid" :to="{path:'/Tickets_detail',query:{id:r.contentid}}" tag="div">
                            <div class="small_imgdiv">
                                <img :src="require('@/assets/img/landmark_img/'+r.img+'')"
                                    style="width:100%;background-size:100%;">
                            </div>
                            <div class="small_content">
                                <h3>{{r.contentname}}</h3>
                                <div class="redspan">{{r.redspan}}</div>
                                <div class="point">
                                    <span style="font-size: 16px;font-weight:800">{{r.grade}}</span>分
                                    <span style="color:#8e8e8e;">{{r.discusscount}}条评论</span>
                                </div>
                                <div class="content_pricediv">
                                    ￥<span style="font-size: 18px;font-weight:800">{{r.price}}</span><span style="color:#8e8e8e;">起</span>
                                </div>
                            </div>
                        </router-link>
                    </div>
                </div>
            </div>

        </div>
    </div>
</template>

<script scoped>
    import Vue from 'vue';
    import { Tab, Tabs } from 'vant';
    Vue.use(Tab);
    Vue.use(Tabs);
    let title;
    let categoryid;
    export default {
        data() {
            return {
                title: title,
                activeName: 'AA',
                inputdata: [{
                    address: '杭州', downicon: 'icon-xiajiantou', research: 'icon-sousuo', children: [
                        { id: 0, text: '上海海昌 0元起' },
                        { id: 1, text: '来浙江 探寻秋天的秘密' },
                        { id: 2, text: '来浙理 吃粑粑' },
                        { id: 3, text: '高榜烯 傻逼' },
                    ]
                }],
                classifyList: [],
                categories: [],
                contentList: [],
                recommendList: [],
            }
        },
        methods: {
            back() {
                this.$router.go(-1);
            },
            shopcar() {
                if(this.$store.state.hostObj.host.username){
                    this.$router.push('/Shopcar');
                }else{
                    this.$router.psh('/Login');
                }
            },
            getclassifyList() {
                this.$axios.get('landmark/getclassify').then((result) => {
                    this.classifyList = result.data;
                }).catch((err) => {
                    console.log("获取分类信息错误" + err)
                })
            },
            getcategories() {
                this.$axios.get('landmark/getcategories').then((result) => {
                    this.categories = result.data;
                }).catch((err) => {
                    console.log("获取categories信息错误" + err)
                })
            },
            getcontent(name, title) {
                if (name == 0) {
                    categoryid = 'A';
                } else if (name == 1) {
                    categoryid = 'B'
                } else if (name == 2) {
                    categoryid = 'C'
                } else if (name == 3) {
                    categoryid = 'D'
                } else if (name == 4) {
                    categoryid = 'E'
                } else if (name == 5) {
                    categoryid = 'F'
                } else if (name == 6) {
                    categoryid = 'G'
                }
                this.$axios.get('landmark/getcontent', {
                    params: {
                        categoryid: categoryid,
                    }
                }).then((result) => {
                    this.contentList = result.data;
                }).catch(err => {
                    console.log("获取contentList数据失败" + err);
                })
            },
            getrecommend() {
                this.$axios.get('landmark/getrecommend').then((result) => {
                    this.recommendList = result.data;
                }).catch(err => {
                    console.log("获取recommendList数据失败" + err);
                })
            }
        },
        beforeCreate() {
            title = this.$route.query.title;
        },
        mounted() {
            this.getclassifyList();
            this.getcategories();
            this.getcontent();
            this.getrecommend();
        },
        deactivated() {
            this.$destroy();
        },

    }
</script>

<style>
    .landmark {
        width: 100%;
        height: auto;
        background-color: white;
        margin: 0;
        padding: 0;
    }

    .lhead {
        width: 100%;
        height: auto;
        position: fixed;
        top: 0;
        background-color: white;
        padding-bottom: 5px;
        z-index: 1000;
    }

    .ltitle {
        width: 100%;
        height: 30px;
        /* background-image: linear-gradient(90deg, #20514e, #0f3562); */
        margin-bottom: 10px;
        background-color: white;
        display: flex;
        justify-content: space-between;
        font-size: 30px;
        color: black;

    }

    .ltitle_left,
    .ltitle_right {
        flex: 1;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .ltitle_center {
        display: flex;
        flex: 8;
        justify-content: center;
        align-items: center;
    }

    .linput {
        width: 92%;
        height: 30px;
        border-radius: 15px;
        background-color: #f2f3f7;
        margin: 0 auto;
        overflow: hidden;
        display: flex;
        justify-content: flex-start;
    }

    .linput div {
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .linput_left {
        width: 15%;
    }

    .linput_center {
        width: 10%;
    }

    .linput_right {
        width: 75%;
    }

    .vanttabs .van-tabs__line {
        display: none !important;
    }

    .van-tabs__nav--line.van-tabs__nav--complete{
        padding: 0 !important;
    }

    .myswiper {
        width: 100%;
        height: 100%;
    }

    .myswiper p {
        width: 100%;
        height: 100%;
        line-height: 25px;
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
    }

    .van-tab--active {
        font-weight: 900;
    }

    .lbody {
        width: 92%;
        height: auto;
        margin: 0 auto;
    }

    .classify {
        width: 100%;
        height: 100px;
        margin-top: 80px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .classifydiv {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .tabs {
        width: 100%;
        height: auto;
    }

    .tabs ul {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        flex-wrap: wrap;
    }

    .tabsdiv {
        width: 32.8%;
        height: auto;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .tabdiv {
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    .tabdiv img {
        width: 120px;
        height: 120px;
        background-size: 100%;
    }

    .tabdiv h3 {
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
    }

    .tab_bottom {
        width: 120px;
        display: flex;
        justify-content: space-between;
    }

    .bottom_left {
        display: flex;
        color: red;
        font-size: 12px;
    }

    .bottom_right {
        display: flex;
        font-size: 13px;
        color: #0086f6;
    }

    .tabs_more {
        text-align: center;
        margin-top: 5px;
        padding-top: 10px;
        padding-bottom: 10px;
    }

    .gray {
        background-color: #f4f4f4;
        width: 100%;
        height: 15px;
    }

    .recommend {
        width: 100%;
        height: auto;
    }

    .recommend_bigdiv {
        width: 100%;
        height: auto;
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
    }

    .recommend_smalldiv {
        width: 48%;
        height: auto;
        margin-top: 10px;
        padding-bottom: 4px;
    }

    .small_imgdiv {
        width: 100%;
        height: auto;
        border-radius: 15px;
        overflow: hidden;
    }

    .small_content{
        width: 92%;
        margin: 0 auto;
        margin-top: 5px;
        height: auto;
    }

    .redspan{
        width: auto;
        display: inline-block;
        font-size: 12px;
        background-color: #fb8550;
        padding-left: 2px;
        padding-right: 2px;
        margin-top: 2px;
        margin-bottom: 2px;
        color: white;
        border-radius: 2px;
    }

    .point{
        font-size: 13px;
        color: #0086f6;
    }

    .content_pricediv{
        width: 100%;
        color: red;
        font-size: 13px;
    }
</style>