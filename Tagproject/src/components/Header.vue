<template>
    <div class="header">
      <div style="margin-left: 200px;margin-top: auto;float: left">
       <img src="../images/zb.jpg" width="300px" height="130px" style="margin-top: 10px"/>
      </div>
      <div style="margin-left: 220px;margin-top: 20px;float: left">
        <p style="font-size: xx-large">众包标注系统</p>
      </div>
      <div style="float: right;margin-top: 70px;margin-right: 20px">
        <h2>欢迎你:{{user}}</h2>

      </div>
    </div>
</template>

<script>
  export default {
    data(){
      return{
        user:window.localStorage.getItem("userID")
      }
    }
  }
</script>

<style scoped>
.header{
  height: 150px;
  background-color: beige;
  border: 2px solid orangered;
}
</style>
