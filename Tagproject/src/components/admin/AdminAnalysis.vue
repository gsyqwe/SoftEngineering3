<template>
  <div style="background-color: #6d7380">
    <!--<div style="width: 85%;height: 100px;margin-left: 15%;">-->


      <!--<div style="width:15%;height: 100px;border-radius: 5px;float:left;border:4px solid  #755567">-->
        <!--<div style="width: 65px;height: 90px;background-color: #2b85e4;float: left;border-radius: 4px">-->
          <!--<Icon type="clipboard" color=white size=50 style="margin-left: 25%;margin-top: 40%"></Icon>-->
        <!--</div>-->

        <!--<div style="width: 120px;height: 90px;float: left;border-radius: 4px;background-color: #e1f0fe">-->
          <!--<p style="text-align: center;margin-top: 8%;font-size: 40px;color: #2b85e4" >{{tasknum}}</p>-->
          <!--<p style="margin-left: 30%;color: #6d7380;opacity: 0.6"> 任务数</p>-->

        <!--</div>-->
      <!--</div>-->

      <!--&lt;!&ndash;第二个&ndash;&gt;-->
      <!--<div style="width:15%;height: 100px;border-radius: 5px;float:left;border:4px solid  #755567">-->
        <!--<div style="width: 65px;height: 90px;background-color:greenyellow;float: left;border-radius: 4px">-->
          <!--<Icon type="ios-book-outline" color=white size=50 style="margin-left: 25%;margin-top: 40%"></Icon>-->
        <!--</div>-->

        <!--<div style="width: 120px;height: 90px;float: left;border-radius: 4px;background-color: #e1f0fe">-->
          <!--<p style="text-align: center;margin-top: 8%;font-size: 40px;color: greenyellow" >{{taskongoing}}</p>-->
          <!--<p style="margin-left: 10%;color: #6d7380;opacity: 0.6" > 正在进行的任务数</p>-->

        <!--</div>-->
      <!--</div>-->

      <!--&lt;!&ndash;第三个&ndash;&gt;-->
      <!--<div style="width:15%;height: 100px;border-radius: 5px;float:left;border:4px solid  #755567">-->
        <!--<div style="width: 65px;height: 90px;background-color: orange;float: left;border-radius: 4px">-->
          <!--<Icon type="ios-person" color=white size=50 style="margin-left: 25%;margin-top: 40%"></Icon>-->
        <!--</div>-->

        <!--<div style="width: 120px;height: 90px;float: left;border-radius: 4px;background-color: #e1f0fe">-->
          <!--<p style="text-align: center;margin-top: 8%;font-size: 40px;color:orange" >{{workernum}}</p>-->
          <!--<p style="margin-left: 30%;color: #6d7380;opacity: 0.6"> 用户数</p>-->

        <!--</div>-->
      <!--</div>-->
      <!--&lt;!&ndash;第4个&ndash;&gt;-->
      <!--<div style="width:15%;height: 100px;border-radius: 5px;float:left;;border:4px solid  #755567">-->
        <!--<div style="width: 65px;height: 90px;background-color: rebeccapurple;float: left;border-radius: 4px">-->
          <!--<Icon type="ios-analytics" color=white size=50 style="margin-left: 20%;margin-top: 40%"></Icon>-->
        <!--</div>-->

        <!--<div style="width: 120px;height: 90px;float: left;border-radius: 4px;background-color: #e1f0fe">-->
          <!--<p style="text-align: center;margin-top: 8%;font-size: 40px;color: rebeccapurple" >{{taskalready}}</p>-->
          <!--<p style="margin-left: 10%;color: #6d7380;opacity: 0.6"> 已经完成的任务数</p>-->

        <!--</div>-->
      <!--</div>-->

    <!--</div>-->


    <div class="layout" id="layout">
      <Sider :style="{position: 'absolute', height: '200vh', left: 0, overflow: 'auto'}">
        <Menu active-name="1-2" theme="dark" width="auto" :open-names="['1']">
          <MenuItem name="1" @click.native="changeflagwhole">
            <Icon type="ios-navigate"></Icon>
            全部发起者任务查看
          </MenuItem>
          <Submenu name="2">
            <template slot="title" >
              <Icon type="ios-keypad" ></Icon>
              工人查看
            </template>

            <Menu-item v-for="item in workerName" :name="item" @click.native="CheckWorker(item)">
              {{item}}
            </Menu-item>

          </Submenu>
          <Submenu name="3">
            <template slot="title">
              <Icon type="ios-analytics"></Icon>
              发起者查看
            </template>

            <Menu-item v-for="item in requestorName" :name="item" @click.native="CheckRequestor(item)">{{item}}</Menu-item>
          </Submenu>
        </Menu>
      </Sider>

      <Layout :style="{marginLeft: '200px'}" >
        <!--总的查看-->
        <div style="width: 100%;margin-top: 100px" id="total" v-show="show_total">
          <div id="echartAnalyse" style="width:100%;height:400px"></div>
        </div>


        <div style="width: 100%" id="worker" v-show="show_worker">
        <div id="leida" style="float:left;width:500px;height: 500px" ></div>
        <div id="accuracy" style="width:400px;height:200px;float:left"></div>
        <div id="efficiency" style="width:400px;height:200px;float:left"></div>
        <div id="predictor" style="width:600px ;height:300px;float:left"></div>

    </div>

        <div style="width: 100%" id="requestor" v-show="show_requestor">
          <div id="requestoranalysis" style="width:100%;height:400px"></div>
        </div>

        <Modal v-model="showBigData" name="235" :closable='false' :mask-closable=false width="800">
          <label>任务统计：</label>
          <Table stripe height="500" width="700" :columns="taskcolumns" :data="taskdata" style="margin-left: 40px"></Table>
          <div slot="footer" style="margin-top: 20px">
            <Button type="primary"  @click="disappearII">确定</Button>
          </div>
        </Modal>


      </Layout>
  </div>
  </div>
