<template >
  <div class="bg">
  <div style="width: 100%;text-align: center;">
    <h1>众包平台</h1>
  </div>

  <div class="login" style="margin-top:50px;">

    <div class="header">
      <div class="switch" id="switch">
        <a class="switch_btn_focus" id="switch_qlogin"  tabindex="7">快速登录</a>
        <a class="switch_btn" id="switch_login"  tabindex="8">快速注册</a><div class="switch_bottom" id="switch_bottom" style="position: absolute; width: 64px; left: 0px;"></div>
      </div>
    </div>


    <div class="web_qr_login" id="web_qr_login" style="display: block; height: 235px;">

      <!--登录-->
      <div class="web_login" id="web_login">


        <div class="login-box">


          <div class="login_form">
            <input type="hidden" name="did" value="0"/>
              <input type="hidden" name="to" value="log"/>
              <div class="uinArea" id="uinArea">
                <label class="input-tips" for="u">帐号：</label>
                <div class="inputOuter" id="uArea">
                  <input type="text" id="u" name="username" v-model="userID" class="inputstyle"/>
                </div>
              </div>
              <div class="pwdArea" id="pwdArea">
                <label class="input-tips" for="p" v-model="password">密码：</label>
                <div class="inputOuter" id="pArea">

                  <input type="password" id="p" name="p" class="inputstyle"/>
                </div>
              </div>

              <div style="padding-left:50px;margin-top:20px;">
                <!--- <a class="button_blue" href="js/main.html" style="width:150px;color: white;text-align: center;">登录</a>-->
                <input type="submit" class="button_blue" style="width:150px;color: white;text-align: center;" @click="jump('requester')" value="登录">
              </div>
          </div>

        </div>

      </div>
    </div>

    <!--注册-->
    <div  id="qlogin" style="display: none; ">

      <div class="web_login">
        <input type="hidden" name="to" value="reg"/>
        <input type="hidden" name="did" value="0"/>
        <ul class="reg_form" id="reg-ul">

          <li>

            <label for="user"  class="input-tips2">用户名：</label>
            <div class="inputOuter2">
              <input type="text" id="user" name="user" maxlength="16" class="inputstyle2"/>
            </div>

          </li>

          <li>
            <label for="passwd" class="input-tips2">密码：</label>
            <div class="inputOuter2">
              <input type="password" id="passwd"  name="passwd" maxlength="16" class="inputstyle2"/>
            </div>

          </li>
          <li>
            <label for="passwd2" class="input-tips2">确认密码：</label>
            <div class="inputOuter2">
              <input type="password" id="passwd2" name="" maxlength="16" class="inputstyle2" />
            </div>

          </li>

          <li>
            <label for="qq" class="input-tips2">联系方式：</label>
            <div class="inputOuter2">

              <input type="text" id="qq" name="qq" maxlength="10" class="inputstyle2"/>
            </div>

          </li>

          <li>
            <div class="inputArea">
              <input type="button" id="reg"  style="margin-top:10px;margin-left:85px;" class="button_blue" value="同意协议并注册"/> <a  class="zcxy" target="_blank">注册协议</a>
            </div>

          </li><div class="cl"></div>
        </ul>


      </div>


    </div>
  </div>
  </div>
</template>

<script>
  import { jq } from '../js/jquery-1.9.0.min'
  import { login } from '../js/login'
    export default {
        name: "login",
      data(){
          return{
            userID:'',
            password:'',
          }
      },
      methods:{
          jump(val){
            this.$router.push({
              name: val,
              params:{
                dataobj:this.userID
              }
            })
          }
      },
    }
</script>

