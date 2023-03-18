<!-- 展示 -->
<template>
    <div>
        <div class="writer_discuss">
            <Son @fun="loaddiscuss" :waterfull_id="waterfull_id" :discount="discount" v-if="$store.state.hostObj.host.userid"></Son>
            <div class="showdiscuss" v-if="List.length>0?true:false">
                <div v-for="(l,index) in List.slice(0,2)" :key="index" class="discuss_div">
                    <h4>{{l.name}}：</h4>
                    <span>{{l.text}}</span>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    const Son = () => import('@/components/mycomponents/smallPostcomments/sonpost')
    export default {
        data() {
            return {
                List: [],
                limit: 2,
                flag: 1,
                discount:0,
            }
        },
        props: ['waterfull_id'],
        components: { Son },
        methods: {
            loaddiscuss(discuss) {
                this.$axios.get('/home/getdiscuss', {
                    params: { waterfullid: this.waterfull_id }
                }).then(discussList => {
                    this.List = discussList.data;
                    if (discuss) {
                        this.List.unshift(discuss);
                    }
                    this.discount=this.List.length;
                }).catch(err => {
                    console.log("获取评论数据失败" + err);
                })
            },

        },
        created() {

        },
        mounted() {
            this.loaddiscuss();
        },
    }
</script>

<style>
    .writer_discuss {
        width: 92%;
        margin: 0 auto;
        height: auto;
    }

    .showdiscuss {
        background-color: #f8f9fd;
        width: 100%;
        height: auto;
        border-radius: 10px;
        margin-top: 10px;
        padding-top: 10px;
        padding-bottom: 10px;
    }

    .discuss_div {
        margin-left: 10px;
        font-size: 14px;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 1;
    }

    .discuss_div h4 {
        display: inline;
    }

    .discuss_div span {
        color: #a8a8a8;
    }
</style>