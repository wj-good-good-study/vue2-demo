<!-- 首页 -->
<template>
    <div class="shouye">
        <!-- 搜索栏 -->
        <SearchNav :search="search"></SearchNav>
        <!-- 标签 -->
        <div class="myLabel">
            <myLabel :tabList1="tabList1" :tabList2="tabList2"></myLabel>
        </div>

        <!-- 轮播图 -->
        <!-- <Slider :sliderList="sliderList"></Slider> -->
        <Elswiper :sliderList="sliderList.slice(0,9)"></Elswiper>
        <!-- 活动 -->
        <div class="huodong">
            <h3>热门活动</h3>
            <p>更多活动></p>
        </div>

        <ul class="sixTag">
            <router-link to="/Home" v-for="(h,index) in huodongList" :key="index" tag="li" class="tag"
                :style="{flex: flex}">
                <div>
                    <h5>{{h.title}}</h5>
                    <span>{{h.text}}</span>
                </div>
                <img :src="require('@/assets/img/'+h.img+'')" alt="" style="width:38px;height:40px;">
            </router-link>
        </ul>
        <!-- 展示 -->
        <div class="waterfull">
            <waterFull :waterFullList="waterFullList"></waterFull>
        </div>
        <!-- 底部导航栏  -->
        <BottomNav></BottomNav>
    </div>
</template>

<script>
    const BottomNav=()=>import('@/components/mycomponents/BottomNav')
    const Slider=()=>import('@/components/mycomponents/Slider_lbt')
    const Elswiper=()=>import('@/components/mycomponents/ElSwiper_lbt')
    const waterFull=()=>import('@/components/mycomponents/waterFull')
    const SearchNav=()=>import('@/components/mycomponents/searchNav')
    const myLabel=()=>import('@/components/myProject/Home/myLabel')
    export default {
        data() {
            return {
                search: { leftText: '全球', leftIcon: 'iconfont icon-xiajiantou', searchIcon: 'iconfont icon-sousuo', placeholder: '目的地/景点/话题...', peopleIcon: 'iconfont icon-user-full' },
                flex: '30%',
                tabList1: [],
                tabList2: [],
                sliderList: [],
                huodongList: [],
                waterFullList: [],
            }
        },
        components: { SearchNav, BottomNav, Slider, Elswiper, waterFull, myLabel },
        methods: {
            gettabdata1() {
                this.$axios.get('home/gettab1').then(tab1 => {
                    this.tabList1 = tab1.data;
                    console.log('tab1',this.tabList1);
                }).catch(err => {
                    console.log("获取tab1数据失败",err);
                })
            },
            gettabdata2() {
                this.$axios.get('home/gettab2').then(tab2 => {
                    this.tabList2 = tab2.data
                }).catch(err => {
                    console.log("获取tab2数据失败")
                })
            },
            getlbtdata() {
                this.$axios.get('home/getlbt_img').then(res => {
                    this.sliderList = res.data
                }).catch(err => {
                    console.log("获取轮播图数据失败")
                })
            },
            gethuodongdata() {
                this.$axios.get('home/gethuodong').then(res => {
                    this.huodongList = res.data
                }).catch(err => {
                    console.log("获取活动数据失败")
                })
            },
            getwaterfulldata() {
                this.$axios.get('home/getwaterfull',{
                    params:{
                        waterfullid:'false'
                    }
                }).then(res => {
                    this.waterFullList = res.data;
                }).catch(err => {
                    console.log("获取数据失败")
                })
            },
        },
        created() {
            this.gettabdata1();
            this.gettabdata2();
            this.getlbtdata();
            this.gethuodongdata();
            this.getwaterfulldata();
        },
        

    }
</script>

<style>
    .shouye {
        background-image: linear-gradient(to bottom, #ffffff, #f1f1f1);
        overflow: hidden;
    }

    /* .myLabel{
        margin: 60px auto 0 auto;
    } */


    .huodong {
        position: absolute;
        width: 96%;
        left: 4%;
        margin: 5px 0;
    }

    .huodong h3,
    .huodong p,
    h3 {
        display: inline;
    }

    .huodong p {
        position: absolute;
        right: 8%;
    }

    .sixTag {
        width: 92%;
        height: auto;
        border-radius: 20px;
        display: flex;
        margin: 40px auto 20px;
        flex-wrap: wrap;
        overflow: hidden;
    }

    .tag {
        white-space: nowrap;
        background-color: white;
        display: flex;
        border-radius: 15px;
        height: 60px;
        flex-direction: row;
        justify-content: space-around;
        align-items: center;
        margin: 1%;
        padding: 0 0.1%;

    }

    .tag div span {
        font-size: 8px;
        color: #7a7a7a;
    }

    .waterfull {
        width: auto;
        height: 700px;
    }
</style>