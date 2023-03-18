<!-- 客户服务 -->
<template>
    <div>
        <div class="service_head">
            <div class="service_head_top">
                <div class="service_left" @click="back">
                    ⬅
                </div>
                <div class="service_center">
                    <h6>客服中心</h6>
                </div>
                <div class="service_right">
                </div>
            </div>
        </div>
        <div class="service_body">
            <div class="body_hellow">
                <img :src="serveice_img" class="hellow_img">
                <div class="hellow">
                    <h3>亲爱的会员，您好</h3>
                    <p style="font-size: 12px;color: #ffffffda;">携程客服随时为您服务 ＞</p>
                </div>
            </div>
            <div class="body_div1">
                <div class="findOrder_div">
                    <div style="margin:0px 20px;">
                        <img src="https://img01.yzcdn.cn/vant/empty-image-default.png">
                    </div>
                    <div class="findorder_text">
                        <p>暂无可查询订单，您可以点击</p>
                        <span style="color:#4c7add;" @click="gotoOrders">查看全部订单</span>
                    </div>
                </div>
                <div class="recommend_service">
                    <h3 style="font-size: 18px;">推荐服务</h3>
                    <van-swipe class="my-swipe" indicator-color="#3685f1" touchable>
                        <van-swipe-item>
                            <ul class="van_ul">
                                <router-link to="" tag="li" class="van_li"
                                    v-for="r in recommend_serviceList.slice(0,10)">
                                    <i :class="'iconfont '+r.icon" :style="{color:r.icon_color,fontSize:'40px'}"></i>
                                    <span style="font-size: 12px;margin-top: 5px;">{{r.text}}</span>
                                </router-link>
                            </ul>
                        </van-swipe-item>
                        <van-swipe-item>
                            <ul class="van_ul">
                                <router-link to="" tag="li" class="van_li"
                                    v-for="r in recommend_serviceList.slice(10,20)">
                                    <i :class="'iconfont '+r.icon" :style="{color:r.icon_color,fontSize:'40px'}"></i>
                                    <p style="font-size: 12px;margin-top: 5px;">{{r.text}}</p>
                                </router-link>
                            </ul>
                        </van-swipe-item>
                    </van-swipe>
                </div>
            </div>
            <div class="body_div2">
                <div class="hot_consultation">
                    <h3 style="font-size: 18px;">热门咨询</h3>
                    <div class="consultation_tab">
                        <div class="consultation_title" v-for="c in consultationList" :key="c.id" @click="click(c)">
                            <span :class="isActive===c.id?'click':'unclick'">{{c.title}}</span>
                            <div :class="isActive===c.id?'blue_line':'white_line'"></div>
                        </div>
                    </div>
                    <div class="consultation_text_div">
                        <div class="consultation_text" v-for="(child,index) in childrenList" :key="index">
                            {{child.span}}
                        </div>
                    </div>
                    <ul class="consultation_ul">
                        <router-link to="" tag="li" class="consultation_li"
                            v-for="r in recommend_serviceList.slice(20,28)">
                            <i :class="'iconfont '+r.icon" :style="{color:r.icon_color,fontSize:'40px'}"></i>
                            <span style="font-size: 12px;margin-top: 5px;">{{r.text}}</span>
                        </router-link>
                    </ul>
                </div>
            </div>
        </div>
        <div class="service_bottom">
            <div class="bottom_div">
                <div :class="index===bottomList.length-1?'bottom_last_button':'bottom_button'"
                    v-for="(b,index) in bottomList" :key="index">
                    <i :class="b.icon" style="font-size: 28px;"></i>
                    <span style="margin-left: 10px;">{{b.text}}</span>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import Vue from 'vue';
    import { Empty } from 'vant';
    import { Swipe, SwipeItem } from 'vant';
    Vue.use(Swipe);
    Vue.use(SwipeItem);
    Vue.use(Empty);
    export default {
        data() {
            return {
                serveice_img: require('@/assets/img/my_img/service.jpg'),
                recommend_serviceList: [],
                consultationList: [],
                isActive: 1,
                childrenList: [],
                bottomList: [
                    { icon: 'iconfont icon-zixun', text: '在线咨询' },
                    { icon: 'iconfont icon-24gl-phoneLoudspeaker', text: '电话咨询' },
                ]
            }
        },
        methods: {
            back() {
                this.$router.go(-1);
            },
            getrecommmend() {
                this.$axios.get('my/getrecommmend').then(res => {
                    this.recommend_serviceList = res.data;
                }).catch(err => {
                    console.log('获取推荐服务列表失败:' + err)
                })
            },
            getconsultation() {
                this.$axios.get('my/getconsultation').then(res => {
                    res.data.forEach(data => {
                        data.children = JSON.parse(data.children)
                    });
                    this.consultationList = res.data;
                }).catch(err => {
                    console.log('获取推荐服务列表失败:' + err)
                })
            },
            click(data) {
                this.isActive = data.id;
                this.childrenList = data.children;
            },
            gotoOrders() {
                if (this.$store.state.hostObj.host.length === 0) {
                    this.$router.push('/Login');
                } else {
                    this.$router.push({ path: '/Orders' })
                }
            }

        },
        watch: {
            consultationList(newData, oldData) {
                this.childrenList = newData[0].children;
            }
        },
        mounted() {
            this.getrecommmend();
            this.getconsultation();
        },
        deactivated() {
            this.$destroy();
        },
    }
