//app.js
//token有效期限（单位:ms）
const DURATION = 10000

App({
  globalData: {
    defaultAvatarUrl:
      "https://mmbiz.qpic.cn/mmbiz/icTdbqWNOwNRna42FI242Lcia07jQodd2FJGIYQfG0LAJGFxM4FbnQP6yfMxBgJ0F3YRqJCJ1aPAK2dQagdusBZg/0",
  },

  onLaunch: function () {
    this.checkLogin()
  },
  
  //检查登录态、token有无、token是否过期
  checkLogin() {
    //如果本地缓存有token,检查其是否有效，无效则刷新token
    const tokenObj = wx.getStorageSync('tokenObj')
    const loginStatus = wx.getStorageSync('loginStatus')
    if(tokenObj&&loginStatus){
      const curTime = Date.now()
      console.log(curTime)
      
      const {expiration_time} = tokenObj
      if(curTime >= expiration_time){
        wx.setStorageSync('loginStatus',0)
        this.login()
      }
    } else {
      //如果本地没有token,发请求从后台获取
      this.login()
    }
  },

  login() {
    wx.login({
      success:(res)=>{
        wx.request({
          url:'http://127.0.0.1:8000/login',
          method:'POST',
          data:{
            code:res.code
          },
          success:(res)=>{
            console.log(res)
            const {loginStatus,token} = res.data.data
            this.saveLoginInfo(token,loginStatus)
          }
        })
      }
    })
  },

  //将获取的token对象存入本地缓存
  saveLoginInfo(token,loginStatus) {
    const expiration_time = Date.now()+DURATION
    const tokenObj = {
      token, //token
      expiration_time //过期时间
    }
    wx.setStorageSync('tokenObj', tokenObj) 
    wx.setStorageSync('loginStatus',loginStatus) //登录态
  }
});
