// pages/routeGen/routeGen.js
Page({
    data: {
      destination:'',
      startDate: '',
      endDate: '',
      budget: '',
      preferences: ''
    },
  
    onStartDateChange: function (e) {
      this.setData({
        startDate: e.detail.value
      });
    },
  
    // 选择结束日期
    onEndDateChange: function (e) {
      this.setData({
        endDate: e.detail.value
      });
    },
  
    // 提交表单
    submitForm:function () {
      const { destination, startDate, endDate, budget, preferences } = this.data;
  
      if (!destination || !startDate || !endDate || !budget || !preferences) {
        wx.showToast({
          title: '请填写完整的表单！',
          icon: 'none'
        });
        return;
      }
  
      // 发送数据到后台
      wx.request({
        url: 'https://example.com/submitForm', // 后端接口地址
        method: 'POST',
        data: {
          destination,
          startDate,
          endDate,
          budget,
          preferences
        },
        success: function (res) {
          wx.showToast({
            title: '提交成功！',
            icon: 'success'
          });
        },
        fail: function (err) {
          wx.showToast({
            title: '提交失败！',
            icon: 'none'
          });
        }
      });
    },
  
    // 重置表单
    resetForm: function () {
      this.setData({
        destination: '',
        startDate: '',
        endDate: '',
        budget: '',
        preferences: ''
      });
    },

    /**
     * 生命周期函数--监听页面加载
     */
    onLoad(options) {

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