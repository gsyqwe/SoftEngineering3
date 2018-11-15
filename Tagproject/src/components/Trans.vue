<template>
  <div  style="margin-top: 100px;margin-left: 40%">
    <atom-spinner
      :animation-duration="1000"
      :size="200"
      color="#ff5050"
    />
    <p style="font-size: 20px;float: left">加载中</p><Spin style="float: left"></Spin>
    <Spin style="float: left"></Spin>
    <Spin style="float: left"></Spin>
    <Spin style="float: left"></Spin>

    <!--<intersecting-circles-spinner-->
      <!--:animation-duration="1200"-->
      <!--:size="70"-->
      <!--color="#ff1d5e"-->
    <!--/>-->

    <!--<semipolar-spinner-->
      <!--:animation-duration="2000"-->
      <!--:size="65"-->
      <!--color="#ff1d5e"-->
    <!--/>-->

    <!--<orbit-spinner-->
      <!--:animation-duration="1200"-->
      <!--:size="55"-->
      <!--color="#ff1d5e"-->
    <!--/>-->

    <!--<trinity-rings-spinner-->
      <!--:animation-duration="1500"-->
      <!--:size="66"-->
      <!--color="#ff1d5e"-->
    <!--/>-->
  </div>
</template>

<script>
  // To use minified css and js files instead of .vue single file components:
  // import 'epic-spinners/dist/lib/epic-spinners.min.css'
  // import {AtomSpinner} from 'epic-spinners/dist/lib/epic-spinners.min.js'

  import 'epic-spinners/dist/lib/epic-spinners.min.css'
  import {AtomSpinner} from 'epic-spinners'
  import { IntersectingCirclesSpinner } from 'epic-spinners'
  import { SemipolarSpinner  } from 'epic-spinners'
  import { OrbitSpinner } from 'epic-spinners'
  import { TrinityRingsSpinner } from 'epic-spinners'
  export default {
    components: {
      AtomSpinner,
      IntersectingCirclesSpinner,
      SemipolarSpinner,
      OrbitSpinner,
      TrinityRingsSpinner
    }
  }
</script>
