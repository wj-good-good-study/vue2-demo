<!-- 社区头部 -->
<template>
    <div>
        <div class="comTop">
            <div class="comTop_left">
                <i :class="topNav.lefticon" style="font-size:24px;"></i>
            </div>
            <div class="comTop_center">
                <ul>
                    <li v-for="(c,index) in topNav.centerspan" @click="show(index)" :class="index==showIndex?'li2':'li1'">{{c.label}}</li>
                </ul>
            </div>
            <div class="comTop_right">
                <i :class="topNav.righticon"></i>
                <img :src="topNav.rightheader">
            </div>
        </div>
    </div>
</template>

<script>
    import Vue from 'vue';
    import { Tab, Tabs } from 'vant';
    Vue.use(Tab);
    Vue.use(Tabs);
    export default {
        data() {
            return {
                topNav: {
                    lefticon: 'iconfont icon-sousuo',
                    centerspan: [{ label: '关注', url: '/Concern' }, { label: '广场', url: '/Square' }, { label: '小组', url: '/Group' }],
                    righticon: 'iconfont icon-liwulipinjiangpin-xianxing', rightheader: require('@/assets/img/head_img/h3.jpg')
                },
                showIndex:1
            }
        },
        methods: {
            show(index){
                this.showIndex=index;
                this.$emit('fun',this.showIndex)
            }
        },

    }
</script>

<style>
    .comTop {
        position: fixed;
        top: 0px;
        width: 92%;
        padding-left: 4%;
        padding-right: 4%;
        height: 40px;
        background-color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;
        z-index: 1000;
    }

    .comTop_left {
        display: flex;
        width: 20%;
        height: 80%;
        align-items: center;
    }

    .comTop_center {
        display: flex;
        width: 60%;
        height: 80%;
        justify-content: center;
    }

    .comTop_center ul {
        display: flex;
        width: 100%;
        height: 100%;
        justify-content: center;
        align-items: center;
    }

    .comTop_center li {
        color: black;
        width: 50px;
        margin-left: 6px;
        margin-right: 6px;
    }

    .li1{
        font-size: 16px;
    }

    .li2{
        font-size: 22px;
        font-weight: 900;
    }

    .comTop_right {
        display: flex;
        width: 20%;
        height: 80%;
        justify-content: space-around;
        align-items: center;
    }

    .comTop_right i,
    .comTop_right img {
        width: 35%;
        color: black;
        font-size: 24px;
        border-radius: 50%;
    }
</style>