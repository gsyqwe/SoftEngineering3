<template>

  <div style="float: left;width: 100%" >

    <div style="background:#eee;padding: 20px;width: 20%;float:left;height: 400px;margin-left: 5%">
      <Card :bordered="false">
        <Icon type="help-circled" size="50" style="margin-left: 35%;"></Icon>
        <p slot="title" style="margin-left: 35%;">温馨提示</p>
        <br><br><br>
        <p>此界面可以供您发起新的任务</p><br>
        <p>希望您在发布任务的时候能尽量一次性发布一种类型的任务</p><br>
        <p>以便于我们的工作，在此对您表示感谢</p><br>
      </Card>
    </div>


    <div class="hello" >


    <div class="upload">

      <div class="upload_warp">

        <div class="upload_warp_left" @click="fileClick">

          <img src="../../images/upload.png">

        </div>

        <div class="upload_warp_right" @drop="drop($event)" @dragenter="dragenter($event)" @dragover="dragover($event)">

          或者将文件拖到此处

        </div>

      </div>

      <div class="upload_warp_text">

        选中{{imgList.length}}张图片，共{{bytesToSize(this.size)}}

      </div>

      <input @change="fileChange($event)" type="file" id="upload_file" multiple style="display: none"/>

      <div class="upload_warp_img" v-show="imgList.length!=0">

        <div class="upload_warp_img_div" v-for="(item,index) of imgList">

          <div class="upload_warp_img_div_top">

            <div class="upload_warp_img_div_text">

              {{item.file.name}}

            </div>

            <img src="../../images/del.png" class="upload_warp_img_div_del" @click="fileDel(index)">

          </div>

          <img :src="item.file.src">

        </div>

      </div>

    </div>

    <br>
    <br>
    <label class="form-inline">积分设置：<InputNumber :min="1" :max="100" v-model="point" class="form-control" style="opacity: 0.8;width: 80px"></InputNumber></label>
    <label  class="form-inline" style="margin-left: 100px">结束时间：
      <DatePicker type="date"  v-model="ddl" :options="option" format="yyyy-MM-dd" placeholder="select data" style="width: 120px;opacity: 0.8"></DatePicker></label><br>
    <!--<Dropdown style="margin-left: 2px;float:left;" >-->
      <!--<Button type="primary">-->
         <!--选择任务类型：-->
        <!--<Icon type="arrow-down-b"></Icon>-->
      <!--</Button>-->
      <!--<DropdownMenu slot="list" >-->
        <!--<DropdownItem v-for="item in origintasktype" @click.native="changetasktype(item)">{{item}}</DropdownItem>-->
      <!--</DropdownMenu>-->

      <!---->

    <!--</Dropdown>-->
      <label class="form-inline" style="margin-left: 5px">任务类型：
        <Select style="width:200px" @on-change="changetasktype">
          <Option v-for="item in origintasktype" :value="item" >{{ item}}</Option>
        </Select>
      </label>
    <!--<input readonly type="text"class="form-control" v-model="tasktype" style="width: 100px;float: left;margin-left: 10px"/>-->


    <label class="form-inline" style="margin-left: 5px">任务名：<input type="text" class="form-control" v-model="taskname" placeholder="任务名" style="opacity: 0.8;width: 100px"/></label>
    <label class="form-inline">任务描述：<input type="text" class="form-control" v-model="taskdescription" placeholder="请对任务进行简短描述" style="opacity: 0.8;width: 400px"/></label><br><br>

    <label style="float: left">你希望的最低工人水平：
      <RadioGroup v-model="workerlevel">
        <Radio label="熟练"></Radio>
        <Radio label="普通"></Radio>
        <Radio label="新手"></Radio>
      </RadioGroup></label>
    <br>
    <br>
      <Button type="primary" @click="appear">选择类型</Button>
      <label class="form-inline">当前的类型：<input type="text" class="form-control" v-model="lastTypes" style="width: 300px" readonly ></label>
    <input type="button" class="btn btn-primary" value="提交任务"  @click="submit" style="margin-left: 30%">

    </div>

    <Modal v-model="showModel" :closable='false' :mask-closable=false :width="500">
      <h3 slot="header" style="color:#2D8CF0">新增期望的一些类型</h3>

      <Table :columns="columns" :data="preTypes"></Table>
      <label class="form-inline">新增类型：
        <input type="text" class="form-control" v-model="newtype" style="width: 250px" placeholder="类型名;比如人类标注,植物标注..."/>
        <Button type="primary" @click="addNewType">新增此类型</Button>
      </label>

      <div slot="footer">
        <Button type="primary"  @click="disappear">确定</Button>
      </div>
    </Modal>


  </div>

</template>



