<!-- 发送 -->
<template>
    <div class="discuss">
        <div class="left">
            <div class="leftdiv"><img :src="require('@/assets/img/head_img/'+head_img+'')" class="left_img"></div>
            <input type="text" placeholder="说点什么" @keyup.enter="post" v-model="text">
            <i :class="submit" @click="post"></i>
        </div>
        <div class="right">
            <div class="dianzan" @click="updatezan">
                <i :class="'iconfont '+zanicon"></i>
                <p>{{count}}</p>
            </div>
            <div class="pinglun" @click="show=!show">
                <i class="iconfont icon-15xiaoxi"></i>
                <p>{{discount}}</p>

            </div>
        </div>
        <van-action-sheet v-model="show" :title="'共有'+discount+'条评论'">
            <div class="content">
                <Show :List="List" :waterfullid="waterfull_id" :limit="1000"></Show>
            </div>
        </van-action-sheet>
    </div> 
</template>

<script>
    const Show = () => import('@/components/mycomponents/Postcomments/showDiscuss')
    export default {
        data() {
            return {
                submit: 'iconfont icon-tijiao-shangchuan-08',
                head_img: this.$store.state.hostObj.host.headimg,
                count: '',
                text: '',
                zanpeople: [],
                host: this.$store.state.hostObj.host,
                zanicon: 'icon-dianzan',
                flag: 1,
                j: 0,
                show: false,
                List:[],
            }
        },
        methods: {
            getdiscussData() {
                this.$axios.get('home/getwaterfull', {
                    params: {
                        waterfullid: this.waterfull_id
                    }
                }).then(res => {
                    if (res.data[0].zanpeople !== []) {
                        this.zanpeople = JSON.parse(res.data[0].zanpeople);
                        for (let i = 0; i < this.zanpeople.length; i++) {
                            if (this.zanpeople[i].name === this.host.username) {
                                this.zanicon = 'icon-tuijian';
                                this.flag = 0;
                                this.j = i;
                                break;
                            } else {
                                this.flag = 1;
                            }
                        }
                        this.count = this.zanpeople.length;
                    } else {
                        this.count = 0;
                        this.flag = 1;
                    }
                }).catch(err => {
                    console.log("获取数据失败")
                });
            },
            gethost() {
                this.$axios.get('/home/gethost', {
                    params: { host: this.$store.state.host }
                }).then(host => {
                    this.host = host.data;
                }).catch(err => {
                    console.log("获取用户数据失败")
                })
            },
            update(zanpeople) {
                this.$axios.get('/community/updatezan', {
                    params: {
                        zanpeople: zanpeople,
                        waterfullid: this.waterfull_id
                    }
                }).then(res => {
                    if (res.status == '200') {
                        console.log('修改赞成功');
                    } else {
                        console.log('修改赞失败')
                    }
                }).catch(err => {
                    console.log('err:' + err);
                })
            },
            updatezan() {
                if (this.flag === 0) {
                    this.zanpeople.splice(this.j, 1);
                    this.zanicon = 'icon-dianzan';
                    this.count = this.zanpeople.length
                    this.update(JSON.stringify(this.zanpeople));
                    this.flag = 1;
                    console.log('1')
                } else {
                    this.zanpeople.splice(this.zanpeople.length, 0, { name: this.host.username });
                    this.zanicon = 'icon-tuijian';
                    this.count = this.zanpeople.length
                    this.update(JSON.stringify(this.zanpeople));
                    this.flag = 0;
                    console.log('2')
                }
            },
            post() {
                var now = new Date()
                var year = now.getFullYear();
                var month = (now.getMonth() + 1) < 10 ? '0' + (now.getMonth() + 1) : (now.getMonth() + 1);
                var date = now.getDate() < 10 ? '0' + now.getDate() : now.getDate();
                var timestamp = now.getTime();
                var discuss = { waterfullid: this.waterfullid, headimg: this.host.headimg, name: this.host.username, text: this.text, timestamp: timestamp, disdate: year + '-' + month + '-' + date, address: this.host.address, zanicon: 'icon-dianzan' }
                this.$axios.get('/home/insertdis', {
                    params: {
                        waterfullid: this.waterfull_id,
                        headimg: this.host.headimg,
                        name: this.host.username,
                        text: this.text,
                        timestamp: timestamp,
                        disdate: year + '-' + month + '-' + date,
                        address: this.host.address
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
                this.loaddiscuss(discuss);
                this.$emit("fun", discuss);
                this.text = '';
            },
            loaddiscuss(discuss) {
                this.$axios.get('/home/getdiscuss', {
                    params: { waterfullid: this.waterfull_id }
                }).then(discussList => {
                    this.List = discussList.data;
                    console.log('list2',this.List);
                    if (discuss) {
                        this.List.unshift(discuss);
                    }
                    this.List.forEach(list => {
                        if (list.zanpeople) {
                            list.zanpeople = JSON.parse(list.zanpeople);
                            let length = 0;
                            list.zanpeople.forEach(people => {
                                if (people.zanname === this.$store.state.hostObj.host.username) {
                                    list.zanicon = 'icon-tuijian';
                                    length--;
                                }
                                length++
                            })
                            if (length !== list.zanpeople.length - 1) {
                                list.zanicon = 'icon-dianzan';
                            }
                            list.zancount = list.zanpeople.length;
                        }else{
                            list.zancount = 0;
                        }
                    });
                }).catch(err => {
                    console.log("获取评论数据失败" + err);
                })
            },
        },
        components:{Show},
        props: ['waterfull_id', 'discount'],
        mounted() {
            this.getdiscussData();
            this.loaddiscuss();
        },
    }
</script>

<style scoped>
    .discuss {
        display: flex;
        width: 100%;
        height: auto;
        justify-content: space-between;
        align-items: center;
    }

    .left {
        display: flex;
        flex: 6;
        border-radius: 20px;
        background-color: #f8f9fd;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        overflow: hidden;
    }

    .leftdiv {
        width: auto;
        height: 30px;
    }

    .left input {
        background-color: #f8f9fd;
        border: 0;
        width: 70%;
        height: 30px;
    }

    .left_img {
        width: 30px;
        height: 30px;
        border-radius: 50%;

    }

    .left i {
        font-size: 25px;
        background-color: #f7f8fa;
        color: #409eff;
        border-top: 2px;
    }

    .right {
        flex: 3;
        display: flex;
        justify-content: space-around;
        align-items: center;
    }

    .right i {
        margin-right: 5px;
    }

    .pinglun,
    .dianzan {
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: flex-start;
    }

    .right p {
        font-size: 12px;
    }

    .right i {
        font-size: 25px;
    }

    .van-action-sheet{
        height: 90%; 
    }

    .content{
        width: 92%;
        margin: 0 auto;
    }
</style>