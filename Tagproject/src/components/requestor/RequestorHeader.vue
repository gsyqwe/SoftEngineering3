<template>
  <div class="layout-ceiling">
    <h1 style="float: left;color: white;font-size: 50px">PIONEER</h1>
    <div style="margin-left: 25%;width: 50px;height: 50px;float: left">
      <Icon type="images" size="80" color="white" ></Icon>
    </div>
    <div style="margin-left: 2%;width: 20%;float: left;margin-top: 12px">
      <h1 style="color: white;font-size: 50px">众包标注系统</h1>
    </div>
    <div class="layout-ceiling-main" style="margin-left: 13%;float: left;" >
      <a @click="jumptohome" style="font-size: 20px">首页</a> |
      <a @click="jumptologin" style="font-size: 20px">注册登录</a> |
      <a @click="jumptohome" style="font-size: 20px">登出</a>
    </div>

    <div @click="jumptoMessage" class="message-con" style="float: left;margin-top: 5px">
      <Tooltip content='无未读消息' placement="bottom">
        <Badge :count="messageCount" dot>
          <Icon type="ios-bell" :size="22" color="white"></Icon>
        </Badge>
      </Tooltip>
    </div>

    <div style="float: left;margin-left: 2%" >
      <Dropdown >
        <Avatar size="large"  shape="circle" src="http://localhost:9900/default.png" />
        <Icon type="arrow-down-b" color="white"></Icon>
        <DropdownMenu slot="list" style="z-index: 20">
          <DropdownItem @click.native="changeToPersonal">个人中心</DropdownItem>
          <DropdownItem>退出登录</DropdownItem>
        </DropdownMenu>

      </Dropdown>
    </div>
  </div>
</template>

<script>
  export default {
    created(){s
      setInterval(()=>{
      },2000)


    },
    data(){
      return{
        messageCount:0
      }
    },
    methods:{
      changeToPersonal(){
        this.$router.push({
          name:'requestorpersonal'
        })
      },
      jumptologin(){
        this.$router.push({
          name:'login'
        })
      },
      jumptohome(){
        this.$router.push({
          name:'home'
        })
      },
      jumptoMessage(){
        this.$router.push({
          name:'personalspace'
        })
      }
    }
  }
</script>

<style scoped>
  .layout{
    border: 1px solid #d7dde4;
    background: #f5f7f9;
    position: relative;
    border-radius: 4px;
    overflow: hidden;
    width: 100%;
  }
  .layout-logo{
    width: 100px;
    height: 30px;
    background: #5b6270;
    border-radius: 3px;
    float: left;
    position: relative;
    top: 15px;
    left: 20px;
  }
  .layout-header{
    height: 60px;
    background: #fff;
    box-shadow: 0 1px 1px rgba(0,0,0,.1);
  }
  .layout-copy{
    text-align: center;
    padding: 10px 0 20px;
    color: #9ea7b4;
  }
  .layout-ceiling{
    background: #464c5b;
    padding: 10px 0;
    overflow: hidden;
    height: 125px;
    width: 100%;
  }
  .layout-ceiling-main{
    float: right;
    margin-right: 15px;
  }
  .layout-ceiling-main a{
    color: #9ba7b5;
  }
</style>