<script>

  export default {

    filters:{
      dateFormat(val) {
        let year = val.getFullYear().toString();
        let month = val.getMonth() >= 9
          ? (val.getMonth() + 1).toString()
          : "0" + (val.getMonth() + 1);
        let date = val.getDate() >= 9
          ? val.getDate().toString()
          : "0" + val.getDate();
        return year + "-" + month + "-" + date;
      }
    },


    computed:{
      lastTypes(){
        var temp=''
        for(var i=0;i<this.preTypes.length;i++)
          temp=temp+' '+this.preTypes[i].type
        return temp
      }
    },

    data() {

      return {
        showModel:false,
        newtype:'',
        preTypes:[],

        imgList: [],
        picArray:[],
        size: 0,
        tasktype:'其他标注',
        origintasktype:['人类标注','动物标注','植物标注','车辆标注','自然标注','日常用品标注','道路标注','logo标注','其他标注'],
        workerlevel: "新手",
        ddl:'',
        taskdescription:'',
        point:10,
        taskname:'',
        option: {
          disabledDate(date){
            return date && date.valueOf() < Date.now()-86400000;
          }
        },

        columns:[
          {
            title:'类型',
            key:'type'
          },
          {
            title: '操作',
            key: 'action',
            width: 150,
            align: 'center',
            render: (h, params) => {
              return h('div', [
                h('Button', {
                  props: {
                    type: 'error',
                    size: 'small'
                  },
                  style: {
                    marginRight: '5px'
                  },
                  on: {
                    click: () => {
                      this.remove(params.index)
                    }
                  }
                }, '删除'),
              ]);
            }
          }
        ]

      }

    },

    methods: {
      changetasktype(item){
        this.tasktype=item
      },

      //设置

      addNewType(){
        if(this.newtype===''){
          this.$Message.error('类型不能为空')
          return
        }
        for(var i=0;i<this.preTypes.length;i++){
          if(this.newtype===this.preTypes[i].type){
            this.$Message.error('不能重名')
            this.newtype=''
            return
          }
        }

        var object ={
          type:this.newtype
        }


        this.preTypes.push(object)
        this.newtype=''
      },

      appear(){
        this.showModel=true
      },
      disappear(){
        this.showModel=false
      },



      remove(index){
        this.preTypes.splice(index,1)
      },

      limitClick(state) {

        this.imgList = [];

        if (state)

          this.limit = 2;

        else

          this.limit = undefined;

      },

      fileClick() {

        document.getElementById('upload_file').click()

      },

      fileChange(el) {

        if (!el.target.files[0].size) return;

        this.fileList(el.target);

        el.target.value = ''

      },

      fileList(fileList) {

        let files = fileList.files;

        for (let i = 0; i < files.length; i++) {

          //判断是否为文件夹

          if (files[i].type != '') {

            this.fileAdd(files[i]);

          } else {

            //文件夹处理

            this.folders(fileList.items[i]);

          }

        }


      },

      //文件夹处理

      folders(files) {

        let _this = this;

        //判断是否为原生file

        if (files.kind) {

          files = files.webkitGetAsEntry();

        }

        files.createReader().readEntries(function (file) {

          for (let i = 0; i < file.length; i++) {

            if (file[i].isFile) {

              _this.foldersAdd(file[i]);

            } else {

              _this.folders(file[i]);

            }

          }

        })

      },

      foldersAdd(entry) {

        let _this = this;

        entry.file(function (file) {

          _this.fileAdd(file)

        })

      },

      fileAdd(file) {

        if (this.limit !== undefined) this.limit--;

        if (this.limit !== undefined && this.limit < 0) return;

        //总大小

        this.size = this.size + file.size;

        //判断是否为图片文件

        if (file.type.indexOf('image') == -1) {

          file.src = 'wenjian.png';

          this.imgList.push({

            file

          });

        } else {

          let reader = new FileReader();

          let image = new Image();

          let _this=this;

          reader.readAsDataURL(file);

          reader.onload = function () {

            file.src = this.result;

            var base64 = this.result

            image.onload=function(){

              let width = image.width;

              let height = image.height;

              file.width=width;

              file.height=height;

              _this.imgList.push({

                file

              });

              _this.picArray.push(base64)

            };

            image.src= file.src;

          }

        }

      },

      fileDel(index) {

        this.size = this.size - this.imgList[index].file.size;//总大小

        this.imgList.splice(index, 1);

        this.picArray.splice(index,1)

        if (this.limit !== undefined) this.limit = this.imgList.length;

      },

      bytesToSize(bytes) {

        if (bytes === 0) return '0 B';

        let k = 1000, // or 1024

          sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],

          i = Math.floor(Math.log(bytes) / Math.log(k));

        return (bytes / Math.pow(k, i)).toPrecision(3) + ' ' + sizes[i];

      },

      dragenter(el) {

        el.stopPropagation();

        el.preventDefault();

      },

      dragover(el) {

        el.stopPropagation();

        el.preventDefault();

      },

      drop(el) {

        el.stopPropagation();

        el.preventDefault();

        this.fileList(el.dataTransfer);

      },

      clear(){
        this.imgList=[]
        this.picArray=[]
        this.ddl=''
        this.taskname=''
        this.taskdescription=''
        this.point=0
        this.size=0
        this.preTypes=[]


      },
      dateFormat(val) {
        let year = val.getFullYear().toString();
        let month = val.getMonth() > 9
          ? (val.getMonth() + 1).toString()
          : "0" + (val.getMonth() + 1);
        let date = val.getDate() > 9
          ? val.getDate().toString()
          : "0" + val.getDate();
        return year + "-" + month + "-" + date;
      },

      submit(){
        var self=this
        var level=0
        if(this.workerlevel=='普通')
          level=1;
        if(this.workerlevel=='熟练')
          level=2
        var array=[]
        for(var i=0;i<self.preTypes.length;i++)
          array.push(self.preTypes[i].type)
        var params = new URLSearchParams();
        params.append("requestorID",window.localStorage.getItem("userID"))
        params.append("imagesURL",JSON.stringify(self.picArray))
        params.append("workerLevel",JSON.stringify(level))
        if(self.tasktype === '人类标注')
          self.tasktype='people'
        else if(self.tasktype==='动物标注')
          self.tasktype='animal'
        else if(self.tasktype==='植物标注')
          self.tasktype='plants'
        else if(self.tasktype==='道路标注')
          self.tasktype='path'
        else if(self.tasktype==='日常用品标注')
          self.tasktype='commodity'
        else if(self.tasktype==='logo标注')
          self.tasktype='logo'
        else if(self.tasktype==='车辆标注')
          self.tasktype='vehicle'
        else if(self.tasktype==='自然标注')
          self.tasktype='scenery'
        else
          self.tasktype='other'

        params.append("label",self.tasktype)
        params.append("endTime",self.dateFormat(self.ddl))
        params.append("taskDescription",self.taskdescription)
        params.append("points",self.point)
        params.append("taskName",self.taskname)
        params.append("type",JSON.stringify(array))
        this.$http.post('api/requestor/createtask',params)
          .then(function (response) {
          if(response.data==1) {
            self.$Message.success({
              content: "发布成功"
            })
            self.clear()
          }
          else {
            self.$Message.warning({
              content: "发布失败"
            })
            self.clear()
          }

        }).catch(function (error) {
          console.log("发起者发起任务错误："+error)
        })

      }


    }

  }

