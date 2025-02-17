//默认图片路径
Page({
  data: {
    genderOptions: [
      { id: 1, gender: "男", value: 0 },
      { id: 2, gender: "女", value: 1 },
    ],
    picUrl: "",
    nickname: "",
    gender: "",
    travelDays: 0,
    budget: "",
    partnerList: "",
    tip: "",
    emptyResultText: "",
    showAddPicBox:true,
    hideForm: "",
  },

  findPartner: function () {
    wx.showLoading({
      title: "寻找旅伴中....",
    });

    /*         wx.request({
            url:'#',
            method:'GET',
            data:{
                nickname:this.data.nickname,
                gender:this.data.gender,
                startDate:this.data.startDate,
                endDate:this.data.endDate,
                budget:this.data.budget
            },
            timeout:20000,
            success: (res) => {
                wx.hideLoading()
                const {partnerList} = res.data.data
                if(partnerList.length > 0){
                    this.setData({
                        partnerList:partnerList,
                        hideForm:false
                    })
                } else {
                    this.setData({
                        emptyResultText:'暂无合适的伙伴！',
                        hideForm :false
                    })
                }
                this.data.hideForm = false;
            },
            fail:(err)=>{
                wx.hideLoading()
                wx.showToast({
                    title:'请求超时，请稍后重试！',
                    icon:'none',
                    duration:2500
                })
                this.setData({
                    emptyResultText:'暂无合适的伙伴！',
                    hideForm :false
                })
            }
        }) */
    setTimeout(() => {
      wx.hideLoading();
      this.setData({
        partnerList: [
          {
            id: 1,
            picUrl: "../../images/homePage/旅行.png",
            initator: "kevinchan042108", //组队发起者
            createTime: "2025-1-20 17:45:30", //组队发起时间
            travelDays: 8, //计划旅行天数
            budget: 2000, //组队预算
            preference: "亲近大自然,远离喧嚣,喜欢宁静", //发起者旅游偏好
          },
          {
            id: 2,
            picUrl: "../../images/homePage/旅游_路线.png",
            initator: "kevinchan",
            createTime: "2025-1-20 17:45:30",
            travelDays: 8,
            budget: 2000,
            preference: "亲近大自然,远离闹市喧嚣",
          },
        ],
        hideForm: false,
      });
    }, 5000);
  },

  //防抖/节流优化？
  joinTeamup(evt) {
    //流程
    const { id } = evt.target.dataset
    const { nickname } = this.data
    wx.showLoading({
      title: "正在组队中",
    });

    /*  wx.request({
        url:'#',
        method:'PUT',//POST/PUT ?
        data:{
            id,//组队编号
            participant:nickname //搭子昵称
        },
        timeout:10000,
        success:(res)=>{
            wx.hideLoading()
            wx.showToast({
                title:'组队成功！',
                image:'../../images/成功.png'
            })
        },
        fail:(err)=>{
            console.log(err)
            wx.hideLoading()
            wx.showToast({
                title:'组队失败！',
                icon:'error'
            })
        }
    }) */

    //组队成功效果
    setTimeout(() => {
      wx.hideLoading()
      wx.showToast({
        title: "组队成功！",
        icon:'success',
        duration:2000
      })
      setTimeout(()=>wx.switchTab({
        url:'/pages/chatspace/chatspace'
      }),2000)
    }, 3000)
  },

  //如未选择照片，则上传默认图片
  createTeamup() {
    const {avatar,initator,travelDays,budget,preference} = this.data
    wx.showLoading({
      title:'正在发布中'
    })

    /* wx.request({
      url:'#',
      method:'POST',
      data:{
        picUrl,
        initator,
        travelDays,
        budget,
        preference
      },
      timeout:10000,
      success:(res)=>{
        wx.hideLoading()
        wx.showToast({
          title:'发布成功！',
          icon:'success'
        })
        wx.switchTab({
          url:'/pages/chatspace/chatspace'
        })
      },
      fail:(err)=>{
        console.log(err)
        wx.hideLoading()
        wx.showToast({
          title:'发布失败！',
          icon:'error'
        })
      }
    }) */

    setTimeout(()=>{
      wx.hideLoading()
      wx.showToast({
        title: "发布成功！",
        icon:'success',
        duration:1000
      });
      setTimeout(()=>wx.switchTab({
        url:'/pages/chatspace/chatspace'
      }),2000)
    },3000)
  },

  onpicChoose() {
    const that = this
    wx.chooseMedia({
      count:1,
      mediaType:['image'],
      sourceType:['album', 'camera'],
      sizeType:['original'],
      success (res)  {
        const {tempFilePath} = res.tempFiles[0]

        //上传图片到服务器 待实现
        /* wx.uploadFile({
          url:'#',
          filePath:tempFilePath,
          name:'teamup-image-file',
          header:{},
          formData:{},
          timeout:5000,
          success:(res)=>{
            if(res.statusCode === 200){
              const {picUrl} = res.data.data
              that.setData({
                picUrl
                showAddPicBox:false
              })
            }
          },
          fail:(err)=>{
            console.log(err)
          }
        }) */

        that.setData({
          picUrl:tempFilePath,
          showAddPicBox:false
        })
      },
      fail (err) {
        console.log(err)
      }
    })
  },

  onLoad(options) {
    Object.keys(options).forEach((key) =>
      this.setData({
        [key]: decodeURIComponent(options[key]),
      })
    )
    this.setData({
      avatar:defaultAvatarUrl,
      hideForm: true,
      emptyResultText: "正在匹配中...",
    })
    this.findPartner()
  }
})
