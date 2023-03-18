<!-- 标签 -->
<template>
    <div class="swiper mySwiper">
        <div class="swiper-wrapper">
            <div class="swiper-slide">
                <ul class="tab1">
                    <router-link class="tabtab" v-for="(t,index) in tabList1" :key="index"
                        :style="{backgroundColor:t.bgc,color:t.color}" tag="li" :to="{path:t.goto,query:{title:t.name}}">
                        <i :class="t.icon" style="font-size: 30px;"></i>
                        <span>{{t.name}}</span>
                    </router-link>
                </ul>
            </div>
            <div class="swiper-slide" v-show="tabList2!=''">
                <ul class="tab1">
                    <router-link class="tabtab" v-for="(t,index) in tabList2" :key="index"
                        :style="{backgroundColor:t.bgc,color:t.color}" tag="li" :to="{path:t.goto,query:{title:t.name}}">
                        <i :class="t.icon" style="font-size: 30px;"></i>
                        <span style="color:#000" >{{t.name}}</span>
                    </router-link>
                </ul>
            </div>
        </div>
    </div>
</template>

<script>
    import Swiper from 'swiper'
    export default {
        props: {
            tabList1: {
                required: true
            },
            tabList2: {
                default: ''
            }
        },
        mounted() {
            // this.$nextTick(function () {
                var mySwiper = new Swiper(".mySwiper", {
                    autoHeight: true,
                    //解决swipe无法滑动问题
                    observer: true,
                    observeParents: true,
                });
                // console.log('tab',this.tabList1)
            // })
        },
    }
</script>

<style>
    .swiper .swiper-slide:nth-child(2n) {
        height: auto;
        line-height: auto;
    }

    .swiper .swiper-slide {
        line-height: 20px;
    }    

    .tab1 {
        width: 92%;
        min-height: 205px;
        max-height: 270px;
        border-radius: 20px;
        display: flex;
        margin: 60px auto 0;
        flex-wrap: wrap;
        overflow: hidden;
    }

    .tabtab {
        display: flex;
        flex: 20%;
        height: 60px;
        padding: 4px 0;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }
    .tabtab li{
        height: 20px;
    }

    .tabtab i {
        width: 28px;
        height: 28px;
        margin-top: 2px;
        margin-bottom: 3px;
    }

    .tabtab span {
        font-size: 12px;
    }
</style>