</script>

<style scoped>

  .upload_warp_img_div_del {

    position: absolute;

    top: 6px;

    width: 16px;

    right: 4px;

  }



  .upload_warp_img_div_top {

    position: absolute;

    top: 0;

    width: 100%;

    height: 30px;

    background-color: rgba(0, 0, 0, 0.4);

    line-height: 30px;

    text-align: left;

    color: #fff;

    font-size: 12px;

    text-indent: 4px;

  }



  .upload_warp_img_div_text {

    white-space: nowrap;

    width: 80%;

    overflow: hidden;

    text-overflow: ellipsis;

  }



  .upload_warp_img_div img {

    max-width: 100%;

    max-height: 100%;

    vertical-align: middle;

  }



  .upload_warp_img_div {

    position: relative;

    height: 100px;

    width: 120px;

    border: 1px solid #ccc;

    margin: 0px 30px 10px 0px;

    float: left;

    line-height: 100px;

    display: table-cell;

    text-align: center;

    background-color: #eee;

    cursor: pointer;

  }



  .upload_warp_img {

    border-top: 1px solid #D2D2D2;

    padding: 14px 0 0 14px;

    overflow: hidden

  }



  .upload_warp_text {

    text-align: left;

    margin-bottom: 10px;

    padding-top: 10px;

    text-indent: 14px;

    border-top: 1px solid #ccc;

    font-size: 14px;

  }



  .upload_warp_right {

    float: left;

    width: 57%;

    margin-left: 2%;

    height: 100%;

    border: 1px dashed #999;

    border-radius: 4px;

    line-height: 130px;

    color: #999;

  }



  .upload_warp_left img {

    margin-top: 32px;

  }



  .upload_warp_left {

    float: left;

    width: 40%;

    height: 100%;

    border: 1px dashed #999;

    border-radius: 4px;

    cursor: pointer;

  }



  .upload_warp {

    margin: 14px;

    height: 130px;

  }



  .upload {

    border: 1px solid #ccc;

    background-color: #fff;

    width: 650px;

    box-shadow: 0px 1px 0px #ccc;

    border-radius: 4px;

  }



  .hello {

    width: 650px;

    margin-left: 30%;

  }

</style>
