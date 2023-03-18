<!-- 登录 -->
<template>
    <div>
        <div id='Login' :style="bg"></div>
        <div class="big">
            <div class="icondiv">
                <i :class="icon"></i>
            </div>
            <div class="textdiv">
                <h2>账号安全，放心登录</h2>
            </div>
            <div class="login-input-content">
                <div class="login-input">
                    <label>账号</label>
                    <input type="text" placeholder="请输入用户名" id="username" class="password" v-model="username" autoComplete='off'>
                </div>
                <div class="login-input">
                    <label>密码</label>
                    <input type="password" placeholder="请输入密码" id="password" class="password" v-model="password">
                </div>
                <div class="text">
                    <router-link to="/Register" tag="div" class="register">还没账号？立即注册</router-link>
                    <router-link to="" tag="div" class="forget">忘记密码？</router-link>
                </div>
            </div>
            <div class="logindiv">
                <input type="button" value="登录" @click="goto" id="submit"
                    :class="verify.flag?'login-button1':'login-button2'">
            </div>
            <div class="login-check">
                <input class="checkbox" id="checkbox" type="checkbox" value='' v-model="check">
                已阅读并同意携程
                <router-link to="" tag="a">《服务协议》</router-link>
                和
                <router-link to="" tag="a">《个人信息保护指引》</router-link>
            </div>
        </div>


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
                bg: {
                    backgroundImage: "url(" + require("@/assets/img/background/b11.jpg") + ")",
                    backgroundRepeat: "no-repeat"
                },
                icon: 'iconfont icon-xicheng',
                username: '',
                password: '',
                check: '',
                usersdata:[]
            }
        },
        methods: {
            goto() {
                if (this.verify.flag) {
                    document.getElementById("submit").disabled = false;
                    Toast.success(this.verify.msg);
                    this.$router.push('/Home');
                } else {
                    Toast.fail(this.verify.msg);
                }
            },
            getusers(){
                this.$axios.get('users/getusers').then(users=>{
                    this.usersdata=users.data;
                }).catch(err=>{
                    console.log("获取数据失败"+err)
                })
            },
            checkuserid(){
                for(let i=0;i<this.usersdata.length;i++){
                    if(this.usersdata[i].username.trim()==this.username){
                        return true;
                        break;
                    }
                }
                return false;
            },
            checkpassword(){
                for(let i=0;i<this.usersdata.length;i++){
                    if(this.usersdata[i].username.trim()==this.username && this.usersdata[i].password==this.password){
                        // this.$root.host=this.usersdata[i];
                        this.$store.state.hostObj.host=this.usersdata[i];
                        return true;
                        break;
                    }
                }
                return false;
            }
        },
        created() {
            this.getusers();
        },
        computed: {
            verify() {
                if (!this.check) {
                    return { "flag": false, "msg": "请同意用户协议" }
                }
                if (!this.username) {
                    return { "flag": false, "msg": "请输入有效的用户名" }
                } else if(!this.checkuserid()){
                    return { "flag": false, "msg": "账号不存在" }
                } 
                else if(!this.password || this.password.length < 6 || this.password.length > 16) {
                    return { "flag": false, "msg": '密码长度在6-16个字符之间' };
                } else if(!this.checkpassword()){
                    return { "flag": false, "msg": '密码错误' };
                }
                else {
                    return { "flag": true, "msg": "登陆成功" }
                }
            }
        },
        deactivated() {
            this.$destroy();
        },
    }
</script>

<style>
    #Login {
        height: 100%;
        width: 100%;
        position: fixed;
        top: 0;
        animation: anim 30s linear infinite;
        z-index: -10;
        opacity: 0.9;
    }

    .big {
        width: 100%;
        height: 100%;
        position: fixed;
    }

    .icondiv {
        width: 100%;
        height: 27%;
        z-index: 10;
        text-align: center;
        overflow: hidden;

    }

    .icondiv i {
        font-size: 300px;
        color: #2157a1;
    }

    .textdiv {
        color: white;
        text-align: center;
        height: 5%;
    }

    .login-input-content {
        height: auto;
    }

    .login-input {
        overflow: hidden;
        margin: 20px 0 20px 0;
    }

    .login-input label {
        float: left;
        width: 19%;
        padding-right: 20px;
        text-align: right;
        line-height: 35px;
        height: 35px;
        font-size: 18px;
        font-weight: 600;
        color: white;
    }

    .login-input input {
        border-radius: 20px;
    }

    input:focus {
        border: none;
        outline: none;
    }

    .username {
        float: left;
        line-height: 35px;
        height: 35px;
        width: 66%;
        border: none;
        text-indent: 20px;
    }

    .password {
        float: left;
        line-height: 35px;
        height: 35px;
        width: 66%;
        border: none;
        text-indent: 20px;
    }

    .text {
        height: 40px;
        width: 80%;
        margin: 0 auto;
        font-size: 13px;
        color: white;
    }

    .register {
        float: left;
    }

    .forget {
        float: right;
    }

    .login-check {
        position: absolute;
        width: 100%;
        text-align: center;
        color: white;
        bottom: 0px;
        font-size: 12px;
    }

    .login-check input {
        position: relative;
        top: 2px;
        border: none;
    }

    .login-check a {
        color: white;
    }

    .logindiv {
        width: 80%;
        height: 40px;
        margin: 0 auto;
    }

    .logindiv input {
        width: 100%;
        height: 40px;
        border: 0;
        margin: 0 auto;
        font-size: 20px;
        color: white;
        border-radius: 8px;
    }

    .login-button1 {
        background-color: #1e90ff;
    }

    .login-button2 {
        background-color: #747474;
    }

    @keyframes anim {
        50% {
            transform: scale(1.3);
        }

        100% {
            transform: scale(1);
        }
    }
</style>