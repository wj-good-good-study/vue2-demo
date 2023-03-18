<template>
  <div>
    <div class="swiper mySwiper">
      <div class="swiper-wrapper">
        <div class="swiper-slide">
          <ul class="tab1">
            <router-link class="tabtab" v-for="(t,index) in tabList1" :key="index"
              :style="{backgroundColor:t.bgc,color:t.color}" tag="li" to="/My">
              <i :class="t.icon" style="font-size: 30px;"></i>
              <span>{{t.name}}</span>
            </router-link>
          </ul>
        </div>
        <div class="swiper-slide">
          <ul class="tab1">
            <router-link class="tabtab" v-for="(t,index) in tabList2" :key="index"
              :style="{backgroundColor:t.bgc,color:t.color}" tag="li" to="/My">
              <i :class="t.icon" style="font-size: 30px;"></i>
              <span style="color:#000">{{t.name}}</span>
            </router-link>
          </ul>
        </div>
      </div>
    </div>
  </div>
  </div>
</template>

<script>
  import Swiper from 'swiper'
  export default {
    data() {
      return {
        tabList1: [
          /* { name: '酒店', bgc: '#fa6554', icon: 'iconfont icon-jiudian', color: '#ffffff' },
          { name: '机票', bgc: '#3f8bfa', icon: 'iconfont icon-jipiao', color: '#ffffff' },
          { name: '火车票', bgc: '#5f83ff', icon: 'iconfont icon-huochepiao', color: '#ffffff' },
          { name: '旅游', bgc: '#21bcaf', icon: 'iconfont icon-icon_xinyong_xianxing_jijin-140', color: '#ffffff' },
          { name: '攻略/景点', bgc: '#ff8d3b', icon: 'iconfont icon-gonglve', color: '#ffffff' },
          { name: '民宿/客栈', bgc: '#fef2f5', icon: 'iconfont icon-kezhangongyu', color: '#fc755f' },
          { name: '机+酒', bgc: '#f0f8fe', icon: 'iconfont icon-jiudian1', color: '#4290fa' },
          { name: '汽车/船票', bgc: '#f2f4ff', icon: 'iconfont icon-qichezhan', color: '#7b81ff' },
          { name: '门票/活动', bgc: '#ecfbf8', icon: 'iconfont icon-menpiao', color: '#48cfb6' },
          { name: '美食', bgc: '#fff9f3', icon: 'iconfont icon-daocha', color: '#ff9c3d' },
          { name: '特价/爆款', bgc: '#fef2f5', icon: 'iconfont icon-baokuan', color: '#fc755f' },
          { name: '接送机/包车', bgc: '#f0f8fe', icon: 'iconfont icon-lvyoubaochedingdan', color: '#4290fa' },
          { name: '租车', bgc: '#f2f4ff', icon: 'iconfont icon-chuzuche', color: '#7b81ff' },
          { name: '周边游', bgc: '#ecfbf8', icon: 'iconfont icon-zhoubianyou', color: '#48cfb6' },
          { name: '购物/免税', bgc: '#fff9f3', icon: 'iconfont icon-gouwu', color: '#ff9c3d' }, */
        ],
        tabList2: [
         /*  { name: '一日游', bgc: '#ffffff', icon: 'iconfont icon-qizhi', color: '#3fcbb7' },
          { name: '向导/包车', bgc: '#ffffff', icon: 'iconfont icon-zujianxiangdao', color: '#3fcbb7' },
          { name: '保险', bgc: '#ffffff', icon: 'iconfont icon-baoxian', color: '#3fcbb7' },
          { name: '微领队', bgc: '#ffffff', icon: 'iconfont icon-34qizhi', color: '#3fcbb7' },
          { name: '定制游', bgc: '#ffffff', icon: 'iconfont icon-dingzhiyou', color: '#3fcbb7' },
          { name: '外币兑换', bgc: '#ffffff', icon: 'iconfont icon-duihuanwaibi', color: '#3fcbb7' },
          { name: 'WiFi电话卡', bgc: '#ffffff', icon: 'iconfont icon-wifi', color: '#3fcbb7' },
          { name: '行李寄送', bgc: '#ffffff', icon: 'iconfont icon-hangliyouxiansongda', color: '#3fcbb7' },
          { name: '携程门店', bgc: '#ffffff', icon: 'iconfont icon-mendian', color: '#3fcbb7' },
          { name: '旅拍/跟拍', bgc: '#ffffff', icon: 'iconfont icon-paizhao1', color: '#3fcbb7' },
          { name: '航班助手', bgc: '#ffffff', icon: 'iconfont icon-hangbandongtai', color: '#3fcbb7' },
          { name: '紧急救援', bgc: '#ffffff', icon: 'iconfont icon-EmergencySOS', color: '#fb7153' },
          { name: '借钱', bgc: '#ffffff', icon: 'iconfont icon-jieqian', color: '#ff8431' },
          { name: '签证', bgc: '#ffffff', icon: 'iconfont icon-qianzhengfuwu', color: '#4fd4b7' },
          { name: '企业差旅', bgc: '#ffffff', icon: 'iconfont icon-chalvfeibaoxiao', color: '#759ace' },
          { name: '加盟合作', bgc: '#ffffff', icon: 'iconfont icon-men', color: '#759ace' },
          { name: '核酸检测', bgc: '#ffffff', icon: 'iconfont icon-hesuanjiance', color: '#759ace' },
          { name: '旅游扶贫', bgc: '#ffffff', icon: 'iconfont icon-fupinqingkuang', color: '#759ace' },
          { name: '数字藏品', bgc: '#ffffff', icon: 'iconfont icon-cangpinjianding', color: '#759ace' },
          { name: '携程公益', bgc: '#ffffff', icon: 'iconfont icon-liebiaodaohang_gongyi', color: '#f24e41' }, */
        ]
      }
    },
    mounted() {
      var mySwiper = new Swiper(".mySwiper", {
        autoHeight: true,
      });
    }
  }
</script>

<style>
  html,
  body {
    position: relative;
    height: 100%;
  }

  body {
    background: #eee;
    font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
    font-size: 14px;
    color: #000;
    margin: 0;
    padding: 0;
  }

  .swiper {
    width: 100%;
    height: auto;
  }

  .swiper-slide {
    text-align: center;
    font-size: 18px;
    background: #fff;
  }

  .swiper .swiper-slide {
    height: 300px;
    line-height: 300px;
  }

  .swiper .swiper-slide:nth-child(2n) {
    height: 500px;
    line-height: 500px;
  }

  .tab1 {
    width: 92%;
    height: auto;
    border-radius: 20px;
    display: flex;
    margin: 60px auto 0;
    flex-wrap: wrap;
    overflow: hidden;
  }

  .tabtab {
    display: flex;
    flex: 20%;
    height: 60px;
    padding: 4px 0;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }

  .tabtab i {
    width: 28px;
    height: 28px;
    margin-top: 2px;
    margin-bottom: 3px;
  }

  .tabtab span {
    font-size: 12px;
  }
</style>