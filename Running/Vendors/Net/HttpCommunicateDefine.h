//
//  HttpCommunicateDefine.h
//  GoddessClock
//
//  Created by Andy on 14-8-12.
//  Copyright (c) 2014年 iMac. All rights reserved.
//

#ifndef GoddessClock_HttpCommunicateDefine_h
#define GoddessClock_HttpCommunicateDefine_h

typedef NS_ENUM (NSInteger , HttpResponseCode)
{
    HttpResponseOk = 0,
    HttpResponseError,
    HttpResponseLoginError,
    HttpResponseCnout
};


//#define URL_BASE        @"http://mama.com/api/v1/rest.php/"          //内网
//#define SEND_KEY        @"dkfiaDIFOGskdjfSIOFLskdjfSIQZPsd"          //内网

#define URL_BASE      @"http://www.moresing.com/api/v1/rest.php/"  //外网
#define SEND_KEY      @"dkfiaDIFOGskdj13IOFLkdsldSIQZPsd"          //外网

//http后缀
typedef NS_ENUM(NSInteger,HTTP_COMMAND_LIST){
    //首页顶部图片1
    HTTP_ESTATE_IMAGE,
    //首页附近店铺2
    HTTP_METHOD_NEARBY_STORE_LIST,
    //店铺的基本信息3
    HTTP_METHOD_STORE_INFO,
    //注册4
    HTTP_METHOD_REGISTER,
    //注册时手机获取验证码5
    HTTP_METHOD_CODENUM,
    //注册时手机获取验证码6
    HTTP_METHOD_LOGIN,
    //我的账户--修改密码7
    HTTP_METHOD_MODIFY_PASSWORD,
    //我的账户修改的手机号验证8
    HTTP_METHOD_MODIFY_PHONENUM,
    //我的账户更换手机号码验证9
    HTTP_METHOD_CHANGE_PHONENUM,
    //个人中心修改用户头像10
    HTTP_METHOD_MODIFY_AVATAR,
    //登录时点击忘记密码--手机号验证11
    HTTP_METHOD_FORGET_PASSWORD,
    //登录时点击忘记密码--判断验证码是否正确12
    HTTP_METHOD_COMPARE_PASSWORD,
    //登录时点击忘记密码--修改密码13
    HTTP_METHOD_LGGIN_CHANGE_PHONENUM,
    //购物车列表14
    HTTP_METHOD_CART_LIST,
    //添加购物车15
    HTTP_METHOD_ADD_CART,
    //删除单条购物车16
    HTTP_METHOD_DELETE_CART,
    //删除单全部物车17
    HTTP_METHOD_DELETE_CART_ALL,
    //店铺的商品信息--商家详情的全部商品18
    HTTP_METHOD_STORE_GOODS_ALL,
    //商品详情19
    HTTP_COMMAND_GOODS_DETAILE,
    //取得所有城市地区20
    HTTP_METHOD_ALLCITY_LIST,
    //首页中，获取当前市中得区县城市21
    HTTP_METHOD_CURRENT_CITY_LIST,
    //获取店铺的总体评价22
    HTTP_METHOD_SHOP_COMMENT_ALL,
    //获取店铺的评价列表23
    HTTP_METHOD_SHOP_COMMENT_LIST,
    //获取发送店铺评论24
    HTTP_METHOD_SEND_SHOP_COMMENT,
    //获取进入订单页获取订单商品信息25
    HTTP_METHOD_GET_DINGDAN_GOODS_INFO,
    //获取我的收货地址列表26
    HTTP_METHOD_GET_MY_ADDRESS_LIST,
    //获取订单信息进入支付选择页面27
    HTTP_METHOD_GET_DINGDAN_INFO,
    //获取原先的收货地址28
    HTTP_METHOD_GET_EDIT_ADDRESS_INFO,
    //删除收货地址29
    HTTP_METHOD_DROP_ADDRESS,
    //设为默认收货地址30
    HTTP_METHOD_SET_DEFAULT_ADDRESS,
    
    //店铺搜索页面的分类31
    HTTP_METHOD_STORE_SEARCH_CATEGORYS,
    //店铺收藏32
    HTTP_METHOD_STORE_ADD_FAVORITES,
    
    //获取分享信息33
    HTTP_METHOD_GET_SHARE_INFO,
    //获取各类型订单信息34
    HTTP_METHOD_GET_ALL_DINGDAN_INFO,
    //取消订单35
    HTTP_METHOD_CANCEL_THE_DINGDAN,
    //确认订单36
    HTTP_METHOD_CONFIRM_THE_DINGDAN,
    //删除订单37
    HTTP_METHOD_DELETE_THE_DINGDAN,
    //发送商品评论38
    HTTP_METHOD_SEND_GOOD_COMMENT,
    //获取优惠卷信息39
    HTTP_METHOD_GET_COUPON_INFO,
    //删除优惠卷40
    HTTP_METHOD_DELETE_COUPON,
    //获取商品收藏列表41
    HTTP_METHOD_GET_GOODS_COLLECTION_LIST,
    //删除商品收藏42
    HTTP_METHOD_DROP_GOODS_COLLECTION,
    //获取店铺收藏列表43
    HTTP_METHOD_GET_STORES_COLLECTION_LIST,
    //删除店铺收藏44
    HTTP_METHOD_DROP_STORES_COLLECTION,
    
    //第三方登录45
    HTTP_METHOD_THIRD_LOGIN,
    //退出登录46
    HTTP_METHOD_LOGIN_OUT,
    //获取订单详情47
    HTTP_METHOD_GET_ORDER_INFO,
    //获取订单详情48
    HTTP_METHOD_GET_ORDER_COUPON_INFO,
    
    //商品收藏49
    HTTP_METHOD_COLLECT_GOODS,
    //购物车里面的加减更新购买个数50
    HTTP_METHOD_UPDATE_NUMBER,
    //获取用户信息，用于修改用户信息51
    HTTP_METHOD_GET_PROFILE,
    //上传头像到服务器52
    HTTP_UPDATE_AVATA,
    //修改用户个人信息，如昵称性别等53
    HTTP_UPDATE_USER_INFO,
    //反馈和意见功能54
    HTTP_METHOD_UPDATE_FEEDBACK,
    //我的电子券55
    HTTP_METHOD_MY_COUPON,
    //商品的总体评价56
    HTTP_METHOD_GOODS_ALL_COMMENT,
    //商品评价57
    HTTP_METHOD_GOODS_COMMENT,
    //获取自提店铺信息58
    HTTP_METHOD_GET_ZITI_STORE_INFO,
    //我的麻豆数量59
    HTTP_METHOD_MY_MADOU,
    //活动接口60
    HTTP_METHOD_ACTIVITY_LIST,
    
    /*******************/
    HTTP_METHOD_RESERVE,
    HTTP_METHOD_COUNT
};

