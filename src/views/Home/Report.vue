<!-- 举报 -->
<template>
    <div>
        <div class="report_head">
            <div class="report_head_top">
                <div class="report_left" @click="back">
                    ⬅
                </div>
                <div class="report_center">
                    <h6>举报</h6>
                </div>
                <div class="report_right">
                </div>
            </div>
        </div>
        <div v-show="!success">
            <div class="report_body">
                <div class="report_type">
                    <div style="width:92%;margin:0 auto;">
                        <h4 style="font-size: 14px;">请选择你要举报的类型<span style="color:#db4f44;"> *</span></h4>
                    </div>
                    <div class="type_button_div">
                        <div :class="now===t?'type_button2':'type_button1'" v-for="(t,index) in typeList" :key="index"
                            @click="click(t)">
                            {{t.text}}
                        </div>
                    </div>
                </div>
                <div class="report_content" v-show="now.length!==0">
                    <div style="width:92%;margin:0 auto;">
                        <h4 style="font-size: 14px;margin-bottom: 10px;">举报描述内容<span style="color:#db4f44;"> *</span>
                        </h4>
                        <el-input type="textarea" :rows="5" placeholder="请详细描述您的理由，我们将在5-10个工作日之内处理" v-model="textarea">
                        </el-input>
                        <h4 style="font-size: 14px;margin-top: 20px;margin-bottom: 10px;">图片证据</h4>
                        <van-uploader v-model="fileList" multiple :max-count="2" />
                        <div class="under_pic">请您提供准确、清晰、完整的图片证据</div>
                    </div>
                </div>
            </div>
            <div class="report_bottom">
                <div :class="now!=='' && textarea!==''?'submit2':'submit1'" @click="submit">提交</div>
            </div>
        </div>
        <div v-show="success">
            <div class="report_body">
                <div style="background-color: #fff;height:100vh;width:100%;padding-top: 40%;">
                    <div class="successful_div">
                        <div class="circle">✔</div>
                        <h3 style="font-size: 14px;">举报提交成功</h3>
                        <div style="color:#898989;font-size: 10px;margin: 7px;">我们将在5-10个工作日内处理，结果通过站内信反馈</div>
                        <div class="return" @click="return_detail">
                            返回详情页(<van-count-down ref="countDown" :time="time" format="ss" style="color:#fff !important;" @finish="return_detail" :auto-start="false" />s)
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import Vue from 'vue';
    import { Uploader } from 'vant';
    import { CountDown } from 'vant';
    Vue.use(CountDown);
    Vue.use(Uploader);
    export default {
        data() {
            return {
                typeList: [
                    { text: '违法违规' },
                    { text: '色情低俗' },
                    { text: '垃圾广告' },
                    { text: '抄袭侵权' },
                    { text: '人身攻击' },
                    { text: '其他' },
                ],
                now: '',
                textarea: '',
                fileList: [],
                flag: false,
                success: false,
                time: 5 * 1000,
            }
        },
        methods: {
            back() {
                this.$router.go(-1);
            },
            click(text) {
                this.now = text;
            },
            submit() {
                if (this.now !== '' && this.textarea !== '') {
                    this.success = true;
                    this.$refs.countDown.start();
                }
            },
            return_detail(){
                this.$router.go(-1);
            }
        },
        deactivated() {
            this.$destroy();
        },
    }
</script>

<style scoped>
    .report_head {
        width: 100%;
        height: auto;
        position: fixed;
        position: relative;
        top: 0;
        z-index: 1000;
        font-size: 30px;
        color: #000;
        background-color: #fff;
    }

    .report_head_top {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .report_right {
        width: 30px;
    }

    .report_body {
        width: 100%;
        height: 100vh;
        background-color: #f2f6f9;
        padding-top: 10px;
    }

    .report_type,
    .report_content {
        width: 100%;
        background-color: #fff;
        padding-top: 10px;
        padding-bottom: 10px;
    }

    .report_content {
        margin-top: 10px;
        padding-top: 30px;
    }

    .type_button_div {
        width: 92%;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
    }

    .type_button1 {
        width: 47%;
        height: auto;
        padding-top: 10px;
        padding-bottom: 10px;
        text-align: center;
        color: #000;
        background-color: #f8f8f8;
        margin: 10px auto;
    }

    .type_button2 {
        width: 47%;
        height: auto;
        padding-top: 10px;
        padding-bottom: 10px;
        text-align: center;
        color: #759fdc;
        background-color: #e6f3fc;
        margin: 10px auto;
    }

    .report_bottom {
        position: fixed;
        bottom: 0px;
        z-index: 1000;
        background-color: #fff;
        width: 100%;
        padding: 10px 0;
        box-shadow: 0px -5px 10px #f2f2f2;
    }

    .under_pic {
        margin-top: 5px;
        color: #c5c5c5;
        font-size: 10px;
    }

    .submit1 {
        width: 92%;
        margin: 0 auto;
        padding: 10px 0;
        text-align: center;
        background-color: #f4f4f4;
        color: #a9a9a9;
        border-radius: 30px;
    }

    .submit2 {
        width: 92%;
        margin: 0 auto;
        padding: 10px 0;
        text-align: center;
        background-color: #f4f4f4;
        color: #fff;
        background-image: linear-gradient(to right, #64c7c4, #3c85eb);
        border-radius: 30px;
    }

    .successful_div {
        padding: 20px 0;
        width: 100%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .circle {
        width: 100px;
        height: 100px;
        color: #fff;
        background-image: linear-gradient(to right, #64c7c4, #3c85eb);
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 20px 0;
        border-radius: 50%;
        font-size: 60px;
    }

    .return {
        padding: 7px 20px;
        background-color: #3b84eb;
        color: #fff;
        text-align: center;
        font-size: 12px;
        margin-top: 5px;
        border-radius: 7px;
        display: flex;
        justify-content: center;
        align-items: center;
    }
</style>