const app = getApp();

Page({
  data: {
    user: {
      token:'',
      nickname: "微信用户",
      avatar: app.globalData.defaultAvatarUrl,
    },
  },

  editInfo() {
    wx.navigateTo({
      url: "/pages/me/personalInfo/personalInfo",
    });
  },

  onLoad(options) {
    this.data.token = app.globalData.token
    const {token} = this.data
    wx.showNavigationBarLoading();

    //通过token获取用户头像和昵称 GET请求
    /* const token = ''
    wx.request({
      url: "#",
      data: {
        token,
      },
      timeout: 5000,
      success: (res) => {
        console.log(res);
        wx.hideNavigationBarLoading();

        if (res.statuseCode == 200) {
          const { avatar, nickname } = res.data.data.userInfo;
          this.setData({
            avatar:avatar||app.globalData.defaultAvatarUrl,
            nickname
          })
        } else {
          wx.hideNavigationBarLoading();
          wx.showToast({
            title:'获取用户信息失败！',
            icon:'none'
          })
        }
      },
      fail: (err) => {
        wx.hideNavigationBarLoading();
        wx.showToast({
          title:'获取用户信息失败！',
          icon:'none'
        })
      },
    }) */

    setTimeout(() => {
      wx.hideNavigationBarLoading();
      this.setData({
        user: {
          nickname: "微信用户",
          avatar: app.globalData.defaultAvatarUrl,
        },
      });
    }, 2000)
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady() {},

  /**
   * 生命周期函数--监听页面显示
   */
  onShow() {},

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide() {},

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload() {},

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh() {},

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom() {},

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage() {},
});
