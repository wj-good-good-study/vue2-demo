<!-- 发现 -->
<template>
    <div class="found">
        <div class="my-swipediv">
            <div class="swipe_title">
                <h3>{{swipeTitle.title}}</h3>
                <span style="font-size:13px;">{{swipeTitle.span}}</span>
            </div>
            <van-swipe class="my-swipe" :autoplay="3000" indicator-color="white">
                <van-swipe-item v-for="i in 4" :key="i">
                    <router-link v-for="h in hotdata.slice(3*i-3,3*i)" :key="h.id" to="" tag="div" class="swipediv1">
                        <div class="swipediv2">
                            <i :class="'iconfont '+h.icon" :style="{color:h.iconcolor}"><span
                                    style="font-size:16px;font-weight:600;color:black;">{{h.title}}</span></i>
                            <span :style="{fontSize:'10px',color:h.spancolor}">{{h.span}}</span>
                        </div>
                    </router-link>
                </van-swipe-item>
            </van-swipe>
        </div>
    </div>
</template>

<script>
    import Vue from 'vue'
    import { Swipe, SwipeItem } from 'vant';
    Vue.use(Swipe);
    Vue.use(SwipeItem);
    export default {
        data() {
            return {
                swipeTitle: { title: '热门话题', span: '话题广场 >' },
                hotdata:[],
            }
        },
        methods: {
            gethotdata(){
                this.$axios.get('/community/gethotdata').then(res=>{
                    this.hotdata=res.data;
                }).catch(err=>{
                    console.log("获取热门话题消息失败"+err)
                })
            }
        },
        mounted() {
            this.gethotdata();
        },
    }
</script>

<style>
    .found {
        width: 100%;
        background-color: #f3f4f6;
        height: auto;
    }

    .found .my-swipediv {
        width: 92%;
        margin: 0 auto;
        border-radius: 10px;
        background-color: white;
        height: 150px;
    }

    .found .swipe_title {
        height: 20%;
        width: 92%;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
    }

    .found .my-swipe {
        width: 92%;
        margin: 0 auto;
        height: 70%;
    }

    .found .swipediv1 {
        display: flex;
        justify-content: flex-start;
        flex-direction: row;
        margin-top: 12px;

    }

    .found .swipediv2 {
        display: flex;
        width: 100%;
        justify-content: space-between;
        align-items: center;
    }
</style>