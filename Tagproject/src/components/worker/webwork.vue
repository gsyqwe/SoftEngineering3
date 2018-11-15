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
            <Icon type="ios-keypad" ></Icon>
            区域划分
          </template>

          <MenuItem v-for="(item,index) in divison_name" :name="index" @click.native="sureItemId(item,2)">
            {{item}}
            <Icon type="close" color="red" style="float: right" @click.native="wantodelete(item,2)"></Icon>
          </MenuItem>

        </Submenu>
        <Submenu name="3">
          <template slot="title">
            <Icon type="ios-analytics"></Icon>
            局部标注
          </template>

          <MenuItem v-for="item in label_name" :name="item" @click.native="sureItemId(item,3)">{{item}}
          <Icon type="close" color="red" style="float: right" @click.native="wantodelete(item,3)"></Icon>
          </MenuItem>
        </Submenu>
      </Menu>
    </Sider>

    <Layout :style="{marginLeft: '200px'}">
      <div @mousedown="canvasdraw">

        <Modal
          title="Common Modal dialog box title"
          v-model="model1"
          @on-ok="dis"
          @on-cancle="cancle">
          <p>是否要删除</p>
        </Modal>

        <div style="margin-top: 10px;margin-left: 20%">{{tip}}</div>
        <br>

        <div class="node"  id="background" style="width:55%; height:620px ; border: solid black;float: left;margin-left:5%;margin-top:20px;">

          <canvas  id="canvas"
                   width="800"
                   height="600">
          </canvas>

          <img :src="currentpicurl"  style="width: 100%;height: 100%;margin-top: -655px"/>

        </div >



        <div style="width:30%;height: 200px;float: right;margin-top: 50px;margin-right: 5%">
          <fieldset style="margin-left: 2%">
            <legend style="margin-top: 0px">工具栏</legend>

            <div style="width:30%;float:left;margin-left: 5%">
              <fieldset style="margin-left: 2%">
                <legend style="font-size:20px"></legend>
                <span style="float: left;margin-top: 6px;">线条粗细: </span>
                <Select v-model="Draw_Size" size="small" style="width:50%;margin-top: 4px">
                  <Option v-for="item in cityList" :value="item.value" :key="item.value">{{ item.label }}</Option>
                </Select>
                <div style="border-top:1px dashed gray;margin-top:8px;padding-top:8px;">
          <span style="width:40%">
          选择颜色:
          </span>
                  <div style="margin-top: -22px;margin-left:42%;width:45%">
                    <ColorPicker v-model="Draw_Color" recommend size="small"/>
                  </div>
                </div>
              </fieldset>
            </div>

            <div style="margin-left: 10%;height:90px;float: left;width: 32% ">
              <fieldset style="height: 70px">
                <legend style="font-size: 20px"></legend>
                <span><span style="margin-top: 6px;">字体大小: </span>
	        	 <Select v-model="Font_Size" size="small" style="width:50%;margin-top: 2px">
          <Option v-for="item in FontList" :value="item.value" :key="item.value" @click.native="Font_Size_Change">{{ item.label }}</Option>
        </Select>
	             </span>
                <br>
                <span><span style="margin-top: 5px">字体选择:</span>
	        		 <Select v-model="Font_Family" size="small" style="width:50%;margin-top: 2px">
          <Option v-for="item in Font_FamilyList" :value="item.value" :key="item.value" @click.native="Font_Family_Change">{{ item.label }}</Option>
        </Select>
	        </span>
              </fieldset>
            </div>

            <div>
              <Button type="info" style="margin-left: 2%" @click.native="clear">清空</Button>
              <br>
              <br>

              <Button type="info" style="margin-left: 2%" @click.native="GetAreaAI">自动标注</Button>
            </div>

          </fieldset>
        </div>

        <div>
          <Select v-model="selected" style="width:10%;margin-left: 10%;margin-top: -80px">
            <Option v-for="item in labellist":value="item" @click.native="getTagAll(item)">{{ item }}</Option>
          </Select>
        </div>

        <div style="margin-top: -30px;margin-left: 20%">
          <Button type="info" style="margin-left: 5%" @click.native="changeflagwhole">全局标注</Button>

          <Button type="info" style="margin-left: 2%" @click.native="changeflagdivision">区域划分</Button>

          <Button type="info" style="margin-left: 2%" @click.native="changeflaglabel">局部标注</Button>
        </div>

        <div style="margin-top:-380px;margin-left:67.5%;width:19%;height:612px; float: left;">
          <br>
          <br>
          <!--标注和描述的框-->
          <Input id="nameinput" v-model="name"  type="textarea" :autosize="{minRows:2,maxRows:2}" clearable placeholder="添加标注" style="border:solid black;font-size: 2px;font-family: 仿宋"></Input><br>
          <Input id="description" v-model="description" type="textarea" :autosize="{minRows: 5,maxRows: 5}" clearable placeholder="添加描述"  style="border:solid black;font-size: 2px;font-family: 仿宋"></Input>
          <br>

          <div width="5%" style="margin-left: 30%;margin-top: 50px">
            <Icon type="chevron-left" size="40" style="margin-left: 3%" @click.native="changeLeft"></Icon>

            <Icon type="chevron-right" size="40" style="margin-left:35%" @click.native="changeRight"></Icon>
          </div>

          <div width="45%" style="margin-left:15%">
            <Button type="primary" @click.native="add">取消</Button>

            <Button type="primary" style="margin-left: 5%" @click.native="SaveData">保存</Button>

            <Button type="primary" style="margin-left: 5%" @click.native="IsSubmit">提交</Button>
          </div>
        </div>

        <Modal
          title="Common Modal dialog box title"
          v-model="model10"
          @on-ok="SubmitData"
          @on-cancle="cancle">
          <p>是否要提交</p>
        </Modal>

      </div>

      <div style="width: 70%;margin-top: -200px">

        <div class="md-subhead">

          <span style="font-size: 20px">图片显示:</span>


        </div>

        <swiper id="swiper" :options="swiperOption" style="width: 55%;height: 60%" >

          <swiper-slide v-for="item in pictureurl" >
            <img :src="item" style="width: 100%;height: 100%;"/>
          </swiper-slide>

          <div class="swiper-pagination" slot="pagination"></div>

        </swiper>


      </div>


    </Layout>
  </div>
