const app = getApp()
Page({
  data: {
    token: '',
    regionText: '',
    currentDate: '',
    genderArr: ['男', '女', '暂不选择'],
    genderIndex: 0,
    avatar: '',
    nickname: '',
    gender: '',
    birthday: '',
    region: '',
    preference: ''
  },

  //选择图片，上传服务器，返回的生成网络图片地址 POST请求（待完善）
  onchooseAvatar(evt) {
    const { avatarUrl } = evt.detail

    /* wx.uploadFile({
      url:'#',
      filePath:avatarUrl,
      name:'avatar-image-files',
      formData:{
        token:this.data.token
      },
      timeout:5000,
      success:(res)=>{
        console.log(res)
        if(res.statusCode == 200){
          const {imgUrl} = res.data.data
          this.setData({
            avatar:imgUrl
          })
          wx.showToast({
            title:'更换头像成功！'
          })
        }
      },

      fail:(err)=>{
        console.log(err)
        wx.showToast({
          title:'更换头像失败！',
          icon:'error',
          duration:2000
        })
      }
    }) */

    wx.showToast({
      title: '更换头像成功！'
    })
    setTimeout(() => {

      this.setData({
        avatar: avatarUrl
      })
    }, 2000)
  },

  ongenderChange(evt) {
    const { genderArr } = this.data
    const genderIndex = evt.detail.value
    if (genderIndex == 2) {
      this.setData({
        genderIndex: '',
        gender: ''
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
    const { value } = evt.detail
    const isSepicalProvince = this.isSepicalProvince(value[0])
    const region = {
      province: value[0],
      city: (isSepicalProvince ? (value[0] == '重庆市' ? '重庆市' : value[0]) : value[1]) || '',
      distric: value[2] || ''
    }
    const regionText = isSepicalProvince ? value.filter((item, index) => index != 1).join(' ') : value.join(' ')
    this.setData({
      region,
      regionText
    })
    console.log(this.data.region, this.data.regionText);
  },

  isSepicalProvince(province) {
    if (province == '北京市' || province == '天津市' || province == '上海市' || province == '香港特别行政区' || province == '澳门特别行政区' || province == '重庆市') return true
    return false
  },

  //点击保存按钮时 修改服务器对应用户数据（待完善）
  saveInfo() {
    const { avatar, nickname, gender, birthday, region, preference } = this.data

    //PUT请求
    /*    wx.request({
          url:'#',
          method:'PUT',
          data:{
            token,
            avatar,
            nickname,
            gender,
            birthday,
            ...region,
            preference
          },
          success:(res)=>{
            console.log(res)
            if(res.statusCode == 200){
              wx.showToast({
                title:'保存成功!',
              })
              wx.navigateBack({
                url:'/pages/me/me'
              })
            } else {
              wx.showToast({
                title:'保存失败！',
                icon:'error',
                duration:2000
              })
            }
          },
          fail:(err)=>{
            console.log(err)
            wx.showToast({
              title:'保存失败！',
              icon:'error',
              duration:2000
            })
          }
        }) */

    wx.showToast({
      title: '保存成功',
      icon: 'success',
      duration: 2000
    })
    setTimeout(() => {
      wx.navigateBack({
        url: '/pages/me/me'
      })
    }, 2000)
  },

  //打开时自动获取并填充用户信息（待完善）
  onLoad(options) {
    wx.showNavigationBarLoading()

    // GET请求 
/*  this.data.token = app.globalData.token
    wx.request({
      url: '#',
      data: {
        token: app.globalData.token
      },
      timeout: 5000,
      success: (res) => {
        wx.hideNavigationBarLoading()
        if (res.statusCode == 200) {
          const { userInfo } = res.data.data
          const { avatar, nickname, gender, birthday, region, preference } = userInfo
          this.setData({
            avatar: avatar || app.globalData.defaultAvatarUrl,
            nickname,
            gender,
            birthday,
            region,
            preference,
            regionText
          })
        } else {
          wx.showToast({
            title: '获取用户信息失败！',
            icon: 'none',
            duration: 2000
          })
          this.setData({
            avatar: app.globalData.defaultAvatarUrl,
          })
        }
      },
      fail: (err) => {
        wx.hideNavigationBarLoading()
        console.log(err)
        wx.showToast({
          title: '获取用户信息失败！',
          icon: 'none',
          duration: 2000
        })
        this.setData({
          avatar: app.globalData.defaultAvatarUrl,
        })
      },
      complete: () => {
        this.setData({
          currentDate: new Date()
        })
      }
    }) */

    setTimeout(() => {
      wx.hideNavigationBarLoading()
      this.setData({
        preference: '',
        region: '',
        genderIndex: '',
        gender: '',
        avatar: app.globalData.defaultAvatarUrl,
        currentDate: new Date()
      })
    }, 3000)
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