import Vue from 'vue'
import Router from 'vue-router'


Vue.use(Router)
export default new Router({
  // mode:'history',
  routes: [
    {
      path: '/',
      redirect:'/Login'
    },
    {
      path: '/Login',
      component: ()=>import('@/views/Login/Login'),
      // meta:{title:'登录'}
    },
    {
      path: '/Register',
      component: ()=>import('@/views/Register/Register'),
      // meta:{title:'注册'}
    },
    {
      path: '/Home',
      component: ()=> import('@/views/Home/Home'),
      // meta:{title:'主页'}
    },
    {
      path: '/Shopcar',
      component: ()=> import('@/views/Home/shopcar'),
      // meta:{title:'购物车'}
    },
    {
      path: '/Land',
      component: ()=> import('@/views/Home/Label/landmark_tickets'),
      // meta:{title:'门票'}
    },
    {
      path: '/Tickets_detail',
      component: ()=> import('@/views/Home/Label/tickets_detail'),
      // meta:{title:'门票详情'}
    },
    {
      path: '/Detail',
      component: ()=> import('@/views/Home/detail'),
      // meta:{title:'帖子详情'}
    },
    {
      path: '/Community',
      component: ()=>import('@/views/Community/Community'),
      // meta:{title:'社区'}
    },
    {
      path: '/Message',
      component: ()=>import('@/views/Message/Message'),
      // meta:{title:'消息'}
    },
    {
      path: '/Itinerary',
      component: ()=>import('@/views/Itinerary/Itinerary'),
      // meta:{title:'登录'}
    },
    {
      path: '/My',
      component: ()=>import('@/views/My/My'),
      // meta:{title:'我的'}
    },
    {
      path:'/Orders',
      component:()=>import('@/views/Orders/Orders'),
      // meta:{title:'订单'}
    },
    {
      path:'/Pingjia',
      component:()=>import('@/views/Orders/Pingjia'),
      // meta:{title:'评价'}
    },
    {
      path:'/MyOrders',
      component:()=>import('@/views/Orders/MyOrders'),
      // meta:{title:'订单详情'}
    },
    {
      path:'/Set',
      component:()=>import('@/views/Set/Set'),
      // meta:{title:'设置'}
    },
    {
      path:'/message_Set',
      component:()=>import('@/views/Set/message_Set'),
      // meta:{title:'设置'}
    },
    {
      path:'/service',
      component:()=>import('@/views/My/service'),
      // meta:{title:'会员服务'}
    },
    {
      path:'/Report',
      component:()=>import('@/views/Home/Report'),
      // meta:{title:'举报'}
    },
    {
      path:'/F',
      component:()=>import('@/components/mycomponents/father'),
      // meta:{title:'举报'}
    },
    {
      path:'/S',
      component:()=>import('@/components/mycomponents/son'),
      // meta:{title:'举报'}
    }
  ]
});
/* this.Router.beforeEach((to, from, next) => {
  // to and from are both route objects. must call `next`.
  if(to.meta.title){
    document.title=to.meta.title
  }
}) */
const VueRouterPush = Router.prototype.push
Router.prototype.push = function push (to) {
  return VueRouterPush.call(this, to).catch(err => err)
}
