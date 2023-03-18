<!-- 发表作者 -->
<template>
    <div>
        <div class="writer" v-for="w in writer" :key="w.id">
            <div class="writer_title">
                <div class="title_left">
                    <img :src="require('@/assets/img/head_img/'+w.head_img+'')">
                    <div class="writer_name">
                        <h3 style="display:inline-block;">{{w.writer}}</h3>
                        <span :style="{backgroundColor:w.bgc,color:w.color}">{{w.span1}}</span>
                        <p style="font-size:8px;color:#a8a8a8;">{{w.publishtime}}</p>
                    </div>
                </div>
                <div class="title_right" v-text="w.flag===1?'已关注':'+关注'" @click="change_attention(w.flag,w.writerid)"></div>
            </div>
            <router-link class="writer_text" tag="div"
                :to="{path:'/detail',query:{waterfull_id:waterfull_id,writer:w.writer}}">
                <h3>{{w.title}}</h3>
                <p style="color:#a8a8a8;" v-html="w.introduce"></p>
            </router-link>
            <div class="writer_pic">
                <img v-for="(i,index) in img.slice(1,4)" :src="require('@/assets/img/detail_img/'+i.img+'')" alt="">
            </div>
            <Post :waterfull_id="waterfull_id"></Post>
        </div>
    </div>


</template>

<script>
    const Post = () => import('@/components/mycomponents/smallPostcomments/fatherpost')
    export default {
        data() {
            return {
                writer: [],
                img: [],
                isAlive:true,
            }
        },
        components: { Post },
        methods: {
            getwaterfulldata() {
                this.$axios.get('home/getwaterfull', {
                    params: {
                        userid:this.$store.state.hostObj.host.userid,
                        waterfullid: this.waterfull_id
                    }
                }).then(res => {
                    let a = res.data[0];
                    this.writer = [{ id: '0', head_img: a.head_img, writer: a.writer,writerid:a.writerid,span1: a.waterfull_span2, color: a.waterfull_span_color, bgc: a.waterfull_span_bgc, publishtime: a.publishtime, title: a.waterfull_title, introduce: a.introduce,flag:a.flag }];
                    this.img = JSON.parse(a.detail_pic);
                }).catch(err => {
                    console.log("获取数据失败");
                })
            },
            change_attention(flag,writerid){
                console.log('flag,writerid',flag,writerid);
                this.$axios.get('/home/change_attention',{
                    params:{
                        flag:flag,
                        userid:this.$store.state.hostObj.host.userid,
                        attentionid:writerid
                    }
                }).then(res=>{
                    if (res.data.status == 200) {
                        this.getwaterfulldata();
                        this.$emit('fun',this.$store.state.hostObj.host.userid);
                        console.log('操作成功');
                        
                    } else {
                        console.log('操作失败');
                    }
                });
            }
        },
        props: ["waterfull_id"],
        mounted() {
            this.getwaterfulldata();
        },

    }
</script>

<style scoped>
    .writer {
        width: 92%;
        margin: 0 auto;
        border-radius: 10px;
        background-color: white;
        height: auto;
        margin-top: 20px;
        padding-top: 5px;
        padding-bottom: 10px;
    }

    .writer_title {
        width: 92%;
        margin: 0 auto;
        background-color: white;
        height: 40px;
        margin-top: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .title_left {
        display: flex;
        align-items: center;

    }

    .writer_name span {
        border-top-left-radius: 10px;
        border-bottom-right-radius: 10px;
        font-size: 10px;
    }

    .title_right {
        width: auto;
        padding: 0 5px 0 5px;
        border-radius: 20px;
        border: 1px solid #a8a8a8;
    }

    .writer_text {
        width: 92%;
        height: auto;
        margin: 0 auto;
        margin-top: 5px;
        background-color: white;
        color: black;
        line-height: 20px;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 4;
    }

    .writer_pic {
        height: auto;
        width: 92%;
        border-radius: 10px;
        overflow: hidden;
        margin: 10px auto 10px auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .writer_pic img {
        width: 32%;
        height: 100px;
        background-size: 100%;
    }

    .writer_discuss {
        width: 92%;
        margin: 0 auto;
        height: auto;
    }
</style>