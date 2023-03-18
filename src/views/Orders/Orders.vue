<!-- 订单 -->
<template>
    <div>
        <div class="order_head">
            <div class="order_head_top">
                <div class="order_left" @click="back">
                    ⬅
                </div>
                <div class="order_center">
                    <h6>订单列表</h6>
                </div>
                <div class="order_right">
                    ···
                </div>
            </div>
            <div class="order_head_bottom">
                <el-tabs v-model="activeId" @tab-click="handleClick" stretch>
                    <el-tab-pane label="全部订单" name="1">
                        <Panel :orderitems="orderitems" >
                            <template #button="orderitem">
                                <div class="cancelbutton" v-if="orderitem.value.flagid===1"
                                    @click="cancelOrders(orderitem.value)">取消订单
                                </div>
                                <div class="cancelbutton" v-if="orderitem.value.flagid===2"
                                    @click="refundOrders(orderitem.value)">申请退款
                                </div>
                            </template>
                        </Panel>
                    </el-tab-pane>
                    <el-tab-pane label="待付款" name="2">
                        <Panel :orderitems="orderitems">
                            <template #button="orderitem">
                                <div class="cancelbutton" @click="cancelOrders(orderitem.value)">取消订单</div>
                            </template>
                        </Panel>
                    </el-tab-pane>
                    <el-tab-pane label="未出行" name="3">
                        <Panel :orderitems="orderitems">
                            <template #button="orderitem">
                                <div class="cancelbutton" @click="refundOrders(orderitem.value)">申请退款</div>
                            </template>
                        </Panel>
                    </el-tab-pane>
                    <el-tab-pane label="待点评" name="4">
                        <Panel :orderitems="orderitems"></Panel>
                    </el-tab-pane>
                </el-tabs>
            </div>
        </div>
        <el-dialog title="提示" :visible.sync="dialogVisible" width="80%">
            <span>确定{{text}}？</span>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="deleteOrders(orderitem,4)">确 定</el-button>
            </span>
        </el-dialog>

    </div>

</template>

<script>
    import Vue from 'vue';
    import { Toast } from 'vant';
    Vue.use(Toast)
    let id;
    let title;
    Toast.setDefaultOptions({ duration: 500 });
    const Panel = () => import('@/components/myProject/Orders/panel')
    export default {
        data() {
            return {
                activeId: '1',
                orderitems: [],
                orderitem: {},
                dialogVisible: false,
                text: '',
            }
        },
        methods: {
            back() {
                this.$router.go(-1);
            },
            handleClick(tab, event) {
                this.activeId = tab.name;
                this.change(this.activeId - 1)
            },
            change(flag) {
                this.$axios.get('orderitems/getorderitems', {
                    params: {
                        flag: flag
                    }
                }).then(result => {
                    this.orderitems = result.data;
                }).catch(err => {
                    console.log('获取订单数据失败' + err);
                })
            },
            cancelOrders(data) {
                this.dialogVisible = true;
                this.orderitem = data;
                this.text = '取消订单'
            },
            refundOrders(data) {
                this.dialogVisible = true;
                this.orderitem = data;
                this.text = '申请退款'
            },
            deleteOrders(data, i) {
                this.dialogVisible = false;
                this.$axios.get('/orderitems/changeflag', {
                    params: {
                        flagid: data.flagid + i,
                        orderid: data.orderid,
                        ticketid: data.ticketid
                    }
                }).then(res => {
                    if (res.data.status == 200) {
                        // let index = this.orderitems.findIndex(item => {
                        //     if (item.orderid === data.orderid && item.ticketid === data.ticketid) {
                        //         return true
                        //     }
                        // });
                        // this.orderitems.splice(index, 1);
                        this.change(this.activeId-1);
                        Toast.success("取消成功！");
                    } else {
                        console.log('取消失败');
                    }
                }).catch(err => {
                    console.log("取消失败" + err);
                });
            },
        },
        components: { Panel },
        mounted() {
            this.change(this.activeId - 1);
        },
        deactivated() {
            this.$destroy();
        },


    }
</script>

<style scoped>
    .order_head {
        width: 100%;
        height: auto;
        background-color: white;
        position: fixed;
        z-index: 1000;
        /* display: flex;
        justify-content: space-between;
        align-items: center; */
        font-size: 30px;
        color: black;
    }

    .order_head_top {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .order_head .order_left,
    .order_head .order_right {
        flex: 1;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .order_head .order_center {
        display: flex;
        flex: 8;
        justify-content: center;
        align-items: center;
    }

    .order_head_bottom {
        background-color: white;
        width: 92%;
        margin: 0 auto;
        height: 40px;
    }

    .cancelbutton {
        font-size: 10px;
        text-align: center;
        border: 1px solid #cfcfcf;
        background-color: white;
        padding: 2px 5px;
    }
</style>