<!-- 详情界面 -->
<template>
    <div :class="popover?'box':''">
        <div class="zhongshuge">
            <div class="zhead">
                <div class="zhead_left" @click="back">
                    ⬅
                </div>
                <div class="writer" v-for="(h,index) in headList" :key="index">
                    <img :src="require('@/assets/img/head_img/'+h.head+'')"
                        style="background-image: 100%;width: 36px;height: 36px;" />
                    <h5>{{h.writer}}</h5>
                </div>
                <div class="zhead_right" @click="change_popover">
                    ···
                </div>
            </div>

            <div :class="popover?'popover2':'popover1'">
                <div class="popover2_content">
                    <div style="font-size: 30px;" @click="change_popover">×</div>
                    <div class="popover2_div">
                        <div class="popover2_divs" v-for="(p,index) in popoverList" :key="index" @click="goto(p.path)">
                            <i :class="'iconfont '+p.icon" style="font-size: 30px;"></i>
                            <span>{{p.text}}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="zbody" ref="zbody">
                <div class="swiper mySwiper" style="height:100%;">
                    <div class="swiper-wrapper">
                        <router-link to="/Home" tag="div" class="swiper-slide" v-for="s in swipeList.slice(0,6)"
                            :key="s.id" ref="swipepic">
                            <img :src="require('@/assets/img/detail_img/'+s.img+'')" />
                        </router-link>
                    </div>
                </div>
                <div class="zbody_address">
                    <el-tag v-for="(tag,index) in tags" :key="index" :type="tag.type">
                        <i class="iconfont icon-dizhi" style="color:#409eff;"></i>{{tag.address}}
                    </el-tag>
                </div>
                <div class="zbody_good">
                    <img :src="require('@/assets/img/detail_img/'+h.appraise+'')" v-for="(h,index) in headList"
                        :key="index" />
                </div>
                <div class="zbody_title">
                    <h2 v-for="(h,index) in headList" :key="index">{{h.title}}</h2>
                </div>
                <div class="zbody_bigcontent" ref="big">
                    <div class="zbody_smallcontent" ref="small">
                        <p style="line-height:25px" v-html="introduce"></p>
                    </div>
                </div>
                <div class="open_button" ref="open" @click="unfold">
                    <el-button type="text">展开<i class="iconfont icon-xiajiantou" style="color:#66b1ff;"></i>
                    </el-button>
                </div>
                <div class="publishtime">
                    {{publishtime}}发布
                </div>
            </div>
            <Post :waterfullid="waterfull_id"></Post>
            <div class="zother">
                <h4 style="font-size:17px;margin: 0px auto 10px 3%;">看了这篇笔记的都在搜</h4>
                <ul class="zotherul">
                    <router-link to="/Home" tag="li" class="zotherli" v-for="(b,index) in bottomList" :key="index">
                        <i :class="b.icon" style="margin-left:10px;margin-right:10px"></i>
                        {{b.name}}
                    </router-link>
                </ul>
            </div>
        </div>
    </div>

</template>

