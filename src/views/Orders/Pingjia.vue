<!-- 评价界面 -->
<template>
    <div>
        <div class="p_head">
            <div class="p_head_top">
                <div class="p_left" @click="back">
                    ⬅
                </div>
                <div class="p_center">
                    <h6>发表评价</h6>
                </div>
                <div class="p_right">
                    ···
                </div>
            </div>
        </div>
        <div class="p_body">
            <div class="p_body_center">
                <div class="center_word">
                    <h2 style="font-size: 18px;">{{props_data.contentname}}</h2>
                    <div class="margin_div">{{props_data.ticketname}}</div>
                    <div class="elrate">
                        <span style="margin-right: 20px;">综合评分</span>
                        <div class="block">
                            <el-rate v-model="value1" :colors="colors">
                            </el-rate>
                        </div>
                    </div>
                    <div class="elrate">
                        <span style="margin-right: 20px;">描述相符</span>
                        <div class="block">
                            <el-rate v-model="value2" :colors="colors">
                            </el-rate>
                        </div>
                    </div>
                    <div class="elrate">
                        <span style="margin-right: 20px;">服务态度</span>
                        <div class="block">
                            <el-rate v-model="value3" :colors="colors">
                            </el-rate>
                        </div>
                    </div>
                    <div class="margin_div">
                        <el-input type="textarea" :rows="5" placeholder="客官，请评价一下吧" v-model="textarea" >
                        </el-input>
                    </div>
                    <div class="submit" @click="submit">
                        提交
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import Vue from 'vue';
    import { Toast } from 'vant';
    Vue.use(Toast)
    let data;
    export default {
        data() {
            return {
                props_data: {},
                value1: null,
                value2: null,
                value3: null,
                textarea:'',
                colors: ['#99A9BF', '#F7BA2A', '#FF9900']

            }
        },
        methods: {
            back() {
                this.$router.go(-1);
            },
            deleteOrders(data, i) {
                this.$axios.get('/orderitems/changeflag', {
                    params: {
                        flagid: data.flagid + i,
                        orderid: data.orderid,
                        ticketid: data.ticketid
                    }
                }).then(res => {
                    if (res.data.status == 200) {
                        Toast.success("评价成功！");
                    } else {
                        console.log('取消失败');
                    }
                }).catch(err => {
                    console.log("取消失败" + err);
                });
            },
            submit(){
                console.log('value',this.value1,this.value2,this.value3,this.props_data);
                this.deleteOrders(this.props_data,1);
                this.back();
            }
        },
        beforeCreate() {
            data = JSON.parse(this.$route.query.data);
            console.log('data', data);
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
    .p_head {
        width: 100%;
        height: auto;
        position: fixed;
        position: relative;
        top: 0;
        z-index: 1000;
        font-size: 30px;
        color: black;
    }

    .p_head_top {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .p_body {
        width: 100%;
        height: auto;
    }

    .p_body_center {
        width: 92%;
        margin: 20px auto;
        height: auto;
        background-color: white;
        border-radius: 15px;
        padding-top: 15px;
        padding-bottom: 15px;
        font-size: 14px;
    }

    .center_word {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .margin_div {
        width: 86%;
        text-align: center;
        margin-top: 10px;
        margin-bottom: 10px;
        font-size: 12px;
        color: #898989;
    }

    .elrate {
        margin-top: 10px;
        margin-bottom: 10px;
        font-size: 12px;
        color: #898989;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .submit{
        padding: 10px 40px;
        background-color: #ecf5ff;
        border: 1px solid #c0dfff;
        color: #409eff;
        text-align: center;
        margin-top: 20px;
    }
</style>