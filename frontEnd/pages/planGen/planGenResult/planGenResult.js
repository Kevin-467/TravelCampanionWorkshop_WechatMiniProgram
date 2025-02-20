// pages/planGen/planGenResult/planGenResult.js
const app = getApp();
Page({
  data: {
    token: "",
    tip: "",
    personality: "",
    hobbies: "",
    budget: "",
    preferences: "",
    time: "",
    plan: "",
    tipShow: true, //是否显示顶部的tip区域和分割线
    emptyBoxShow: false, //是否展示生成失败的样式
  },

  getTravelPlan: function () {
    wx.showLoading({
      title: "正在生成中...",
    });

    // POST请求 将数据发送到后端，并从后端获取生成的个性化旅游方案( 后端接口? )
    /* const {token,personality,hobbies,budeget,preferences,time} = this.data
    wx.request{
      url:'#',
      data: {
        token,
        personality,
        hobbies,
        budget,
        preferences,
        travelDays:time
      },
      method:'POST',
      timeout:20000,
      success:(res)=>{
        wx.hideLoading()
        console.log(res)
        if(res.statusCode == 200){
          const {plan} = res.data.data
          if(plan){
            this.setData({
              tip:'已为您生成以下旅游方案',
              plan:res.data.data.plan
            })
          } else {
            wx.showToast({
              title:'很抱歉，未能为您生成旅游方案！',
              icon:'none'
            })
            this.setData({
                tip:'',
                tipShow:false,
                emptyBoxShow:true
            }) 
          }
        }
      },
      fail:(err)=>{
        wx.hideLoading()
        wx.showToast({
          title: '出错了,未能为您生成旅游方案！',
          icon:'none'
        })
        this.setData({
          tip:'',
          tipShow:false,
          emptyBoxShow:true
        }) 
      }
    }) */

    setTimeout(() => {
      wx.hideLoading();

      //生成方案成功效果
      this.setData({
        tip: "已为您生成以下旅游方案！",
        plan: {
          budget: 1500,
          arrange: [
            {
              id: 1,
              title: "第一天：阳朔 & 自由探险",
              detail:
                "从桂林出发，乘车前往阳朔（车程约1.5-2小时）。到达后入住民宿，稍作休息。下午开始十里画廊徒步，途经月亮山、剑峰山等景点，步行约4小时。晚上回到民宿，享受当地特色晚餐，体验阳朔的小镇氛围。",
            },
            {
              id: 2,
              title: "第二天：遇龙河漂流 & 探险",
              detail:
                "早晨参加遇龙河竹筏漂流（漂流时间约2小时），欣赏沿途的自然山水。下午进行阳朔附近山洞探险，探索当地的溶洞和峡谷。晚上返回阳朔，享受晚餐并放松。",
            },
            {
              id: 3,
              title: "第三天：漓江徒步 & 返回",
              detail:
                "早晨前往漓江边进行徒步，沿着漓江走，欣赏山水画般的景色。沿途经过一些宁静的村庄，适合拍照和放松。中午可以在当地的小镇上享用午餐，下午乘车返回,结束行程。",
            },
          ],
        },
        tipShow: true,
        emptyBoxShow: false,
      });

      //生成方案失败的效果
      /* wx.showToast({
      title:'生成方案失败！',
      icon:'error'
     })

    this.setData({
      tip:'',
      tipShow:false,
      emptyBoxShow:true
   }) */
    }, 5000);
  },

  onLoad(options) {
    this.setData({
      token: app.globalData.token,
      personality: decodeURIComponent(options.personality || ""),
      preferences: decodeURIComponent(options.preferences || ""),
      hobbies: decodeURIComponent(options.hobbies || ""),
      time: decodeURIComponent(options.time || ""),
      budget: decodeURIComponent(options.budget || ""),
      plan: "",
      tip: "正在为您生成个性化的旅游方案！",
      warningText: "",
      tipShow: true,
      emptyBoxShow: false,
    });
    this.getTravelPlan();
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
