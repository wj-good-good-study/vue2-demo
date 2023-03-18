<!-- 展示评论 -->
<template>
    <div>
        <div class="mydiscuss">
            <div class="mydiscusstitle">
                <h4 style="font-size:17px;">共有{{List.length}}条评论</h4>
            </div>
            <Son @fun="loaddiscuss" :waterfullid="waterfullid" v-if="$store.state.hostObj.host.userid"></Son>
            <div class="bigshowdiscussdiv" ref="big">
                <div ref="small">
                    <Show :List="List" :waterfullid="waterfullid" :limit="limit"></Show>
                </div>
            </div>
            <div class="bigshow_button" ref="open" @click="open">
                <el-button type="primary" plain style="width:100%;">查看全部评论</el-button>
            </div>
        </div>
    </div>
</template>

<script>
    const Son = () => import('@/components/mycomponents/Postcomments/sonpost')
    const Show = () => import('@/components/mycomponents/Postcomments/showDiscuss')
    export default {
        data() {
            return {
                List: [],
                limit: 2,
                flag: 1,
                length:0
            }
        },
        props: ['waterfullid'],
        methods: {
            loaddiscuss(discuss) {
                this.$axios.get('/home/getdiscuss', {
                    params: { waterfullid: this.waterfullid }
                }).then(discussList => {
                    this.List = discussList.data;
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
                    console.log('list',this.List);
                    if (discuss) {
                        this.List.unshift(discuss);
                    }
                }).catch(err => {
                    console.log("获取评论数据失败" + err);
                })
                
            },
            init() {
                // this.$nextTick(function () {
                    if (this.List.length <= 2) {
                        this.$refs.open.style.display = 'none'
                    } else {
                        this.$refs.open.style.display = 'block'
                    }
                // })
            },
            open() {
                // this.$nextTick(function () {
                    this.$refs.open.style.display = 'none';
                    this.limit = this.List.length;
                    this.flag = 0;
                // })
            },
            change() {
                if (this.flag != 0) {
                    this.init();
                } else {
                    this.open();
                }
            }

        },
        components: { Son,Show },
        created() { 
            this.loaddiscuss();
            console.log('hostc',this.$store.state.hostObj.host);
        },
        mounted() {
            this.init();
        },
        updated() {
            this.change();
        },
    }
</script>

<style scoped>
    .mydiscusstitle {
        width: 100%;
        height: 35px;
        line-height: 35px;
    }

    .mydiscuss {
        width: 94%;
        height: auto;
        background-color: white;
        margin-top: 20px;
        padding: 10px 3%;

    }

    .bigshowdiscussdiv {
        width: 100%;
        height: auto;
        overflow: hidden;
    }

    .smallshowdiscussdiv {
        width: 100%;
        height: auto;
        overflow: hidden;
        justify-content: center;
    }

    /* .showhead {
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
    } */
</style>