<!--社区  -->
<template>
    <div class="Community">
        <topNav @fun="receive"></topNav>
        <div class="center">
            <div class="center1" v-show="showIndex==0">
                <div class="center2_content">
                    <WriterDiv @fun="getattention" v-for="a in attentionList" :key="a.waterfull_id" :waterfull_id="a.waterfull_id">
                    </WriterDiv>
                </div>
            </div>
            <div class="center2" v-show="showIndex==1">
                <div class="center2_content">
                    <Tab1></Tab1>
                    <Elswiper :sliderList="sliderList.slice(9,12)"></Elswiper>
                    <WriterDiv @fun="getattention" v-for="(i,index) in 8" :waterfull_id="i"></WriterDiv>
                </div>
            </div>
            <div class="center3" v-show="showIndex==2">
                <div class="center3_content">
                    <Group></Group>
                </div>
            </div>
        </div>
        <BottomNav></BottomNav>
    </div>
</template>

<script>
    const topNav = () => import('@/components/myProject/Community/topNav')
    const Group = () => import('@/components/myProject/Community/group')
    const BottomNav = () => import('@/components/mycomponents/BottomNav')
    const Tab1 = () => import('@/components/myProject/Community/Tab/com_Tab1')
    const Elswiper = () => import('@/components/mycomponents/ElSwiper_lbt')
    const WriterDiv = () => import('@/components/myProject/Community/Tab/com_writerdiv')
    export default {
        data() {
            return {
                showIndex: 1,
                waterfull_id: 2,
                sliderList: [],
                attentionList: [],
                userid: this.$store.state.hostObj.host.userid,
            }
        },
        components: { BottomNav, topNav, Tab1, WriterDiv, Elswiper, Group },
        methods: {
            receive(data) {
                this.showIndex = data;
                if (this.showIndex === 0) {
                    this.getattention(this.userid);
                }
            },
            getlbtdata() {
                this.$axios.get('home/getlbt_img').then(res => {
                    this.sliderList = res.data
                }).catch(err => {
                    console.log("获取轮播图数据失败")
                })
            },
            getattention(id) {
                if (id) {
                    this.$axios.get('/home/getattention',{
                        params:{
                            userid:id
                        }
                    }).then(res => {
                        this.attentionList = res.data;
                        console.log('attention',this.attentionList);
                    }).catch(err => {
                        console.log('获取关注列表失败' + err)
                    });
                } else {
                    this.$router.push('/Login');
                }
            }
        },
        mounted() {
            this.getlbtdata();
        },
        deactivated() {
            this.$destroy();
        },
    }
</script>

<style>
    .Community {
        background-color: white;
        width: 100%;
        height: auto;
    }

    .center {
        width: 100%;
        background-color: #f3f4f6;
        padding-top: 20px;
        height: auto;
    }

    .center1 {
        width: 100%;
        height: 1000px;
    }

    .center2 {
        margin-top: 40px;
    }

    .center3 {
        margin-top: 21px;
        background-color: white;
    }

    .center3_content,
    .center2_content {
        width: 100%;
        height: auto;
        padding-bottom: 60px;
    }

    .center2_content {
        padding-top: 10px;
    }
    .center3_content {
        padding-top: 10px;
    }


    .center2 .van-tab--active {
        font-size: 18px;
        color: #409eff;
    }

    .center2 .van-tabs__line {
        background-color: #409eff;
    }
</style>