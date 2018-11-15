import Vue from 'vue'
import  Vuex from 'vuex'
Vue.use(Vuex)

const store = new Vuex.Store({
  state:{
    isloading:false
  }
})

export  default store;
