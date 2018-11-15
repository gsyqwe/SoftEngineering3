<template>
  <div>
    <Menu mode="horizontal" theme="dark" active-name="1">
      <Icon type="person"  size="50" style="float: left"></Icon>
      <MenuItem name="1" style="margin-left:15%">
        <Icon type="plus-round"></Icon>
        <router-link to="/missioncreate">发起任务</router-link>
      </MenuItem>
      <MenuItem name="2">
        <Icon type="settings"></Icon>
        <router-link to="/missioncheck">评审任务</router-link>
      </MenuItem>

      <MenuItem name="3">
        <Icon type="stats-bars"></Icon>
        <router-link to="/requesteranalysis">统计分析</router-link>
      </MenuItem>

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
