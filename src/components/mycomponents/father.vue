<!-- 爸爸 -->
<template>
    <div>
        <son @fun="loadtext" :List="List"></son>
        <ul>
            <li v-for="(l,index) in List" :key="index">{{l.text}}</li>
        </ul>
    </div>
</template>

<script>
    const son = () => import('@/components/mycomponents/son')
    export default {
        data() {
            return {
                List:[]
            }
        },
        methods: {
            loadtext(){
                this.List=JSON.parse(localStorage.getItem('text')||'[]');
            }
        },
        components: { son },
        mounted() {
            this.loadtext();
        },
    }
</script>

<style>

</style>