<!-- 轮播图 -->
<template>
    <div class="swiperdiv">
        <el-carousel height="100px">
            <el-carousel-item v-for="(image,index) in sliderList" :key="index">
                <img :src="require('@/assets/img/'+image.img+'')"/>
            </el-carousel-item>
          </el-carousel>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                firstid: 0
            }
        },
        methods: {
        },
        props: ["sliderList"],
    }
</script>

<style>
    .swiperdiv {
        width: 92%;
        margin: 20px 4% 0 4%;
        height: 100px;
        overflow: hidden;
    }

    .swiperdiv img {
        width: 100%;
        background-image: 100%;
    }

    /* .el-carousel__indicators .el-carousel__indicators--horizontal{
        width: 100%;
        padding: 0;
        color: black;
    }
    .el-carousel__indicator .el-carousel__indicator--horizontal{
        color: black;
        background-color: #0ba0fe;
        width: 20px;
    } */

    .swiperdiv .el-carousel__button{
        width: 10px !important;
        height: 10px !important;
        border-radius: 50% !important;
        background-color:  white !important;
    }
</style>