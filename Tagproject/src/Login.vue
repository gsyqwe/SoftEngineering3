<template>
    <div id="login">
      <trans v-if="isloading"></trans>
      <transition name="fade">
         <router-view></router-view>
      </transition>

      <!--<personal></personal>-->





    </div>
</template>

<script type="text/ecmascript-6">
import Mheader from './components/Header'
import  work from './components/worker/webwork'
import test from './components/Test'
import  table1 from './components/Table'
import trans from  './components/Trans'
import personal from './components/Personal'
import te from './components/Test/test'
import message from './components/message/message'
import three from  './components/worker/ThreeD'

import {mapState}  from "vuex"
 export default {
  data(){
    return{
    }
  },
   computed:{
     ...mapState([
       'isloading'
     ])

   },
  methods: {
    jump (val) {
      this.$router.push({
        name: val,
        params: {
          userid: 123
        }
      })
    }
  },
  components: {
    Mheader,
    work,
    test,
    table1,
    trans,
    personal,
    te,
    message,
    three
  },

}
</script>

<style scoped>
  html,body,#login{height: 100%}
  slide-left-enter, slide-right-leave-active {
    opacity: 0.2;
    -webkit-transform: translate(50px, 0);
    transform: translate(30px, 0);
  }
  slide-left-leave-active, slide-right-enter {
    opacity: 0.5;
    -webkit-transform: translate(-50px, 0);
    transform: translate(-30px, 0);
  }


  fade-enter{
    opacity:0.2;
  }
  fade-enter-active{
    transition:opacity 3s;
  }
  fade-leave-active{
    transition:transform 3s;
  }
  fade-leave-to{
    transform:translateX(50px);
  }


</style>
