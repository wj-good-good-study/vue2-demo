<!-- 消息 -->
<template>
    <div>
        <div class="top">
            <div class="topNav">
                <ul>
                    <li style="flex:2;height: auto;">
                    </li>
                    <li style="flex:6;flex-direction: row;">
                        <h2>{{message.title}}</h2>
                        <div class="clear" :style="{backgroundColor:message.icon_bgc,color:message.icon_color}">
                            <i :class="'iconfont '+message.icon" style="font-size:30px;"></i>
                        </div>
                    </li>
                    <router-link :to="t.goto" tag="li" v-for="t in topList1" :key="t.id">
                        <i :class="'iconfont '+t.icon" style="font-size:20px;"></i>
                        <p style="font-size:12px;">{{t.text}}</p>
                    </router-link>
                </ul>
            </div>
            <div class="buttonDiv">
                <div v-for="b in buttonList" :key="b.id" class="buttonDiv_div">
                    <i :class="'iconfont '+b.icon"
                        :style="{fontSize: '50px',marginBottom: '10px',color:b.iconcolor}"></i>
                    <p>{{b.text}}</p>
                </div>
            </div>
        </div>
        <div class="message">
            <div v-for="m in messageList" :key="m.id" class="messagediv">
                <div class="left" :style="{backgroundColor:m.iconbgc}">
                    <i :class="'iconfont '+m.icon" :style="{color:m.iconcolor,fontSize:'40px'}"></i>
                </div>
                <div class="right">
                    <div class="right_top">
                        <p style="font-weight:bolder;font-size: 16px;">{{m.title}}</p>
                        <p style="color:#878787;font-size: 12px;">{{m.time}}</p>
                    </div>
                    <div class="right_bottom">
                        {{m.text}}
                    </div>
                </div>
            </div>
            <div class="none">
                没有更多内容了
            </div>
        </div>

        <BottomNav></BottomNav>
    </div>
</template>

<script>
    const BottomNav = () => import('@/components/mycomponents/BottomNav')
    export default {
        data() {
            return {
                message: { title: '消息', icon: 'icon-qingli', icon_color: '#3d80d5', icon_bgc: '#c8dced' },
                topList1: [
                    { id: 0, icon: 'icon-wode', text: '客服',goto:'/service' },
                    { id: 1, icon: 'icon-31shezhi', text: '设置',goto:'/message_Set' },
                ],
                buttonList: [],
                messageList: []
            };
        },
        methods: {
            getbuttondata() {
                this.$axios.get('message/buttonDiv').then(res => {
                    this.buttonList = res.data;
                    console.log('buttonList', this.buttonList);
                }).catch(err => {
                    console.log("获取四个按钮数据失败" + err);
                })
            },
            getmessagedata() {
                this.$axios.get('message/message').then(res => {
                    this.messageList = res.data
                }).catch(err => {
                    console.log('获取消息框数据失败' + err)
                })
            }
        },
        components: { BottomNav },
        mounted() {
            this.getbuttondata();
            this.getmessagedata();
        },
        deactivated() {
            this.$destroy();
        },

    }
</script>

<style scoped>
    .top {
        position: absolute;
        width: 100%;
        height: auto;
        background: inherit;
        background-image: radial-gradient(#eff4fa, #d4e4f3, #deeaf6);
    }

    .topNav {
        width: 100%;
        height: auto;
        position: fixed;
        z-index: 1000;
    }

    .topNav ul {
        width: 92%;
        margin: 0 auto;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .clear {
        border-radius: 50%;
        width: 30px;
        height: 30px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .topNav li {
        flex: 1;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        margin: 5px;
    }

    .buttonDiv {
        background-color: white;
        width: 92%;
        margin: 60px auto;
        margin-bottom: 10px;
        height: auto;
        border-radius: 10px;
        display: flex;
        justify-content: space-around;
        align-items: center;
    }

    .buttonDiv_div {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin: 10px 0px;
    }

    .message {
        position: relative;
        top: 170px;
        height: auto;
        width: 100%;
    }

    .messagediv {
        width: 100%;
        height: auto;
        display: flex;
        justify-content: flex-start;
        align-items: center;
        background-color: white;
    }

    .messagediv .left {
        width: 10%;
        border-radius: 50%;
        height: auto;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-left: 4%;
    }

    .messagediv .right {
        width: 80%;
        height: auto;
        margin-left: 10px;
    }

    .right .right_top,
    .right .right_bottom {
        margin: 5px;
    }

    .right .right_top {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .right .right_bottom {
        display: -webkit-box;
        overflow: hidden;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
        color: #878787;
    }

    .none {
        position: relative;
        height: auto;
        margin: 10px;
        text-align: center;
        color: #878787;
        background-color: none;
    }
</style>