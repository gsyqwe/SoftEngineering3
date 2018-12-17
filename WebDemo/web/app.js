import Vue from 'js/vue.js'
import Router from 'js/vue-router.js'
import not from 'compoents/Not.vue'
import already from 'components/Already.vue'

Vue.use(Router)
export  default new Router({
    routes:[
        {
            path:'/not',
            component:not
        },
        {
            path:'/already',
            component:already
        }
     ]
    }
)
