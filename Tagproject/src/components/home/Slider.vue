<template >
  <Carousel autoplay v-model="value1" loop style="width:100%" >



    <CarouselItem>
      <div class="carousel" style="height: 500px" >
        <img src="../../images/bg5.jpg" width="110%" height="480px"/>
        <h1 style="margin-left: 10%;margin-top: -400px;font-weight: bold;color: white">数据众包服务</h1>
        <p style="margin-top: 40px;margin-left:10%;color: white">数据众包服务，使用低成本高效率的众包模式满足客户对数据的需求，可采集大量的原始数据，通过数据加<br>工，为客户交付标准化结构化的可用数据。帮助客户训练算法模型、开展机器学习，提高AI领域的竞争力。</p>
      </div>
    </CarouselItem>

    <CarouselItem>
      <div class="carousel" style="height: 500px" >
        <img src="../../images/bg6.jpg" width="110%" height="480px"/>
        <h1 style="margin-left: 10%;margin-top: -400px;font-weight: bold;color: white">数据众包服务</h1>
        <p style="margin-top: 40px;margin-left:10%;color: white">数据众包服务，使用低成本高效率的众包模式满足客户对数据的需求，可采集大量的原始数据，通过数据加<br>工，为客户交付标准化结构化的可用数据。帮助客户训练算法模型、开展机器学习，提高AI领域的竞争力。</p>
      </div>

    </CarouselItem>

    <CarouselItem>
      <div class="carousel" style="height: 500px" >
        <img src="../../images/bg3.jpg" width="110%" height="480px"/>
        <h1 style="margin-left: 10%;margin-top: -400px;font-weight: bold;color: white">数据众包服务</h1>
        <p style="margin-top: 40px;margin-left:10%;color: white">数据众包服务，使用低成本高效率的众包模式满足客户对数据的需求，可采集大量的原始数据，通过数据加<br>工，为客户交付标准化结构化的可用数据。帮助客户训练算法模型、开展机器学习，提高AI领域的竞争力。</p>
      </div>
    </CarouselItem>
  </Carousel>
</template>
<script>
  export default {
    data () {
      return {
        value1: 0
      }
    }
  }
</script>

<style scoped>
  .bg1{
    height: 400px;
    width: 100%;
    background-image: url("../../images/bg3.jpg");
    background-size: cover;
  }

  .carousel{
    width: 100%;
  }
</style>
