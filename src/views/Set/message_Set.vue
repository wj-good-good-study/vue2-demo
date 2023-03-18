<!-- 消息设置 -->
<template>
    <div>
        <div class="set_head">
            <div class="set_head_top">
                <div class="set_left" @click="back">
                    ⬅
                </div>
                <div class="set_center">
                    <h6>消息设置</h6>
                </div>
                <div class="set_right">
                </div>
            </div>
        </div>
        <div class="set_body">
            <div class="content_div" style="margin-bottom: 20px;">
                <div class="span_div">
                    <p>{{span1}}</p>
                    <p style="color:#898989">＞</p>
                </div>
            </div>
            <div class="content_div" v-for="(l,i) in List" :key="i">
                <div :class="i===List.length-1?'span_div':'span_line_div'">
                    <p>{{l.title}}</p>
                    <p style="color:#898989">＞</p>
                </div>
            </div>
            <div class="content_div" style="margin-top: 20px;">
                <div class="span_div">
                    <p>{{span2}}</p>
                    <p style="color:#898989">＞</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                span1:'接收消息推送',
                span2:'黑名单管理',
                List: [
                    { title: '平台消息设置' },
                    { title: '消息号动态设置' },
                    { title: '谁可以私信我' },
                ]
            }
        },
        methods: {
            back() {
                this.$router.go(-1);
            },
            loginout() {
                this.$router.push('/Login');
            }
        },
        deactivated() {
            this.$destroy();
        },
    }
</script>

<style scoped>
    .set_head {
        width: 100%;
        height: auto;
        position: fixed;
        position: relative;
        top: 0;
        z-index: 1000;
        font-size: 30px;
        color: black;
        background-color: #fff;
    }

    .set_head_top {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .set_right {
        width: 30px;
    }

    .set_body {
        width: 100%;
        height: 100%;
    }

    .content_div {
        width: 100%;
        height: 50px;
        background-color: #fff;
    }

    .span_div {
        width: 92%;
        margin: 0 auto;
        height: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .span_line_div {
        width: 92%;
        margin: 0 auto;
        height: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #808080;
    }
</style>