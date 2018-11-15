<template>  <div>
  <nav class="navbar navbar-inverse">

      <div class="container">

        <div class="navbar-header">
          <img src="../images/1.jpg" style="width: 50px;height: 50px">
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><router-link to="/already">已提交</router-link></li>
            <li><router-link to="/not">未提交</router-link></li>
            <li><router-link to="/workanalysis">数据统计</router-link></li>
            <li><router-link to="/table">表</router-link></li>
          </ul>
        </div>

      </div>


  </nav>
  <router-view></router-view>
  </div>
</template>

<script type="text/ecmascript-6">export default {}
</script>

<style scoped>
</style>