</script>

<style scoped>
    .service_head {
        width: 100%;
        height: auto;
        position: fixed;
        position: relative;
        top: 0;
        z-index: 1000;
        font-size: 30px;
        color: #fff;
        background-color: #3997fb;
    }

    .service_head_top {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .service_right {
        width: 30px;
    }

    .service_body {
        width: 100%;
        height: 100%;
        background-color: #3997fb;

    }

    .body_hellow {
        width: 92%;
        margin: 0 auto;
        display: flex;
        justify-content: flex-start;
        align-items: center;
    }

    .hellow_img {
        width: 30%;
        background-image: 100%;
    }

    .hellow {
        width: auto;
        height: 100%;
        margin-left: 10%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: flex-start;
        color: #fff;
    }

    .body_div1 {
        width: 100%;
        border-top-right-radius: 10px;
        border-top-left-radius: 10px;
        background-color: #fff;
        padding: 20px 0;
    }

    .findOrder_div {
        width: 92%;
        margin: 0 auto;
        padding: 10px 0;
        display: flex;
        justify-content: flex-start;
        align-items: center;
        border-radius: 15px;
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    }

    .findOrder_div img {
        width: 60px;
        height: 60px;
    }

    .findorder_text {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: flex-start;
        font-size: 16px;
        color: #747474;
    }

    .recommend_service {
        width: 92%;
        margin: 50px auto 0 auto;
    }

    .my-swipe .van-swipe-item {
        color: #000;
        text-align: center;
        padding-bottom: 20px;
    }

    .van_ul {
        display: flex;
        justify-content: space-around;
        flex-wrap: wrap;
        overflow: hidden;
        margin-top: 15px;
    }

    .van_li {
        width: 18%;
        height: auto;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        margin-top: 10px;
    }

    .body_div2 {
        margin-top: 10px;
        background-color: #fff;
        width: 100%;
    }

    .hot_consultation {
        width: 92%;
        margin: 0 auto;
        padding-top: 10px;
    }

    .consultation_tab {
        margin-top: 20px;
        display: flex;
        justify-content: flex-start;
        align-items: center;
    }

    .consultation_title {
        width: 20%;
        text-align: center;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .blue_line {
        width: 30px;
        height: 4px;
        background-color: #4884ea;
        border-radius: 10px;
        margin-top: 5px;
    }

    .white_line {
        width: 30px;
        height: 4px;
        background-color: #fff;
        border-radius: 10px;
        margin-top: 5px;
    }

    .click {
        font-size: 16px;
        font-weight: 900;
    }

    .unclick {
        font-size: 14px;
    }

    .consultation_text_div {
        width: 100%;
        border-bottom: 1px solid #898989;
        margin: 0 auto;
        display: flex;
        flex-wrap: wrap;
        justify-content: flex-start;
        align-items: center;
        padding-bottom: 10px;
    }

    .consultation_text {
        width: 50%;
        text-align: left;
        color: black;
        margin: 10px 0;
    }

    .consultation_ul {
        width: 100%;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        padding-bottom: 60px;
    }

    .consultation_li {
        width: 21%;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }

    .service_bottom {
        position: fixed;
        z-index: 1000;
        bottom: 0px;
        width: 100%;
        height: auto;
        background-color: #fff;
    }

    .bottom_div {
        width: 92%;
        margin: 10px auto;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .bottom_button {
        border-right: 1px solid grey;

    }

    .bottom_last_button,
    .bottom_button {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 48%;
    }
</style>