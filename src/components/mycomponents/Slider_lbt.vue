<!-- 轮播图1 -->
<template>
    <div>
        <div class="slide-content">
            <div class="slide-view">
                <img v-for="s in sliderList" :key="s.id" :src="s.img" alt="" v-show="s.id==firstid">
                <ul class="slide-page">
                    <li v-for="s in sliderList" :key="s.id" @click="changeCircle(s.id)" :class="s.id==firstid?'li2':'li1'">
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                firstid:0
            }
        },
        methods: {
            changeCircle(id) {
                this.firstid = id;
            },
            go() {
                setInterval(() => {
                    if (this.firstid < this.sliderList.length-1) {
                        this.firstid++;
                    } else {
                        this.firstid = '0';
                    }
                }, 3000)
            }
        },
        mounted() {
            this.sliderList[this.firstid].color = 'black'
            this.go()
        },
        props: ["sliderList"]
    }
</script>

<style>
    .slide-content {
        margin-top: 20px;
        width: 100%;
    }

    .slide-content .slide-view {
        height: 100px;
    }

    .slide-content img {
        width: 92%;
        height: 90px;
        margin: 0 4%;
        position: absolute;
    }

    .slide-page {
        position: relative;
        bottom: -70%;
        text-align: center;
    }

    .slide-page li {
        height: 10px;
        border-radius: 10px;
        display: inline-block;
        margin: 0 3px;
    }

    .li1 {
        width: 10px;
        background-color: white;
        opacity: 0.8;
    }

    .li2 {
        width: 20px;
        background-color: white;
        opacity: 1;
    }
</style>