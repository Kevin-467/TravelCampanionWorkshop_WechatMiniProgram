const app =getApp()
Page({
  data: {
    regionText:'',
    currentDate:'',
    genderArr:['男','女','暂不选择'],
    genderIndex:0,
    avatar:'',
    nickname:'',
    gender:'',
    birthday:'',
    region:'',
    preference:''
  },

  //选择图片，上传服务器，返回的生成网络图片地址（待完善）
  onchooseAvatar(evt) {

  },

  ongenderChange(evt) {
    const {genderArr} =this.data
    const genderIndex = evt.detail.value
    if(genderIndex == 2){
      this.setData({
        genderIndex:'',
        gender:''
      })
      return
    }
    const gender = genderArr[genderIndex]
    this.setData({
      genderIndex,
      gender
    })
  },

  ondateChange(evt) {
    // console.log(evt.detail.value);
    const birthday = evt.detail.value
    this.setData({
      birthday
    })
  },

  onregionChange(evt) {
    const {value} = evt.detail
    const isSepicalProvince = this.isSepicalProvince(value[0])
    const region = {
      province:value[0],
      city:(isSepicalProvince ? (value[0] == '重庆市' ? '重庆市': value[0] ): value[1])||'',
      distric:value[2]||''
    }
    const regionText = isSepicalProvince ? value.filter((item,index)=>index != 1).join(' ') : value.join(' ')
    this.setData({
      region,
      regionText
    })
    console.log(this.data.region,this.data.regionText);
  },

  isSepicalProvince(province) {
    if(province == '北京市'||province == '天津市' || province == '上海市'||province == '香港特别行政区' || province == '澳门特别行政区'||province == '重庆市') return true
    return false
  },

  //点击保存按钮时 将用户信息上传到服务器/修改服务器已有的用户数据（待完善）
  saveInfo() {
    const {avatar,nickname,gender,birthday,region,preference} = this.data
    wx.request({
      url:'#',
      method:'PUT',
      data:{
        avatar,
        nickname,
        gender,
        birthday,
        ...region,
        preference
      },
      success:{

      },
      fail:{

      }
    })
  },

  //打开时自动获取并填充用户信息（待完善）
  onLoad(options) {
    this.setData({
      preference:'',
      region:'',
      genderIndex:'',
      gender:'',
      avatar:app.globalData.defaultAvatarUrl,
      currentDate:new Date()
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