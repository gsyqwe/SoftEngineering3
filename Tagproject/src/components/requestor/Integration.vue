<template >

  <div class="layout" id="layout">
    <Sider :style="{position: 'absolute', height: '200vh', left: 0, overflow: 'auto'}">
      <Menu active-name="1-2" theme="dark" width="auto" :open-names="['1']">
        <MenuItem name="1" @click.native="changeflagwhole">
          <Icon type="ios-navigate"></Icon>
          整体标注
        </MenuItem>
        <Submenu name="2">
          <template slot="title" >
            <Icon type="ios-keypad" @click.native="changeflagdivision"></Icon>
            区域划分
          </template>

          <Menu-item v-for="item in divison_name" :name="item" @click.native="sureItemId(item,2)">{{item}}</Menu-item>

        </Submenu>
        <Submenu name="3">
          <template slot="title">
            <Icon type="ios-analytics"></Icon>
            局部标注
          </template>

          <Menu-item v-for="item in label_name" :name="item" @click.native="sureItemId(item,3)">{{item}}</Menu-item>

        </Submenu>
      </Menu>
    </Sider>

    <Layout :style="{marginLeft: '200px'}">
      <div>
        <div style="margin-top: 10px;margin-left: 20%"></div>
        <div class="node"  id="background" style="width:55%; height:620px ; border: solid black;float: left;margin-left:5%;margin-top:20px;">
          <canvas  id="canvas"
                   width="800"
                   height="600">
          </canvas>
          <img :src="currentpicurl"  style="width: 100%;height: 100%;margin-top: -615px"/>

        </div >

        <textarea id="MissionOutput" v-model="MissionOutput" readonly autosize style="width: 200px;position: absolute;visibility: hidden"></textarea>

        <div style="margin-top:-400px;margin-left:67.5%;width:19%;height:612px; float: left;">
          <div>类型选择:
            <Select v-model="selected" style="width:50%;margin-left: 20%">
              <Option v-for="item in labellist":value="item" @click.native="getTagAll(item)">{{ item }}</Option>
            </Select>
          </div>
          <br>
          <br>
          <!--标注和描述的框-->
          <label>评分:<Rate allow-half v-model="valuehalf" style="margin-left: 60px"></Rate></label>

          <div width="5%" style="margin-left: 30%;margin-top: 50px">
            <Icon type="chevron-left" size="40" style="margin-left: 3%" @click.native="changeLeft"></Icon>

            <Icon type="chevron-right" size="40" style="margin-left:35%" @click.native="changeRight"></Icon>
          </div>

          <div width="45%" style="margin-left:20%">
            <Button type="primary" @click.native="add">取消</Button>

            <Button type="primary" style="margin-left: 5%" @click.native="SaveData">保存</Button>

            <Button type="primary" style="margin-left: 5%" @click.native="SubmitData">提交</Button>
          </div>
        </div>

      </div>
    </Layout>
  </div>