<style scoped>
  .bg{
    background-image: url("../images/1.jpg");
    background-size: cover;
  }
  html {

  }
  body {
    font-family:"Microsoft Yahei";
    font-size:12px;
    margin:0;
    background: url(../images/1.jpg) 50% 0 no-repeat;
  }
  ul {
    padding:0;
    margin:0;
  }
  ul li {
    list-style-type:none;
  }
  a {
    text-decoration:none;
  }
  a:hover {
    text-decoration:none;color:#f00;
  }
  .cl{ clear: both;}
  input[type="text"]:focus, input[type="password"]:focus {
    outline:none;
  }
  input::-ms-clear {
    display:none;
  }
  .login {
    margin:0 auto;
    width:370px;
    border:2px solid #eee;
    border-bottom:none;
    position:relative;
  }
  .header {
    height:50px;
    border-bottom:1px solid #e2e2e2;
    position:relative;
    font-family:"Microsoft Yahei";
  }
  .header .switch {
    height:45px;
    position:absolute;
    left:60px;
    bottom:0;
    font-size:16px;
  }
  .header .switch #switch_qlogin {
    margin-right:85px;
  }
  .header .switch .switch_btn {
    color:#999;
    display:inline-block;
    height:45px;
    line-height:45px;
    outline:none;
    *hide-focus:expression(this.hideFocus=true);
  }
  .header .switch .switch_btn_focus {
    color:#333;
    display:inline-block;
    height:45px;
    line-height:45px;
    outline:none;
    *hide-focus:expression(this.hideFocus=true);
  }
  .header .switch .switch_btn:hover {
    color:#333;
    text-decoration:none;
  }
  .header .switch .switch_btn_focus:hover {
    text-decoration:none;
  }
  #switch_bottom {
    position:absolute;
    bottom:-1px;_bottom:-2px;
    border-bottom:2px solid #848484;
  }

  .web_login {
    width:370px;
    position:relative;
  }
  #web_login{_left:60px;*left:0;}
  .web_login .login_form {
    width:272px;
    margin:0 auto;
  }
  .web_login .reg_form {
    width:300px;
    margin:0 auto;
  }
  .web_login .input-tips {
    float:left;
    margin-top:10px;
    width:50px;
    height:42px;
    font-size:16px;
    line-height:42px;
    font-family:"Hiragino Sans GB", "Microsoft Yahei";
  }
  .web_login .input-tips2 {
    float:left;
    text-align:right;
    padding-right:10px;
    width:75px;
    height:30px;
    font-size:16px;
    margin-top:10px;
    clear:both;
    line-height:30px;
    font-family:"Hiragino Sans GB", "Microsoft Yahei";
  }
  .web_login .inputOuter {
    width:200px;
    height:42px;
    margin-top:10px;
    float:left;

  }
  .web_login .inputOuter2 {
    width:200px;
    margin-top:6px;margin-top:5px\9;
    float:left;

  }
  .web_login .inputstyle {
    width:200px;
    height:38px;
    padding-left:5px;
    line-height:30px;line-height:38px;
    border:1px solid #D7D7D7;
    background:rgba(255, 255, 255, 0.32);;
    color:#333;border-radius:2px;
    font-family:Verdana, Tahoma, Arial;
    font-size:16px;
    ime-mode:disabled;
  }
  .web_login input.inputstyle2:focus,.web_login input.inputstyle:focus{border:1px solid #198BD4;box-shadow:0 0 2px #198BD4;}
  .web_login .inputstyle2 {
    width:200px;
    height:34px;
    padding-left:5px;
    line-height:34px;
    border:1px solid #D7D7D7;
    background:rgba(255, 255, 255, 0.32);
    color:#333;border-radius:2px;
    font-family:Verdana, Tahoma, Arial;
    font-size:16px;
    ime-mode:disabled;
  }
  .web_login .uinArea {
    height:55px;
    position:relative;
    z-index:10;
  }
  .web_login .pwdArea {
    height:55px;
    margin-bottom:10px;
    position:relative;
    z-index:3;
  }
  .web_qr_login {
    position:relative;

    overflow:hidden;
  }

  .login {
    background-color:rgba(255, 255, 255, 0.32);
  }

  h1{margin:80px auto 50px auto;text-align:center;color:#fff;margin-left:-25px;font-size:35px;font-weight: bold;text-shadow: 0px 1px 1px #555;}
  h1 sup{
    font-size: 18px;
    font-style: normal;
    position: absolute;
    margin-left: 10px;}
  .login {border:0;padding:5px 0;
    background: rgba(255,255,255,0.5);;
    margin: 0 auto;
    -webkit-box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, .3);
    box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, .3);}

  .web_login{padding-bottom:20px;}

  .jianyi{color:#fff;text-align:center;margin-top:25px;color:#B3B8C4;}
  .reg_form li {
    height: 55px;
  }

  .web_login input.inputstyle2:focus, .web_login input.inputstyle:focus {
    border: 1px solid #5796f;
    box-shadow: 0 0 0;
  }
  .web_login .reg_form {
    width: 300px;
    margin: 0 auto;
  }
  .web_login .inputstyle2 {border-radius:2px;width:210px;}
  .web_login .input-tips2 {
    padding-right: 5px;
    width: 80px;_width: 75px;_font-size:12px;}
  .button_blue
  {
    display:inline-block;
    float:left;
    height:41px;border-radius:4px;
    background:#2795dc;border:none;cursor:pointer;
    border-bottom:3px solid #0078b3;*border-bottom:none;
    color:#fff;
    font-size:16px;padding:0 10px;*width:140px;
    text-align:center;outline:none;font-family: "Microsoft Yahei",Arial, Helvetica, sans-serif;
  }
  input.button_blue:hover
  {
    background:#0081c1;
    border-bottom:3px solid #006698;*border-bottom:none;
    color:#fff;
    text-decoration:none;
  }
  a.zcxy {text-decoration: underline;line-height:58px;margin-left:15px;color: #959ca8;}
  .web_login .login_form {margin-top:30px;}
  .web_login .uinArea {
    height: 60px;}
  .header .switch{left:70px;}



</style>
