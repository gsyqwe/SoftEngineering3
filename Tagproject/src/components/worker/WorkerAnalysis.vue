<template>
  <div  style="background-color: #6d7380">
    <div style="width: 100%;height: 100px">
      <!--总积分-->
      <div style="margin-left:10%;width:14%;height: 100px;border-radius: 5px;float:left;border:5px solid  #755567">
        <div style="width: 70px;height: 90px;background-color: rebeccapurple;float: left;border-radius: 4px">
          <Icon type="social-sass" color=white size=50 style="margin-left: 20%;margin-top: 40%"></Icon>
        </div>

        <div style="width: 132px;height: 90px;float: left;border-radius: 4px;background-color: #e1f0fe">
          <p style="text-align: center;margin-top: 8%;font-size: 40px;color: rebeccapurple" v-model="point">{{point|fil}}</p>
          <p style="margin-left: 33%;color: #6d7380;opacity: 0.6"> 总积分</p>

        </div>
      </div>

      <!--群体排名-->
      <div style="margin-left:5%;width:14%;height: 100px;border-radius: 5px;float:left;border:5px solid  #755567" @mousedown="showTopTen" >
        <div style="width: 70px;height: 90px;background-color:greenyellow;float: left;border-radius: 4px">
          <Icon type="ios-book-outline" color=white size=50 style="margin-left: 20%;margin-top: 40%"></Icon>
        </div>

        <div style="width: 132px;height: 90px;float: left;border-radius: 4px;background-color: #e1f0fe">
          <p style="text-align: center;margin-top: 8%;font-size: 40px;color: greenyellow" v-model="ranking">{{ranking}}</p>
          <p style="margin-left: 33%;color: #6d7380;opacity: 0.6"> 群体排名</p>
0
        </div>
      </div>

      <!--做群体排名的悬停，然后能够显示TopTen-->
      <Modal v-model="model1" :closable='false' :mask-closable=false @mouseleave="leaveTopTen">
        <label v-for="(item,index) in TopTenID">
          <img  :src="TopTenAvatol[index]" width="50" height="50"/>
          姓名:{{item}}&nbsp&nbsp   得分:{{TopTenPoints[index]|fil}} &nbsp&nbsp
          准确度:{{TopTenAccuracy[index]|fil}}&nbsp&nbsp        效率:{{TopTenEffiencicy[index]|fil}}&nbsp&nbsp
          <br>
        </label>
      </Modal>

      <!--已完成-->
      <div style="margin-left:5%;width:14%;height: 100px;border-radius: 5px;float:left;border:5px solid  #755567">
        <div style="width: 70px;height: 90px;background-color:orange;float: left;border-radius: 4px">
          <Icon type="podium" color=white size=50 style="margin-left: 20%;margin-top: 40%"></Icon>
        </div>

        <div style="width: 132px;height: 90px;float: left;border-radius: 4px;background-color: #e1f0fe">
          <p style="text-align: center;margin-top: 8%;font-size: 40px;color: orange" v-model="complete">{{complete}}</p>
          <p style="margin-left: 33%;color: #6d7380;opacity: 0.6"> 已完成</p>

        </div>
      </div>

      <!--未完成-->
      <div style="margin-left:5%;width:14%;height: 100px;border-radius: 5px;float:left;border:5px solid  #755567">
        <div style="width: 70px;height: 90px;background-color:burlywood;float: left;border-radius: 4px">
          <Icon type="ios-analytics" color=white size=50 style="margin-left: 20%;margin-top: 40%"></Icon>
        </div>

        <div style="width: 132px;height: 90px;float: left;border-radius: 4px;background-color: #e1f0fe">
          <p style="text-align: center;margin-top: 8%;font-size: 40px;color: burlywood" v-model="ongoing">{{ongoing}}</p>
          <p style="margin-left: 33%;color: #6d7380;opacity: 0.6"> 未完成</p>

        </div>
      </div>

    </div>


    <br>
    <div id="leida" style="float:left;width: 30%;height: 500px;margin-left: 1%" @click="appear">
    </div>

     <div style="width: 65%; float: left;margin-left: 2%">
       <Input
         icon="search"
         placeholder="请输入搜索内容..."
         style="width: 300px;float: right"
         size="default"
         v-model="keyword"
         v-on:input="change"
       />
       <br><br>
        <Table :data="tableData1" :columns="columns"  height="500"  stripe></Table>
        <!--<div style="overflow: hidden">-->
          <!--<div style="float: right;">-->
            <!--<Page :total="100" :current="1"  @on-change="changePage"></Page>-->
          <!--</div>-->
        <!--</div>-->
    </div>


    <Modal v-model="showDetail" :closable='false' :mask-closable=false>
      <div id="accuracy" style="width:500px ;height:400px;"></div>
      <div id="efficiency" style="width:500px ;height:400px;"></div>
      <div id="predictor" style="width:500px ;height:400px;"></div>
    </Modal>

    <Modal v-model="showTaskMoreDetail" :closable='false' :mask-closable=false style="width: 500px;height: 600px">
      <label>图片信息：</label>
      <div style="width: 250px;height:250px;margin-left: 25%;margin-top: 10%">
        <img :src="currentPicUrl" style="width: 100%;height: 100%;"/>
        <p>任务名:{{CurrentTaskName}}</p>
        <p>任务描述:{{CurrentTaskDescription}}</p>
        <p>任务类型:{{CurrentTaskLabel}}</p>
        <p>任务:{{CurrentTaskoption}}</p>
      </div>
      <div slot="footer" style="margin-top: 50px">
        <Button  @click="changetoleft">上一张</Button>
        <Button  @click="changetoright">下一张</Button>
        <Button type="primary"  @click="disappear">确定</Button>
      </div>
    </Modal>

  </div>
