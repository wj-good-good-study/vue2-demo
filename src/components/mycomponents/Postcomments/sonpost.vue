<!-- 发表评论 -->
<template>
    <div>
        <div class="mydiscussinputdiv">
            <div><img  :src="require('@/assets/img/head_img/'+host.headimg+'')" class="discussinputimg"></div>
            <input type="text" placeholder="我想说的..." @keyup.enter="post" v-model="text">
            <i :class="submit" @click="post"></i>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                submit: 'iconfont icon-tijiao-shangchuan-08',
                text: '',
                host:this.$store.state.hostObj.host,
            }
        },
        created() {
            // this.gethost();
        },
        methods: {
            gethost(){
                this.$axios.get('/home/gethost',{
                    params:{host:this.$store.state.hostObj.host}
                }).then(host=>{
                    this.host=host.data;
                }).catch(err=>{
                    console.log("获取用户数据失败")
                })
            },
            post() {
                var now = new Date()
                var year = now.getFullYear();
                var month = (now.getMonth() + 1) < 10 ? '0' + (now.getMonth() + 1) : (now.getMonth() + 1);
                var date = now.getDate() < 10 ? '0' + now.getDate() : now.getDate();
                var timestamp=now.getTime();
                var discuss={waterfullid:this.waterfullid,headimg:this.host.headimg,name:this.host.username,text:this.text,timestamp:timestamp,disdate:year + '-' + month + '-' + date,address:this.host.address,zanicon:'icon-dianzan',zancount:0,flag:0}
                console.log('discuss',discuss);
                this.$axios.get('/home/insertdis',{
                    params:{
                        waterfullid:this.waterfullid,
                        headimg:this.host.headimg,
                        name:this.host.username,
                        text:this.text,
                        timestamp:timestamp,
                        disdate:year + '-' + month + '-' + date,
                        address:this.host.address
                    }
                }).then(res => {
                    if (res.data.status == 200) {
                        console.log('添加成功');
                    } else {
                        console.log('添加失败');
                    }
                }).catch(err => {
                    console.log("操作失败" + err);
                });
                this.$emit("fun", discuss)
                this.text = ''
            }
        },
        props: ['waterfullid']
    }
</script>

<style>
    

    .mydiscussinputdiv {
        width: 100%;
        height: 35px;
        margin-top: 5px;
        margin-bottom: 10px;
        border-radius: 20px;
        background-color: #f7f8fa;
        display: flex;
        justify-content: center;
        overflow: hidden;
    }

    .mydiscussinputdiv div {
        width: 10%;
        height: 100%;
        background-color: #f7f8fa;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .discussinputimg {
        width: 30px;
        height: 30px;
        border-radius: 50%;
    }

    .mydiscussinputdiv input {
        width: 80%;
        height: 100%;
        background-color: #f7f8fa;
        border: none;
    }

    .mydiscussinputdiv i {
        font-size: 30px;
        background-color: #f7f8fa;
        color: #409eff;
        border-top: 2px;
    }
</style>