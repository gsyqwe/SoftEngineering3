<template>
  <div >
    <button v-on:click="f">
      Toggle
    </button>
    <transition name="fade">
      <p v-if="show">hello</p>
    </transition>
  </div>
</template>

<script>
    export default {
        name: "test",
      created(){
        this.show=!this.show
      },
      mounted(){
        this.show=!this.show
      },
      data() {
          return{
            show: true
          }
      },
      methods:{
          f(){
            this.show=!this.show
          }
      }
    }
</script>

<style scoped>
  fade-enter-active, fade-leave-active {
    transition: opacity .5s;
  }
  fade-enter, fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
    opacity: 0;
  }
</style>