</template>
<script>
  import '../js/jQuery'
  import index from "../router";
  import login from "../js/login";
  export default {
    name: 'app',
    data() {
      return {
        currentpicurl:"",
        valuehalf:2.5,
        totalpoint:0,
        workerID:"",
        flag: 0,
        moving_id:"moving_box",
        active_id:"active_box",
        Rectstx: [], //矩阵的左上角x
        Rectsty: [], //矩阵的左上角y
        Rectenx: [], //右下角x
        Recteny: [], //右下角y
        x: [], //局部的x
        y: [], //局部的y
        i: 0,
        name: '',//保存标注
        description: '',//描述
        isAddable:0,//用来指示是新建或者是保存,0是新建，1是修改
        index:0,//指示到了第几张
        indexofTag:0,//用来指示当前到第几张标注
        pictureurl:[],//保存了全部的Picture，然后根据index来拿取
        RecordID:"",//ID
        MissionOutput:"",//用来显示所有的信息
        Draw_Color:"",//画图颜色
        Draw_Size:"",//画图大小
        Font_Size:"",//字体大小
        Font_Family:"",//字体
        labellist:[],//类型
        selected:"",//选择后的类型，根据类型取
        AreaTagId:[],//保存从后端拿上来的AreaTagId
        CircleTagId:[],//保存CircleTagId
        whole_name:"",//初始化的时候拿到全局标注
        whole_description:"",//初始化的时候拿到全局描述
        divison_name:[],//区域划分的标注
        divison_description:[],//区域划分的描述
        label_name:[],//局部标注
        label_description:[],//局部描述
      }
    },
    methods: {
      changeflagZero:function(){
        this.flag=0;
        this.label_name.splice(0,this.label_name.length);
        this.label_description.splice(0,this.label_description.length);
        this.divison_name.splice(0,this.divison_name.length);
        this.divison_description.splice(0,this.divison_description.length);
      },
      changeflagwhole: function () {
        this.flag = 1;
        var m = document.getElementById("canvas");
        m.height = m.height;
        this.name="";
        this.description="";
        this.clear();
        this.name=this.whole_name;
        this.description=this.whole_description;
      },

      changeflagdivision: function () {
        this.flag = 2;
        var m = document.getElementById("canvas");
        m.height = m.height;
        this.name="";
        this.description="";
        this.clear();
      },

      changeflaglabel: function () {
        this.flag = 3;
        var m = document.getElementById("canvas");
        m.height = m.height;
        this.name="";
        this.description="";
        this.clear();
      },

      //根据类别拿取全部的Area division_name,division_description,AreaTagId Circle label_name,label_description,CircleTagId
      getTagAll:function(value){
        var self=this;
        this.$http.get('api/webwork/getLabelAndId/'+self.userID+"/"+self.RecordID+"/"+value,{
          params:{
            pictureurl:self.currentpicurl
          }
        }).then(function(response){
          var temp=new Array;
          temp=response.data.split(";");
          if(temp[0]!="disA"){
            self.divison_name=temp[0].split(",");
          }else{
            self.divison_name.splice(0,self.divison_name.length);
          }
          if(temp[1]!="disAd"){
            self.divison_description=temp[1].split(",");
          }else{
            self.divison_description.splice(0,self.divison_description.length);
          }
          if(temp[2]!="disAT"){
            self.AreaTagId=temp[2].split(",");
          }else{
            self.AreaTagId.splice(0,self.AreaTagId.length);
          }
          if(temp[3]!="disL"){
            self.label_name=temp[3].split(",");
          }else{
            self.label_name.splice(0,self.label_name.length);
          }
          if(temp[4]!="disLd"){
            self.label_description=temp[4].split(",");
          }else{
            self.label_description.splice(0,self.label_description.length);
          }
          if(temp[5]!="disLT"){
            self.CircleTagId=temp[5].split(",");
          }else{
            self.CircleTagId.splice(0,self.CircleTagId.length);
          }
        })
      },

      //初始化的算法
      drawinit: function () {
        this.isAddable=1;//表明是改变
        this.clear();
        var layout=document.getElementById("layout")
        var canvas=document.getElementById("canvas")
        //然后初始化
        if (this.flag == 1) {
          var m = document.getElementById("canvas");
          m.height = m.height;
          this.name = "";
          this.description = "";
          this.name=this.whole_name;
          this.description=this.whole_description;
        } else if (this.flag == 2) {

          //进行清空
          this.clear();
          //判断是新建还是修改
          //先找到是第几个即找到itemID
          if(this.isAddable==0){
            //这是新建
            this.itemID=this.divison_name.length;
          }else {
            //这是需要初始化
            //需要找到相对应的itemID
            //然后将里面的点坐标移到Rectstx[]等数组中
            //进行初始化
            var m=this;
            this.Rectstx.splice(0,this.Rectstx.length);
            this.Rectsty.splice(0,this.Rectsty.length);
            this.Rectenx.splice(0,this.Rectenx.length);
            this.Recteny.splice(0,this.Recteny.length);
            this.$http.get(
              'api/webwork/getdivision/'+m.AreaTagId[m.indexofTag]
            )
              .then(function (response) {
                //在拿drawColor,drawSize,fontSize,fontFamily
                //做解析将所有的点拿进来
                //在拿drawColor,drawSize,fontSize,fontFamily
                //做解析将所有的点拿进来
                var result=new Array;
                result=response.data.split(";");
                console.log(result)
                m.name=result[0];
                m.description=result[1];
                m.Rectstx.push(result[2].substring(1,result[2].length-1));
                m.Rectsty.push(result[3].substring(1,result[3].length-1));
                m.Rectenx.push(result[4].substring(1,result[4].length-1));
                m.Recteny.push(result[5].substring(1,result[5].length-1));
                m.Draw_Color=result[6];
                m.Draw_Size=result[7];
                m.Font_Size=result[8];
                m.Font_Family=result[9];
                //画个矩形
                m.i=m.Rectstx.length-1;
                m.onflag=1;
                for (var number = 0; number <= m.i; number++) {
                  var startx = m.Rectstx[number];
                  var starty = m.Rectsty[number];
                  var endx = m.Rectenx[number];
                  var endy = m.Recteny[number];
                  var active_box = document.createElement("div");
                  active_box.id = m.moving_id + number;
                  active_box.className = "box";
                  active_box.style.width = endx - startx + 'px';
                  active_box.style.height = endy - starty + 'px';
                  active_box.style.top = starty + 'px';
                  active_box.style.left = startx + 'px';
                  active_box.style.right = endx + 'px';
                  active_box.style.bottom = endy + 'px';
                  active_box.style.border=parseInt(m.Draw_Size)+'px'+' '+"solid"+' '+m.Draw_Color;
                  //设置line在右下角
                  var locatex,locatey;
                  if(startx>endx){
                    locatex=startx;
                  }else {
                    locatex = endx;
                  }
                  if(starty>endy){
                    locatey=starty;
                  }else{
                    locatey=endy;
                  }
                  //创建Line
                  var line=document.createElement("div");
                  line.id="line";
                  line.className="line";
                  line.style.borderBottom=parseInt(m.Draw_Size)+'px'+' '+"solid"+' '+m.Draw_Color;
                  //设置line的位置...失败
                  line.style.left=parseInt(locatex)+parseInt(15)+'px';
                  line.style.top=parseInt(locatey)-56+'px';
                  //设置MissionOutput的输入的位置
                  var MissionOutput=document.getElementById("MissionOutput");
                  MissionOutput.style.border=parseInt(m.Draw_Size)+'px'+' '+"solid"+' '+m.Draw_Color;
                  MissionOutput.style.left=parseInt(locatex)+56+'px';
                  MissionOutput.style.top=parseInt(locatey)-80-layout.offsetTop+'px';
                  MissionOutput.style.zIndex="9999";
                  MissionOutput.style.visibility="visible"
                  //设置输入框的大小和颜色
                  //设置字体和大小
                  //设定内容
                  m.MissionOutput=m.name+"\n"+m.description;
                  //显示MissionOutput
                  document.body.appendChild(line);
                  document.body.appendChild(active_box);
                }
              })
              .catch(function (error) {
                alert(error)
              })
          }
        } else if (this.flag == 3) {
          if (this.isAddable == 0) {
            //这是新建
            this.itemID=this.label_name.length;
          } else {
            //先得到itemID
            //然后进行得到
            var m=this;
            this.x.splice(0,this.x.length);
            this.y.splice(0,this.y.length);
            this.$http.get(
              'api/webwork/getlabel/'+m.CircleTagId[m.indexofTag]
            )
              .then(function (response) {
                //拿取局部标注的drawSize,drawColor,fontSize,fontFamily
                var result=new Array;
                result=response.data.split(";");
                m.name=result[0]
                m.description=result[1]
                var xlist=result[2].split(",");
                var ylist=result[3].split(",");
                m.Draw_Color=result[4];
                m.Draw_Size=result[5];
                m.Font_Family=result[6];
                m.Font_Size=result[7];
                for(var num=0;num<xlist.length;num++){
                  m.x.push(xlist[num]);
                  m.y.push(ylist[num]);
                }
                m.i=m.x.length-1;
                var canvas=document.getElementById("canvas");
                var ctx=canvas.getContext('2d');
                ctx.strokeStyle=m.Draw_Color;
                ctx.lineWidth=parseInt(m.Draw_Size);
                ctx.moveTo(m.x[0],m.y[0]);
                for (var number = 1; number <= m.i; number++) {
                  var startx2 = m.x[number];
                  var starty2 = m.y[number];
                  ctx.lineTo(startx2,starty2);
                  ctx.stroke();
                }
                //得到locatex和locatey
                var locatex,locatey;
                locatex=m.x[0].replace("[","");
                locatey=m.y[0].replace("[","");
                for(var number=1;number<=m.i;number++){
                  m.x[number]=m.x[number].replace("]","");
                  m.y[number]=m.y[number].replace("]","");
                  if(locatex<parseInt(m.x[number])){
                    locatex=parseInt(m.x[number])
                    locatey=parseInt(m.y[number])
                  }
                }
                console.log(locatex+" "+locatey)
                //显示一下名称和描述
                m.name=m.label_name[m.indexofTag];
                m.description=m.label_description[m.indexofTag];
                //设置字体和字体大小
                m.MissionOutput=m.name+"\n"+m.description;
                var MissionOutput=document.getElementById("MissionOutput");
                MissionOutput.style.border=parseInt(m.Draw_Size)+'px'+' '+"solid"+' '+m.Draw_Color;
                MissionOutput.style.left=parseInt(locatex)+canvas.offsetLeft+56+'px';
                MissionOutput.style.top=parseInt(locatey)-220-canvas.offsetTop+layout.offsetTop+'px';
                MissionOutput.style.zIndex="9999";
                MissionOutput.style.visibility="visible";
                //创建Line
                var line=document.createElement("div");
                line.id="line";
                line.className="line";
                line.style.borderBottom=parseInt(m.Draw_Size)+'px'+' '+"solid"+' '+m.Draw_Color;
                //设置line的位置...失败
                line.style.left=parseInt(locatex)+parseInt(15)+canvas.offsetLeft+'px';
                line.style.top=parseInt(locatey)-15+layout.offsetTop+'px';
                //显示MissionOutput
                document.body.appendChild(line);
              })
              .catch(function (error) {
                alert(error)
              })
          }
        }
      },

      //上一张
      changeLeft: function () {
        this.changeflagZero();
        this.clear()
        var m = document.getElementById("canvas");
        m.height = m.height;
        this.name = "";
        this.description = "";
        this.clear();
        if(this.index==0){
          this.$Message.warning({
            title:"警告",
            content:"已经是第一张",
            duration:3,
          });
        }else {
          this.Rectstx.splice(0,this.Rectstx.length);
          this.Rectsty.splice(0,this.Rectsty.length);
          this.Rectenx.splice(0,this.Rectenx.length);
          this.Recteny.splice(0,this.Recteny.length);
          this.x.splice(0,this.x.length);
          this.x.splice(0,this.y.length);
          this.index=this.index-1;
          this.currentpicurl=this.pictureurl[this.index]
        }
      },

      //下一张
      changeRight: function () {
        this.changeflagZero()
        this.clear()
        var m = document.getElementById("canvas");
        m.height = m.height;
        this.name = "";
        this.description = "";
        this.clear();
        if(this.index==this.pictureurl.length-1){
          this.$Message.warning({
            title:"警告",
            content:"已经是最后一张",
            duration:3,
          });
        }else {
          //加上新的积分
          this.totalpoint=this.totalpoint+this.valuehalf
          this.index = this.index + 1;
          this.Rectstx.splice(0,this.Rectstx.length);
          this.Rectsty.splice(0,this.Rectsty.length);
          this.Rectenx.splice(0,this.Rectenx.length);
          this.Recteny.splice(0,this.Recteny.length);
          this.x.splice(0,this.x.length);
          this.x.splice(0,this.y.length);
          this.currentpicurl=this.pictureurl[this.index]
        }
      },

      //提交的方法
      SubmitData:function(){
        if(this.index<this.pictureurl.length-1)
          this.$Message.success({
            title:"成功",
            content:"请继续评审下一张",
            duration:3,
          });
        else {
          var m = this;
          this.clear();
          var userID=m.userID
          this.$http.get(
            'api/requestor/check/'+userID+'/'+m.RecordID+'/'+m.totalpoint,

          )
            .then(function (response) {
              m.$Message.success({
                title:"成功",
                content:"评审成功",
                duration:3,
              });
              //路由跳转
              if(m.index==(m.pictureurl.length-1)){
                m.clear();
                //跳转
                m.$router.push({
                  name:'missioncheck'
                })
              }
            })
            .catch(function (error) {
              console.log(error)
            })
        }
      },
      clear: function () {
        this.MissionOutput=false;
        var m = document.getElementById("canvas");
        m.height = m.height;
        this.name = "";
        this.description = "";
        for (var number = this.Rectstx.length-1; number >= 0; number--) {
          var a = document.getElementById(this.moving_id + number);
          if (a !== null) {
            document.body.removeChild(a);
          }
          var b = document.getElementById(this.active_id + number);
          if (b !== null) {
            document.body.removeChild(b);
          }
        }
        for(var number=this.x.length;number>=0;number--){
          var a=document.getElementById(this.moving_circle_id+number);
          if(a!=null){
            document.body.removeChild(a);
          }
          var b=document.getElementById(this.active_circle_id+number);
          if(b!=null){
            document.body.removeChild(b);
          }
        }
        var line=document.getElementById("line");
        if(line!=null){
          document.body.removeChild(line);
        }
      },

      //点击显示的方法
      sureItemId:function(value,flag){
        this.flag=flag;
        if(flag==2){
          for(var number=0;number<this.divison_name.length;number++){
            if(value==this.divison_name[number]){
              this.indexofTag=number;
              break;
            }
          }

        }else if(flag==3){
          for(var number=0;number<this.label_name.length;number++){
            if(value==this.label_name[number]){
              this.indexofTag=number;
              break;
            }
          }
        }
        this.drawinit();
      },

    },

    created(){
      this.userID=this.$route.params.userID;
      this.RecordID=this.$route.params.taskID;
      var m=this;
      this.$http.get('api/webwork/init/'+m.RecordID
      ).
      then(function (response) {
        //把数据加载入data中
        //得到全部的pictureurl，然后把pictureurl载入data图片
        response.data=response.data.substring(1,response.data.length-1);
        m.pictureurl=response.data.split(",");
        m.currentpicurl=m.pictureurl[0];
        //调用这个方法
        m.$http.get('api/webwork/getOptions/'+m.RecordID)
          .then(function (response) {
            //拿取全部的类型
            var temp=new Array;
            temp=response.data;
            m.labellist=temp.split(",");
            var can=document.getElementById("canvas")
            var dos=document.getElementById("background")
            can.width=dos.offsetWidth
          })
          .catch(function (error) {
            alert(error)
          })
      })
        .catch(function (error) {
          alert(error)
        })
    }
  }
</script>
<style>
  .box {
    width: 0px;
    height: 0px;
    position: absolute;
    opacity: 0.5;
    cursor: move;
    border: 5px solid black;
  }
  .circle {
    width:10px;
    height:10px;
    border-radius:25px;
    background-color: black;
    position: absolute;
  }

  .line {
    height:80px;
    border-bottom: 2px solid black;
    width: 80px;
    position: absolute;
    transform:rotate(135deg);
  }
  .layout{
    border: 1px solid #d7dde4;
    background: #f5f7f9;
    position: relative;
    border-radius: 4px;
    overflow: hidden;
  }
  .layout-header-bar{
    background: #fff;
    box-shadow: 0 1px 1px rgba(0,0,0,.1);
  }
  .swiper-inner {

    width: 100%;

    height: 400px;

    padding-top: 50px;

    padding-bottom: 50px;

  }

  .swiper-slide {

    background-position: center;

    background-size: cover;

    width: 300px;

    height: 300px;

  }
</style>
