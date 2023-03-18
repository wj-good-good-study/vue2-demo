<!-- 展示评论 -->
<template>
    <div>
        <div class="smallshowdiscussdiv" v-for="(d,index) in List.slice(0,limit)" :key="index" v-if="List.length>0?true:false">
            <div class="showhead">
                <img :src="require('@/assets/img/head_img/'+d.headimg+'')">
            </div>
            <router-link to="" tag="div" class="showmessage">
                <p>{{d.name}}</p>
                <p style="color:black;font-weight:600;font-size: 15px;">{{d.text}}</p>
                <p>{{d.disdate | formater}} <span>{{d.address}}</span></p>
            </router-link>
            <div class="showzan">
                <i :class="'iconfont '+d.zanicon" style="font-size:20px" @click="updatezan(d.timestamp)"></i>
                <div>{{d.zancount}}</div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                flag: 1, 
            }
        },
        props: ['List','waterfullid','limit'],
        methods: {
            update(zanicon, zanpeople, timestamp) {
                this.$axios.get('/home/updatezan', {
                    params: {
                        zanicon: zanicon,
                        zanpeople: zanpeople,
                        waterfullid: this.waterfullid,
                        timestamp: timestamp,
                    }
                }).then(res => {
                    if (res.data.status == 200) {
                        console.log('添加成功');
                    } else {
                        console.log('添加失败' + res.data);
                    }
                }).catch(err => {
                    console.log("操作失败" + err);
                });
            },
            updatezan(time) {
                if(this.$store.state.hostObj.host.username){
                    for (let i = 0; i < this.List.length; i++) {
                        if (this.List[i].timestamp === time) {
                            let count = 0;
                            let flag = 0;
                            if (this.List[i].zanpeople) {
                                if (this.List[i].zanpeople.length !== 0) {
                                    for (let j = 0; j < this.List[i].zanpeople.length; j++) {
                                        if (this.List[i].zanpeople[j].zanname === this.$store.state.hostObj.host.username) {
                                            this.List[i].zanpeople.splice(j, 1);
                                            this.List[i].zanicon = 'icon-dianzan';
                                            this.List[i].zancount = this.List[i].zanpeople.length;
                                            flag = 0;
                                            this.update(this.List[i].zanicon, JSON.stringify(this.List[i].zanpeople), time);
                                            break;
                                        }
                                        else if (count === this.List[i].zanpeople.length - 1) {
                                            this.List[i].zanpeople.splice(count, 0, { zanname: this.$store.state.hostObj.host.username });
                                            this.List[i].zanicon = 'icon-tuijian'
                                            this.List[i].zancount = this.List[i].zanpeople.length;
                                            flag = 1;
                                            this.update(this.List[i].zanicon, JSON.stringify(this.List[i].zanpeople), time);
                                            break;
                                        }
                                        count++;
                                    }
                                } else {
                                    this.List[i].zanpeople = [{ zanname: this.$store.state.hostObj.host.username }];
                                    console.log('0', this.List[i].zanpeople);
                                    this.List[i].zanicon = 'icon-tuijian';
                                    this.List[i].zancount = this.List[i].zanpeople.length;
                                    this.update(this.List[i].zanicon, JSON.stringify(this.List[i].zanpeople), time);
                                }
                            } else {
                                this.List[i].zanpeople = [{ zanname: this.$store.state.hostObj.host.username }];
                                console.log('0', this.List[i].zanpeople);
                                this.List[i].zanicon = 'icon-tuijian';
                                this.List[i].zancount = this.List[i].zanpeople.length;
                                this.update(this.List[i].zanicon, JSON.stringify(this.List[i].zanpeople), time);
                            }
                            // console.log('zanpeople', this.List[i].zanpeople.length); 
                        }
                    }
                }else{
                    this.$router.push('/Login');
                }
            },
        },
        filters: {
            formater(date) {
                var time = new Date(date);
                var year = time.getFullYear();
                var month = (time.getMonth() + 1) < 10 ? '0' + (time.getMonth() + 1) : (time.getMonth() + 1);
                var date = time.getDate() < 10 ? '0' + time.getDate() : time.getDate();
                return year + '-' + month + '-' + date;
            }
        },
    }
</script>

<style>
    .smallshowdiscussdiv {
        width: 100%;
        height: auto;
        overflow: hidden;
        justify-content: center;
        background-color: white;
    }

    .showhead {
        width: 10%;
        height: auto;
        margin-top: 10px;
        text-align: center;
        float: left;

    }

    .showhead img {
        width: 30px;
        height: 30px;
        border-radius: 50%;
    }

    .showmessage {
        width: 80%;
        height: auto;
        margin-top: 10px;
        float: left;
    }

    .showmessage p {
        font-size: 14px;
        color: #a3a3a3;
        margin-left: 5px;
        margin-bottom: 3px;
    }

    .showzan {
        width: 8%;
        height: auto;
        margin-top: 10px;
        text-align: center;
        float: left;
    }
</style>