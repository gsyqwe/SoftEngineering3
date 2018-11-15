<template>
  <div>
    <!--&lt;!&ndash;已经发起的任务总数&ndash;&gt;-->
    <!--<div style="margin-left:10%;width:15%;height: 100px;border-radius: 5px;float:left;border: 5px solid  #755567">-->
      <!--<div style="width: 78px;height: 90px;background-color:greenyellow;float: left;border-radius: 4px">-->
        <!--<Icon type="ios-analytics" color=white size=50 style="margin-left: 20%;margin-top: 40%"></Icon>-->
      <!--</div>-->

      <!--<div style="width: 138px;height: 90px;float: left;border-radius: 4px;background-color: #e1f0fe">-->
        <!--<p style="text-align: center;margin-top: 8%;font-size: 40px;color: greenyellow" >{{tasknum}}</p>-->
        <!--<p style="margin-left: 33%;color: #6d7380;opacity: 0.6"> 任务总数</p>-->

      <!--</div>-->
    <!--</div>-->

    <label style="margin-left: 80px"> 任务类型:
    <i-switch  id="switch" size="large" @on-change="changeState">
      <span slot="open">进行</span>
      <span slot="close">结束</span>
    </i-switch>
    </label>

    <br><br>

    <label style="float: left;margin-left: 5%">任务情况：
      <Table stripe height="500" width="1400" :columns="currentcolumns" :data="data"></Table></label>

    <div style="margin-top: 600px">
         <div id="echartAnalyse" style="width:100%;height:400px;"></div>
    </div>

    <Modal v-model="showTaskMoreDetail" name="123" :closable='false' :mask-closable=false style="width: 500px;height: 600px">
      <label>图片信息：</label>
      <div style="width: 250px;height:250px;margin-left: 25%;margin-top: 10%">
        <img :src="currentPicUrl" style="width: 100%;height: 100%;"/>
        <p>任务名:{{CurrentTaskName}}</p>
        <p>任务描述:{{CurrentTaskDescription}}</p>
        <p>任务类型:{{CurrentTaskLabel}}</p>
        <p>任务:{{CurrentTaskoption}}</p>
        <p style="color: red">建议:{{CurrentAnalysis}}</p>
      </div>
      <div slot="footer" style="margin-top: 120px">
        <Button  @click="changetoleft">上一张</Button>
        <Button  @click="changetoright">下一张</Button>
        <Button type="primary"  @click="disappear">确定</Button>
      </div>
    </Modal>

    <Modal v-model="showBigData" name="235" :closable='false' :mask-closable=false width="800">
      <label>任务统计：</label>
      <Table stripe height="500" width="700" :columns="taskcolumns" :data="taskdata" style="margin-left: 40px"></Table>
      <div slot="footer" style="margin-top: 20px">
        <Button type="primary"  @click="disappearII">确定</Button>
      </div>
    </Modal>

  </div>
