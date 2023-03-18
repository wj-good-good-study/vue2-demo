<!-- 小组 -->
<template>
    <div>
        <div class="group" v-for="(g,index) in groupList" :key="index">
            <img :src="require('@/assets/img/group_img/'+g.img+'')" alt="">
            <div class="community_content">
                <h3>{{g.title}}</h3>
                <div>{{g.count1}}<span :style="{color:g.spancolor}">{{g.span1}}</span> {{g.count2}}<span
                    :style="{color:g.spancolor}">{{g.span2}}</span></div>
            </div>
            <div class="right">
                <i :class="'iconfont '+g.icon" :style="{color:g.iconcolor}"></i>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                groupList: []
            }
        },
        methods: {
            getgroupdata() {
                this.$axios.get('/community/getgroupdata').then(res => {
                    this.groupList = res.data;
                }).catch(err => {
                    console.log("获取小组消息失败" + err)
                });
            }
        },
        mounted() {
            this.getgroupdata();
        },

    }
</script>

<style scoped>
    .group {
        width: 92%;
        height: auto;
        background-color: white;
        margin: 10px auto;
        padding-top: 5px;
        padding-bottom: 5px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .right {
        background-color: white;
        display: flex;
        align-items: center;
    }

    .community_content {
        background-color: white;
        width: 70%;
    }

    .community_content div {
        font-size: 13px;
    }

    .community_content div span {
        font-size: 11px;
    }
</style>