<!-- 瀑布流 -->
<template>
    <div class="waterFull">
        <router-link v-for="(w,index) in waterFullList" :key="index" tag="div"
            :to="{path:w.goto,query:{waterfull_id:w.waterfull_id,writer:w.writer}}" class="water_li">
            <img :src="require('@/assets/img/waterFull_img/'+w.waterfull_img+'')" >
            <div class="water_div1">
                <i class="iconfont icon-dizhi" style="font-size: 22px;"></i>
                {{w.waterfull_address}}
            </div>
            <div class="water_div2">
                <h4>{{w.waterfull_title}}</h4>
                <p style="font-size:8px;color:#7a7a7a;margin-bottom: 5px;">{{w.waterfull_span1}}</p>
                <div style="float:left;margin-left: 2px;">
                    <img :src="require('@/assets/img/head_img/'+w.head_img+'')" style="width:30px;height:30px">
                </div>
                <div style="float:left;margin-left: 5px;font-size: 12px;">
                    <p>{{w.writer}}</p>
                    <span :style="{color:w.waterfull_span_color,backgroundColor:w.waterfull_span_bgc}">{{w.waterfull_span2}}</span>
                </div>
            </div>
        </router-link>
    </div>

</template>

<script>
    export default {
        props: ["waterFullList"],
    }
</script>

<style scoped>
    .waterFull {
        width: 92%;
        height: auto;
        margin: 0 4%;
        position: absolute;
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        padding-bottom: 60px;
    }

    .water_li {
        border-radius: 20px;
        width: 48%;
        overflow: hidden;
        height: auto;
        display: flex;
        flex-direction: column;
        position: relative;
        background-color: white;
        margin: 1% 0;
    }

    .water_li img {
        background-size: 100%;
    }

    .water_div1 {
        font-size: 8px;
        position: absolute;
        top: 60%;
        color: white;
    }

    .water_div2 {
        width: 96%;
        margin: 0 auto;
    }

    .water_div2 h4 {
        width: 100%;
        height: 38px;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 2;
    }
</style>