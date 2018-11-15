<template>
  <div>
    <Card>
      <Avatar  style="margin-left: 12%;width: 5%;height: 5%" :src="NowAvatol" id="avatar" />
      <Button  size="default" type="primary" @click="changeHead">换头像</Button>
      <p slot="title">
        <Icon type="person"></Icon>
        个人信息
      </p>
      <div>

        <!--姓名-->
        <div>
          <label>姓名:{{uid}}</label>
        </div>

        <!--身份-->
        <div>
          <label>身份:{{type}}</label>
        </div>

        <!--邮箱-->
        <div>
          <label>邮箱:{{Email}}</label>
        </div>

        <!--修改密码-->
        <div>
          <Button type="text" size="small" @click="showEditPassword">修改密码</Button>
        </div>

          <div>
            <Button type="text" style="width: 100px;" @click="cancelEditUserInfor">取消</Button>
            <Button type="primary" style="width: 100px;" :loading="save_loading" @click="saveEdit">保存</Button>
          </div>

      </div>
    </Card>

    <input type="file" style="margin-top: 100px;margin-left: 20%;visibility: hidden" id="touxiang" @change="fileChange($event)" multiple="false">

    <Modal v-model="editPasswordModal" :closable='false' :mask-closable=false :width="500">
      <h3 slot="header" style="color:#2D8CF0">修改密码</h3>
      <Form ref="editPasswordForm" :model="editPasswordForm" :label-width="100" label-position="right" :rules="passwordValidate">
        <FormItem label="邮箱" prop="oldPass" :error="oldPassError">
          <Input v-model="editPasswordForm.oldPass" placeholder="请输入注册时输入的邮箱" ></Input>
          <Button type="default">发送验证码</Button>
        </FormItem>
        <FormItem label="验证码" prop="newPass">
          <Input v-model="editPasswordForm.newPass" placeholder="请输入验证码" ></Input>
        </FormItem>
        <FormItem label="新密码" prop="rePass">
          <Input v-model="editPasswordForm.rePass" placeholder="请输入新密码" ></Input>
        </FormItem>
      </Form>
      <div slot="footer">
        <Button type="text" @click="cancelEditPass">取消</Button>
        <Button type="primary" :loading="savePassLoading" @click="saveEditPass">保存</Button>
      </div>
    </Modal>

  </div>
</template>

