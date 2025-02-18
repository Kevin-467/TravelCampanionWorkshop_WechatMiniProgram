const app = getApp()

Page({
  data: {
    user:{
      nickname:'',
      avatar:'',
    }
  },

  editInfo() {
    wx.navigateTo({
      url:'/pages/me/personalInfo/personalInfo'
    })
  },

  onLoad(options) {
    this.setData({
      user:{
        nickname:'微信用户',
        avatar:app.globalData.defaultAvatarUrl,
      }
    })
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