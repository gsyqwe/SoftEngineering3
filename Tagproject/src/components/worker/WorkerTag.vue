<template>
  <div>
  <Menu mode="horizontal" theme="dark" active-name="1">
    <Icon type="person"  size="50" style="float: left"></Icon>
    <MenuItem name="1" style="margin-left:15%">
      <Icon type="checkmark-round"></Icon>
      <router-link to="already" >已提交任务</router-link>
    </MenuItem>
    <MenuItem name="2">
      <Icon type="close-round"></Icon>
      <router-link to="not" >未提交任务</router-link>
    </MenuItem>

    <MenuItem name="3">
      <Icon type="clipboard"></Icon>
      <router-link to="missionreceive" >领取任务</router-link>
    </MenuItem>

    <MenuItem name="4">
      <Icon type="stats-bars"></Icon>
      <router-link to="workanalysis" >统计分析</router-link>
    </MenuItem>

    <!--<Submenu name="4">-->
      <!--<template slot="title">-->
        <!--<Icon type="stats-bars"></Icon>-->
        <!--统计分析-->
      <!--</template>-->
        <!--<MenuItem name="4-1">-->
          <!--<router-link to="workanalysis" >以往数据统计</router-link>-->
        <!--</MenuItem>-->
        <!--<MenuItem name="4-2">-->
          <!--<router-link  >数据预测 </router-link>-->
        <!--</MenuItem>-->
    <!--</Submenu>-->


  </Menu>
  <br>
    <router-view></router-view>
  </div>
</template>
<script>
  export default {
    data () {
      return {
      }
    }
  }
</script>
