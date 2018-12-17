

<template>
    <div id="app">
        <tab></tab>
        <router-view></router-view>
    </div>
</template>

<script type="text/ecmascript-6">
    import tab from 'compoents/tag'
    //注册？
    export default {
       components:{
           tab
       }
    }
</script>

<style scoped>

</style>