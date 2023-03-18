<!-- 小卡片 -->
<template>
    <div>
        <div class="card">
            <div class="card_top">
                <i :class="cardList.icon" :style="{color:cardList.iconColor,fontSize:'25px'}"></i>
                <span style="font-weight:600;">{{cardList.text}}</span>
            </div>
            <div class="card_content">
                <slot></slot>
            </div>

        </div>
    </div>
</template>

<script>
    export default {
        props: ["cardList"]

    }
</script>

<style>
    .card {
        width: 100%;
        height: 180px;
        border-radius: 10px;
        background-color: #ffffff;
    }

    .card_top {
        width: 92%;
        height: 15%;
        margin: 5px auto;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
    }
    .card_content{
        width: 92%;
        height: 80%;
        margin: 0 auto;
    }
</style>