// pages/routeGen/routeGenResult/routeGenResult.js
Page({
  data: {
    tip:'',
    destination: '',
    travelDays:'',
    budget: '',
    preferences: '',
    route:''
  },

  getRoute: function (){
    wx.showLoading({
      title: '生成路线中...',
    })

    // GET/POST请求 将数据发送到后端，并从后端获取生成的旅游路线( 后端接口? )
    wx.request({
      url:'#', // url = ???
      data: {
        destination: this.data.destination,
        travelDays:this.options.travelDays,
        budget: this.data.budget,
        preferences: this.data.preferences,
      },
      timeout:25000,
      success:(res)=>{
        wx.hideLoading()
        if(res.data&&res.route){
          this.setData({
            route:res.data.route,
            tip:'已为您生成旅游路线！'
          })
        } else {
          //未能生成旅游路线
          wx.showModal({
            title:'温馨提示',
            content:'很抱歉，未能为您生成旅游路线！',
            showCancel:false,
            confirmText:'确认'
          })
        }
      },
      fail:(err)=>{
        wx.hideLoading()
        if (err.errMsg.includes('timeout')) {
          wx.showToast({
            title: '请求超时,未能生成旅游路线！',
            icon:'none',
            duration:2500
          })
        }
      }
    })
  },

  onLoad(options) {
    this.setData({
      destination: decodeURIComponent(options.destination||''),
      travelDays:decodeURIComponent(options.travelDays||''),
      budget: decodeURIComponent(options.budget||''),
      preferences: decodeURIComponent(options.preferences||''),
      tip:'正在为您生成旅游路线中...',
      route:''
    })
    this.getRoute()
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady() {
    
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