<template>
    <div>

      <div class="md-subhead">

        <span>图片显示:</span>


      </div>

      <swiper id="swiper" :options="swiperOption" style="width: 55%">

        <swiper-slide ><img src="../../images/1.jpg" style="width: 100%;height: 100%;"/></swiper-slide>

        <swiper-slide><img src="../../images/1.jpg" style="width: 100%;height: 100%;"/></swiper-slide>

        <swiper-slide><img src="../../images/1.jpg" style="width: 100%;height: 100%;"/></swiper-slide>

        <swiper-slide><img src="../../images/1.jpg" style="width: 100%;height: 100%;"/></swiper-slide>

        <swiper-slide><img src="../../images/1.jpg" style="width: 100%;height: 100%;"/></swiper-slide>

        <swiper-slide><img src="../../images/1.jpg" style="width: 100%;height: 100%;"/></swiper-slide>

        <swiper-slide><img src="../../images/1.jpg" style="width: 100%;height: 100%;"/></swiper-slide>

        <div class="swiper-pagination" slot="pagination"></div>

      </swiper>

    </div>

</template>



<script>
  export default {


    data() {

      return {

        swiperOption: {

          effect: 'coverflow',

          grabCursor: true,

          centeredSlides: true,

          slidesPerView: 'auto',

          slideToClickedSlide: true,

          preventLinksPropagation : false,


          on: {
            touchEnd: function(){
              console.log(this.activeIndex)
            },
          },


          coverflowEffect: {

            rotate: 50,

            stretch: 0,

            depth: 100,

            modifier: 1,

            slideShadows : true

          },

          pagination: {

            el: '.swiper-pagination'

          }

        }

      }

    },

    methods:{
    }

  }

</script>



<style scoped>

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