<script>
    export default {
      data () {
        const validateEmail = (rule, value, callback) => {
          var regEmail=new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$");
          if(value === ''){
            callback(new Error('请输入邮箱！'));
          }
          else if(!regEmail.test(value)){
            callback(new Error('邮箱格式有误！'));
          }
          else{
            var self=this;
            this.$http.get('api/LoginController/CheckEmail/'+self.editPasswordForm.oldPass)
              .then(function (response) {
                self.EmailExitable=response.data;
                console.log(self.EmailExitable)
                if(self.EmailExitable==true){
                  //邮箱已经存在可以修改密码
                  callback();
                }else{
                  //邮箱不存在不可以修改
                  callback("不存在该邮箱请重新输入")
                }
              })
          }
        };
        const validateIdentify = (rule, value, callback) => {
          if(value === ''){
            callback(new Error('请输入验证码！'));
          }else{
            callback();
          }
        };
        const validatePassword = (rule, value, callback) => {
          if(value === ''){
            callback(new Error('请输入密码！'));
          }
          else {
            callback();
          }
        };

        return {
          newTouXiang:'',
          userForm: {
            name: '',
            Email: ''
          },
          NowAvatol:"https://i.loli.net/2017/08/21/599a521472424.jpg",//现在的头像
          uid: '', // 登录用户的userId
          type:"",//身份，管理人员0,有工作人员1,发布人员2
          Email:"",//邮箱
          securityCode: '', // 验证码
          save_loading: false,
          identifyError: '', // 验证码错误
          editPasswordModal: false, // 修改密码模态框显示
          savePassLoading: false,
          oldPassError: '',
          identifyCodeRight: false, // 验证码是否正确
          hasGetIdentifyCode: false, // 是否点了获取验证码
          canGetIdentifyCode: false, // 是否可点获取验证码
          checkIdentifyCodeLoading: false,
          editPasswordForm: {
            oldPass: '',
            newPass: '',
            rePass: ''
          },
          passwordValidate: {
            oldPass: [
              { required:true,validator:validateEmail,trigger:'blur'},
            ],
            newPass: [
              { required: true,validator:validateIdentify,trigger:'blur'},
            ],
            rePass: [
              { required: true,validator:validatePassword,trigger:'blur'},
            ]
          },
          inputCodeVisible: false, // 显示填写验证码box
          initPhone: '',
          gettingIdentifyCodeBtnContent: '获取验证码' // “获取验证码”按钮的文字
        };
      },
      methods: {
        fileChange(el){

          let files = el.target.files;
          var file=files[0]
          console.log(file.name)
          let reader = new FileReader();
          let _this=this;
          reader.readAsDataURL(file);
          reader.onload = function () {
            //file.src = this.result;
            var base64 = this.result
            _this.newTouXiang = base64


            var m = _this;
            var t = 0;
            if (_this.type == "管理员") {
              t = 0;
            } else if (_this.type == "发起者") {
              t = 2;
            } else {
              t = 1;
            }
            var params = new URLSearchParams();
            params.append("userID", m.uid)
            params.append("type", t)
            params.append("base64", m.newTouXiang)
            _this.$http.post('api/LoginController/changeHead', params)
              .then(function (response) {
                console.log(response.data)
                m.NowAvatol = response.data;
              })
            //调用后端方法
          }

      },

        getIdentifyCode () {
          this.hasGetIdentifyCode = true;
          this.$refs['userForm'].validate((valid) => {
            if (valid) {
              this.canGetIdentifyCode = true;
              let timeLast = 60;
              let timer = setInterval(() => {
                if (timeLast >= 0) {
                  this.gettingIdentifyCodeBtnContent = timeLast + '秒后重试';
                  timeLast -= 1;
                } else {
                  clearInterval(timer);
                  this.gettingIdentifyCodeBtnContent = '获取验证码';
                  this.canGetIdentifyCode = false;
                }
              }, 1000);
              this.inputCodeVisible = true;
              // you can write ajax request here
            }
          });
        },

        changeHead(){
          var input = document.getElementById("touxiang")
          input.click()
        },
        showEditPassword () {
          this.editPasswordModal = true;
        },
        cancelEditUserInfor () {
          this.$store.commit('removeTag', 'ownspace_index');
          localStorage.pageOpenedList = JSON.stringify(this.$store.state.app.pageOpenedList);
          let lastPageName = '';
          if (this.$store.state.app.pageOpenedList.length > 1) {
            lastPageName = this.$store.state.app.pageOpenedList[1].name;
          } else {
            lastPageName = this.$store.state.app.pageOpenedList[0].name;
          }
          this.$router.push({
            name: lastPageName
          });
        },
        saveEdit () {
          this.$refs['userForm'].validate((valid) => {
            if (valid) {
              if (this.phoneHasChanged && this.userForm.cellphone !== this.initPhone) { // 手机号码修改过了而且修改之后的手机号和原来的不一样
                if (this.hasGetIdentifyCode) { // 判断是否点了获取验证码
                  if (this.identifyCodeRight) { // 判断验证码是否正确
                    this.saveInfoAjax();
                  } else {
                    this.$Message.error('验证码错误，请重新输入');
                  }
                } else {
                  this.$Message.warning('请先点击获取验证码');
                }
              } else {
                this.saveInfoAjax();
              }
            }
          });
        },
        cancelEditPass () {
          this.editPasswordModal = false;
        },
        saveEditPass () {
          var self=this
          this.$refs['editPasswordForm'].validate((valid) => {
            if (valid) {
              self.savePassLoading=true
              var that=self
              setTimeout(function () {
                that.savePassLoading = false
              },2000
              )
              // you can write ajax request here
            }
          });
        },
        cancelInputCodeBox () {
          this.inputCodeVisible = false;
          this.userForm.cellphone = this.initPhone;
        },
        submitCode () {
          let vm = this;
          vm.checkIdentifyCodeLoading = true;
          if (this.securityCode.length === 0) {
            this.$Message.error('请填写短信验证码');
          } else {
            setTimeout(() => {
              this.$Message.success('验证码正确');
              this.inputCodeVisible = false;
              this.checkIdentifyCodeLoading = false;
            }, 1000);
          }
        },
        hasChangePhone () {
          this.phoneHasChanged = true;
          this.hasGetIdentifyCode = false;
          this.identifyCodeRight = false;
        },
        saveInfoAjax () {
          this.save_loading = true;
          setTimeout(() => {
            this.$Message.success('保存成功');
            this.save_loading = false;
          }, 1000);
        }
      },
      created(){
        var self=this;
        this.type=window.localStorage.getItem("identity")
        this.uid=window.localStorage.getItem("userID")
        console.log(this.uid)
        //拿取头像调用后端方法
        this.$http.get('api/LoginController/GetUserInit/'+self.uid)
          .then(function (response) {

          })
      },
    }
</script>

<style scoped>

</style>
