<!-- 买票详情 -->
<template>
    <div>
        <div class="thead">
            <div class="thead_left" @click="back">
                ⬅
            </div>
            <div class="thead_center" v-for="d in detailList" :key="d.contentid">
                <h5>{{d.contentname}}</h5>
            </div>
            <div class="thead_right">
                <i class="iconfont icon-gouwuchekong" style="font-size:25px;" @click="shopcar"></i>
            </div>
        </div>
        <div class="picjson">
            <div class="swiper mySwiper" style="height:100%;">
                <div class="swiper-wrapper">
                    <div class="swiper-slide" v-for="p in picjson" :key="p.id">
                        <img :src="require('@/assets/img/landmark_img/'+p.img+'')" />
                    </div>
                </div>
            </div>
        </div>
        <div class="tbody_content">
            <div class="tbody_content_body" v-for="d in detailList" :key="d.contentid">
                <div class="content_body_title">
                    <div class="title_left">
                        <h2>{{d.contentname}}</h2>
                        <p style="color:#8e8e8e;">{{d.shortaddress}} ▲ {{d.span}}</p>
                    </div>
                    <div class="title_right">
                        <h2>{{d.hot}}</h2>
                        <div class="right_icon">
                            <i class="iconfont icon-baokuan"></i>
                            <span>热度</span>
                        </div>
                    </div>
                </div>
                <div class="content_body_span">
                    <div class="content_body_span_left">
                        <div class="grade_left">
                            <span style="font-size:20px;font-weight:800;">{{d.grade}}</span>分
                        </div>
                        <span class="left_redspan">"{{d.redspan}}"</span>
                    </div>
                    <div class="content_body_span_right">
                        {{d.discusscount}}条点评＞
                    </div>
                </div>
                <div class="content_body_time">
                    <p style="font-size:18px;">{{d.opentime}}-{{d.closetime}}开放</p>
                    <p style="color:#8e8e8e;">实用攻略＞</p>
                </div>
                <div class="content_body_longaddress">
                    <p class="longaddress">{{d.longaddress}}</p>
                    <div class="longaddress_div">
                        <i class="iconfont icon-dizhi" style="font-size:25px"></i>
                        <p>导航·打车</p>
                    </div>
                </div>
            </div>
            <div class="tbody_buydiv">
                <div class="buydiv_title">
                    <h2>门票</h2>
                    <p style="color: #f27000;">查看门票的使用说明＞</p>
                </div>
                <div class="buydiv_ticketdiv" v-for="(t,index) in tickets.slice(0,i)" :key="index">
                    <div class="tickets_left">
                        <h3>{{t.title}}</h3>
                        <span class="tickets_requirement" v-if="t.requirement">{{t.requirement}}</span>
                        <span style="font-size:12px;color:#ff6600;">
                            <i class="iconfont icon-jiudian" style="font-size:12px;color:#ff6600;"></i>
                            {{t.give}}
                        </span>
                        <div class="tickets_span">
                            <span style="color:#009c67;">{{t.span1}}</span>
                            <span>{{t.span2}}</span>
                            <span>{{t.span3}}</span>
                        </div>
                        <div class="tickets_sold">
                            <div class="guanfang">官方</div>
                            已售{{t.sold|count}}丨购买须知＞
                        </div>
                    </div>
                    <div class="tickets_right">
                        <div class="ticket_price">
                            ￥<span style="font-size:20px;font-weight:800;">{{t.price}}</span>起
                        </div>
                        <div class="ticket_buy" @click="addtickets(t)">抢购</div>
                    </div>
                </div>
                <div class="button" @click="lookmore" ref="lookmore">
                    查看更多门票信息＞
                </div>
            </div>
        </div>
        <div style="height:15px;width:100%;background-color: white;">

        </div>
    </div>
</template>

<script>
    import Swiper from 'swiper';
    import Vue from 'vue';
    import { Toast } from 'vant';

    Vue.use(Toast);
    let contentid;
    export default {
        data() {
            return {
                i: '3',
                detailList: [],
                picjson: [],
                tickets: [],
                ticket: {}
            }
        },
        beforeCreate() {
            contentid = this.$route.query.id;
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
            getrecommend() {
                this.$axios.get('landmark/getrecommend', {
                    params: {
                        id: contentid
                    }
                }).then((result) => {
                    result.data[0].picjson = JSON.parse(result.data[0].picjson)
                    this.detailList = result.data;
                    this.picjson = result.data[0].picjson;
                }).catch(err => {
                    console.log("获取detailList数据失败" + err);
                })
            },
            gettickets() {
                this.$axios.get('landmark/gettickets', {
                    params: {
                        id: contentid
                    }
                }).then((result) => {
                    this.tickets = result.data;
                    if (this.tickets.length <= 3) {
                        this.$refs.lookmore.style.display = 'none';
                    }
                    console.log(this.tickets);
                }).catch(err => {
                    console.log("获取tickets数据失败" + err);
                })
            },
            lookmore() {
                this.i = 100;
                this.$refs.lookmore.style.display = 'none';
            },
            addtickets(value) {
                this.$axios.get('landmark/getrecommend', {
                    params: {
                        id: value.contentid
                    }
                }).then((result) => {
                    console.log('value11',value)
                    this.ticket = { title: result.data[0].contentname, img: result.data[0].img, ticketid: value.ticketid, contentid: value.contentid, price: value.price, num: 1,classify:value.title };
                    this.$store.dispatch('shopcarObj/addtickets', this.ticket);
                }).catch(err => {
                    console.log("获取recommendList数据失败" + err);
                });
                Toast.success({
                    message:'成功加入购物车',
                    duration: 200,
                });

            }
        },
        mounted() {
            this.getrecommend();
            this.$nextTick(function () {
                var swiper = new Swiper(".mySwiper", {
                    autoHeight: true,
                    observer: true,
                    observeParents: true,
                });
            });
            this.gettickets();

        },
        filters: {
            count(value) {
                if (value < 100) {
                    return value;
                } else {
                    let unit = '';
                    var k = 10000,
                        sizes = ['', '万', '亿', '万亿'],
                        i;
                    if (value < k) {
                        value = value;
                    } else {
                        i = Math.floor(Math.log(value) / Math.log(k));
                        value = ((value / Math.pow(k, i))).toFixed(2);
                        unit = sizes[i];
                    }
                    return value + unit;
                }
            }
        },
        deactivated() {
            this.$destroy();
        },

    }
