<template>
  <div class="layout">
   <myheader></myheader>
    <br>
    <slider></slider>

    <div style="width: 80%;height: 700px">
      <img src="../../images/zhongbao.png" style="background-size: cover"/>
    </div>


    <div style="width: 100%;height: 400px">
        <!--<div style="margin-left: 20px;margin-top: 20px">-->
            <!--<p style="font-size: 40px;color: #2b85e4;float: left">| </p>-->
            <!--<p style="font-size: 40px;float: left;margin-left: 2%">   产品优势</p>-->
        <!--</div>-->

      <div style="width: 40% ;height: 80%;float: left;background-size: cover;margin-top: 2%;margin-left:2%">
      <img src="../../images/area.png" style="width: 100%;height: 100%"/>
     </div>

      <div style="width: 8%;float: left;height: 100%;margin-left: 0">
        <br><br><br><br><br><br>
        <h4>整体标注模式</h4>
        <br><br><br><br>
        <h4>对整张图片进行综合的描述</h4>
      </div>

      <div style="width: 40% ;height: 80%;float: left;margin-top: 2%;background-size: cover">
        <img src="../../images/area2.png" style="width: 100%;height: 100%"/>
      </div>
      <div style="width: 8%;float: left;height: 100%;margin-left: 0">
        <br><br><br><br><br><br>
        <h4>局部标注模式</h4>
        <br><br><br><br>
        <h4>对图片的某些重要的部分进行的描述</h4>
      </div>


    </div>

  </div>
</template>
<script>
  import slider from '@/components/home/Slider'
  import myheader from '@/components/HeaderII'
  export default {
    components:{
      slider,
      myheader
    }
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
  .layout-logo{
    width: 100px;
    height: 30px;
    background: #5b6270;
    border-radius: 3px;
    float: left;
    position: relative;
    top: 15px;
    left: 20px;
  }
  .layout-header{
    height: 60px;
    background: #fff;
    box-shadow: 0 1px 1px rgba(0,0,0,.1);
  }
  .layout-copy{
    text-align: center;
    padding: 10px 0 20px;
    color: #9ea7b4;
  }
  .layout-ceiling{
    background: #464c5b;
    padding: 10px 0;
    overflow: hidden;
    height: 100px;
  }
  .layout-ceiling-main{
    float: right;
    margin-right: 15px;
  }
  .layout-ceiling-main a{
    color: #9ba7b5;
  }
</style>
