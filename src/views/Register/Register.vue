<!-- 登录 -->
<template>
    <div>
        <div id='Register' :style="bg"></div>
        <div class="big">
            <router-link to="/Login" tag="div" style="height:40px;position: fixed;line-height: 40px; margin-left: 4%;">
                <h2 style="font-size: 30px;">
                    ＜
                </h2>

            </router-link>

            <div class="icondiv">
                <i :class="icon"></i>
            </div>
            <div class="textdiv">
                <h2>欢迎使用携程，请注册</h2>
            </div>
            <div class="register-input-content">
                <div class="register-input">
                    <label>账号</label>
                    <input type="text" placeholder="请输入用户名" id="username" class="password" v-model="username" autoComplete='off'>
                </div>
                <div class="register-input">
                    <label>密码</label>
                    <input type="password" placeholder="请输入密码" id="password1" class="password" v-model="password1">
                </div>
                <div class="register-input">
                    <label>确认密码</label>
                    <input type="password" placeholder="请再次输入密码" id="password2" class="password" v-model="password2">
                </div>
                <div class="register-input">
                    <label>手机号</label>
                    <input type="text" placeholder="请输入手机号" id="phone" class="password" v-model="phone">
                </div>
                <div class="register-input">
                    <label>邮箱</label>
                    <input type="text" placeholder="请输入邮箱" id="email" class="password" v-model="email">
                </div>

            </div>
            <div class="registerdiv">
                <input type="button" value="注册" @click="goto" id="submit"
                    :class="verify.flag?'register-button1':'register-button2'">
            </div>
            <div class="register-check">
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
                password1: '',
                password2: '',
                phone: '',
                email: '',
                check: '',
                usersdata:[]
            }
        },
        methods: {
            goto() {
                if (this.verify.flag) {
                    document.getElementById("submit").disabled = false;
                    Toast.success(this.verify.msg);
                    this.adduser();
                    this.$router.push('/Login');
                } else {
                    Toast.fail(this.verify.msg);
                }
            },
            adduser() {   
                this.$axios.get('users/adduser', {
                    params: {
                        username: this.username,
                        password: this.password1,
                        email: this.email,
                        phone: this.phone
                    }
                }).then(res => {
                    if (res.data.status == 200) {
                        this.$message({
                            message: '添加成功',
                            type: 'success'
                        });
                    } else {
                        this.$message({
                            message: '添加失败',
                            type: 'error'
                        });
                    }
                }).catch(err => {
                    console.log("操作失败" + err);
                });
                
            },
            getusers(){
                this.$axios.get('users/getusers').then(users=>{
                    this.usersdata=users.data;
                }).catch(err=>{
                    console.log("获取数据失败")
                })
            },
            checkuserid(){
                this.getusers();
                for(let i=0;i<this.usersdata.length;i++){
                    if(this.usersdata[i].username.trim()===this.username){
                        return true;
                        break;
                    }
                }
                return false;
            },

        },
        computed: {
            verify() {
                if (!this.check) {
                    return { "flag": false, "msg": "请同意用户协议" }
                }
                if (!this.username) {
                    return { "flag": false, "msg": '请填写有效的用户名' };
                }else if(this.checkuserid()){
                    return { "flag": false, "msg": "账号已存在" }
                } 
                if (this.password1.length < 6 || this.password1.length > 16) {
                    return { "flag": false, "msg": '密码长度在6-16个字符之间' };
                }
                if (this.password1 != this.password2) {
                    return { "flag": false, "msg": '两次输入的密码不一致' };
                }
                if (this.phone.length != 11) {
                    return { "flag": false, "msg": '手机号不足11位' }
                }
                if (!/\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.test(this.email)) {
                    return { "flag": false, "msg": '请填写有效的邮箱' };
                }
                return { "flag": true, "msg": '注册成功，请登录！' }
            }
        }
    }
</script>

<style>
    #Register {
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

    .register-input-content {
        height: auto;
    }

    .register-input {
        overflow: hidden;
        margin: 20px 0 20px 0;
    }

    .register-input label {
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

    .register-input input {
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


    .register-check {
        position: absolute;
        width: 100%;
        text-align: center;
        color: white;
        bottom: 0px;
        font-size: 12px;
    }

    .register-check input {
        position: relative;
        top: 2px;
        border: none;
    }

    .register-check a {
        color: white;
    }

    .registerdiv {
        width: 80%;
        height: 40px;
        margin: 0 auto;
    }

    .registerdiv input {
        width: 100%;
        height: 40px;
        border: 0;
        margin: 0 auto;
        font-size: 20px;
        color: white;
        border-radius: 8px;
    }

    .register-button1 {
        background-color: #1e90ff;
    }

    .register-button2 {
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