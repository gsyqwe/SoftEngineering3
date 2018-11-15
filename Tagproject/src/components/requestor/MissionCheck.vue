<template>
  <div>
    <Input
      icon="search"
      placeholder="请输入搜索内容..."
      style="width: 300px;float: right"
      size="default"
    />
    <br><br>

    <div style="background:#eee;padding: 20px;width: 20%;float:left;height: 400px">
      <Card :bordered="false">
        <Icon type="help-circled" size="50" style="margin-left: 35%;"></Icon>
        <p slot="title" style="margin-left: 35%;">温馨提示</p>
        <br><br><br>
        <p>此界面可以对您发布的任务进行评价</p><br><br><br>
        <p>您的评价将关系到每一个工人的工作质量评价</p><br>
      </Card>
    </div>


    <div style="width: 80%;float:left;">
      <Table stripe height="400" :columns="columns" :data="data"></Table>
    </div>
  </div>
</template>
<script>
  export default {

    created(){
      this.init()
    },
    data () {
      return {
        columns: [
          {
            title: '工人名',
            render: (h, params) => {
              return h('div', [
                h('Icon', {
                  props: {
                    type: 'person'
                  }
                }),
                h('strong', params.row.workerID)
              ]);
            }
          },
          {
            title: '任务名',
            key: 'taskID'
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
                      this.Check(params.index)
                    }
                  }
                }, '评审'),



              ]);
            }
          }
        ],
        data: []


      }
    },
    methods: {
      //显示某一行数据
      show (index) {
        this.$Modal.info({
          title: 'Task Detail',
          content: `WorkerID：${this.data[index].workerID}<br>TaskID：${this.data[index].taskID}<br>`
        })
      },


      Check(index){
        this.$router.push({
          name: 'missioncheckdetail',
          params:{
            taskID:this.data[index].taskID,
            userID:this.data[index].workerID,

          }
        })

      },

      //界面初始化得到数据
      init(){
        var self=this
        var userID = window.localStorage.getItem("userID")
        this.$http.get('api/requestor/querytasks/'+userID)
          .then(function (response) {
             self.data=response.data
          })
          .catch(function (error) {
            console.log("发起者评审任务错误:"+error)
          })
      }


    }
  }
</script>
