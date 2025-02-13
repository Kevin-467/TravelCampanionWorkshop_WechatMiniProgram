// pages/teamup/teamup.js
Page({
  data: {
    genderOptions: [
      { id: 1, gender: "男", value: 0 },
      { id: 2, gender: "女", value: 1 },
    ],
    nickname: "",
    gender: "",
    travelDays:0,
    budget: 0,
    preference: "",
  },

  // 性别选择变化
  handleChoice: function (e) {
    const gender = e.detail.value;
    this.setData({
      gender: gender,
    });
  },

  //多个滑块共用此函数，用所点击滑块的id来区别设置的数据项
  onSliderChange(e) {
    const typeId = e.target.id;
    this.setData({
      [typeId]: e.detail.value
    })
  },

  submitForm() {
    const {nickname,gender,travelDays,budget,preference} = this.data
    
    if(!nickname||!gender||travelDays === 0||budget === 0||!preference){
     wx.showToast({
        title: '请您先填写完所有信息！',
        icon:'none',
        duration:2000
      })
      return
    }

    const queryObj = {
      nickname,
      gender,
      travelDays,
      budget,
      preference
    }
    const queryStr = Object.keys(queryObj).map(key => `${key}=${encodeURIComponent(queryObj[key])}`).join('&')
    wx.redirectTo({
      url:`/pages/teamup/teamup?${queryStr}`
    })
  },

  resetForm() {
    this.setData({
      nickname: "",
      gender: "",
      travelDays:0,
      budget: 0,
      preference: "",
    })
  },

  //生命周期函数--监听页面加载
  onLoad(options) {
    this.setData({
      travelDays:0,
      budget: 0,
    });
  },

  //生命周期函数--监听页面初次渲染完成
  onReady() {},

  //生命周期函数--监听页面显示
  onShow() {},

  //生命周期函数--监听页面隐藏
  onHide() {},

  //生命周期函数--监听页面卸载
  onUnload() {},

  //页面相关事件处理函数--监听用户下拉动作
  onPullDownRefresh() {},

  //页面上拉触底事件的处理函数
  onReachBottom() {},

  //用户点击右上角分享
  onShareAppMessage() {},
});
