// pages/teamup/teamup.js
Page({
  data: {
    genderOptions: [
      { id: 1, gender: "男", value: 0 },
      { id: 2, gender: "女", value: 1 },
    ],
    name: "",
    gender: "",
    budget: "",
    preference: "",
    startDate: "",
    endDate: "",
    startDateText: "",
    endDateText: "",
    avatar:""
  },

  // 性别选择变化
  handleChoice: function (e) {
    const gender = e.detail.value;
    this.setData({
      gender: gender,
    });
  },

  // 开始日期选择变化
  onStartDateChange: function (e) {
    const startDate = new Date(e.detail.value).setHours(0, 0, 0, 0);
    const endDate = this.data.endDate;
    //不早于当前日期
    if (startDate < new Date().setHours(0, 0, 0, 0)) {
      wx.showToast({
        title: "所选开始日期不能早于当前日期!",
        icon: "none",
        duration: 2000,
      });
      return;
    }

    if (endDate && new Date(endDate).setHours(0, 0, 0, 0) < startDate) {
      wx.showToast({
        title: "所选开始日期不能晚于结束日期!",
        icon: "none",
        duration: 2000,
      });
      return;
    }

    this.setData({
      startDate: e.detail.value,
      startDateText: e.detail.value,
    });
  },

  // 结束日期选择变化
  onEndDateChange: function (e) {
    const endDate = new Date(e.detail.value).setHours(0, 0, 0, 0);
    const startDate = this.data.startDate;
    //不早于当前日期
    if (endDate < new Date().setHours(0, 0, 0, 0)) {
      wx.showToast({
        title: "所选结束日期不能早于当前日期!",
        icon: "none",
        duration: 2000,
      });
      return;
    }

    if (startDate && new Date(startDate).setHours(0, 0, 0, 0) > endDate) {
      wx.showToast({
        title: "所选结束日期不能早于开始日期!",
        icon: "none",
        duration: 2000,
      });
      return;
    }

    this.setData({
      endDate: e.detail.value,
      endDateText: e.detail.value,
    });
  },

  // 预算变化
  onBudgetChange: function (e) {
    const budget = e.detail.value;
    this.setData({
      budget: budget,
    });
  },

  submitForm() {
    const {name,gender,startDate,endDate,budget,preference} = this.data
    
    if(!name||!gender||!startDate||!endDate||budget === 0||!preference){
     wx.showToast({
        title: '请您先填写所有信息！',
        icon:'none',
        duration:2000
      })
      return
    }

    const queryObj = {name,
      gender,
      startDate,
      endDate,
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
      name: '',
      gender: "",
      budget: 0,
      preference: '',
      startDate: '',
      endDate: '',
      startDateText: '请选择开始日期',
      endDateText: '请选择结束日期',
    })
  },

  //生命周期函数--监听页面加载
  onLoad(options) {
    this.setData({
      startDateText: "请选择开始日期",
      endDateText: "请选择结束日期",
      budget: 0,
    });
  },
  ///生命周期函数--监听页面初次渲染完成
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
