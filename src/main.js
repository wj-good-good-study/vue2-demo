// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import '@/assets/css/style.css'
import '@/assets/icons/iconfont.css'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import '../node_modules/swiper/swiper-bundle.min.css'
import 'vant/lib/index.less'
import store from '@/store/index'
Vue.config.productionTip = false
Vue.use(ElementUI);
import { ActionSheet } from 'vant';
Vue.use(ActionSheet);
//引入并注册axios
import axios from 'axios'
Vue.prototype.$axios=axios
axios.defaults.baseURL='http://127.0.0.1:85/'

/* eslint-disable no-new */
new Vue({
  router,
  store,
  render: h => h(App),
  
}).$mount("#app")
