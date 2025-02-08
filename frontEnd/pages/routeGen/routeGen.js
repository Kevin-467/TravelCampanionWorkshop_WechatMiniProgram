// pages/routeGen/routeGen.js
Page({
    data: {
      destination:'',
      startDate: '',
      endDate: '',
      budget: '',
      preferences: '',
    },
  
    onStartDateChange: function (e) {
      const curDate = new Date().setHours(0,0,0,0)
      const selectedDate = new Date(e.detail.value).setHours(0,0,0,0)
      const endDate = new Date(this.data.startDate).setHours(0,0,0,0)

      if(selectedDate < curDate){
        wx.showModal({
          title: '温馨提示',
          content:'开始日期不能早于当前日期！',
          showCancel:false
        })
        console.log(this.data.startDate)
        return
      }

      if(endDate && selectedDate > endDate){
        wx.showModal({
          title: '温馨提示',
          content:'开始日期不能晚于结束日期！',
          showCancel:false
        })
        return
      }

      this.setData({
        startDate: e.detail.value
      })
    },
  
    // 选择结束日期
    onEndDateChange: function (e) {
      const curDate = new Date().setHours(0,0,0,0)
      const startDate = new Date(this.data.startDate).setHours(0,0,0,0)
      const selectedDate = new Date(e.detail.value).setHours(0,0,0,0)

      //不早于当前日期
      if(selectedDate < curDate){
        wx.showModal({
          title: '温馨提示',
          content:'结束日期不能早于当前日期！',
          showCancel:false
        })
        return
      }

      if(startDate && selectedDate < startDate){
        wx.showModal({
          title: '温馨提示',
          content:'结束日期不能早于开始日期！',
          showCancel:false
        })
        return
      }
      this.setData({
        endDate: e.detail.value
      });
    },
  
    // 提交表单
    submitForm:function () {
      console.log(this.data);
      const { destination, startDate, endDate, budget, preferences } = this.data;
  
      if (!destination) {
        wx.showToast({
          title: '表单不能有空白！',
          icon: 'none',
          duration:2000
        });
        return;
      }
  
      /* // 发送数据到后台
      wx.request({
        url: '#', // 后端接口地址
        method: '',
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
      }); */

      //跳转路线生成页面
      wx.redirectTo({
        url:'/pages/routeGen/routeGenResult/routeGenResult'
      })
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