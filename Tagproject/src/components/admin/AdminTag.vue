<template>
  <div>
    <Menu mode="horizontal" theme="dark" active-name="1">
      <Icon type="person"  size="50" style="float: left"></Icon>
      <MenuItem name="1" style="margin-left:15%">
        <Icon type="stats-bars"></Icon>
        <router-link to="/adminanalysis">统计分析</router-link>
      </MenuItem>

    </Menu>
    <br>
    <router-view ></router-view>
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
