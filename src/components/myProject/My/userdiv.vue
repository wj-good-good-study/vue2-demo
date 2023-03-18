<!-- 用户面板 -->
<template>
    <div>
        <div class="topUser" v-for="(h,index) in hostList" :key="index">
            <div class="userhead">
                <img :src="require('@/assets/img/head_img/'+h.headimg+'')" class="userimg">
                <div class="username">
                    <h2 v-text="h.username" style="display:inline;font-size: 20px;"></h2>
                    <div class="vip" :style="{color:h.iconcolor}">
                        <i class="iconfont icon-kaitonghuiyuanyuan" :style="{backgroundColor:h.bgc,fontSize:'12px'}"></i>
                        {{h.vipname}}
                    </div>
                    <div class="community">
                        {{h.community}}
                    </div>
                </div>
            </div>
            <div class="userbottom">
                <p style="display:inline;font-size: 14px;color:#6c6a6b;">{{h.myintroduce===null?'简单自我介绍，让你更受欢迎':h.myintroduce}}</p>
                <i :class="h.myintroduce===null?h.myintroduceicon:''"></i>
                <div class="fourdiv">
                    <router-link to="" tag="span" v-for="(o,index) in otherList" :key="index">
                        {{o.text}} {{o.count}}
                    </router-link>
                </div>
            </div>
        </div>
        <div class="topUser" v-show="!this.$store.state.hostObj.host.username">
            <div class="userhead">
                <img src="@/assets/img/head_img/h2.jpg" class="userimg">
                <div class="username">
                    <h2 style="display:inline;font-size: 20px;" @click="login">请登录</h2>
                </div>
            </div>
            <div class="userbottom">
                <p style="display:inline;font-size: 14px;color:#6c6a6b;">'简单自我介绍，让你更受欢迎'</p>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                hostList:[],
                otherList:[]
            }
        },
        methods: {
            gethost(){
                this.$axios.get('/home/gethost', {
                    params: { host: this.$store.state.hostObj.host.username }
                }).then(host => {
                    this.hostList = host.data;
                    console.log('myhost',this.hostList);
                }).catch(err => {
                    console.log("获取host数据失败")
                })
            },
            getuserothers(){
                this.$axios.get('/my/getuserothers',{
                    params:{userid:this.$store.state.hostObj.host.userid}
                }).then(other=>{
                    this.otherList=other.data;
                }).catch(err => {
                    console.log("获取other数据失败")
                })
            },
            login(){
                this.$router.push('/Login');
            }
        },
        mounted() {
            this.gethost();
            this.getuserothers();

        },
    }
</script>

<style scoped>
    .topUser {
        width: 100%;
        height: auto;
        padding-top: 5px;
        padding-bottom: 10px;
        background-color: white;
        border-radius: 10px;
        margin: 60px auto 20px auto;
    }

    .userhead,
    .userbottom {
        width: 92%;
        height: auto;
        margin: 0 auto;
        position: relative;
    }

    .userimg {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        margin-right: 4%;
    }

    .username {
        display: inline-block;
        position: absolute;
        top: 10px;
        width: 80%;
        height: auto;
        font-size: 12px;
        text-indent: 0px;
    }

    .vip {
        display: inline-block;
        border-radius: 10px;
        background: #e8f2ff;
        width: auto;
        height: 16px;
        line-height: 16px;
        padding: 1px 2px;
        text-indent: 0px;

    }

    .community {
        background: #eaf6e1;
        color: #779d62;
        width: 20%;
        height: 16px;
        line-height: 16px;
        text-align: center;
    }

    .fourdiv {
        font-size: 14px;
        margin-top: 6px;
        color: #6c6a6b;
    }

    .fourdiv span {
        padding: 0 2px 0 2px;
        border-left: 1px solid #eeeeee;
        border-right: 1px solid #eeeeee;
    }
</style>