</template>
<script>
  import '../../js/jQuery'
  export default {
    name: 'app',
    data() {
      let _this=this;
      return {
        model1:false,
        model10:false,
        currentpicurl:'http://localhost:9900/1.jpg',
        //选择画图大小
        cityList: [
          {
            value: '1px',
            label: '1px'
          },
          {
            value: '2px',
            label: '2px'
          },
          {
            value: '3px',
            label: '3px'
          },
          {
            value: '4px',
            label: '4px'
          },
          {
            value: '5px',
            label: '5px'
          },
          {
            value: '6px',
            label: '6px'
          }
        ],
        Draw_Size:"2px",
        //字体大小
        FontList: [
          {
            value: '1px',
            label: '1px'
          },
          {
            value: '2px',
            label: '2px'
          },
          {
            value: '3px',
            label: '3px'
          },
          {
            value: '4px',
            label: '4px'
          },
          {
            value: '5px',
            label: '5px'
          },
          {
            value: '6px',
            label: '6px'
          }
        ],
        Font_Size:"2px",
        //选择字体
        Font_FamilyList: [
          {
            value: '宋体',
            label: '宋体'
          },
          {
            value: '微软雅黑',
            label: '微软雅黑'
          },
          {
            value: '仿宋',
            label: '仿宋'
          },
        ],
        Font_Family:"仿宋",//等之后给Font_Family,Font_Size,Draw_Color,Draw_Size均设置默认值
        Draw_Color:"#000000",//画图颜色
        labellist:[],//类型
        selected:"",//选择后的类型，根据类型取
        AreaTagId:[],//保存从后端拿上来的AreaTagId
        CircleTagId:[],//保存CircleTagId
        flag: 0,
        onflag:0,//用来确保只能画一个框
        onlabelflag:0,
        labelflag:0,//用来确保只能画一个label一次
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
        whole_name:"",//初始化的时候拿到全局标注
        whole_description:"",//初始化的时候拿到全局描述
        whole_Font_Size:"",
        whole_Font_Family:"",
        divison_name:[],//区域划分的标注
        divison_description:[],//区域划分的描述
        label_name:[],//局部标注
        label_description:[],//局部描述
        tip:"",//提醒
        //swiper
        swiperOption: {

          effect: 'coverflow',

          grabCursor: true,

          centeredSlides: true,

          slidesPerView: 'auto',

          slideToClickedSlide: true,

          preventLinksPropagation : false,


          on: {
            slideChangeTransitionStart: function(){
              _this.index=this.activeIndex;
              _this.changeImage();
            },

            // slideNextTransitionEnd: function(){
            //   alert('切换结束了');
            // },
            //
            touchEnd: function(){
              _this.index=this.activeIndex;
              _this.changeImage();
            },

            // slideChangeTransitionEnd: function(){
            //   alert(this.activeIndex);//切换结束时，告诉我现在是第几个slide
            // },

          },


          coverflowEffect: {

            rotate: 50,

            stretch: 0,

            depth: 100,

            modifier: 1,

            slideShadows : true

          },

          pagination: {

            el: '.swiper-pagination'

          }

        }

      }
    },
    methods: {
      GetAreaAI:function(){
        var m=this;
        this.changeflagdivision();
        this.$http.get(
          'api/webwork/getAreaAI',{
            params:{
              pictureurl:m.currentpicurl
            }
          })
          .then(function(response){

            var layout=document.getElementById("layout");

            m.Rectstx.splice(0,m.Rectstx.length)
            m.Rectsty.splice(0,m.Rectsty.length)
            m.Rectenx.splice(0,m.Rectenx.length)
            m.Recteny.splice(0,m.Recteny.length)

            var width=response.data.originWidth;
            var height=response.data.originHeight;
            var startx=response.data.result.left;
            var starty=response.data.result.top;
            var kuangwidth=response.data.result.width;
            var kuangheight=response.data.result.height;

            var dos=document.getElementById("background");
            var bili=width/dos.offsetWidth;
            kuangwidth=kuangwidth/bili;
            var hili=height/dos.offsetHeight;
            kuangheight=kuangheight/hili;
            startx=startx/bili+dos.offsetLeft;

            starty=starty/hili+dos.offsetTop+layout.offsetTop;

            var active_box = document.createElement("div");
            active_box.id = m.active_id + m.i;
            active_box.className = "box";
            active_box.style.top = starty + 'px';
            active_box.style.left = startx + 'px';
            active_box.style.width=kuangwidth+'px';
            active_box.style.height=kuangheight+'px';
            m.onflag=1;
            m.flag=2;
            m.Rectstx.push(startx);
            m.Rectsty.push(starty);
            active_box.style.border=parseInt(m.Draw_Size)+'px'+' '+"solid"+' '+m.Draw_Color;
            document.body.appendChild(active_box);
            var endx=parseInt(startx)+parseInt(kuangwidth)
            var endy=parseInt(starty)+parseInt(kuangheight)
            m.Rectenx.push(endx)
            m.Recteny.push(endy)
          })
      },
      //改变了Font_Size
      Font_Size_Change:function(){
        var name_input=document.getElementById("nameinput");
        var description=document.getElementById("description");
        name_input.style.fontSize=this.Font_Size;
        name_input.style.fontFamily=this.Font_Family;
        description.style.fontSize=this.Font_Size;
        description.style.fontFamily=this.Font_Family;
      },
      //改变了Font_Family
      Font_Family_Change:function(){
        var name_input=document.getElementById("nameinput");
        var description=document.getElementById("description");
        name_input.style.fontSize=this.Font_Size;
        name_input.style.fontFamily=this.Font_Family;
        description.style.fontSize=this.Font_Size;
        description.style.fontFamily=this.Font_Family;
      },
      //变回初始状态
      changeflag0:function(){
        this.flag=0;
        this.isAddable=0;
      },
      //整体标注状态
      changeflagwhole: function () {
        this.tip="当前正在进行整体标注";
        this.flag = 1;
        var m = document.getElementById("canvas");
        m.height = m.height;
        this.name="";
        this.description="";
        this.clear();
        this.name=this.whole_name;
        this.description=this.whole_description;
        var that=this;
        this.$http.get(
          'api/webwork/getwholeextra/'+window.localStorage.getItem("userID")+"/"+that.RecordID,{
            params:{
              pictureurl:that.pictureurl[that.index],
            }
          }
        ).then(function(response){
          var tmp=response.data;
          var temp=new Array;
          temp=tmp.split(",");
          that.Font_Size=temp[0].substring(1,temp[0].length-1);
          that.Font_Family=temp[1].substring(1,temp[1].length-1);
        })
      },
      //区域标注状态
      changeflagdivision: function () {
        this.tip="当前正在新建区域标注";
        this.flag = 2;
        this.isAddable=0;
        var m = document.getElementById("canvas");
        m.height = m.height;
        this.name="";
        this.description="";
        this.clear();
      },
      //局部标注状态
      changeflaglabel: function () {
        this.flag = 3;
        this.isAddable=0;
        var m = document.getElementById("canvas");
        m.height = m.height;
        this.name="";
        this.description="";
        this.clear();
      },
      //画图方法
      canvasdraw: function () {
        var m = this;
        var can = document.getElementById("canvas");
        if (this.flag == 1) {

        } else if (this.flag == 2) {
          // startX, startY 为鼠标点击时初始坐标
          // diffX, diffY 为鼠标初始坐标与 box 左上角坐标之差，用于拖动
          var startX, startY, diffX, diffY;
          var pianyi=document.getElementById("background")
          var layout=document.getElementById("layout")
          var startheight=parseInt(pianyi.offsetTop)+parseInt(layout.offsetTop)
          // 是否拖动，初始为 false
          var dragging = false;
          var targeti = 0;
          //做一个保存要删除的变量
          var wantodelete;
          // 鼠标按下
          document.onmousedown = function (e) {
            if (m.flag == 2) {
              startX = e.pageX;
              startY = e.pageY;
              if (pianyi.offsetLeft<=startX&&startheight<=startY&&startX<=(pianyi.offsetLeft+parseInt(pianyi.offsetWidth))
                &&startY<=(pianyi.offsetHeight+startheight)) {
                // 如果鼠标在 box 上被按下
                if (e.target.className.match(/box/)) {
                  //保存删除
                  wantodelete=e.target;
                  // 允许拖动
                  dragging = true;
                  var c = e.target.id;
                  targeti = c.substring(10, (c.length));
                  e.target.id = m.moving_id + targeti;
                  //改变矩形的颜色和大小
                  var mn=document.getElementById(m.moving_id + targeti);
                  mn.style.border=parseInt(m.Draw_Size)+'px'+" "+"solid";
                  mn.style.borderColor=m.Draw_Color;
                  // 计算坐标差值
                  diffX = startX - e.target.offsetLeft;
                  diffY = startY - e.target.offsetTop;
                }
                else if(m.onflag==0){
                  // 在页面创建 box
                  var active_box = document.createElement("div");
                  active_box.id = m.active_id + m.i;
                  active_box.className = "box";
                  active_box.style.top = startY + 'px';
                  active_box.style.left = startX + 'px';
                  active_box.style.border=parseInt(m.Draw_Size)+'px'+" "+"solid";
                  active_box.style.borderColor=m.Draw_Color;
                  document.body.appendChild(active_box);
                  active_box = null;
                  m.Rectstx.push(startX);
                  m.Rectsty.push(startY);
                }
              }
            }

          };
          // 鼠标移动
          document.onmousemove = function (e) {
            if (m.flag == 2) {
              // 更新 box 尺寸
              if (document.getElementById(m.active_id + m.i) !== null&&m.onflag==0) {
                var ab = document.getElementById(m.active_id + m.i);
                var left = e.pageX - startX;
                var top = e.pageY - startY;
                ab.style.width = left + 'px';
                ab.style.height = top + 'px';
              }
              // 移动，更新 box 坐标
              if (document.getElementById(m.moving_id + targeti) !== null && dragging) {
                var top = e.pageY - diffY;
                var left = e.pageX - diffX;
                var mb = document.getElementById(m.moving_id + targeti);
                if (pianyi.offsetLeft<=left&&startheight<=top&&
                  (left+parseInt(mb.style.width))<=(pianyi.offsetLeft+parseInt(pianyi.offsetWidth))
                  &&(top+parseInt(mb.style.height))<=(pianyi.offsetHeight+startheight)) {
                  mb.style.top = top + 'px';
                  mb.style.left = left + 'px';
                  m.Rectstx[targeti] = parseInt(mb.style.left);
                  m.Rectsty[targeti] = parseInt(mb.style.top);
                  m.Rectenx[targeti] = parseInt(parseInt(mb.style.width) + parseInt(mb.style.left));
                  m.Recteny[targeti] = parseInt(parseInt(mb.style.height) + parseInt(mb.style.top));
                }
              }
            }
          };
          // 鼠标抬起
          document.onmouseup = function (e) {
            if (m.flag == 2) {
              // 禁止拖动
              dragging = false;
              if (document.getElementById(m.active_id + m.i) !== null) {
                var ab = document.getElementById(m.active_id + m.i);
                // 如果长宽均小于 3px，移除 box
                if (ab.offsetWidth < 3 || ab.offsetHeight < 3) {
                  document.body.removeChild(ab);
                }else if(m.onflag==0){
                  m.i = m.i + 1;
                  m.Rectenx.push(e.pageX);
                  m.Recteny.push(e.pageY);
                  m.onflag=1;
                }
                if(pianyi.offsetLeft<=ab.offsetLeft&&startheight<=ab.offsetTop&&
                  (ab.offsetLeft+parseInt(ab.offsetWidth))<=(pianyi.offsetLeft+parseInt(pianyi.offsetWidth))
                  &&(ab.offsetTop+parseInt(ab.offsetHeight)<=(startheight+parseInt(pianyi.offsetHeight)))){

                }else{
                  m.i=0;
                  m.Rectstx.splice(0,m.Rectstx.length);
                  m.Rectsty.splice(0,m.Rectsty.length);
                  m.Rectenx.splice(0,m.Rectenx.length);
                  m.Recteny.splice(0,m.Recteny.length);
                  m.onflag=0;
                  document.body.removeChild(ab);
                }

              }
            }
          };
          //删除的键盘事件
          document.onkeydown=function(e){
            if(m.flag==2){
              var k=e.keyCode||e.which;
              if(k==46){
                m.deleteRect(wantodelete);
                m.onflag=0;
                m.i=0;
              }
            }
          };
        }
        else if (this.flag == 3) {
          var m=this;
          var can=document.getElementById("canvas")
          var ctx=can.getContext('2d')
          ctx.lineWidth=parseInt(m.Draw_Size);
          ctx.strokeStyle=m.Draw_Color;
          m.onlabelflag=0;
          document.onmousedown = function (e) {
            if (m.flag == 3&&m.labelflag==0&&m.onlabelflag==0) {
              var startX=e.offsetX;
              var startY=e.offsetY;
              ctx.moveTo(startX,startY);
              m.x.push(startX);
              m.y.push(startY);
            }
            document.onmousemove = function (e) {
              if (m.flag == 3&&m.labelflag==0&&m.onlabelflag==0) {
                var startX2=e.offsetX;
                var startY2=e.offsetY;
                ctx.lineTo(startX2,startY2);
                ctx.stroke();
                m.x.push(startX2);
                m.y.push(startY2);
              }
            }

            document.onmouseup = function (e) {
              if (m.flag == 3&&m.labelflag==0&&m.onlabelflag==0) {
                document.onmousemove = null;
                document.onmouseup = null;
                m.labelflag=1;
              }
            }
          }
        }
      },
      //点击删除矩形方法
      deleteRect:function (wantodelete) {
        if(wantodelete==null){
          this.$Modal.warning({
            title: "警告",
            content: "请先选择一个标注",
          });
        }else {
          document.body.removeChild(wantodelete);
          //把后面的id提前
          var wantoi=wantodelete.id;
          wantoi=wantoi.substring(10,wantoi.length);
          //删除x和y的对应的那个值
          for(var number=parseInt(wantoi);number<this.Rectstx.length-1;number++){
            this.Rectstx[number]=this.Rectstx[parseInt(number)+1];
            this.Rectsty[number]=this.Rectsty[parseInt(number)+1];
            this.Rectenx[number]=this.Rectenx[parseInt(number)+1];
            this.Recteny[number]=this.Recteny[parseInt(number)+1];
          }
          for(var number=parseInt(wantoi)+1;number<this.i;number++){
            var a=document.getElementById(this.moving_id+number);
            if(a!=null){
              a.id=this.moving_id+(parseInt(number)-1);
            }
            var b=document.getElementById(this.active_id+number);
            if(b!=null){
              b.id=this.active_id+(parseInt(number)-1);
            }
          }
          this.Rectstx.pop();
          this.Rectsty.pop();
          this.Rectenx.pop();
          this.Recteny.pop();
          this.i=this.i-1;
          this.onflag=0;
        }
      },

      //清空的算法
      clear: function () {
        var m = document.getElementById("canvas");
        m.height = m.height;
        this.name = "";
        this.description = "";
        this.onflag=0;
        this.labelflag=0;
        this.onlabelflag=1;
        this.i=0;
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
        for(var number=this.x.length-1;number>=0;number--){
          var a=document.getElementById(this.moving_circle_id+parseInt(number));
          if(a!==null){
            document.body.removeChild(a);
          }
          var b=document.getElementById(this.active_circle_id+parseInt(number));
          if(b!==null){
            document.body.removeChild(b);
          }
        }
        this.Rectstx.splice(0, this.Rectstx.length);
        this.Rectsty.splice(0, this.Rectsty.length);
        this.Rectenx.splice(0, this.Rectenx.length);
        this.Recteny.splice(0, this.Recteny.length);
        this.x.splice(0,this.x.length);
        this.y.splice(0,this.y.length);
      },

      //根据类别拿取全部的Area division_name,division_description,AreaTagId Circle label_name,label_description,CircleTagId
      getTagAll:function(value){
        this.divison_name.splice(0,this.divison_name.length);
        this.divison_description.splice(0,this.divison_description.length)
        this.AreaTagId.splice(0,this.AreaTagId.length);
        this.label_name.splice(0,this.label_name.length);
        this.label_description.splice(0,this.label_description.length);
        this.CircleTagId.splice(0,this.CircleTagId.length)
        var self=this;
        this.clear();
        this.$http.get('api/webwork/getLabelAndId/'+window.localStorage.getItem("userID")+"/"+self.RecordID+"/"+value,{
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

      //点击显示的方法
      sureItemId:function(value,difference){
        this.flag=difference;
        if(difference==2){
          this.changeflagdivision()
          for(var number=0;number<this.divison_name.length;number++){
            if(value==this.divison_name[number]){
              this.indexofTag=number;
              break;
            }
          }

        }else if(difference==3){
          this.changeflaglabel()
          for(var number=0;number<this.label_name.length;number++){
            if(value==this.label_name[number]){
              this.indexofTag=number;
              break;
            }
          }
        }
        this.drawinit();
      },

      //初始化的算法
      drawinit: function () {
        this.isAddable=1;//表明是改变
        this.clear();
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
                var result=new Array;
                result=response.data.split(";");
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
                for(var number=0;number<=m.i;number++){
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
                  document.body.appendChild(active_box);
                }
                //设置下字体
                var mn=document.getElementById("nameinput");
                mn.style.fontFamily=m.Font_Family;
                mn.style.fontSize=m.Font_Size;
                var mm=document.getElementById("description");
                mm.style.fontSize=m.Font_Size;
                mm.style.fontFamily=m.Font_Family;
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
            this.labelflag=1;
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
                // //设置字体和字体大小
                var name_input=document.getElementById("nameinput");
                var description=document.getElementById("description");
                name_input.style.fontSize=m.Font_Size;
                name_input.style.fontFamily=m.Font_Family;
                description.style.fontSize=m.Font_Size;
                description.style.fontFamily=m.Font_Family;
              })
              .catch(function (error) {
                alert(error)
              })
          }
        }
      },

      //删除方法的调用，显示Model
      wantodelete:function(value,difference){
        this.isAddable=0;
        this.model1=true;
        if(difference==2){
          this.changeflagdivision()
          for(var number=0;number<this.divison_name.length;number++){
            if(value==this.divison_name[number]){
              this.indexofTag=number;
              break;
            }
          }

        }else if(difference==3){
          this.changeflaglabel()
          for(var number=0;number<this.label_name.length;number++){
            if(value==this.label_name[number]){
              this.indexofTag=number;
              break;
            }
          }
        }
      },
      //点击删除的取消
      cancle:function () {
        this.$Message.info('Clicked cancle');
        this.model1=false;
      },

      //删除一个标注的算法
      dis: function () {
        //先进行清空
        this.$Message.info('删除标注');
        this.model1=false;
        this.clear();
        //删除对应indexofTag里面的内容
        if(this.flag==2){
          this.divison_name.splice(this.indexofTag,1);
          this.divison_description.splice(this.indexofTag,1);
          this.Rectstx.splice(0,this.Rectstx.length);
          this.Rectsty.splice(0,this.Rectsty.length);
          this.Rectenx.splice(0,this.Rectenx.length);
          this.Recteny.splice(0,this.Recteny.length);
        }else if(this.flag==3){
          this.label_name.splice(this.indexofTag,1);
          this.label_description.splice(this.indexofTag,1);
          this.x.splice(0,this.x.length);
          this.y.splice(0,this.y.length);
        }
        //删除方法
        var m=this;
        var TagId="";
        if(m.flag==2){
          TagId=m.AreaTagId[m.indexofTag]
        }else if(m.flag==3){
          TagId=m.CircleTagId[m.indexofTag]
        }
        //传递flag和TagId
        this.$http.get(
          'api/webwork/delete/'+m.flag+"/"+TagId
        )
          .then(function (response) {
            m.$Message.success({
              title:"成功",
              content:"删除成功",
              duration:3
            })
          })
          .catch(function (error) {
            alert(error)
          })
      },

      //改变图片
      changeImage:function(){
        var m = document.getElementById("canvas");
        m.height = m.height;
        this.name = "";
        this.description = "";
        this.clear();
        this.onflag=0;
        this.onlabelflag=1;
        this.labelflag=0;
        this.currentpicurl=this.pictureurl[this.index];
        this.Rectstx.splice(0,this.Rectstx.length);
        this.Rectsty.splice(0,this.Rectsty.length);
        this.Rectenx.splice(0,this.Rectenx.length);
        this.Recteny.splice(0,this.Recteny.length);
        this.x.splice(0,this.x.length);
        this.x.splice(0,this.y.length);
        this.changeflag0();
        this.label_name.splice(0,this.label_name.length);
        this.label_description.splice(0,this.label_description.length);
        this.divison_name.splice(0,this.divison_name.length);
        this.divison_description.splice(0,this.divison_description.length);
        this.AreaTagId.splice(0,this.AreaTagId.length);
        this.CircleTagId.splice(0,this.CircleTagId.length);
      },
      //上一张
      changeLeft: function () {
        var m = document.getElementById("canvas");
        m.height = m.height;
        this.name = "";
        this.description = "";
        this.clear();
        this.onflag=0;
        this.onlabelflag=1;
        this.labelflag=0;
        if(this.index==0){
          this.$Message.warning({
            title:"警告",
            content:"已经是第一张",
            duration:3
          })
        }else {
          this.index=this.index-1;
          this.currentpicurl=this.pictureurl[this.index];
          this.Rectstx.splice(0,this.Rectstx.length);
          this.Rectsty.splice(0,this.Rectsty.length);
          this.Rectenx.splice(0,this.Rectenx.length);
          this.Recteny.splice(0,this.Recteny.length);
          this.x.splice(0,this.x.length);
          this.x.splice(0,this.y.length);
          this.changeflag0();
        }
      },

      //下一张
      changeRight: function () {
        var m = document.getElementById("canvas");
        m.height = m.height;
        this.name = "";
        this.description = "";
        this.onflag=0;
        this.onlabelflag=1;
        this.labelflag=0;
        this.clear();
        if(this.index==this.pictureurl.length-1){
          this.$Message.warning({
            title:"警告",
            content:"已经是最后一张",
            duration:3
          })
        }else {
          this.index = this.index + 1;
          this.currentpicurl=this.pictureurl[this.index];
          this.Rectstx.splice(0,this.Rectstx.length);
          this.Rectsty.splice(0,this.Rectsty.length);
          this.Rectenx.splice(0,this.Rectenx.length);
          this.Recteny.splice(0,this.Recteny.length);
          this.x.splice(0,this.x.length);
          this.x.splice(0,this.y.length);
          this.changeflag0();
        }
      },

      //保存的方法，根据flag来保存
      SaveData:function() {
        var m=this;
        if(this.flag==0){
          this.$Message.warning("请选择一个标注方式");
        }
        if (this.flag == 1) {
          //isExitable为0则是新建否则为更改
          var params = new URLSearchParams();
          params.append("userID",window.localStorage.getItem("userID"));
          params.append("RecordID",m.RecordID);
          params.append("pictureurl",m.pictureurl[m.index]);
          params.append("whole_name",m.name);
          params.append("whole_description",m.description);
          params.append("Font_Size",m.Font_Size);
          params.append("Font_Family",m.Font_Family);
          this.$http.post(
            'api/webwork/savewhole',params
          )
            .then(function(response){
              m.$Message.success({
                title: "成功",
                content: "保存成功",
              });
              m.clear();

            }) .catch(function (error) {
          })
          this.whole_name=this.name;
          this.whole_description=this.description;
        }
        else if (this.flag == 2) {
          //保存区域划分
          //检查是否重名
          var num=0;
          for(var number=0;number<this.divison_name.length;number++){
            if(this.name==this.divison_name[number]){
              num=1;
            }
          }
          if(num==1&&this.isAddable==0){
            this.$Message.warning({
              title: "不可以重名",
              content: "不同的标注不可以重名",
            });
            this.name="";
          }else {
            var m = this;
            var params = new URLSearchParams();
            if(this.isAddable=='0') {
              params.append("userID", window.localStorage.getItem("userID"));
              params.append("RecordID", m.RecordID);
              params.append("pictureurl", m.pictureurl[m.index]);
              params.append("name", m.name);
              params.append("description", m.description);
              params.append("isAddable", m.isAddable);
              params.append("option", m.selected);
              params.append("startxlist", JSON.stringify(m.Rectstx));
              params.append("startylist", JSON.stringify(m.Rectsty));
              params.append("endxlist", JSON.stringify(m.Rectenx));
              params.append("endylist", JSON.stringify(m.Recteny));
              params.append("Draw_Color", m.Draw_Color);
              params.append("Draw_Size", m.Draw_Size);
              params.append("Font_Size", m.Font_Size);
              params.append("Font_Family", m.Font_Family);
            }else{
              params.append("areaTagId",m.AreaTagId[m.indexofTag]);
              params.append("name",m.name);
              params.append("description",m.description);
              params.append("isAddable",m.isAddable);
              params.append("option",m.selected);
              params.append("startxlist",JSON.stringify(m.Rectstx));
              params.append("startylist",JSON.stringify(m.Rectsty));
              params.append("endxlist",JSON.stringify(m.Rectenx));
              params.append("endylist",JSON.stringify(m.Recteny));
              params.append("Draw_Color",m.Draw_Color);
              params.append("Draw_Size",m.Draw_Size);
              params.append("Font_Size",m.Font_Size);
              params.append("Font_Family",m.Font_Family);
            }
            this.$http.post("api/webwork/savedivision",params
            )
              .then(function (response) {
                if(response.data==-1){

                }else {
                  m.AreaTagId.push(response.data)
                }
                m.$Message.success({
                  title: "成功",
                  content: "保存成功",
                });
                m.clear();
                m.getTagAll(m.selected);
              })
              .catch(function (error) {
              })
            if (this.isAddable == 0) {
              //这是新建所以用push
              this.divison_name.push(this.name);
              this.divison_description.push(this.description);
              //进行大数组的Push
            } else {
              //这是添加根据itemID来进行改变
              this.divison_name[this.indexofTag] = this.name;
              this.divison_description[this.indexofTag] = this.description;
            }
          }
        } else if (this.flag == 3) {
          //保存局部标注
          //是否重名
          var num=0;
          for(var number=0;number<this.divison_name.length;number++){
            if(this.name==this.divison_name[number]){
              num=1;
            }
          }
          if(num==1&&this.isAddable==0) {
            this.$Message.warning({
              title: "不可以重名",
              content: "不同的标注不可以重名",
            });
            this.name="";
          }else {
            var m = this;
            var params = new URLSearchParams();
            if(this.isAddable=='0') {
              params.append("userID", window.localStorage.getItem("userID"));
              params.append("RecordID", m.RecordID);
              params.append("pictureurl", m.pictureurl[m.index]);
              params.append("name", m.name);
              params.append("description", m.description);
              params.append("xlist", JSON.stringify(m.x));
              params.append("ylist", JSON.stringify(m.y));
              params.append("Draw_Color", m.Draw_Color);
              params.append("Draw_Size", m.Draw_Size);
              params.append("Font_Size", m.Font_Size);
              params.append("Font_Family", m.Font_Family);
              params.append("isAddable", m.isAddable);
              params.append("option",m.selected);
            }else{
              params.append("CircleTagId",m.CircleTagId[m.indexofTag]);
              params.append("isAddable",m.isAddable);
              params.append("option",m.selected);
              params.append("name",m.name);
              params.append("description",m.description);
              params.append("xlist",JSON.stringify(m.x));
              params.append("ylist",JSON.stringify(m.y));
              params.append("Draw_Color",m.Draw_Color);
              params.append("Draw_Size",m.Draw_Size);
              params.append("Font_Size",m.Font_Size);
              params.append("Font_Family",m.Font_Family);
            }
            this.$http.post(
              'api/webwork/savelabel',params
            )
              .then(function (response) {
                if(response.data==-1){

                }else{
                  m.CircleTagId.push(response.data)
                }
                m.$Message.success({
                  title: "成功",
                  content: "保存成功",
                });
                m.clear();
                m.getTagAll(m.selected);
              })
              .catch(function (error) {
                alert(error)
              })
            //点是不用改变的，保存完了可以继续做，提交了不可以在改变了
            if (this.isAddable == 0) {
              this.label_name.push(this.name);
              this.label_description.push(this.description);
            } else {
              this.label_name[this.indexofTag] = this.name;
              this.label_description[this.indexofTag] = this.description;
            }
          }
        }
      },

      //显示提交框的
      IsSubmit:function () {
        this.model10=true;
      },

      //提交的方法
      SubmitData:function(){
        //提交
        var m=this;
        this.clear();
        this.$http.post(
          'api/webwork/submit/'+window.localStorage.getItem("userID")+"/"+m.RecordID
        )
          .
          then(function (response) {
            m.$Modal.success({
              title: "成功",
              content: "提交成功",
            });
            m.model10=false;
            m.clear();
            //路由跳转
            m.$router.push({
              name: 'already',
            })

          })
          .catch(function (error) {
            alert(error)
          })
      },

      //新建
      add:function () {
        //0是新建，1是改变
        this.isAddable=0;
        //然后清空
        this.clear();
        this.onflag=0;
        this.onlabelflag=1;
        this.labelflag=0;
        this.Rectstx.splice(0,this.Rectstx.length);
        this.Rectsty.splice(0,this.Rectsty.length);
        this.Rectenx.splice(0,this.Rectenx.length);
        this.Recteny.splice(0,this.Recteny.length);
        this.x.splice(0,this.x.length);
        this.y.splice(0,this.y.length);
        if(this.flag==1){
          this.$Modal.warning({
            title: "警告",
            content: "全局标注无法新建",
          });

        }else if(this.flag==2){
          this.itemID=this.divison_name.length;
        }else if(this.flag==3){
          this.itemID=this.label_name.length;
        }else{
          this.$Modal.warning({
            title: "警告",
            content: "请先选择标注方式",
          });
        }
      },
    },


    created(){
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
            can.height=dos.offsetHeight
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