</template>
<script>
  import Schart from 'vue-schart';
  import Button from "iview/src/components/button/button";
  export default {
    components:{
      Button,
      Schart
    },
    created(){
      this.init()
    },
    filters:{
       fil(value){
         return Math.round(value*100)/100
       }
    },
    data() {
      let self=this
      return {
        keyword:'',
        currentPicUrl:'',
        currentIndex:0,
        showTaskMoreDetail:false,
        model1:false,
        TopTenID:[],//前10的ID
        TopTenAvatol:[],//前10的头像url
        TopTenPoints:[],//前10的分数
        TopTenAccuracy:[],//前10的准确度
        TopTenEffiencicy:[],//前10的效率
        CurrentTaskName:"",//任务名称
        CurrentTaskDescription:"",//任务描述
        CurrentTaskLabel:"",//类型
        CurrentTaskUrl:[],//图片url
        CurrentTaskOption:[],//Option
        CurrentTaskoption:"",
        userID:"",
        showDetail:false,
        ongoing:0,
        complete:0,
        point:10,
        ranking:1,
        data:[],
        data1: [],
        data2:[],
        tableData1: [],
        originData:[],
        Leida:[],
        effiencicy_Series:[],//效率
        effienciy_Time:[],//时间
        effienciy_Forcast_Series:[],//效率预测x
        effiencicy_Forcast_P:[],//概率
        effiencicy_Most_P:[],
        accuracy_Series:[],//准确度
        accuracy_Time:[],//准确度时间
        accuracy_Forcast_Series:[],//准确度预测x
        accuracy_Forcast_P:[],//准确度预测P
        accuracy_Most_P:[],
        columns: [
          {
            title: '任务编号',
            render: (h, params) => {
              let self=this
              return h('div', [
                h('strong', {
                  on:{
                    click:()=>{
                      this.MoreDetails(params.index)
                    }
                  }
                },params.row.taskID)
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
            title:'原始积分',
            key:'taskPoints'
          },
          {
            title:'实际得分',
            render: (h, params) => {
              return h('span',
                {
                  domProps: {
                    innerHTML: Math.round(params.row.awards*100)/100
                  }
                })
              ;
            }
          },
          {
            title:'提交时间',
            key:'commitTime',
          },
          {
            title: '操作',
            key: 'action',
            width: 250,
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
                      this.CheckDetail(params.index)
                    }
                  }
                }, '查看任务记录'),

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
      }
    },


    methods:{
      change(){
        this.tableData1=[]
        var self=this
        if(self.keyword=='')
          self.tableData1=self.originData
        else {
          for (var i = 0; i < self.originData.length; i++) {
            var item = self.originData[i]
            console.log(item.taskID+item.taskName+self.keyword)
            if (item.taskID.search(self.keyword) != -1 || item.taskName.search(self.keyword) != -1)
              self.tableData1.push(item)
          }
        }
      },
      CheckDetail(index){
        var taskID = this.tableData1[index].taskID
        this.$router.push({
          name:'wokermissionincheckhistory',
          params:{
            taskID:taskID
          }
        })

      },
      formatDate (time) {
        let date = new Date(time);
        let year = date.getFullYear();
        let month = date.getMonth() + 1;
        let day = date.getDate();
        return year + '/' + month + '/' + day ;
      },
      disappear(){
        this.showTaskMoreDetail=false;
      },
      MoreDetails(index){
        var self=this;
        this.CurrentTaskoption="";
        var taskid=this.tableData1[index].taskID;
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
      finish(index){
        var taskId=this.tableData1[index].taskID
        console.log(taskId)
        this.$router.push({
          name:'workermissionintegration',
          params:{
            taskID:taskId
          }
        })
      },
      leaveTopTen(){
        this.model1=false;
      },
      showTopTen:function(){
       this.model1=true;
      },
      appear(){
        this.showDetail=true
        this.DrawAccuracy();
        this.DrawEfficiency();
        this.DrawPredictor();
      },
      disappear(){
        this.showTaskMoreDetail=false
      },
      DrawAccuracy(){
        var self=this;
        let myChart=this.$echarts.init(document.getElementById("accuracy"));
            myChart.setOption({
              title: {
                text: '准确度统计',
                subtext: '根据以往数据'
              },
              tooltip: {
                trigger: 'axis',
                axisPointer: {
                  type: 'cross'
                }
              },
              toolbox: {
                show: true,
                feature: {
                  saveAsImage: {}
                }
              },
              xAxis:  {
                type: 'category',
                boundaryGap: false,
                data: self.accuracy_Time
              },
              yAxis: {
                type: 'value',
                axisLabel: {
                  formatter: '{value} '
                },
                axisPointer: {
                  snap: true
                }
              },
              visualMap: {
                show: false,
                dimension: 0,
                pieces: [{
                  lte: 6,
                  color: 'green'
                }, {
                  gt: 6,
                  lte: 8,
                  color: 'green'
                }, {
                  gt: 8,
                  lte: 14,
                  color: 'green'
                }, {
                  gt: 14,
                  lte: 17,
                  color: 'green'
                }, {
                  gt: 17,
                  color: 'green'
                }]
              },
              series: [
                {
                  name:'用电量',
                  type:'line',
                  smooth: true,
                  data:self.accuracy_Series
                }
              ]
            })
      },
      DrawEfficiency(){
        let myChart=this.$echarts.init(document.getElementById("efficiency"));
        var self=this;
            myChart.setOption({
              title: {
                text: '效率统计',
                subtext: '根据以往数据'
              },
              tooltip: {
                trigger: 'axis',
                axisPointer: {
                  type: 'cross'
                }
              },
                toolbox: {
                show: true,
                feature: {
                  saveAsImage: {}
                }
              },
              xAxis:  {
                type: 'category',
                boundaryGap: false,
                data: self.effienciy_Time
              },
              yAxis: {
                type: 'value',
                axisLabel: {
                  formatter: '{value} '
                },
                axisPointer: {
                  snap: true
                }
              },
              visualMap: {
                show: false,
                dimension: 0,
                pieces: [{
                  lte: 6,
                  color: 'green'
                }, {
                  gt: 6,
                  lte: 8,
                  color: 'green'
                }, {
                  gt: 8,
                  lte: 14,
                  color: 'green'
                }, {
                  gt: 14,
                  lte: 17,
                  color: 'green'
                }, {
                  gt: 17,
                  color: 'green'
                }]
              },
              series: [
                {
                  name:'用电量',
                  type:'line',
                  smooth: true,
                  data:self.effiencicy_Series,
                }
              ]
            })
      },

      DrawPredictor(){
        var self=this;
        let myChart=this.$echarts.init(document.getElementById("predictor"));
        var colors = ['#5793f3', '#d14a61', '#675bba'];
        console.log(self.accuracy_Forcast_Series+" "+self.accuracy_Forcast_P+" "+self.effiencicy_Forcast_P+" "+self.effienciy_Forcast_Series)
        myChart.setOption({
          color: colors,
          title:{
            text:"准确度与效率预测图"
          },
          tooltip: {
            trigger: 'none',
            axisPointer: {
              type: 'cross'
            }
          },
          toolbox: {
            show: true,
            feature: {
              saveAsImage: {}
            }
          },
          legend: {
            data:['准确度', '效率']
          },
          grid: {
            top: 70,
            bottom: 50
          },
          xAxis: [
            {
              type: 'category',
              axisTick: {
                alignWithLabel: true
              },
              axisLine: {
                onZero: false,
                lineStyle: {
                  color: colors[1]
                }
              },
              axisPointer: {
                label: {
                  formatter: function (params) {
                    return '准确度  ' + params.value
                      + (params.seriesData.length ? '：' + params.seriesData[0].data : '');
                  }
                }
              },
              data:self.accuracy_Forcast_Series
            },
            {
              type: 'category',
              axisTick: {
                alignWithLabel: true
              },
              axisLine: {
                onZero: false,
                lineStyle: {
                  color: colors[0]
                }
              },
              axisPointer: {
                label: {
                  formatter: function (params) {
                    return '效率  ' + params.value
                      + (params.seriesData.length ? '：' + params.seriesData[0].data : '');
                  }
                }
              },
              data:self.effienciy_Forcast_Series
            }
          ],
          yAxis: [
            {
              type: 'value'
            }
          ],
          series: [
            {
              name:'准确度预测',
              type:'line',
              xAxisIndex: 1,
              smooth: true,
              data: self.accuracy_Forcast_P
            },
            {
              name:'效率预测',
              type:'line',
              smooth: true,
              data: self.effiencicy_Forcast_P
            }
          ]
        })
      },
      DrawLeida(){
        var self=this;
            let myChart=self.$echarts.init(document.getElementById("leida"));
            console.log(self.Leida)
            myChart.setOption({
              title: {
                text: '工人能力图'
              },
              tooltip: {},
              legend: {
                data: ['具体详情']
              },
              radar: {
                // shape: 'circle',
                name: {
                  textStyle: {
                    color: '#fff',
                    backgroundColor: '#999',
                    borderRadius: 3,
                    padding: [3, 5]
                  }
                },
                indicator: [
                  { name: '平均效率', max:1},
                  { name: '平均准确度', max: 1},
                  { name: '经验', max: 5},
                  { name: '活跃度', max: 5},
                ]
              },
              series: [{
                name: '预算 vs 开销',
                type: 'radar',
                // areaStyle: {normal: {}},
                data : [
                  {
                    value : self.Leida,
                    name : '具体详情'
                  },
                ]
              }]
            })
      },

      //得到表格的数据
      getTaskData(){
        var self=this
        var userID=window.localStorage.getItem("userID")
        this.$http.get('api/worker/taskanalysis/'+userID)
          .then(function (response) {
            self.originData=response.data
            self.tableData1=response.data
          })
          .catch(function (error) {
            console.log("工人数据统计错误"+error)
          })
      },


      getFour(){
        var self=this
        var userID=window.localStorage.getItem("userID")
        this.$http.get('api/worker/getFour/'+userID)
          .then(function (response) {
            self.ongoing=response.data.ongoing
            self.complete=response.data.finish
            self.point=response.data.awards
            self.ranking=response.data.ranking
          })
          .catch(function (error) {
            console.log(error)
          })
      },
      init(){
        this.getTaskData()
      },

      mockTableData1 () {
        let data = [];
        for (let i = 0; i < 10; i++) {
          data.push({
            name: 'Business' + Math.floor(Math.random () * 100 + 1),
            status: Math.floor(Math.random () * 3 + 1),
            portrayal: ['City', 'People', 'Cost', 'Life', 'Entertainment'],
            people: [
              {
                n: 'People' + Math.floor(Math.random () * 100 + 1),
                c: Math.floor(Math.random () * 1000000 + 100000)
              },
              {
                n: 'People' + Math.floor(Math.random () * 100 + 1),
                c: Math.floor(Math.random () * 1000000 + 100000)
              },
              {
                n: 'People' + Math.floor(Math.random () * 100 + 1),
                c: Math.floor(Math.random () * 1000000 + 100000)
              }
            ],
            time: Math.floor(Math.random () * 7 + 1),
            update: new Date()
          })
        }
        return data;
      },
      formatDate (date) {
        const y = date.getFullYear();
        let m = date.getMonth() + 1;
        m = m < 10 ? '0' + m : m;
        let d = date.getDate();
        d = d < 10 ? ('0' + d) : d;
        return y + '-' + m + '-' + d;w
      },
      changePage (page) {
        console.log(page)
        // The simulated data is changed directly here, and the actual usage scenario should fetch the data from the server
        this.tableData1 = this.mockTableData1();
      }


    },
    created(){
      this.init()
      this.userID=window.localStorage.getItem("userID");
      var self=this;
      this.$http.get('api/worker/init/'+self.userID)
        .then(function (response) {
          var temp=new Array
          temp=response.data.split(";")
          console.log(temp)
          self.TopTenID=temp[0].split(",");
          self.TopTenAvatol=temp[1].split(",");
          self.TopTenPoints=temp[2].split(",");
          self.TopTenAccuracy=temp[3].split(",");
          self.TopTenEffiencicy=temp[4].split(",");
          self.Leida=temp[5].split(",");
          self.effienciy_Time=temp[6].split(",");
          self.effiencicy_Series=temp[7].split(",");
          self.accuracy_Time=temp[8].split(",");
          self.accuracy_Series=temp[9].split(",");
          self.effienciy_Forcast_Series=temp[10].split(",");
          self.effiencicy_Forcast_P=temp[11].split(",");
          self.effiencicy_Most_P=temp[12];
          self.accuracy_Forcast_Series=temp[13].split(",");
          self.accuracy_Forcast_P=temp[14].split(",");
          self.accuracy_Most_P=temp[15];
          self.DrawLeida();
        })
      this.getFour()
    },

    show (index) {
      this.$Modal.info({
        title: 'Task Detail',
        content: `任务编号${this.data2[index].taskId}<br>发起者：${this.data2[index].situation}`
      })
    },
  }
</script>
