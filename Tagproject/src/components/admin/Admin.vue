<template>
  <div>

    <myheader ></myheader>
    <admintag></admintag >
  </div>
</template>

<script>
  import myheader from '@/components/HeaderII'
  import admintag from '@/components/admin/AdminTag'
  export default {
    components:{
      myheader,
      admintag
    },
    created(){
      this.getParams()
    },
    data(){
      return{id:''}
    },

    methods:{
      getParams(){
        let temp=this.$route.params.dataobj
        this.id=temp
      }
    },
    watch: {
      // 监测路由变化,只要变化了就调用获取路由参数方法将数据存储本组件即可
      '$route': 'getParams'
    },

  }
</script>

<style scoped>

</style>
