<!-- 购物车 -->
<template>
    <div>
        <div class="thead">
            <div class="thead_left" @click="back">
                ⬅
            </div>
            <div class="thead_center">
                <h5>购物车</h5>
            </div>
            <div class="thead_right">
                ···
            </div>
        </div>
        <div class="tbody">
            <div class="ticketdiv" v-for="t in ticketList" :key="t.contentid" v-if="t.length!==0">
                <div class="ticket_top">
                    <h2>{{t.title}}</h2>
                </div>
                <div class="ticket_center" v-for="(c,index) in t.children" :key="index">
                    <div class="center_left">
                        <input type="checkbox" :name="c.ticketid" style="width:20px;height:20px;"
                            @click="compute(t.contentid,c.ticketid)" :checked="c.check">
                    </div>
                    <div class="center_center">
                        <img :src="require('@/assets/img/landmark_img/'+t.img+'')">
                    </div>
                    <div class="center_right">
                        <h3>{{c.classify}}</h3>
                        <div class="right_center">
                            <p><span style="font-size:12px;">￥</span>{{c.price}}</p>
                            <div class="numberbox">
                                <input type="button" @click="decrease(t.contentid,c.ticketid)" value="-">
                                <input type="number" v-model="c.num">
                                <input type="button" @click="increase(t.contentid,c.ticketid)" value="+">
                            </div>
                        </div>
                        <div class="delete" @click.prevent="clear(t.contentid,c.ticketid)">
                            删除
                        </div>
                    </div>
                </div>
            </div>
            <div v-if="ticketList.length==0" class="empty">
                <van-empty image="search" description="空空如也" />
            </div>
        </div>
        <div class="tbottom">
            <div class="tbottom_left">
                <input type="checkbox" style="width:20px;height:20px;margin-right: 10px;" @click="check"
                    :checked="checkAll">
                <p v-if="!checkAll">全选</p>
                <p v-if="checkAll">取消全选</p>
            </div>
            <div class="tbottom_right">
                <div>
                    合计:
                    <span style="color:red;font-size:12px;">￥<span
                            style="color:red;font-size:20px;font-weight: 800;">{{$store.state.shopcarObj.total}}</span></span>
                </div>
                <div class="pay" @click="pay">
                    结算
                </div>
            </div>
        </div>
        <el-dialog title="提示" :visible.sync="dialogVisible" width="80%">
            <span>确定支付？</span>
            <span slot="footer" class="dialog-footer">
                <el-button @click="cancel">狠心取消</el-button>
                <el-button type="primary" @click="confirm">确认支付</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    import Vue from 'vue';
    import { Empty, Toast } from 'vant';

    Vue.use(Toast);
    Vue.use(Empty);
    export default {
        data() {
            return {
                ticketList: this.$store.state.shopcarObj.tickets,
                checkAll: false,
                dialogVisible: false,
                // orders:[]
            }
        },
        methods: {
            back() {
                this.$router.go(-1);
            },
            decrease(contentid, ticketid) {
                const decrease = { contentid: contentid, ticketid: ticketid };
                this.$store.dispatch('shopcarObj/decrease', decrease);
            },
            increase(contentid, ticketid) {
                const increase = { contentid: contentid, ticketid: ticketid };
                this.$store.dispatch('shopcarObj/increase', increase);
            },
            clear(contentid, ticketid) {
                const clear = { contentid: contentid, ticketid: ticketid };
                this.$store.dispatch('shopcarObj/clear', clear);
                this.isallcheck();
            },
            compute(contentid, ticketid) {
                let checked = { checked: event.target.checked, contentid: contentid, ticketid: ticketid };
                this.$store.dispatch('shopcarObj/checked', checked);
                this.isallcheck();
            },
            check() {
                this.$store.dispatch('shopcarObj/checkall', this.checkAll);
                this.checkAll = !this.checkAll;
            },
            isallcheck() {
                let flag = 0;
                console.log('tick',this.ticketList);
                for (let i = 0; i < this.ticketList.length; i++) {
                    let item = this.ticketList[i];
                    if (item.children) {
                        for (let j = 0; j < item.children.length; j++) {
                            let child = item.children[j];
                            if (child.check === false) {
                                this.checkAll = false;
                                flag = 1;
                            }
                        }
                    }
                }
                if (flag === 0) {
                    this.checkAll = true;
                }
                if(this.$store.state.shopcarObj.tickets.length === 0){
                    this.checkAll=false;
                }
            },
            pay() {
                console.log('tickets', this.ticketList)
                if (this.ticketList.length !== 0) {
                    if (this.$store.state.shopcarObj.total !== 0) {
                        this.dialogVisible = true;
                    } else {
                        Toast.fail({
                            message: '请先选择订单',
                            duration: 200,
                        });
                    }
                } else {
                    Toast.fail({
                        message: '请先添加订单',
                        duration: 200,
                    });
                }
            },
            addOrder(flagid) {
                let orders = [];
                for (let i = 0; i < this.ticketList.length; i++) {
                    let item = this.ticketList[i];
                    if (item.children) {
                        for (let j = 0; j < item.children.length; j++) {
                            let child = item.children[j];
                            if (child.check) {
                                this.clear(item.contentid, child.ticketid);
                                orders.push({ ticketid: child.ticketid, unitprice: child.price, quantity: child.num, amount: child.price * child.num, flagid: flagid });
                            }
                        }
                    }
                }
                this.$axios.get('landmark/getMaxOrderid').then((res) => {
                    let maxOrderid = res.data[0].orderid + 1;
                    orders.forEach(order => {
                        this.save(maxOrderid, order);
                    })
                }).catch((err) => {
                    console.log('获取最大订单号错误' + err);
                });
            },
            cancel() {
                this.dialogVisible = false;
                console.log('取消支付，状态为未付款存入订单');
                console.log('票', this.ticketList);
                this.addOrder(1);
            },
            confirm() {
                this.dialogVisible = false;
                console.log('确认支付，状态为未使用存入订单');
                console.log('票', this.ticketList);
                this.addOrder(2);
            },
            getMaxOrderid() {
                this.$axios.get('landmark/getMaxOrderid').then((res) => {
                    maxOrderid = res.data[0].orderid;
                }).catch((err) => {
                    console.log('获取最大订单号错误' + err);
                });
            },
            save(orderid, data) {
                this.$axios.get('landmark/save', {
                    params: {
                        orderid: orderid,
                        ticketid: data.ticketid,
                        unitprice: data.unitprice,
                        quantity: data.quantity,
                        amount: data.amount,
                        flagid: data.flagid
                    }
                }).then(res => {
                    if (res.status === 200) {
                        Toast.success({
                            message: '新增订单成功',
                            duration: 200,
                        });
                    } else {
                        Toast.fail({
                            message: '新增订单失败',
                            duration: 200,
                        });
                    }
                }).catch(err => {
                    console.log('新增订单失败' + err);
                });
            }


        },
        mounted() {
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

    .tbody {
        width: 100%;
        min-height: 100%;
        height: auto;
        padding-bottom: 55px;
    }

    .ticketdiv {
        width: 92%;
        height: auto;
        margin: 0 auto;
        margin-top: 10px;
        background-color: white;
        border-radius: 10px;
        padding: 10px;
        box-shadow: 0 0 5px #898989;
    }

    .ticket_top {
        width: 100%;
    }

    .ticket_center {
        width: 100%;
        height: auto;
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }

    .center_left {
        width: 5%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .center_center {
        width: 20%;
        height: auto;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .center_center img {
        width: 100%;
        background-size: 100%;
    }

    .center_right {
        width: 70%;
        height: auto;
    }

    .center_right h3 {
        font-size: 17px;
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
    }

    .right_center {
        width: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .right_center p {
        color: red;
        font-size: 20px;
        font-weight: 800;
    }

    .numberbox input {
        width: 20px;
        text-align: center;
    }

    .delete {
        border-radius: 5px;
        background-color: #ff6600;
        width: 50px;
        font-size: 16px;
        color: white;
        font-weight: 600;
        text-align: center;
        float: right;
    }

    .empty {
        width: 100%;
        height: 80%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .tbottom {
        width: 92%;
        height: 50px;
        background-color: white;
        position: fixed;
        bottom: 0;
        z-index: 1000;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-left: 4%;
        padding-right: 4%;
        box-shadow: 0 -2px 5px #898989;
    }

    .tbottom_left {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .tbottom_right {
        width: auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .pay {
        width: 60px;
        border-radius: 20px;
        background-color: #ff6600;
        font-size: 18px;
        font-size: 800;
        color: white;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-left: 10px;
    }
</style>