</script>

<style scoped>
    .thead {
        width: 100%;
        height: 50px;
        background-color: white;
        display: flex;
        justify-content: space-between;
        font-size: 30px;
        color: black;
        position: fixed;
        top: 0;
        z-index: 1000;

    }

    .thead_left,
    .thead_right {
        flex: 1;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .thead_center {
        display: flex;
        flex: 8;
        justify-content: center;
        align-items: center;
    }

    .picjson {
        width: 100%;
        height: auto;
        background-color: white;
        margin-top: 50px;
    }

    .swiper-slide {
        max-height: 240px;
        min-height: 200px;
    }

    .picjson .swiper-slide img {
        width: 100%;
        background-size: 100%;
    }

    .tbody_content {
        width: 100%;
        min-height: 100%;
        height: auto;
        background-color: white;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        position: relative;
        top: -15px;
        z-index: 5;
    }

    .tbody_content_body {
        width: 92%;
        height: auto;
        margin: 0 auto;
    }

    .content_body_title,
    .content_body_span,
    .content_body_time,
    .content_body_longaddress {
        width: 100%;
        height: 70px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #eeeeee;
    }

    .title_left {
        display: flex;
        height: 70px;
        flex-direction: column;
        justify-content: space-around;
    }

    .title_right {
        width: 50px;
        height: 50px;
        border-radius: 15px;
        background-color: #ff7664;
        padding: 5px;
        color: white;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .content_body_span {
        height: 40px;
    }

    .content_body_span_left {
        flex: 7;
        display: flex;
        justify-content: flex-start;
        align-items: center;
    }

    .grade_left {
        background-color: #0086f6;
        color: white;
        padding: 1px 4px 1px 4px;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        border-bottom-right-radius: 10px;
    }

    .left_redspan {
        color: #0086f6;
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
    }

    .content_body_span_right {
        flex: 3;
        color: #8e8e8e;
        text-align: right;
    }

    .content_body_time {
        height: 50px;
    }

    .content_body_longaddress {
        height: 70px;
        padding-bottom: 10px;
    }

    .longaddress {
        flex: 8;
        font-size: 18px;
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
    }

    .longaddress_div {
        display: flex;
        flex: 2;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .tbody_buydiv {
        width: 100%;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        height: auto;
        background-color: #f3f8fe;
        position: relative;
        top: -10px;
        padding-bottom: 10px;
    }

    .buydiv_title {
        width: 92%;
        margin: 0 auto;
        height: 60px;
        display: flex;
        flex-direction: column;
        justify-content: space-around;
        align-items: flex-start;
    }

    .buydiv_ticketdiv {
        width: 92%;
        margin: 10px auto;
        height: auto;
        box-shadow: 0px 0px 5px 5px #e9eef4;
        display: flex;
        justify-content: space-between;
        background-color: white;
        padding: 10px;
    }

    .tickets_left {
        margin-right: 10px;
        display: flex;
        flex: 7;
        flex-direction: column;
        justify-content: center;
        font-size: 12px;
    }

    .tickets_left div,
    .tickets_left span,
    .tickets_left h4 {
        margin-top: 2px;
        margin-bottom: 2px;
    }

    .tickets_span {
        display: inline;
        color: #8e8e8e;
    }

    .tickets_requirement {
        font-size: 12px;
        color: #8e8e8e;
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
    }

    .tickets_span span {
        margin: 0px 2px;
    }

    .tickets_sold {
        color: #8e8e8e;
    }

    .guanfang {
        display: inline;
        border-radius: 5px;
        padding: 2px;
        margin-right: 4px;
        background-color: #ffebc3;
        color: #805837;
    }

    .tickets_right {
        display: flex;
        flex: 2;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .ticket_price {
        color: #ff6600;
        font-size: 12px;
    }

    .ticket_buy {
        font-size: 16px;
        font-weight: 800;
        background-color: #ff6600;
        color: white;
        border-radius: 5px;
        padding: 2px 4px;
    }

    .button {
        width: 50%;
        margin: 0 auto;
        height: 30px;
        line-height: 30px;
        text-align: center;
        font-size: 16px;
        border-radius: 10px;
        background-color: white;
        color: #0086f6;
        box-shadow: 0px 0px 5px 5px #e9eef4;
        margin-bottom: 10px;
    }
</style>