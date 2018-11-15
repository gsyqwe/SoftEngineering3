<template>
  <div>
    <Input
      icon="search"
      placeholder="请输入搜索内容..."
      style="width: 300px;float: right"
      size="default"
      v-model="keyword"
      v-on:input="change"
    />
    <br><br>


    <div style="background:#eee;padding: 20px;width: 20%;float:left;height: 400px">
      <Card :bordered="false">
        <Icon type="help-circled" size="50" style="margin-left: 35%;"></Icon>
        <p slot="title" style="margin-left: 35%;">温馨提示</p>
        <br><br><br>
        <p>此界面可以查看以往提交的任务</p><br><br><br>
        <p>并且可以进行简单的排序和搜索功能</p><br>
      </Card>
    </div>



    <div style="width: 80%;float:left;">
    <Table  stripe height="400" :columns="columns" :data="data"></Table>
    </div>
    <!--任务具体信息显示弹窗-->
    <Modal v-model="showTaskDetail" :closable='false' :mask-closable=false style="width: 500px;height: 500px">
      <label>图片信息：</label>
      <div style="width: 250px;height:250px;margin-left: 25%;margin-top: 10%">
        <img :src="currentPicUrl" style="width: 100%;height: 100%;"/>
      </div>
      <div slot="footer">
        <Button  @click="changetoleft">上一张</Button>
        <Button  @click="changetoright">下一张</Button>
        <Button type="primary"  @click="disappear">确定</Button>
      </div>
    </Modal>

  </div>
</template>
<script>
  import Icon from "iview/src/components/icon/icon";

  export default {

    components: {Icon},
    created(){
      this.init()
    },
    data () {
      let _this=this
      return {
        keyword:'',
        picArray:[],
        currentPicUrl:'',
        currentIndex:0,
        showTaskDetail:false,
        columns: [
          {
            title: '发起者',
            key:'requestorId',
            render: (h, params) => {
              var self=this
              return h('div', [
                h('Icon', {
                  props: {
                    type: 'person'
                  }
                }),

                h('span', {
                  domProps: {
                    innerHTML: params.row.requestorId.replace(self.keyword, '<span style="background: #ffff00;">'+self.keyword+'</span>')
                  }
                })
              ],
            );
            }
          },
          {
            title: '任务编号',
            key: 'taskId',

            render: (h, params) => {
              var self=this
              return h('span', {
                domProps: {
                  innerHTML: params.row.taskId.replace(self.keyword, '<span style="background: #ffff00;">'+self.keyword+'</span>')
                }
              });
            }


          },
          {
            title: '任务名',
            key: 'taskName',

            render: (h, params) => {
              var self=this
              return h('span', {
                domProps: {
                  innerHTML: params.row.taskName.replace(self.keyword, '<span style="background: #ffff00;">'+self.keyword+'</span>')
                }
              });
            }
          },
          {
            title:'任务描述',
            key:'taskDescription',

            render: (h, params) => {
              var self=this
              return h('span', {
                domProps: {
                  innerHTML: params.row.taskDescription.replace(self.keyword, '<span style="background: #ffff00;">'+self.keyword+'</span>')
                }
              });
            }
          },
          {
            title:'截止日期',
            key:'endTime',
            sortable: true,

            render: (h, params) => {
              var self=this
              return h('span',[
                h('Icon', {
                  props: {
                    type: 'android-time',
                    size: 12
                  },
                  style: {
                    margin: '0 5px'
                  }
                }),

                h('span',{
                domProps: {
                  innerHTML: this.formatDate(params.row.endTime).replace(self.keyword, '<span style="background: #ffff00;">'+self.keyword+'</span>')
                }
              }),
              ]);
            }
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
                    type: 'primary',
                    size: 'small'
                  },
                  style: {
                    marginRight: '5px'
                  },
                  on: {
                    click: () => {
                      this.show(params.index)
                    }
                  }
                }, '查看图片内容'),



              ]);
            }
          }
        ],
        data: [],
        originData:[],

        computed: {
          //计算浏览器的高度
          mapWidth() {return $(window).width() +'px'}

        },
      }
    },
    methods: {

      formatDate (time) {
        let date = new Date(time);
        let year = date.getFullYear();
        let month = date.getMonth() + 1;
        let day = date.getDate();
        return year + '/' + month + '/' + day ;
      },

      change(){
        this.data=[]
        var self=this
        if(self.keyword=='')
          self.data=self.originData
        else {
          for (var i = 0; i < self.originData.length; i++) {
            var item = self.originData[i]
            if (item.taskId.search(self.keyword) != -1 || item.requestorId.search(self.keyword) != -1 || item.taskName.search(self.keyword) != -1 || this.formatDate(item.endTime).search(self.keyword) != -1 || item.taskDescription.search(self.keyword) != -1)
              self.data.push(item)
          }
        }
      },
      //显示任务图片
      show (index) {
        this.appear(index)
        // this.$Modal.info({
        //   title: 'Task Detail',
        //   content: `RequesterName：${this.data[index].requestorID}<br>TaskID：${this.data[index].taskID}<br>TaskName：${this.data[index].taskName}<br>TaskDescription:${this.data[index].taskDescription}<br>DeadLine:${this.data[index].endTime}`
        // })
      },

      //界面初始化得到数据
      init(){
        var self=this
        var userID=window.localStorage.getItem("userID")
        this.$http.get('api/worker/already/'+userID)
          .then(function (response) {
             self.data=response.data
              self.originData=response.data

          })
          .catch(function (error) {
              console.log("工人已提交任务错误:"+error)
          })


      },

      //上一张
      changetoleft(){
        if(this.currentIndex==0)
          this.$Message.warning("已经是第一张")
        else{
          this.currentIndex--;
          this.currentPicUrl=this.picArray[this.currentIndex]
        }
      },

      //下一张
      changetoright(){
        if(this.currentIndex==this.picArray.length-1)
          this.$Message.warning("已经是最后一张")
        else {
          this.currentIndex++;
          this.currentPicUrl = this.picArray[this.currentIndex]
        }
      },

      //弹框出现
      appear(index){
        //后后端拿图片url
        this.showTaskDetail=true
        var taskId=this.data[index].taskId
        var m=this;
        this.$http.get('api/webwork/init/'+taskId
        ).
        then(function (response) {
          //把数据加载入data中
          //得到全部的pictureurl，然后把pictureurl载入data图片
          // response.data = response.data.substring(1, response.data.length - 1);
          // m.pictureurl = response.data.split(",");
          m.picArray=response.data.substring(1,response.data.length-1).split(",")
          m.currentPicUrl=m.picArray[0]
        })
      },

      //弹框消失
      disappear(){
        this.showTaskDetail=false
      }


    }
  }
</script>
