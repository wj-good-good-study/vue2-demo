<!-- 查看订单 -->
<template>
    <div>
        <div class="m_head">
            <div class="m_head_top">
                <div class="m_left" @click="back">
                    ⬅
                </div>
                <div class="m_center">
                    <h6>订单详情</h6>
                </div>
                <div class="m_right">
                    ···
                </div>
            </div>

        </div>
        <div class="m_body">
            <div class="m_body_top">
                <h2>{{props_data.flagname}} <span>＞</span></h2>
            </div>
            <div class="m_body_center">
                <div class="body_center">
                    <div class="body_center_order"><span>订单编号</span><span
                            style="color: #9a9a9a;">{{props_data.orderid}}</span></div>
                    <div class="body_center_order"><span>
                            <h3>{{props_data.contentname}}</h3>---{{props_data.ticketname}}
                        </span><span style="font-weight: bold;">￥{{props_data.unitprice}}</span></div>
                    <div style="text-align: right;color:#9a9a9a">× {{props_data.quantity}}</div>
                    <div class="body_center_order"><span>实际支付：</span><span
                            style="font-size: 16px;color: #e1612d;font-weight: bold;">￥{{props_data.amount}}</span>
                    </div>
                </div>
            </div>
            <div class="m_body_center">
                <div class="body_center">
                    <div class="body_center_order">
                        <h2 style="font-size: 18px;">预定信息</h2>
                    </div>
                    <div class="body_center_order">
                        <span>出行人</span><span>{{this.$store.state.hostObj.host.username}}</span>
                    </div>
                    <div class="body_center_order">
                        <span>联系信息</span>
                        <p>86 {{this.$store.state.hostObj.host.phone}}</p>
                    </div>
                    <div style="text-align: right;">
                        {{this.$store.state.hostObj.host.email}}
                    </div>
                    <div class="body_center_order">
                        <span>合同条款</span><span>电子合同</span>
                    </div>
                    <div class="body_center_order">
                        <span>退款条件</span><span>{{props_data.span}}</span>
                    </div>
                    <div class="body_center_order"><span>产品快照</span><span style="color: #9a9a9a;">核对交易细节时，可作为判断依据
                            ＞</span></div>
                </div>
            </div>
            <div class="m_body_center">
                <div class="body_center">
                    <div class="body_center_order">
                        <h2 style="font-size: 16px;">{{props_data.contentname}}</h2><span style="font-size: 10px;" @click="goto">景点详情
                            ＞</span>
                    </div>
                </div>
            </div>
            <div class="m_body_center">
                <div class="body_center">
                    <div class="body_center_order">
                        <h2 style="font-size: 18px;">遇到问题？</h2>
                    </div>
                    <div class="body_center_bottom">
                        <div v-for="(b,index) in bottomList" :key="index">
                            <i :class='b.icon' style="font-size: 18px;color:#51b2f6"></i>
                            <span style="margin-left: 5px;">{{b.text}}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    let data;
    export default {
        data() {
            return {
                props_data: {},
                bottomList:[
                    {icon:'iconfont icon-15xiaoxi',text:'联系商家'},
                    {icon:'iconfont icon-24gl-phoneLoudspeaker',text:'拨打电话'},
                    {icon:'iconfont icon-icon_xinyong_xianxing_jijin-137',text:'投诉商家'}
                ]
            }
        },
        methods: {
            back() {
                this.$router.go(-1);
            },
            goto(){
                this.$router.push({path:'/Tickets_detail',query:{id:this.props_data.contentid}})
            }
        },
        beforeCreate() {
            data = JSON.parse(this.$route.query.data);
        },
        mounted() {
            this.props_data = data;
        },
        deactivated() {
            this.$destroy();
        },
    }
</script>

<style scoped>
    .m_head {
        width: 100%;
        height: auto;
        background-color: #51b2f6;
        position: fixed;
        position: relative;
        top: 0;
        z-index: 1000;
        font-size: 30px;
        color: white;
    }

    .m_head_top {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .m_body {
        width: 100%;
        height: 100vh;
        background-image: linear-gradient(#51b2f6, #75bbf0);
    }

    .m_body_top {
        width: 92%;
        margin: 0 auto;
        padding-top: 10px;
        margin-bottom: 10px;
        height: auto;
        color: white;
    }

    .body_center {
        width: 92%;
        margin: 0 auto;
    }

    .m_body_center {
        width: 92%;
        margin: 10px auto;
        height: auto;
        background-color: white;
        border-radius: 15px;
        padding-top: 10px;
        padding-bottom: 10px;
        font-size: 14px;
    }

    .m_body_center div {
        margin: 8px auto;
    }

    .body_center_order {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .body_center_bottom{
        display: flex;
        justify-content: space-around;
        align-items: center;
    }
</style>