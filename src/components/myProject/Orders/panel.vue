<!-- panel -->
<template>
    <div>
        <router-link v-for="(o,index) in orderitems" :key="index" class="panel" to="/Orders" tag="div">
            <div class="panel_top">
                <div class="panel_top_left">
                    <i class="iconfont icon-menpiao" style="font-size:20px;color:#96d5c3"></i>
                    <div style="margin-left: 5px;font-size: 14px;font-weight: bold;">门票</div>
                </div>
                <span style="font-size: 12px;color: #686868;">
                    <slot name="right_span">{{o.flagname}}</slot>
                </span>
            </div>
            <div class="panel_center">
                <h3>{{o.contentname}}--{{o.ticketname}}</h3>
                <span style="color:#9d9d9d;">{{o.redspan}}</span>
                <span style="color:#9d9d9d;">{{o.longaddress}}</span>
                <div class="center_price">
                    ￥{{o.amount}}
                </div>
            </div> 
            <div class="panel_bottom">
                <slot name="button" :value="o"></slot>
                <div class="button" v-show="o.flagid===1" v-text="'去付款'" @click="gotouse(o)"></div>
                <div class="button" v-show="o.flagid===2" v-text="'去使用'" @click="gotouse(o)"></div>
                <div class="button" v-show="o.flagid===3" v-text="'去评价'" @click="gotoEvaluation(o)"></div>
                <div class="button" v-text="'查看订单'" @click="myorders(o)"></div>
            </div>
        </router-link>
        <p style="font-size: 13px;text-align: center;color: #9d9d9d;">已显示全部订单</p>
    </div>
</template>

<script>
    import Vue from 'vue';
    import { Toast } from 'vant';
    Vue.use(Toast)
    Toast.setDefaultOptions({ duration: 500 });
    export default {
        data() {
            return {
                // panel_orderitems:this.orderitems
            }
        },
        methods: {
            gotouse(data) {
                this.$axios.get('/orderitems/changeflag', {
                    params: {
                        flagid: data.flagid + 1,
                        orderid: data.orderid,
                        ticketid: data.ticketid
                    }
                }).then(res => {
                    if (res.data.status == 200) {
                        console.log('修改成功');
                        let index = this.orderitems.findIndex(item => {
                            if (item.orderid === data.orderid && item.ticketid === data.ticketid) {
                                return true
                            }
                        });
                        this.orderitems.splice(index, 1);
                        Toast.success("操作成功！");
                    } else {
                        console.log('修改失败');
                    }
                }).catch(err => {
                    console.log("操作失败" + err);
                });
            },
            gotoEvaluation(data){
                console.log('data1',data);
                this.$router.push({path:"/Pingjia",query:{data:JSON.stringify(data)}});
            },
            myorders(data){
                this.$router.push({path:"/MyOrders",query:{data:JSON.stringify(data)}});
            }
        },
        props: ['orderitems'],
        mounted() {
            // console.log('panel_orderitems',this.orderitems)
        },
        deactivated() {
            this.$destroy();
        },
    }
</script>

<style>
    .panel {
        width: 95%;
        height: 100%;
        margin: 0 auto;
        background-color: white;
        border-radius: 15px;
        margin-bottom: 10px;
        font-size: 12px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        box-shadow: 0px 0px 5px #898989;
    }

    .panel_top {
        width: 92%;
        margin-top: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .panel_top_left {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .panel_center {
        width: 92%;
        margin-top: 5px;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
    }

    .center_price {
        width: 100%;
        text-align: right;
        margin-top: 5px;
        font-size: 13px;
        font-weight: bold;
    }

    .el-tabs__content {
        height: calc(100vh - 110px);
        overflow: auto;
    }


    .panel_bottom {
        width: 92%;
        height: auto;
        display: flex;
        justify-content: flex-end;
        align-items: center;
        margin-top: 5px;
        margin-bottom: 10px;
        text-align: center;
    }

    .button {
        font-size: 10px;
        color: #409eff;
        text-align: center;
        border: 1px solid #b3d8ff;
        background-color: #ecf5ff;
        padding: 2px 5px;
        margin-left: 5%;
    }
</style>