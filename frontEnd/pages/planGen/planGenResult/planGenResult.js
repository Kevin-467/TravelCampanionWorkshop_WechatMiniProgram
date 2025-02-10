// pages/planGen/planGenResult/planGenResult.js
Page({
  data: {
    tip:'',
    personality: '',
    hobbies:'',
    budget: '',
    preferences: '',
    tim:'',
    plan:''
  },

  getTravelPlan: function (){
    wx.showLoading({
      title: '个性化旅游方案生成中'
    })

    // GET/POST请求 将数据发送到后端，并从后端获取生成的个性化旅游方案( 后端接口? )
    wx.request({
      url:'#', // url = ???
      data: {
        personality: this.data.personality,
        hobbies:this.data.hobbies,
        budget: this.data.budget,
        preferences: this.data.preferences,
        travelDays:this.data.time
      },
      timeout:25000,
      success:(res)=>{
        wx.hideLoading()
        if(res.data&&res.plan){
          this.setData({
            tip:'已为您生成以下旅游方案',
            plan:res.data.plan
          })
        } else {
          //未能生成旅游路线
          wx.showModal({
            title:'温馨提示',
            content:'很抱歉，未能为您生成旅游方案！',
            showCancel:false,
            confirmText:'确认'
          })
        }
      },
      fail:(err)=>{
        wx.hideLoading()
        if (err.errMsg.includes('timeout')) {
          wx.showToast({
            title: '请求超时,未能为您生成旅游方案！',
            icon:'none',
            duration:2500
          })
        }
      }
    })
  },

  onLoad(options) {
    this.setData({
      personality: decodeURIComponent(options.personality||''),
      preferences: decodeURIComponent(options.preferences||''),
      hobbies:decodeURIComponent(options.hobbies||''),
      time: decodeURIComponent(options.time||''),
      budget: decodeURIComponent(options.budget||''),
      plan:'',
      tip:'正在为您生成个性化的旅游方案！'
    })
    
  },
  
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady() {
    this.getTravelPlan()
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow() {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide() {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload() {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh() {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom() {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage() {

  }
})