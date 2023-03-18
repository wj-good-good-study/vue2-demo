<!-- 设置--退出登录 -->
<template>
    <div>
        <div class="set_head">
            <div class="set_head_top">
                <div class="set_left" @click="back">
                    ⬅
                </div>
                <div class="set_center">
                    <h6>设置</h6>
                </div>
                <div class="set_right">
                </div>
            </div>
        </div>
        <div class="set_body">
            <div v-for="(s,index) in setList" :key="index">
                <div class="title_div">
                    <span>{{s.title}}</span>
                </div>
                <div class="content_div" v-for="(c,i) in s.children" :key="i">
                    <div :class="i===s.children.length-1?'span_div':'span_line_div'">
                        <p>{{c.span}}</p>
                        <p style="color:#898989">＞</p>
                    </div>
                </div>
            </div>
            <div class="title_div"></div>
            <div class="content_div">
                <div class="span_div">
                    <p>关于携程旅行</p>
                    <p style="color:#898989;"><span style="font-size: 10px;">版本8.88.2</span> ＞</p>
                </div>
            </div>
        </div>
        <div class="set_bottom">
            <div class="login_out" v-text="host?'退出登录':'点击登录'" @click="loginout"></div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                setList: [
                    { title: '账户设置', children: [{ span: '个人信息' }, { span: '账号安全' }, { span: '支付设置' }] },
                    { title: '通用设置', children: [{ span: '个人主题页换肤' }, { span: '消息通知' }, { span: '网络设置' }] },
                    { title: '隐私设置', children: [{ span: '隐私设置' }] },
                    { title: '个人信息收集与共享', children: [{ span: '个人信息收集清单' }, { span: '第三方共享个人信息清单' }] },
                ],
                host:this.$store.state.hostObj.host.userid
            }
        },
        methods: {
            back() {
                this.$router.go(-1);
            },
            loginout(){
                this.$router.push('/Login');
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
    .set_head {
        width: 100%;
        height: auto;
        position: fixed;
        position: relative;
        top: 0;
        z-index: 1000;
        font-size: 30px;
        color: black;
        background-color: #fff;
    }

    .set_head_top {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .set_right {
        width: 30px;
    }

    .set_body {
        width: 100%;
        height: 100%;
    }

    .title_div {
        width: 92%;
        margin: 0 auto;
        height: 35px;
        font-size: 12px;
        display: flex;
        justify-content: flex-start;
        align-items: flex-end;
        color: #898989;
        margin-bottom: 5px;
    }

    .content_div {
        width: 100%;
        height: 50px;
        background-color: #fff;
    }

    .span_div {
        width: 92%;
        margin: 0 auto;
        height: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .span_line_div {
        width: 92%;
        margin: 0 auto;
        height: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #808080;
    }
    .set_bottom{
        width: 100%;
        position: absolute;
        bottom: 0px;
        height: auto;
    }
    .login_out{
        width: 92%;
        height: 40px;
        margin: 0 auto;
        border-radius: 8px;
        margin-bottom: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #3b84eb;
        color: #fff;

    }
</style>