</template>

<script>
  import Schart from 'vue-schart';
  export default {
    created(){
      this.init()

    },
    data() {
      return {
        showBigData:false,
        show_total:true,
        show_worker:true,
        show_requestor:false,
        Sum_year_released:[],
        Sum_year_obtained:[],
        Sum_year_finished:[],
        Sum_season_released:[],
        Sum_season_obtained:[],
        Sum_season_finished:[],
        Sum_month_released:[],
        Sum_month_obtained:[],
        Sum_month_finished:[],
        Sum_week_released:[],
        Sum_week_obtained:[],
        Sum_week_finished:[],
        //单个工人统计存放信息处
        workerName:[],//放工人id
        requestorName:[],//放发起者id
        requestorId:"",
        WorkerLeida:[],//0是准确度，1是效率，2是经验，3是活跃度
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
        //单个发起者统计存放信息处
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
        //其他数据
        data: [],
        tasknum:1,
        taskongoing:0,
        taskalready:0,
        workernum:10,
        option3:{
          title: '任务进行情况',
          bgColor: '#829dca',
          titleColor: '#ffffff',
          legendColor: '#ffffff'
        },
        tabledata:[],
        columns: [
          {
            title: '工人',
            render: (h, params) => {
              return h('div', [
                h('Icon', {
                  props: {
                    type: 'person'
                  }
                }),
                h('strong', params.row.userID)
              ]);
            }
          },
          {
            title: '积分',
            key: 'awards'
          },
          {
            title:'排名',
            key:'ranking'
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
                }, '查看'),



              ]);
            }
          }
        ],



        columnsII: [
          {
            title: '发起者',
            render: (h, params) => {
              return h('div', [
                h('Icon', {
                  props: {
                    type: 'person'
                  }
                }),
                h('strong', params.row.userID)
              ]);
            }
          },
          {
            title: '积分',
            key: 'awards'
          },
          {
            title:'排名',
            key:'ranking'
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
                }, '查看'),



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

        ],
        taskdata:[],

      }
    },
    components:{
      Schart
    },

    methods:{
      formatDate (time) {
        let date = new Date(time);
        let year = date.getFullYear();
        let month = date.getMonth() + 1;
        let day = date.getDate();
        return year + '/' + month + '/' + day ;
      },
      disappearII(){
        this.showBigData=false
      },
      DrawPredictor(){
        var self=this;
        let myChart=this.$echarts.init(document.getElementById("predictor"));
        var colors = ['#5793f3', '#d14a61', '#675bba'];
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
              data:self.accuracy_Forcast_P
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
              data:self.effiencicy_Forcast_P
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
              data: self.accuracy_Forcast_Series
            },
            {
              name:'效率预测',
              type:'line',
              smooth: true,
              data: self.effienciy_Forcast_Series
            }
          ]
        })
      },

      DrawLeida(){
        var self=this;
        let myChart=self.$echarts.init(document.getElementById("leida"));
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
              { name: '平均准确度', max: 1},
              { name: '平均效率', max:1},
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
                value : self.WorkerLeida,
                name : '具体详情'
              },
            ]
          }]
        })
      },
      sum:function (value) {
        var result=0;
        for(var number=0;number<value.length;number++){
          result=result+parseInt(value[number]);
        }
        return result;
      },
      //总的
      drawLine(){
        var self=this;
        var year_released_sum=this.sum(self.Sum_year_released);
        var year_obtained_sum=this.sum(this.Sum_year_obtained);
        var year_finished_sum=this.sum(this.Sum_year_finished);
        var season_released_sum=this.sum(self.Sum_season_released);
        var season_obtained_sum=this.sum(this.Sum_season_obtained);
        var season_finished_sum=this.sum(this.Sum_season_finished);
        var month_released_sum=this.sum(self.Sum_month_released);
        var month_obtained_sum=this.sum(this.Sum_month_obtained);
        var month_finished_sum=this.sum(this.Sum_month_finished);
        var week_released_sum=this.sum(self.Sum_week_released);
        var week_obtained_sum=this.sum(this.Sum_week_obtained);
        var week_finished_sum=this.sum(this.Sum_week_finished);
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
                {data:self.Sum_year_released},
                {data:self.Sum_year_obtained},
                {data:self.Sum_year_finished},
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
                {data: self.Sum_season_released},
                {data: self.Sum_season_obtained},
                {data: self.Sum_season_finished},
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
                {data: self.Sum_month_released},
                {data:self.Sum_month_obtained},
                {data: self.Sum_month_finished},
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
                {data: self.Sum_week_released},
                {data: self.Sum_week_obtained},
                {data: self.Sum_week_finished},
                {data: [
                    {name: '发布次数', value:week_released_sum},
                    {name: '领取次数', value:week_obtained_sum},
                    {name: '完成次数', value: week_finished_sum}
                  ]}
              ]
            },
          ]
        });
      },



      //发起者画图
      drawLineII(){
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
        let myChart=this.$echarts.init(document.getElementById("requestoranalysis"));
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
                {data: self.year_released},
                {data:self.year_obtained},
                {data:self.year_finished},
                {data: [
                    {name: '发布次数', value: year_released_sum},
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
        var userID = this.requestorId
        console.log(userID+index+label+type)
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

      //画准确度的图
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
              name:'准确度',
              type:'line',
              smooth: true,
              data:self.accuracy_Series
            }
          ]
        })
      },
      //画效率的图
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
              name:'效率',
              type:'line',
              smooth: true,
              data:self.effiencicy_Series,
            }
          ]
        })
      },




      show (index) {
        this.$Modal.info({
          title: 'Ranking Detail',
          content: `userID：${this.tabledata[index].userID}<br>Awards：${this.tabledata[index].awards}<br>Ranking：${this.tabledata[index].ranking}`
        })
      },
      CheckWorker(Id){
        this.show_requestor=false
        this.show_worker=true
        this.show_total=false
        var self=this;
        this.$http.get('api/admin/CheckWorker/'+Id)
          .then(function (response) {
            var temp=new Array
            temp=response.data.split(";");
            self.WorkerLeida=temp[0].split(",")
            self.accuracy_Time=temp[1].split(",")
            self.accuracy_Series=temp[2].split(",")
            self.effienciy_Time=temp[3].split(",")
            self.effiencicy_Series=temp[4].split(",")
            self.accuracy_Forcast_Series=temp[5].split(",")
            self.accuracy_Forcast_P=temp[6].split(",")
            self.accuracy_Most_P=temp[7]
            self.effienciy_Forcast_Series=temp[8].split(",")
            self.effiencicy_Forcast_P=temp[9].split(",")
            self.effiencicy_Most_P=temp[10]
            self.DrawLeida()
            self.DrawAccuracy()
            self.DrawEfficiency()
            self.DrawPredictor()
          })
      },
      CheckRequestor(Id){
        this.requestorId=Id;
        this.show_requestor=true
        this.show_worker=false
        this.show_total=false
        var self=this
        this.$http.get('api/admin/CheckRequestor/'+Id)
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
            self.drawLineII()
          })
      },
      changeflagwhole(){
        this.show_requestor=false
        this.show_worker=false
        this.show_total=true
      },
    },
    created(){
      var self=this;
      this.userID=window.localStorage.getItem("userID");
      this.$http.get("api/admin/getBigData")
        .then(function (response) {
          var temp=new Array
          temp=response.data.split(";")
          self.Sum_year_released=temp[0].split(",");
          self.Sum_year_obtained=temp[1].split(",");
          self.Sum_year_finished=temp[2].split(",");
          self.Sum_season_released=temp[3].split(",");
          self.Sum_season_obtained=temp[4].split(",");
          self.Sum_season_finished=temp[5].split(",");
          self.Sum_month_released=temp[6].split(",");
          self.Sum_month_obtained=temp[7].split(",");
          self.Sum_month_finished=temp[8].split(",");
          self.Sum_week_released=temp[9].split(",");
          self.Sum_week_obtained=temp[10].split(",");
          self.Sum_week_finished=temp[11].split(",");
          self.workerName=temp[12].split(",");
          self.requestorName=temp[13].split(",");
          self.drawLine();
        })
    },
  }

</script>

<style scoped>
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
