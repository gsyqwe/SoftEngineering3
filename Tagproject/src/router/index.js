import Vue from 'vue'
import Router from 'vue-router'
import  not from '@/components/worker/Not'
import missioncreate from '@/components/requestor/Upload'
import login from '@/components/login'
import already from '@/components/worker/Already'
import worker from '@/components/worker/Worker'
import workanalysis from '@/components/worker/WorkerAnalysis'
import requester from '@/components/requestor/Requester'
import login2 from '@/components/login/Login2'
import requesteranalysis from '@/components/requestor/RequesterAnalysis'
import adminanalysis from '@/components/admin/AdminAnalysis'
import admin from '@/components/admin/Admin'
import missionreceive from '@/components/worker/MissionReceive'
import  missioncheck from '@/components/requestor/MissionCheck'
import webwork from '@/components/worker/webwork';
import  missioncheckdetail from  '@/components/requestor/MissonCheckDetail'
import home from '@/components/home/Home'
import message from '@/components/message/message'
import error from '@/components/error/404'
import missionIntergration from '@/components/requestor/MissionIntegration'
import workerMissionIntegration from  '@/components/worker/MissionIntegration'

import workerPerosonal from '@/components/worker/WorkerPersonal'
import requestorPersonal from  '@/components/requestor/RequestorPersonal'

import missioncheckhistory from '@/components/worker/MissionCheckHistory'


Vue.use(Router)

export default new Router({
  //mode:'history',
  routes: [
    {
      path:'/',
      name:'home',
      component:home

    },

    {
      path:'/login',
      name:'login',
      component:login2
    },


    {
      path:'/worker',
      name:'worker',
      component:worker,
      redirect:'/already',
      children:[
        {
          path:'/already',
          name:'already',
          component:already
        },
        {
          path:'/not',
          name:'not',
          component:not

        },
        {
          path:'/missionreceive',
          name:missionreceive,
          component:missionreceive
        },
        {
          path:'/workanalysis',
          name:'workanalysis',
          component:workanalysis
        },
        {
          path:'/webwork',
          name:'webwork',
          component:webwork,
        },
        {
          path:'/workermessage',
          name:'workermessage',
          component:message
        },
        {
          path:'/workerpersonal',
          name:'workerpersonal',
          component:workerPerosonal
        },
        {
          path:'/wokermissionintegration',
          name:'workermissionintegration',
          component:workerMissionIntegration
        },
        {
          path:'/wokermissionincheckhistory',
          name:'wokermissionincheckhistory',
          component:missioncheckhistory
        },
        {
          path:'*',
          redirect:'/worker'
        }
      ],



    },
    {
      path:'/requester',
      name:'requester',
      component:requester,
      redirect:'/missioncreate',
      children:[
        {
          path: '/missioncreate',
          name:'missioncreate',
          component:missioncreate
        },
        {
          path:'/missioncheck',
          name:'missioncheck',
          component:missioncheck
        },
        {
          path:'/requesteranalysis',
          name:'requesteranalysis',
          component:requesteranalysis
        },
        {
          path:'/missioncheckdetail',
          name:'missioncheckdetail',
          component:missioncheckdetail
        },
        {
          path:'/requestorpersonal',
          name:'requestorpersonal',
          component:requestorPersonal
        },
        {
          path:'/missionintegration',
          name:'missionintegration',
          component:missionIntergration
        },
        {
          path:'*',
          redirect:'/requesteranalysis'
        }
      ]
    },

    {
      path:'/admin',
      name:'admin',
      component:admin,
      redirect:'/adminanalysis',
      children:[
        {
          path:'/adminanalysis',
          name:'adminanalysis',
          component:adminanalysis
        },{
          path:'*',
          redirect:'/adminanalysis'
        }
      ]
    },


    {
      path:'/error',
      name:404,
      component:error
    },
    {
      path:'*',
      redirect:'/error'
    }
  ]
})


