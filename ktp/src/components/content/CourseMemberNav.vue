<template>
  <navigation class="task-commit-nav">
    <template v-slot:left><div style="cursor: pointer" @click="back"><i class="el-icon-back" /><span>{{cname}}</span></div></template>
    <template v-slot:right>
      <div class="rstyle">
        <div>
          <el-badge :value="msgNum" :hidden="hiddenOrNot" class="item">
            <i style="font-size: 25px" class="el-icon-bell" @click="gotoMessage" />
          </el-badge>
        </div>
        <div>
          <el-popover
            placement="bottom"
            trigger="click"
            content="这是一段内容">
            <!-- 弹出框 -->
            <div class="nav-btn">
              <div @click="gotoProfile"><i class="setting" />个人设置</div>
              <div @click="logout"><i class="exit" />退出账户</div>
            </div>
            <!-- 点击效果 -->
            <div class="avatar" slot="reference"><img :src="avatar" /></div>
          </el-popover>
        </div>
      </div>
    </template>
  </navigation>
</template>

<script>
import Navigation from 'components/common/Navigation'
import {request} from "../../network/request"
import {IS_LOGIN, CHANGE_UID} from "../../store/mutation-type"

export default {
  name: 'CourseMemberNav',
  components: {
    Navigation
  },
  props: {
    cname: String,
    cno: {
      type: String,
      default: ''
    }
  },
  data() {
    return {
      avatar: '',
      msgNum: 0,
      hiddenOrNot: false
    }
  },
  mounted() {
    // 加载头像
    this.avatar = require('../../assets/avatar/' + this.$store.state.avatar)

    // 查询消息数量
    request({
      url: '/api/message/getNotReadCount',
      method: 'get',
      params: {
        to: this.$store.state.uid
      }
    }).then(res => {
      this.msgNum = res.data
      this.hiddenOrNot = this.msgNum === 0
    }).catch(err => {
      console.log(err)
    })
  },
  methods: {
    logout() {
      this.$store.commit(CHANGE_UID, '')
      this.$store.commit(IS_LOGIN, '')

      // 删除cookie
      this.$cookies.remove("user")

      this.$router.push('/')
      
    },
    msgMinis() {
      this.msgNum--
      if (this.msgNum === 0) {
        this.hiddenOrNot = true
      } else {
        this.hiddenOrNot = false
      }
    },
    gotoMessage() {
      if (this.$route.path !== '/message') {
        this.$router.push('/message')
      }
    },
    gotoProfile() {
      if (this.$route.path !== '/profile') {
        this.$router.push('/profile')
      }
    },
    back() {
      this.$emit('back')
    },
  }
}
</script>

<style scoped>
  .task-commit-nav {
    background: #fff;
    position: fixed;
    z-index: 50;
    box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.04);
  }

  .el-icon-back {
    font-size: 25px;
    font-weight: bold;
    width: 27px;
    height: 25px;
    vertical-align: middle;
  }
  .el-icon-back+span {
    line-height: 32px;
    vertical-align: middle;
    margin-left: 14px;
    display: inline-block;
    height: 32px;
    border-radius: 16px;
    font-size: 14px;
    font-family: PingFangSC-Medium;
    font-weight: 500;
    padding: 0 10px;
    min-width: 80px;
    text-align: center;
    background: #2c58ab;
    color: #fff;
  }

  .avatar>img {
    width: 30px;
    height: 30px;
    background-repeat: no-repeat;
    background-position: center;
    border-radius: 50%;
  }

  .lstyle {
    display: inline-block;
    vertical-align: middle;
    height: 24px;
  }

  .rstyle {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    width: 85px;
  }

  .avatar {
    border: 0;
    border-radius: 50%;
    width: 30px;
    height: 30px;
    cursor: pointer;
  }

  .el-icon-bell {
    cursor: pointer;
  }

  /* 弹出框 */
  .nav-btn>div {
    cursor: pointer;
    width: 100%;
    padding-left: 10px;
    text-align: left;
    user-select: none;
    font-size: 14px;
    height: 40px;
    line-height: 40px;
  }
  .nav-btn>div:hover {
    background: #f2f2f2;
  }
  .setting {
    display: inline-block;
    vertical-align: middle;
    background: url('../../assets/img/Setting.png') no-repeat 0/14px;
    width: 30px;
    height: 40px;
  }
  .exit {
    display: inline-block;
    vertical-align: middle;
    background: url('../../assets/img/exit.png') no-repeat 0/14px;
    width: 30px;
    height: 40px;
  }

  /* 消息提示 */
  .item {
    margin-top: 10px;
    margin-right: 40px;
  }

  .back-home {
    cursor: pointer;
  }
</style>