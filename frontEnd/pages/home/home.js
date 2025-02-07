// pages/home/home.js
Page({
  data: {
      urlPath:"/pages/searchResult/searchResult",
      swiperList:[
        {
          id:0,
          url:"../../images/slider/slider-1.jpg"
        },
        {
          id:1,
          url:"../../images/slider/slider-2.jpg"
        },
        {
          id:2,
          url:"../../images/slider/slider-3.jpg"
        },
      ],
      commonFunc:[
        {
          id:0,
          name:'旅游路线',
          className:'route-gen',
          imgUrl:'../../images/homePage/旅游_路线.png',
          navUrl:'/pages/routeGen/routeGen',
        },
        {
          id:1,
          name:'旅游方案',
          className:'trip-plan',
          imgUrl:'../../images/homePage/旅行.png',
          navUrl:'/pages/planGen/planGen',
        },
        {
          id:2,
          name:'更多游记',
          className:'route-gen',
          imgUrl:'../../images/homePage/游记.png',
          navUrl:'/pages/share/share',
          openType:'switchTab'
        },
      ],
      article:[
        {
          id:1,
          articleName:'欢迎访问旅伴奇遇工坊!',
          picSrc:'../../images/homePage/游记.png'
        },
        {
          id:2,
          articleName:'寻找旅伴指南',
          picSrc:'../../images/homePage/旅行.png'
        }
      ],
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