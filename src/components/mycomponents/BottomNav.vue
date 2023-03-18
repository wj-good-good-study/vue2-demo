<!-- 导航栏 -->
<template>
    <div class="nav">
        <div class="nav-bottom">
            <ul>
                <router-link v-for="(n,index) in buttomNavList" :key="index" :to=n.url tag="li" >
                    <i :class=n.icon style="font-size: 26px;" ></i>
                    <span>{{n.name}}</span>
                </router-link>
            </ul>
        </div>
    </div>

</template>

<script>
    export default {
        data() {
            return {
                buttomNavList: [
                    { name: '首页', url: '/Home', icon: 'iconfont icon-shouye' },
                    { name: '社区', url: '/Community', icon: 'iconfont icon-shequ-weijihuo' },
                    { name: '消息', url: '/Message', icon: 'iconfont icon-iconfontzhizuobiaozhun023110' },
                    // { name: '行程', url: '/Itinerary', icon: 'iconfont icon-SX_015' },
                    { name: '我的', url: '/My', icon: 'iconfont icon-xiecheng' }
                ]
            }
        },
        methods: {
            reload(){
                setTimeout(()=>{
                    location.reload()
                })
            }
        },
    }
</script>

<style>
    .nav-bottom {
        width: 100%;
        height: 60px;
        position: fixed;
        bottom: 0;
        z-index: 1000;
        background-color: white;
    }

    .nav-bottom ul {
        display: flex;
        height: 60px;
    }

    .nav-bottom ul li {
        width: 25%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .nav-bottom .router-link-exact-active,
    .nav-bottom .router-link-active {
        color: #0588f6;
    }
</style>