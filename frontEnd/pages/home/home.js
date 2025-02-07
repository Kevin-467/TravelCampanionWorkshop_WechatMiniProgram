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
        {
          id:3,
          name:'组队',
          className:'teamup',
          imgUrl:'../../images/navbar/teamup_active.png',
          navUrl:'/pages/teamup/teamup',
          openType:'switchTab'
        }
      ],
      article:[
        {
          id:1,
          title:'欢迎访问旅伴奇遇工坊!',
          content:'寻找旅伴,尽在旅伴奇遇工坊',
          picSrc:'../../images/homePage/游记.png',
          pubDate:'2025-1-20 17:45'
        },
        {
          id:2,
          title:'寻找旅伴指南',
          content:`在本站，您可找到适合自己的旅游路线和旅行方案！您可通过发布组队或参与其他旅友发起的组队，找到合适自己的旅伴！`,
          picSrc:'../../images/homePage/旅行.png',
          pubDate:'2025-1-21 17:50'
        },
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