</template>
<script>
  import Schart from 'vue-schart';
  import ECharts from "vue-echarts/components/ECharts";

  export default {
    created(){
      this.init()
      this.linedata=[
        {name: '1', value: 2},
        {name: '2', value: 1},
        {name: '3', value: 2},
        {name: '4', value: 5},]
    },

    components: {
      ECharts,
      alert,
      Schart,
    },
    data () {
      return {
        showBigData:false,
        currentPicUrl:'',
        currentIndex:0,
        showTaskMoreDetail:false,
        CurrentAnalysis:"",//任务分析
        CurrentTaskName:"",//任务名称
        CurrentTaskDescription:"",//任务描述
        CurrentTaskLabel:"",//类型
        CurrentTaskUrl:[],//图片url
        CurrentTaskOption:[],//Option
        CurrentTaskoption:"",
        userID:"",
        year_released:[],
        year_obtained:[],
        year_finished:[],
        season_released:[],
        season_obtained:[],
        season_finished:[],
        month_released:[],
        month_obtained:[],
        month_finished:[],
        week_released:[],
        week_obtained:[],
        week_finished:[],
        currentcolumns:this.columns,
        linedata:[],
        tasknum:0,


        columnsIII: [
          {
            title: '任务编号',
            render: (h, params) => {
              return h('div', [
                h('strong', {
                  on:{
                    click:()=>{
                      this.MoreDetails(params.index)
                    }
                  }
                },params.row.taskId)
              ]);
            }
          },
          {
            title:'任务名',
            key:'taskName',
            render: (h, params) => {
              return h('div', [
                h('strong',{
                  on:{
                    click:()=>{
                      this.MoreDetails(params.index)
                    }
                  }
                }, params.row.taskName)
              ]);
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
            title:'领取人数',
            render: (h, params) => {
              var self=this
              return h('span', {
                domProps: {
                  innerHTML: params.row.finishNum+params.row.workingNum
                }
              });
            }
          },
          {
            title:'正在进行数',
            key:'workingNum'
          },
          {
            title:'已结束数',
            key:'finishNum'
          },
          {
            title: '操作',
            key: 'action',
            width: 210,
            align: 'center',
            render: (h, params) => {
              return h('div', [
                h('Button', {
                  props: {
                    type: 'primary',
                    size: 'small'
                  },
                  style: {
                    marginRight: '5px',
                    display:'none'
                  },
                  on: {
                    click: () => {
                    }
                  }
                }, '查看图片内容'),


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
                      this.finish(params.index)
                    }
                  }
                }, '查看整合结果'),



              ]);
            }
          }
        ],

        taskcolumns:[
          {
            title:'开始时间',
            key:'beginTime',
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
                    innerHTML: this.formatDate(params.row.beginTime)
                  }
                }),
              ]);
            }
          },
          {
            title:'截止日期',
            key:'endTime',
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
                    innerHTML: this.formatDate(params.row.endTime)
                  }
                }),
              ]);
            }
          },
          {
            title:'任务名称',
            key:'taskName'
          },
          {
            title:'任务类型',
            key:'labels'
          },
          {
            title:'正在进行数',
            key:'workingNum'
          },
          {
            title:'已结束数',
            key:'finishNum'
          },

        ],

        columns: [
          {
            title: '任务编号',
            render: (h, params) => {
              return h('div', [
                h('strong', {
                  on:{
                    click:()=>{
                      this.MoreDetails(params.index)
                    }
                  }
                },params.row.taskId)
              ]);
            }
          },
          {
            title:'任务名',
            key:'taskName',
            render: (h, params) => {
              return h('div', [
                h('strong',{
                  on:{
                    click:()=>{
                      this.MoreDetails(params.index)
                    }
                  }
                }, params.row.taskName)
              ]);
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
            title: '创建时间',
            key: 'beginTime',
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
                    innerHTML: this.formatDate(params.row.beginTime)
                  }
                }),
              ]);
            }

          },
          {
            title:'正在进行数',
            key:'workingNum'
          },
          {
            title:'已结束数',
            key:'finishNum'
          },
        ],

        data: [],
        data2:[],
        taskdata:[],

        taskprocess:[],
        taskfinish:[],
      }
    },
    mounted(){
      this.drawLine();
    },
    methods: {
      disappearII(){
        this.showBigData=false
      },
      formatDate (time) {
        let date = new Date(time);
        let year = date.getFullYear();
        let month = date.getMonth() + 1;
        let day = date.getDate();
        return year + '/' + month + '/' + day ;
      },

      disappear(){
        this.showTaskMoreDetail=false
      },
      changetoleft(){
        if(this.currentIndex==0)
          this.$Message.warning("已经是第一张")
        else{
          this.currentIndex--;
          this.currentPicUrl=this.CurrentTaskUrl[this.currentIndex]
        }
      },

      //下一张
      changetoright(){
        if(this.currentIndex==this.CurrentTaskUrl.length-1)
          this.$Message.warning("已经是最后一张")
        else {
          this.currentIndex++;
          this.currentPicUrl = this.CurrentTaskUrl[this.currentIndex]
        }
      },
      formatDate (time) {
        let date = new Date(time);
        let year = date.getFullYear();
        let month = date.getMonth() + 1;
        let day = date.getDate();
        return year + '/' + month + '/' + day ;
      },
      //跳到整合界面
      finish(index){
        var taskId=this.taskfinish[index].taskId
        console.log(taskId)
        this.$router.push({
          name:'missionintegration',
          params:{
            taskID:taskId
          }
        })
      },
      changeState(state){
        //进行
        if(state == true){
          this.data2=[]
          this.currentcolumns=this.columns
          this.data=this.taskprocess
        }
        //结束
        else{
          this.data2=[]
          this.currentcolumns=this.columnsIII
          this.data=this.taskfinish
        }
      },
      sum:function (value) {
        var result=0;
        for(var number=0;number<value.length;number++){
          result=result+parseInt(value[number]);
        }
        return result;
      },
      MoreDetails(index){
        var self=this;
        this.CurrentTaskoption="";
        var taskid=this.data[index].taskId;
        this.currentIndex=0;
        this.$http.get('api/worker/CheckMoreDetail/'+taskid)
          .then(function (response) {
            var temp=new Array;
            temp=response.data.split(";");
            self.CurrentTaskUrl=temp[0].split(",");
            self.CurrentTaskName=temp[1];
            self.CurrentTaskDescription=temp[2];
            self.CurrentTaskLabel=temp[3];
            self.CurrentTaskOption=temp[4].split(",");
            self.currentPicUrl=self.CurrentTaskUrl[0];
            for(var number=0;number<self.CurrentTaskOption.length;number++){
              self.CurrentTaskoption=self.CurrentTaskoption+" "+self.CurrentTaskOption[number];
            }
            self.showTaskMoreDetail=true;
          })
        this.$http.get('api/requestor/getAnalysis/'+taskid)
          .then(function (response) {
            self.CurrentAnalysis=response.data;
          })
      },
      drawLine(){
        var self=this;
        var year_released_sum=this.sum(self.year_released);
        var year_obtained_sum=this.sum(this.year_obtained);
        var year_finished_sum=this.sum(this.year_finished);
        var season_released_sum=this.sum(self.season_released);
        var season_obtained_sum=this.sum(this.season_obtained);
        var season_finished_sum=this.sum(this.season_finished);
        var month_released_sum=this.sum(self.month_released);
        var month_obtained_sum=this.sum(this.month_obtained);
        var month_finished_sum=this.sum(this.month_finished);
        var week_released_sum=this.sum(self.week_released);
        var week_obtained_sum=this.sum(this.week_obtained);
        var week_finished_sum=this.sum(this.week_finished);
        let myChart=this.$echarts.init(document.getElementById("echartAnalyse"));
        myChart.setOption({
          baseOption: {
            timeline: {
              axisType: 'category',
              autoPlay: true,
              playInterval: 1000,
              data: [
                "最近一年","最近一季","最近一月",
                {
                  value: "最近一周",
                  symbol: 'diamond',
                  symbolSize: 16
                },

              ],
            },
            tooltip: {
            },
            legend: {
              x: 'right',
              data: ['结束任务数', '发布任务数', '提交人数'],
            },
            calculable : true,
            grid: {
              top: 80,
              bottom: 100,
              tooltip: {
                trigger: 'axis',
                axisPointer: {
                  type: 'shadow',
                  label: {
                    show: true,
                    formatter: function (params) {
                      return params.value.replace('\n', '');
                    }
                  }
                }
              }
            },
            xAxis: [
              {
                'type':'category',
                'axisLabel':{'interval':0},
                'data':[
                  '人像\n', '动物\n','植物\n','交通工具\n',
                  '自然风光\n','日常用品\n', '道路\n', 'logo标牌\n', '其他'
                ],
                splitLine: {show: false}
              }
            ],
            yAxis: [
              {
                type: 'value',
                name: '数量'
              }
            ],
            series: [
              {name: '发布次数', type: 'bar'},
              {name: '领取次数', type: 'bar'},
              {name: '完成次数', type: 'bar'},
              {
                name: '数量占比',
                type: 'pie',
                center: ['75%', '35%'],
                radius: '28%',
                z: 1
              }
            ]
          },
          options: [
            {
              title: {text: '最近一年'},
              series: [
                {data:self.year_released},
                {data:self.year_obtained},
                {data:self.year_finished},
                {data: [
                    {name: '发布次数', value:year_released_sum},
                    {name: '领取次数', value:year_obtained_sum},
                    {name: '完成次数', value:year_finished_sum}
                  ]}
              ]
            },
            {
              title : {text: '最近一季'},
              series : [
                {data: self.season_released},
                {data: self.season_obtained},
                {data: self.season_finished},
                {data: [
                    {name: '发布次数', value: season_released_sum},
                    {name: '领取次数', value:season_obtained_sum},
                    {name: '完成次数', value: season_finished_sum}
                  ]}
              ]
            },
            {
              title : {text: '最近一月'},
              series : [
                {data: self.month_released},
                {data:self.month_obtained},
                {data: self.month_finished},
                {data: [
                    {name: '发布次数', value: month_released_sum},
                    {name: '领取次数', value:month_obtained_sum},
                    {name: '完成次数', value:month_finished_sum}
                  ]}
              ]
            },
            {
              title : {text: '最近一周'},
              series : [
                {data: self.week_released},
                {data: self.week_obtained},
                {data: self.week_finished},
                {data: [
                    {name: '发布次数', value:week_released_sum},
                    {name: '领取次数', value:week_obtained_sum},
                    {name: '完成次数', value: week_finished_sum}
                  ]}
              ]
            },
            ]
        });
        var mchart=myChart;
        myChart.on('click',function(param){
          var index=mchart.getOption().timeline[0].currentIndex
          self.GetTaskByLabel(index,param.name,param.componentSubType)
        })
      },

      GetTaskByLabel(index,label,type){
        var self=this;
        var userID = window.localStorage.getItem("userID")
        if(type=="bar") {
          var time = 0;
          if (index == 0) {
            time = 3
          } else if (index == 1) {
            time = 2
          } else if (index == 2) {
            time = 1
          } else if (index == 3) {
            time = 0
          }
          this.$http.get('api/requestor/getTaskByLabel/' + userID + "/" + time + "/" + label)
            .then(function (response) {
              self.taskdata = response.data
              self.showBigData = true
            })
        }
      },

      show (index) {
        var self=this
        this.data2=[]
        var taskID = this.data[index].taskId
        this.$http.get("api/requestor/getworkersbytaskID/"+taskID)
          .then(function (response) {
            self.data2=response.data
          })
      },

      showII (index) {
        this.$Modal.info({
          title: 'Task Detail',
          content: `工人编号：${this.data2[index].workerID}<br>任务状态：${this.data2[index].status}`
        })
      },

      init(){
        //拿到已结束和进行中的任务 放到taskprocess和taskfinish里面

        //
        var self=this
        this.$http.get('api/RequesterServlet',{
          params:{
            userID:window.localStorage.getItem("userID"),
            method:'DateAnalysis'
          }
        }).then(function (response) {
          self.data=response.data
          console.log(response.data);
        }).catch(function (error) {
          console.log("发起者数据分析初始化错误："+error)
        })



        this.$http.get('api/RequesterServlet',{
          params:{
            userID:window.localStorage.getItem("userID"),
            method:'DateAnalysisIII'
          }
        }).then(function (response) {
          console.log("init"+response)
          self.tasknum=response.data.res
        }).catch(function (error) {
          console.log("工人init"+error)
        })

      },
    },
    created(){
      var self=this;
      this.userID=window.localStorage.getItem("userID");
      this.$http.get("api/requestor/getBigData/"+self.userID)
        .then(function (response) {
          var temp=new Array
          temp=response.data.split(";")
          self.year_released=temp[0].split(",");
          self.year_obtained=temp[1].split(",");
          self.year_finished=temp[2].split(",");
          self.season_released=temp[3].split(",");
          self.season_obtained=temp[4].split(",");
          self.season_finished=temp[5].split(",");
          self.month_released=temp[6].split(",");
          self.month_obtained=temp[7].split(",");
          self.month_finished=temp[8].split(",");
          self.week_released=temp[9].split(",");
          self.week_obtained=temp[10].split(",");
          self.week_finished=temp[11].split(",");
          self.drawLine()
        })


      this.$http.get('api/requestor/gettaskend/'+window.localStorage.getItem("userID"))
        .then(function (response) {
          self.taskfinish=response.data
          self.currentcolumns=self.columnsIII
          self.data=self.taskfinish
          var m=self;
          self.$http.get('api/requestor/gettasknotend/'+window.localStorage.getItem("userID"))
            .then(function (response) {
              m.taskprocess=response.data
            })
        })

    },
  }
</script>
