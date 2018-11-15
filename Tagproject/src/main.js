// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import router from './router'
import login from './Login'
import iView from 'iview'
import 'iview/dist/styles/iview.css'
import axios from 'axios'
import store from './store'
import echarts from 'echarts'
import 'swiper/dist/css/swiper.css'
import VueAwesomeSwiper from 'vue-awesome-swiper'

Vue.prototype.$echarts=echarts
Vue.prototype.$http=axios


Vue.use(iView)
Vue.use(router)
Vue.use(VueAwesomeSwiper)





// router.beforeEach((to,from,next)=>{
//   if(to.path!='/'&&to.path!='/login') {
//     var userID = window.localStorage.getItem("userID");
//     //根据身份判断
//     var identity = window.localStorage.getItem("identity")
//     console.log(identity)
//     if (identity == null) {
//       next({path: '/'})
//       return
//     }
//     if (identity == '管理员' && to.path != '/admin' && to.path!='/adminanalysis') {
//       next({path: '/'})
//       return
//     }
//
//     else if (identity == '工人' && (to.path != '/already' && to.path != '/not' && to.path != '/missionreceive' && to.path != '/workanalysis' && to.path != '/webwork')) {
//       next({path: '/'})
//       return
//     }
//     else if (identity == '发起者' && (to.path!='/requester' && to.path != '/missioncreate' && to.path != '/missioncheck' && to.path != '/requesteranalysis' && to.path != '/missioncheckdetail' &&to.path!='/missionintegration')) {
//       next({path: '/'})
//       return
//     }
//
//   }
//    iView.LoadingBar.start();
//    if(to.path!='/login' && to.path!='/'){
//       store.state.isloading=true
//    }
//    next()
// });

router.afterEach((to,from,next)=>{
  iView.LoadingBar.finish()
  setTimeout(function () {
    store.state.isloading=false
  },2000)
})

Vue.config.productionTip = false

/* eslint-disable no-new */

new Vue({
  el: '#login',
  render: h => h(login),
  router,
  store
})
