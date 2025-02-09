// pages/planGen/planGen.js
Page({
  data: {
    questions: [
      { id: 1, text: '您偏好的旅游环境是？', type: 'single', options: ['安静、自然', '繁华、热闹', '舒适、现代'] },
      { id: 2, text: '您最喜欢的旅游活动是？', type: 'multiple', options: ['登山徒步', '海边休闲', '文化历史探索', '美食之旅'] },
      { id: 3, text: '您更倾向于怎样的住宿环境？', type: 'single', options: ['豪华酒店', '民宿', '露营'] },
      { id: 4, text: '您希望在旅游中享受哪些体验？（可多选）', type: 'multiple', options: ['购物', '温泉', '亲子活动', '夜生活','参观名胜古迹'] },
      { id: 5, text: '您的可出行时间（滑动选择天数）', type: 'slider', min: 1, max: 50, step: 1 },
      { id: 6, text: '您的旅游预算范围是多少？（单位：元）', type: 'slider', min: 0, max: 10000, step: 100 }
    ],
    answers: {},
    completedCount: 0
  },

  handleChoice(e) {
    const questionId = e.currentTarget.dataset.id
    const value = e.detail.value
    this.updateAnswer(questionId, value)
  },

  handleInput(e) {
    const questionId = e.currentTarget.dataset.id
    const value = e.detail.value
    this.updateAnswer(questionId, value)
  },

  updateAnswer(questionId, value) {
    const answers = this.data.answers
    answers[questionId] = value
    this.setData({
      answers,
      completedCount: Object.keys(answers).length
    })
  },

  submitSurvey() {
    const { answers, questions } = this.data;
    console.log(answers)
    
    if (Object.keys(answers).length !== questions.length) {
      wx.showToast({
        title: '请完成所有问题再提交',
        icon: 'none'
      })
      return
    }
    
    // 预留与后端连接的代码
   /*  wx.request({
      url: '', // 后端提交接口
      method: '',
      data: {
        
      },
      success(res) {
        if (res.data.success) {
          
        } else {
          wx.showToast({
            title: '提交失败，请稍后再试',
            icon: 'none'
          });
        }
      },
      fail(err) {
        wx.showToast({
          title: '网络异常，请检查网络',
          icon: 'none'
        });
      }
    }); */

    wx.redirectTo({
      url:'/pages/planGen/planGenResult/planGenResult'
    })
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