<script>
    import Swiper from 'swiper'
    const Post = () => import('@/components/mycomponents/Postcomments/fatherpost');
    let waterfull_id;
    let writer;
    export default {
        data() {
            return {
                List: [],
                headList: {},
                introduce: '',
                publishtime: '',
                swipeList: [],
                tags: [],
                bottomList: [],
                waterfull_id: waterfull_id,
                popover: false,
                popoverList: [
                    { icon: 'icon-shouye', text: '首页', path: '/Home' },
                    { icon: 'icon-iconfontzhizuobiaozhun023110', text: '消息', path: '/Message' },
                    { icon: 'icon-SX_015', text: '订单', path: '/Orders' },
                    { icon: 'icon-fenxiang', text: '分享', path: '' },
                    { icon: 'icon-jubao', text: '举报', path: '/Report' },
                ],
            }
        },
        methods: {
            getwaterfulldata() {
                this.$axios.get('home/getwaterfull', {
                    params: {
                        waterfullid: waterfull_id
                    }
                }).then(res => {
                    this.headList = [{ head: res.data[0].head_img, appraise: res.data[0].detail_appraise, title: res.data[0].waterfull_title, writer: res.data[0].writer }];
                    this.swipeList = JSON.parse(res.data[0].detail_pic);
                    this.tags = JSON.parse(res.data[0].detail_tags);
                    this.introduce = res.data[0].introduce;
                    this.publishtime = res.data[0].publishtime;
                    this.bottomList = JSON.parse(res.data[0].detail_bottom);
                }).catch(err => {
                    console.log("获取数据失败")
                })
            },
            unfold() {
                this.$refs.open.style.display = 'none';
                this.$refs.big.style.overflow = 'visible';
                const smallheight = this.$refs.small.offsetHeight;
                this.$refs.big.style.height = smallheight + 'px';
            },
            back() {
                this.$router.go(-1);/* 返回前一个界面 */
            },
            change_popover() {
                this.popover = !this.popover
            },
            goto(path){
                this.$router.push(path);
            }
        },
        beforeCreate() {
            waterfull_id = this.$route.query.waterfull_id;
            writer = this.$route.query.writer;
        },
        mounted() {
            this.getwaterfulldata();
            this.$nextTick(function () {
                var swiper = new Swiper(".mySwiper", {
                    autoHeight: true,
                    observer: true,
                    observeParents: true,
                });
            });
        },
        deactivated() {
            this.$destroy();
        },

        components: { Post }
    }
</script>

<style scoped>
    .box {
        position: fixed;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        pointer-events: none;
    }

    .zhongshuge {
        background-color: #f5f9fc;
        width: 100%;
        height: auto;
    }

    .zhead {
        width: 100%;
        height: 50px;
        background-color: white;
        display: flex;
        justify-content: space-between;
        font-size: 30px;
        color: black;

    }

    .zhead_left,
    .zhead_right {
        flex: 1;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .writer {
        display: flex;
        flex: 8;
        justify-content: center;
        align-items: center;
    }

    .popover1 {
        display: none;
    }

    .popover2 {
        width: 100%;
        height: auto;
        background-color: #4c4c4e;
        opacity: 0.9;
        display: fixed;
        z-index: 1000;
        position: absolute;
        top: 0px;
        pointer-events: auto;
        padding-bottom: 10px;
    }

    .popover2_content {
        width: 92%;
        margin: 0 auto;
        margin-top: 10px;
        text-align: right;
        color: #fff;
    }

    .popover2_div {
        width: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .popover2_divs {
        width: 13%;
        padding: 10px;
        border-radius: 10px;
        background-color: black;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: center;
    }

    .zbody {
        width: 100%;
        height: auto;
        background-color: white;
        padding-bottom: 10px;
    }

    .swiper-slide {
        min-height: 200px;
        /* max-height: 450px; */
        /* height: 450px; */
        height: auto;
    }

    .zbody .swiper-slide img {
        display: block;
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .zbody_address {
        height: auto;
        width: aut0;
        float: left;
        margin: 0 3%;

    }

    .zbody_good {
        height: auto;
        width: 20%;
        float: right;
        text-align: center;
        background-color: #fefefe;
    }

    .zbody_good img {
        width: 40%;
    }

    .zbody_title {
        clear: both;
        width: 94%;
        height: auto;
        margin: 0 3%;
    }

    .zbody_bigcontent {
        width: 100%;
        height: 150px;
        overflow: hidden;
        position: relative;
    }

    .open_button {
        padding: 0;
        float: right;
    }

    .zbody_smallcontent {
        margin: 5px 3%;
        text-align: left;
        font-size: 17px;
        height: auto;
    }

    .publishtime {
        font-size: 12px;
        color: #a3a3a3;
        margin: 20px 3% 0 3%;
    }

    .zother {
        width: 100%;
        height: auto;
        margin-top: 20px;
        padding-top: 10px;
        padding-bottom: 20px;
        background-color: white;
    }

    .zotherul {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        align-items: center;
    }

    .zotherli {
        display: flex;
        width: 44%;
        height: 40px;
        margin: 5px 3% 5px 3%;
        align-items: center;
        background-color: #f7f8fa;
        border-radius: 10px;
    }
</style>