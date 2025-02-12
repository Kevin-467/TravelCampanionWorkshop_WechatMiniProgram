Page({
    data:{
        genderOptions: [
            { id: 1, gender: "男", value: 0 },
            { id: 2, gender: "女", value: 1 }
        ],
        name:'',
        gender:'',
        startDate:'',
        endDate:'',
        budget:'',
        /* partnerList:[
            {id:1,avatar:'../../images/homePage/旅行.png',nickname:'kevinchan042108',preference:'亲近大自然'},
            {id:2,avatar:'../../images/homePage/旅游_路线.png',nickname:'kevinchan',preference:'喜欢越野冒险，探索未知'}
        ], */
        partnerList:'',
        tip:'',
        emptyResultText:'',
        hideForm:''
    },

    findPartner: function() {
        wx.showLoading({
            title:'寻找旅伴中....',
        })
        
        wx.request({
            url:'#',
            method:'GET',
            data:{
                name:this.data.name,
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
        })
    },

    onLoad(options){
        Object.keys(options).forEach(key => this.setData({
            [key]:decodeURIComponent(options[key])
        }))
        this.setData({
            hideForm:true,
            emptyResultText:'正在匹配中...'
        })
        this.findPartner()
    },

    onReady(){

    },
})