//#ifdef __ONLY_FOR_HTTP_COMMUNICATE__
//****************************************************************************/

static char cHttpMethod[HTTP_METHOD_COUNT][64] = {
    
    "ad_manage.manage",//1
    "search.store",//2
    "stores.store_info",//3
    "member.register",//4
    "member.yanzhengma",//5
    "member.login",//6
    "member.yh_password",//7
    "member.xiu_phoneyz",//8
    "member.xiu_phone",//9
    "member.upload_ws",//10
    "member.password",//11
    "method member.yan",//12
    "member.set_password",//13
    "cart.index",//14
    "cart.add",//15
    "cart.drop",//16
    "cart.del_all",//17
    "stores.store_goods",//18
    "good.goods_info",//19
    "search.all_citys",//20
    "search.get_chind",//21
    "stores.z_evaluate",//22
    "stores.evaluate",//23
    "stores.evaluate_add",//24
    "order.index",//25
    "my_address.index",//26
    "cashier.index",//27
    "my_address.edit",//28
    "my_address.drop",//29
    "my_address.defaults",//30
    "search.get_regions_store_categorys",//31
    "stores.add_collect_store",//32
    "other.index",//33
    "buyerorder.index",//34
    "buyerorder.cancel_order",//35
    "buyerorder.confirm_order",//36
    "buyerorder.delete_order",//37
    "good.evaluate_add",//38
    "my_coupon.index",//39
    "my_coupon.drop",//40
    "good.list_collect_goods",//41
    "good.drop_collect_goods",//42
    "stores.list_collect_store",//43
    "stores.store_drop",//44
    "member.third_reg_login",//45
    "member.logout",//46
    "buyerorder.view",//47
    "order.coupons",//48
    "good.add_collect_goods", //49
    "cart.update",   //50
    "member.get_profile", //51
    "member.upload_ws", //52
    "member.profile",  //53
    "member.feedback", //54
    "my_coupon.electronic_voucher", //55
    "good.z_evaluate", //56
    "good.evaluate", //57
     "order.ziti",//58
    "member.madou",  //59
    "other.event",   //60
};

/*****************************************************************************/

typedef NS_ENUM(NSUInteger,ServiceStatusTypeDefine){
    
    ServiceStatusTypeWaitingDefine = 1,
    ServiceStatusTypeWorkingDefine,
    ServiceStatusTypeFinishedDefine,
    ServiceStatusTypeDefineCount,
};

#endif
