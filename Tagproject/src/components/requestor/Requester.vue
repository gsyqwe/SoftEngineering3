<template>
    <div>

      <myheader ></myheader>
      <Requestertag></Requestertag >
    </div>
</template>

<script>
  import myheader from '@/components/requestor/RequestorHeader'
  import Requestertag from '@/components/requestor/RequesterTag'
    export default {
      components:{
        myheader,
        Requestertag
      },
      data(){
        return{id:''}
      },

    }
</script>

<style scoped>

</style>
