/*
Navicat MySQL Data Transfer

Source Server         : teat
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : platform-tianhe

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2018-05-11 14:23:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_function
-- ----------------------------
DROP TABLE IF EXISTS `auth_function`;
CREATE TABLE `auth_function` (
  `id` varchar(32) COLLATE utf8_bin NOT NULL,
  `name` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '功能名称名称',
  `url` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(1024) COLLATE utf8_bin DEFAULT NULL COMMENT '功能描述',
  `parentId` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `seq` varchar(11) COLLATE utf8_bin DEFAULT NULL,
  `level` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of auth_function
-- ----------------------------
INSERT INTO `auth_function` VALUES ('00000000000000000000000000000001', '权限管理', null, '权限管理', '', '0', '0', 'glyphicon glyphicon-lock');
INSERT INTO `auth_function` VALUES ('00000000000000000000000000000002', '用户管理', '/user/list', '用户管理', '1', '0', '1', null);
INSERT INTO `auth_function` VALUES ('00000000000000000000000000000003', '角色管理', '/role/list', '角色管理', '1', '1', '1', null);
INSERT INTO `auth_function` VALUES ('00000000000000000000000000000004', '菜单管理', '/function/list', '菜单管理', '1', '2', '1', null);
INSERT INTO `auth_function` VALUES ('20170830183816171550789786359428', '公告管理', 'null_', '公告管理', '00000000000000000000000000000001', '1', '0', 'glyphicon glyphicon-envelope');
INSERT INTO `auth_function` VALUES ('20170830183909707277064130641973', '公告列表', '/notice/list', '公告列表', '20170830183816171550789786359428', '1', '1', null);
INSERT INTO `auth_function` VALUES ('20170830185429920178209535439591', '会员管理', '/customer/list', '会员管理', '00000000000000000000000000000001', '2', '0', 'glyphicon glyphicon-user');
INSERT INTO `auth_function` VALUES ('20170830185504559062723332631547', '会员管理', '/customer/list', '会员管理', '20170830185429920178209535439591', '1', '1', null);
INSERT INTO `auth_function` VALUES ('20170830185731628896338072062993', '零售管理', 'null_', '零售管理', '00000000000000000000000000000001', '3', '0', 'glyphicon glyphicon-shopping-cart');
INSERT INTO `auth_function` VALUES ('20170830190303393232437385332999', '交接班', '/CashierUserLoginAndLogout/list', '交接班', '20170830185731628896338072062993', '2', '1', null);
INSERT INTO `auth_function` VALUES ('20170830190702794379289348317756', '订单列表', '/order/list?model.type=2', '线下订单', '20170830185731628896338072062993', '3', '1', null);
INSERT INTO `auth_function` VALUES ('20170830190959210674064146816515', '换货列表', '/order/changeList', '换货列表', '20170830185731628896338072062993', '4', '1', null);
INSERT INTO `auth_function` VALUES ('20170830191420447290774284855126', '同商品换货列表', '/order/sameChangeList', '同商品换货', '20170830185731628896338072062993', '5', '1', null);
INSERT INTO `auth_function` VALUES ('20170830191749488648028410600993', '退货列表', '/order/returnList', '退货订单', '20170830185731628896338072062993', '6', '1', null);
INSERT INTO `auth_function` VALUES ('20170830192801090374131261177687', '商品管理', 'null_', '商品管理', '00000000000000000000000000000001', '4', '0', 'glyphicon glyphicon-briefcase');
INSERT INTO `auth_function` VALUES ('20170830193127615704538008702005', '商品管理', '/goods/list', '商品管理', '20170830192801090374131261177687', '1', '1', null);
INSERT INTO `auth_function` VALUES ('20170830194834837619463546970437', '促销管理', 'null_', '促销管理', '00000000000000000000000000000001', '5', '0', 'glyphicon glyphicon-gift');
INSERT INTO `auth_function` VALUES ('20170830194954276445047746311165', '促销管理', '/promotionGroup/list', '促销管理', '20170830194834837619463546970437', '1', '1', null);
INSERT INTO `auth_function` VALUES ('20170830195608709484577230290915', '采购管理', 'null_', '采购管理', '00000000000000000000000000000001', '7', '0', 'glyphicon glyphicon-list-alt');
INSERT INTO `auth_function` VALUES ('20170830195737455259940359442166', '采购进货管理', '/procurement/list', '采购进货', '20170830195608709484577230290915', '1', '1', null);
INSERT INTO `auth_function` VALUES ('20170830200418252654557431739635', '采购退货管理', '/procurement/returnList', '采购退货管理', '20170830195608709484577230290915', '2', '1', null);
INSERT INTO `auth_function` VALUES ('20170830202942936037599981591778', '库存管理', 'null_', '库存管理', '00000000000000000000000000000001', '8', '0', 'glyphicon glyphicon-transfer');
INSERT INTO `auth_function` VALUES ('20170830203014829529478121512844', '库存清单', '/inventory/list', '库存清单', '20170830202942936037599981591778', '1', '1', null);
INSERT INTO `auth_function` VALUES ('20170830203138578743848208894007', '库存调拨', '/allocation/list', '库存调拨', '20170830202942936037599981591778', '2', '1', null);
INSERT INTO `auth_function` VALUES ('20170830203543201341540025481647', '库存盘点', '/checkstorage/list', '库存盘点', '20170830202942936037599981591778', '3', '1', null);
INSERT INTO `auth_function` VALUES ('20170830204008872143102098236806', '打印二维码', '/qrcode/input', '打印二维码', '20170830192801090374131261177687', '2', '1', null);
INSERT INTO `auth_function` VALUES ('20170830204300007556616765694571', '二维码列表', '/qrcode/list', '二维码列表', '20170830192801090374131261177687', '3', '1', null);
INSERT INTO `auth_function` VALUES ('20170830205906169522332142318231', '财务管理', 'null_', '财务管理', '00000000000000000000000000000001', '9', '0', 'glyphicon glyphicon-calendar');
INSERT INTO `auth_function` VALUES ('20170830210032500639302088394405', '供应商财务管理', '/finance/procurementList	', '供应商财务管理', '20170830205906169522332142318231', '1', '1', null);
INSERT INTO `auth_function` VALUES ('20170830210224485662374233983717', '充值(微信/支付宝)财务管理', '/finance/rechargeRecordList', '充值财务管理', '20170830205906169522332142318231', '2', '1', null);
INSERT INTO `auth_function` VALUES ('20170830210326269196310192189589', '订单(微信/支付宝)财务管理', '/finance/orderList', '订单财务管理', '20170830205906169522332142318231', '3', '1', null);
INSERT INTO `auth_function` VALUES ('20170830210506906087510933120077', '电子券管理', 'null_', '电子券管理', '00000000000000000000000000000001', '10', '0', 'glyphicon glyphicon-tags');
INSERT INTO `auth_function` VALUES ('20170830210923758888642650283582', '统计管理', 'null_', '统计管理', '00000000000000000000000000000001', '11', '0', 'glyphicon glyphicon-equalizer');
INSERT INTO `auth_function` VALUES ('20170830210957723327387304558240', '售后管理', 'null_', '售后管理', '00000000000000000000000000000001', '12', '0', 'glyphicon glyphicon-heart-empty');
INSERT INTO `auth_function` VALUES ('20170830211023632413917401921109', '系统管理', 'null_', '系统管理', '00000000000000000000000000000001', '16', '0', 'glyphicon glyphicon-cog');
INSERT INTO `auth_function` VALUES ('20170830211433450770016074415679', '系统日志', '/log/list', '系统日志', '20170830211023632413917401921109', '1', '1', null);
INSERT INTO `auth_function` VALUES ('20170830211521443870931033782224', '品牌设置', '/brand/list', '品牌设置', '20170830211023632413917401921109', '2', '1', null);
INSERT INTO `auth_function` VALUES ('20170830211859067594508738262698', '分类设置', '/classification/list', '分类设置', '20170830211023632413917401921109', '3', '1', null);
INSERT INTO `auth_function` VALUES ('20170830212500858165271076518856', '单位设置', '/specification/list', '单位设置', '20170830211023632413917401921109', '4', '1', null);
INSERT INTO `auth_function` VALUES ('20170830212742847304965710849167', '供应商设置', '/vende/list', '供应商设置', '20170830211023632413917401921109', '5', '1', null);
INSERT INTO `auth_function` VALUES ('20170830213114654521981752595705', '仓库设置', '/storage/list', '仓库设置', '20170830211023632413917401921109', '6', '1', null);
INSERT INTO `auth_function` VALUES ('20170830213637287649377336464713', '服务费设置', '/storeBonus/list', '服务费设置', '20170830211023632413917401921109', '7', '1', null);
INSERT INTO `auth_function` VALUES ('20170830213928619714435380492216', '充值返现设置', '/backCash/list', '充值返现设置', '20170830211023632413917401921109', '8', '1', null);
INSERT INTO `auth_function` VALUES ('20170830214134550927178354397788', '充值提成设置', '/consumeBonus/list', '充值提成设置', '20170830211023632413917401921109', '9', '1', null);
INSERT INTO `auth_function` VALUES ('20170830214722853299084468988221', '注册提成设置', '/registerBonus/input', '注册提成设置', '20170830211023632413917401921109', '10', '1', null);
INSERT INTO `auth_function` VALUES ('20170830215054894588174665620170', '订单提成设置', '/bonus/input', '订单提成设置', '20170830211023632413917401921109', '11', '1', null);
INSERT INTO `auth_function` VALUES ('20170830215258813602882080472084', '微信轮播设置', '/banner/input', '微信轮播设置', '20170830211023632413917401921109', '12', '1', null);
INSERT INTO `auth_function` VALUES ('20170830215734365360148127838984', '余额记录列表', '/consume/list', '余额记录列表', '20170830185731628896338072062993', '8', '1', null);
INSERT INTO `auth_function` VALUES ('20170830220333421103573820212235', '开票管理', 'null_', '开票管理', '00000000000000000000000000000001', '13', '0', 'glyphicon glyphicon-pencil');
INSERT INTO `auth_function` VALUES ('20170830220418115613075933228358', '购物小票', '/order/saleOrderInput', '购物小票', '20170830220333421103573820212235', '1', '1', null);
INSERT INTO `auth_function` VALUES ('20170830220758624700709841742603', '优惠小票', '/order/saleOrderInput?isOptions=yes', '优惠小票', '20170830220333421103573820212235', '2', '1', null);
INSERT INTO `auth_function` VALUES ('20170830221143028763978658679598', '换货小票', '/order/changeInput', '换货开票', '20170830220333421103573820212235', '3', '1', null);
INSERT INTO `auth_function` VALUES ('20170830221255184869187266662568', '同商品换货小票', '/order/sameChangeList', '同商品换货', '20170830220333421103573820212235', '4', '1', null);
INSERT INTO `auth_function` VALUES ('20170830221450704419578232369378', '退货小票', '/order/returnInput', '退货小票', '20170830220333421103573820212235', '5', '1', null);
INSERT INTO `auth_function` VALUES ('20170831100443749421767820382012', '购物小票（预约）', '/order/reserveOrderInput', '购物小票（预约）', '20170830220333421103573820212235', '6', '1', null);
INSERT INTO `auth_function` VALUES ('20170831105709637433542084155567', '优惠小票（预约）', '/order/reserveOrderInput?isOptions=yes', '优惠小票（预约）', '20170830220333421103573820212235', '7', '1', null);
INSERT INTO `auth_function` VALUES ('20170831114538119517520094403238', '售后管理', '/orderAfterSale/list', '售后管理', '20170830210957723327387304558240', '1', '1', null);
INSERT INTO `auth_function` VALUES ('20170831194907675599943884893329', '预约订单', '/order/list?model.type=4', '预约订单', '20170830185731628896338072062993', '11', '1', null);
INSERT INTO `auth_function` VALUES ('20170903180412513771883642819392', '领取赠品', '/order/putOutGoods', '领取赠品', '20170830185731628896338072062993', '12', '1', null);
INSERT INTO `auth_function` VALUES ('20170904150043523454182167230607', '换购小票', '/order/changeEnoughOrderInput', '换购小票', '20170830220333421103573820212235', '8', '1', null);
INSERT INTO `auth_function` VALUES ('20170905113126581783386129837052', '换购订单', '/order/changeEnoughList', '换购订单', '20170830185731628896338072062993', '13', '1', null);
INSERT INTO `auth_function` VALUES ('20170907092643759540912159475573', '线上订单', '/order/list?model.type=1', '线上订单', '20170830185731628896338072062993', '13', '1', null);
INSERT INTO `auth_function` VALUES ('20170907114119815524412901088376', '电子券列表', '/eticket/list', '电子券列表', '20170830210506906087510933120077', '1', '1', null);
INSERT INTO `auth_function` VALUES ('20170907164732612865647529918420', '发放电子券（手动）', '/eticket/goManualOutEticket', '发放电子券（手动）', '20170830210506906087510933120077', '2', '1', null);
INSERT INTO `auth_function` VALUES ('20170907182526490723820173687401', '电子券发放明细', '/eticketoutRecord/getListEticketOut', '电子券发放明细', '20170830210506906087510933120077', '3', '1', null);
INSERT INTO `auth_function` VALUES ('20170908153123715153718590969758', '邮费设置', '/postageBonus/input', '邮费设置', '20170830211023632413917401921109', '18', '1', null);
INSERT INTO `auth_function` VALUES ('20170910113052263946187698109753', '会员充值', '/rechargeRecord/list', '会员充值', '20170830185429920178209535439591', '2', '1', null);
INSERT INTO `auth_function` VALUES ('20170916163654602342670688229142', '赔偿列表', '/order/reparationList', '赔偿列表', '20170830185731628896338072062993', '14', '1', null);
INSERT INTO `auth_function` VALUES ('20170916165347531655467952102185', '赔偿开票', '/order/reparationInput', '赔偿开票', '20170830220333421103573820212235', '9', '1', null);
INSERT INTO `auth_function` VALUES ('20170920120227832495591402472122', '提成管理', 'null_', '提成管理', '00000000000000000000000000000001', '14', '0', 'glyphicon glyphicon-piggy-bank');
INSERT INTO `auth_function` VALUES ('20170920140721113396713522018300', '服务费列表', '/storeBonusDetil/list', '服务费列表', '20170920120227832495591402472122', '1', '1', null);
INSERT INTO `auth_function` VALUES ('20170920140918836827561129524509', '充值提成列表', '/consumeBonusDetail/list', '充值提成列表', '20170920120227832495591402472122', '2', '1', null);
INSERT INTO `auth_function` VALUES ('20170920141135562731777711168645', '注册提成列表', '/registerBonusDetil/list', '注册提成记录列表', '20170920120227832495591402472122', '3', '1', null);
INSERT INTO `auth_function` VALUES ('20170920141344151285783658252960', '销售提成列表', '/bonusDetail/list', '销售提成列表', '20170920120227832495591402472122', '4', '1', null);
INSERT INTO `auth_function` VALUES ('20170920185136363603167195101193', '门店设置', '/store/list', '门店设置', '20170830211023632413917401921109', '1', '1', null);
INSERT INTO `auth_function` VALUES ('20180201143903638866869668932234', '统计管理', 'null_', '统计管理', '00000000000000000000000000000001', '15', '0', 'glyphicon glyphicon-align-left');
INSERT INTO `auth_function` VALUES ('20180201144329056933959728668571', '营收统计', '/statistics/saleList?selectDay=true', '营收统计', '20180201143903638866869668932234', '1', '1', null);
INSERT INTO `auth_function` VALUES ('20180201144620369755932574915577', '销量统计', '/statistics/amountList?selectDay=true', '销量统计', '20180201143903638866869668932234', '2', '1', null);
INSERT INTO `auth_function` VALUES ('20180201144944586115870231089286', '业绩统计', '/statistics/achievementList?selectMonth=true', '业绩统计', '20180201143903638866869668932234', '3', '1', null);

-- ----------------------------
-- Table structure for auth_operation
-- ----------------------------
DROP TABLE IF EXISTS `auth_operation`;
CREATE TABLE `auth_operation` (
  `id` varchar(32) NOT NULL,
  `code` varchar(125) DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL,
  `status` varchar(8) DEFAULT NULL,
  `functionId` varchar(32) DEFAULT NULL,
  `url` varchar(512) DEFAULT NULL,
  `description` varchar(3000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_operation
-- ----------------------------
INSERT INTO `auth_operation` VALUES ('000', 'null_', '添加操作', null, '00000000000000000000000000000004', '/operation/doAddOrUpdate', '添加操作');
INSERT INTO `auth_operation` VALUES ('111', 'null_', '用户', '', '00000000000000000000000000000002', '/user/list', '用户列表');
INSERT INTO `auth_operation` VALUES ('20160415140059891937043500787708', 'null_', '跳转至添加或修改角色', null, '00000000000000000000000000000003', '/role/goAddOrUpdate', '跳转至添加或修改角色');
INSERT INTO `auth_operation` VALUES ('20160415140315589488357298679758', 'null_', '保存角色菜单', null, '00000000000000000000000000000003', '/role/addFunctionWithRole', '保存角色菜单');
INSERT INTO `auth_operation` VALUES ('20160415140650979215674794451962', 'null_', '保存或修改角色', null, '00000000000000000000000000000003', '/role/doAddOrUpdate', '保存或修改角色');
INSERT INTO `auth_operation` VALUES ('20160415143651840724315934364923', 'null_', '获取菜单树', null, '00000000000000000000000000000003', '/function/getFunctionTree', '获取菜单树');
INSERT INTO `auth_operation` VALUES ('20160415164935962215115835027222', 'null_', '删除角色', null, '00000000000000000000000000000003', '/role/doDelete', '删除角色');
INSERT INTO `auth_operation` VALUES ('20160415165703568268531935319815', 'user_input', '跳转至添加用户', null, '00000000000000000000000000000002', '/user/input', '跳转至添加用户');
INSERT INTO `auth_operation` VALUES ('20160415165805876615746724249243', 'null_', '添加用户', null, '00000000000000000000000000000002', '/user/saveOrUpdate', '添加用户');
INSERT INTO `auth_operation` VALUES ('20160415171804273019813454226532', 'user_delete', '删除用户', null, '00000000000000000000000000000002', '/user/doDelete', '删除用户');
INSERT INTO `auth_operation` VALUES ('20160420141639347226653157950297', 'null_', '验证账户以否重复', null, '00000000000000000000000000000002', '/user/isUserExist', '验证账户以否重复');
INSERT INTO `auth_operation` VALUES ('20160729093543406383295943985668', 'user_view', '查看用户', null, '00000000000000000000000000000002', '/user/view', '查看用户');
INSERT INTO `auth_operation` VALUES ('20170830183936652673595283828742', 'null_', '公告列表', null, '20170830183909707277064130641973', '/notice/list', '公告列表');
INSERT INTO `auth_operation` VALUES ('20170830184319456073557599752722', 'notice_input', '新建/修改公告', null, '20170830183909707277064130641973', '/notice/input', '新建/修改公告修改');
INSERT INTO `auth_operation` VALUES ('20170830184346154378900435400313', 'notice_view', '查看公告', null, '20170830183909707277064130641973', '/notice/view', '查看公告');
INSERT INTO `auth_operation` VALUES ('20170830184406104305961735404828', 'notice_delete', '删除公告', null, '20170830183909707277064130641973', '/notice/doDelete', '删除公告修改');
INSERT INTO `auth_operation` VALUES ('20170830184429085652294791142908', 'null_', '公告新增修改操作', null, '20170830183909707277064130641973', '/notice/saveOrUpdate', '公告新增修改操作修改');
INSERT INTO `auth_operation` VALUES ('20170830185533315508572447453603', 'null_', '会员列表', null, '20170830185504559062723332631547', '/customer/list', '会员列表');
INSERT INTO `auth_operation` VALUES ('20170830185601323048968454631701', 'customer_view', '会员详情', null, '20170830185504559062723332631547', '/customer/view', '会员详情');
INSERT INTO `auth_operation` VALUES ('20170830185621893270687419528888', 'customer_isBlank', '会员拉黑', null, '20170830185504559062723332631547', '/customer/doIsBlank', '会员拉黑');
INSERT INTO `auth_operation` VALUES ('20170830190722909644428155787833', 'null_', '订单列表', null, '20170830190702794379289348317756', '/order/list', '订单列表');
INSERT INTO `auth_operation` VALUES ('20170830190749437593611799583348', 'order_print', '小票打印', null, '20170830190702794379289348317756', '/order/salePrintView', '小票打印');
INSERT INTO `auth_operation` VALUES ('20170830190806693389915480819873', 'order_view', '订单详情', null, '20170830190702794379289348317756', '/order/view', '订单详情');
INSERT INTO `auth_operation` VALUES ('20170830190828376902478881510993', 'order_updateOrderStateBySeven', '放弃未支付订单', null, '20170830190702794379289348317756', '/order/updateOrderStateBySeven', '放弃未支付订单');
INSERT INTO `auth_operation` VALUES ('20170830191032390049862822671399', 'null_', '换货单', null, '20170830190959210674064146816515', '/order/changeList', '换货单');
INSERT INTO `auth_operation` VALUES ('20170830191052591570764290093428', 'order_changeInput', '创建/修改换货单', null, '20170830190959210674064146816515', '/order/changeInput', '创建/修改换货单');
INSERT INTO `auth_operation` VALUES ('20170830191112598727093983747834', 'order_changeView', '换货详情', null, '20170830190959210674064146816515', '/order/changeView', '换货详情');
INSERT INTO `auth_operation` VALUES ('20170830191131738117038661939144', 'null_', '依据QrCodeID获取产品信息', null, '20170830190959210674064146816515', '/qrcode/getQrcodeByQrcodeIdForOrder', '依据QrCodeID获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170830191151925745849108113454', 'null_', '验证商品售出', null, '20170830190959210674064146816515', '/order/qrcodeIsSale', '验证商品售出');
INSERT INTO `auth_operation` VALUES ('20170830191213252779732586193257', 'null_', '保存换货单', null, '20170830190959210674064146816515', '/order/changeSaveOrUpdate', '保存换货单');
INSERT INTO `auth_operation` VALUES ('20170830191232595410869912724090', 'order_updateOrderStateBySeven', '放弃未支付订单', null, '20170830190959210674064146816515', '/order/updateOrderStateBySeven', '放弃未支付订单');
INSERT INTO `auth_operation` VALUES ('20170830191258161989305015042996', 'order_print', '小票打印', null, '20170830190959210674064146816515', '/order/changePrintView', '小票打印');
INSERT INTO `auth_operation` VALUES ('20170830191452155693740548441181', 'null_', '同商品换货单', null, '20170830191420447290774284855126', '/order/sameChangeList', '同商品换货单');
INSERT INTO `auth_operation` VALUES ('20170830191505864748906036206883', 'order_sameChangeInput', '创建/修改同商品换货单', null, '20170830191420447290774284855126', '/order/sameChangeInput', '创建/修改同商品换货单');
INSERT INTO `auth_operation` VALUES ('20170830191522823371398187741710', 'order_sameChangeView', '同商品换货详情', null, '20170830191420447290774284855126', '/order/sameChangeView', '同商品换货详情');
INSERT INTO `auth_operation` VALUES ('20170830191539095557519254816008', 'null_', '依据QrCodeID获取产品信息	', null, '20170830191420447290774284855126', '/qrcode/getQrcodeByQrcodeIdForOrder', '依据QrCodeID获取产品信息	');
INSERT INTO `auth_operation` VALUES ('20170830191559505634620738009684', 'null_', '验证商品售出', null, '20170830191420447290774284855126', '/order/qrcodeIsSale', '验证商品售出');
INSERT INTO `auth_operation` VALUES ('20170830191617163610391939087218', 'null_', '保存同商品换货单', null, '20170830191420447290774284855126', '/order/sameChangeSaveOrUpdate', '保存同商品换货单');
INSERT INTO `auth_operation` VALUES ('20170830191631242284938401241106', 'order_updateOrderStateBySeven', '放弃未支付订单', null, '20170830191420447290774284855126', '/order/updateOrderStateBySeven', '放弃未支付订单');
INSERT INTO `auth_operation` VALUES ('20170830191649218225294187613654', 'order_print', '小票打印', null, '20170830191420447290774284855126', '/order/sameChangePrintView', '小票打印');
INSERT INTO `auth_operation` VALUES ('20170830191816873595811679804946', 'null_', '退货列表', null, '20170830191749488648028410600993', '/order/returnList', '退货列表');
INSERT INTO `auth_operation` VALUES ('20170830191833743610957280978678', 'order_returnInput', '添加退货单', null, '20170830191749488648028410600993', '/order/returnInput', '添加退货单');
INSERT INTO `auth_operation` VALUES ('20170830191851344574311818941542', 'order_returnView', '查看退货单', null, '20170830191749488648028410600993', '/order/returnView', '查看退货单');
INSERT INTO `auth_operation` VALUES ('20170830191914892000759564094882', 'null_', '依据QrCodeID获取产品信息', null, '20170830191749488648028410600993', '/qrcode/getQrcodeByQrcodeIdForOrder', '依据QrCodeID获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170830191935642499525772525756', 'null_', '验证商品售出', null, '20170830191749488648028410600993', '/order/qrcodeIsSale', '验证商品售出');
INSERT INTO `auth_operation` VALUES ('20170830191958829086242466989194', 'null_', '保存退货单', null, '20170830191749488648028410600993', '/order/returnSaveOrUpdate', '保存退货单');
INSERT INTO `auth_operation` VALUES ('20170830192032675542147064290037', 'order_updateOrderStateBySeven', '放弃未支付订单', null, '20170830191749488648028410600993', '/order/updateOrderStateBySeven', '放弃未支付订单');
INSERT INTO `auth_operation` VALUES ('20170830192054683460859544871283', 'order_print', '小票打印', null, '20170830191749488648028410600993', '/order/returnPrintView', '小票打印');
INSERT INTO `auth_operation` VALUES ('20170830193152120595507615483034', 'null_', '商品列表', null, '20170830193127615704538008702005', '/goods/list', '商品列表');
INSERT INTO `auth_operation` VALUES ('20170830193222502820225571239715', 'goods_input', '商品添加修改页面', null, '20170830193127615704538008702005', '/goods/input', '商品添加修改页面');
INSERT INTO `auth_operation` VALUES ('20170830193238046005494334668906', 'goods_view', '查看商品详情', null, '20170830193127615704538008702005', '/goods/view', '查看商品详情');
INSERT INTO `auth_operation` VALUES ('20170830193255125760891065708665', 'goods_delete', '删除商品', null, '20170830193127615704538008702005', '/goods/doDelete', '删除商品');
INSERT INTO `auth_operation` VALUES ('20170830193330260862194401977716', 'null_', '更新保存商品', null, '20170830193127615704538008702005', '/goods/saveOrUpdate', '更新保存商品');
INSERT INTO `auth_operation` VALUES ('20170830193421061689978568425583', 'goods_doVisible', '商品上架下架操作', null, '20170830193127615704538008702005', '/goods/doSetVisible', '商品上架下架操作');
INSERT INTO `auth_operation` VALUES ('20170830193443869546062429795974', 'goods_doRecommed', '商品推荐', null, '20170830193127615704538008702005', '/goods/doSetRecommed', '商品推荐');
INSERT INTO `auth_operation` VALUES ('20170830193505037098024646042053', 'class_goodsChild', '拿取子产品', null, '20170830193127615704538008702005', '/classification/goodsChild', '拿取子产品');
INSERT INTO `auth_operation` VALUES ('20170830193528425979326277446232', 'class_getTwoClassification', '获取二级分类', null, '20170830193127615704538008702005', '/classification/getTwoClassification', '获取二级分类');
INSERT INTO `auth_operation` VALUES ('20170830195203940806023405686549', 'null_', '活动列表', null, '20170830194954276445047746311165', '/promotionGroup/list', '活动列表');
INSERT INTO `auth_operation` VALUES ('20170830195224496291856286404584', 'promotionGroup_input', '添加/编辑活动组', null, '20170830194954276445047746311165', '/promotionGroup/input', '添加/编辑活动组');
INSERT INTO `auth_operation` VALUES ('20170830195251191262648827672964', 'promotionGroup_view', '查看活动组', null, '20170830194954276445047746311165', '/promotionGroup/view', '查看活动组');
INSERT INTO `auth_operation` VALUES ('20170830195314785640772998552609', 'promotionGroup_delete', '删除活动组', null, '20170830194954276445047746311165', '/promotionGroup/doDelete', '删除活动组');
INSERT INTO `auth_operation` VALUES ('20170830195352937457574523798180', 'null_', '保存活动组', null, '20170830194954276445047746311165', '/promotionGroup/saveOrUpdate', '保存活动组');
INSERT INTO `auth_operation` VALUES ('20170830195432994371041316490602', 'null_', '活动组获取产品', null, '20170830194954276445047746311165', '/goods/getGoodsListWhithProGroup', '活动组获取产品');
INSERT INTO `auth_operation` VALUES ('20170830195508840331307265397642', 'null_', '获取下一级分类列表', null, '20170830194954276445047746311165', '/classification/getTwoClassification', '获取下一级分类列表修改');
INSERT INTO `auth_operation` VALUES ('20170830195820048673255790198309', 'null_', '采购订单list', null, '20170830195737455259940359442166', '/procurement/list', '采购订单list');
INSERT INTO `auth_operation` VALUES ('20170830195837172395553321840017', 'procurement_add', '添加采购订单', null, '20170830195737455259940359442166', '/procurement/input', '添加采购订单');
INSERT INTO `auth_operation` VALUES ('20170830195855484937024655629259', 'null_', '获取产品信息', null, '20170830195737455259940359442166', '/goods/getGoodsByGoodsId', '获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170830195917902820776713291685', 'null_', '获取产品信息', null, '20170830195737455259940359442166', '/goods/getGoodsByQrcodeId', '获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170830195935564931630978871605', 'null_', '保存采购单', null, '20170830195737455259940359442166', '/procurement/saveOrUpdate', '保存采购单');
INSERT INTO `auth_operation` VALUES ('20170830195952927735812968924402', 'procurement_update', '修改采购订单', null, '20170830195737455259940359442166', '/procurement/input', '修改采购订单');
INSERT INTO `auth_operation` VALUES ('20170830200010440770258081239747', 'procurement_view', '查看采购订单', null, '20170830195737455259940359442166', '/procurement/view', '查看采购订单');
INSERT INTO `auth_operation` VALUES ('20170830200035607992811693777952', 'procurement_delete', '删除采购单', null, '20170830195737455259940359442166', '/procurement/doDelete', '删除采购单');
INSERT INTO `auth_operation` VALUES ('20170830200059305228605976665035', 'null_', '获取子产品备选项', null, '20170830195737455259940359442166', '/goods/getSubGoodsByGoodsId', '获取子产品备选项');
INSERT INTO `auth_operation` VALUES ('20170830200122024157882634843521', 'procurement_check', '审核采购单', null, '20170830195737455259940359442166', '/procurement/doCheck', '审核采购单');
INSERT INTO `auth_operation` VALUES ('20170830200138467141485172827079', 'procurement_proGoodsGoHome', '采购到货', null, '20170830195737455259940359442166', '/procurement/input', '采购到货');
INSERT INTO `auth_operation` VALUES ('20170830200203606705146483134270', 'null_', '门店Id获取商品列表', null, '20170830195737455259940359442166', '/goods/getGoodsByStoreId', '门店Id获取商品列表');
INSERT INTO `auth_operation` VALUES ('20170830200225095851015197490178', 'procurement_printView', '打印采购单', null, '20170830195737455259940359442166', '/procurement/procurementPrintView', '打印采购单');
INSERT INTO `auth_operation` VALUES ('20170830200453019324751350889773', 'null_', '采购订单list', null, '20170830200418252654557431739635', '/procurement/returnList', '采购订单list');
INSERT INTO `auth_operation` VALUES ('20170830200510672214993873192328', 'procurement_add', '添加采购订单', null, '20170830200418252654557431739635', '/procurement/returnInput', '添加采购订单');
INSERT INTO `auth_operation` VALUES ('20170830200533595050868616542628', 'null_', '获取产品信息', null, '20170830200418252654557431739635', '/goods/getGoodsByGoodsId', '获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170830200559215203812372538141', 'null_', '获取产品信息', null, '20170830200418252654557431739635', '/goods/getGoodsByQrcodeId', '获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170830200621039369322000231880', 'null_', '保存采购单', null, '20170830200418252654557431739635', '/procurement/returnSaveOrUpdate', '保存采购单');
INSERT INTO `auth_operation` VALUES ('20170830200635789169186303647746', 'procurement_update', '修改采购订单', null, '20170830200418252654557431739635', '/procurement/returnInput', '修改采购订单');
INSERT INTO `auth_operation` VALUES ('20170830200652734808802789393289', 'procurement_view', '查看采购订单', null, '20170830200418252654557431739635', '/procurement/returnView', '查看采购订单');
INSERT INTO `auth_operation` VALUES ('20170830200711652334092203833713', 'procurement_delete', '删除采购单商品', null, '20170830200418252654557431739635', '/procurement/returnDoDelete', '删除采购单商品');
INSERT INTO `auth_operation` VALUES ('20170830200733143235499828027705', 'null_', '获取子产品备选项', null, '20170830200418252654557431739635', '/goods/getSubGoodsByGoodsId', '获取子产品备选项');
INSERT INTO `auth_operation` VALUES ('20170830200800396241502855800517', 'procurement_check', '审核采购单', null, '20170830200418252654557431739635', '/procurement/returnDoCheck', '审核采购单');
INSERT INTO `auth_operation` VALUES ('20170830200821065628262301789436', 'null_', '门店Id获取商品列表', null, '20170830200418252654557431739635', '/goods/getGoodsByStoreId', '门店Id获取商品列表');
INSERT INTO `auth_operation` VALUES ('20170830200845995931051321942756', 'null_', '根据二维码获取商品并保存锁定', null, '20170830200418252654557431739635', '/qrcode/getQrcodeByQrcodeIdForProcurement', '根据二维码获取商品并保存锁定');
INSERT INTO `auth_operation` VALUES ('20170830200906019190839087178461', 'null_', '完成退货单', null, '20170830200418252654557431739635', '/procurement/submitProcurement', '完成退货单');
INSERT INTO `auth_operation` VALUES ('20170830200927016251907168067342', 'procurement_delete', '删除退货单', null, '20170830200418252654557431739635', '/procurement/doDelete', '删除退货单');
INSERT INTO `auth_operation` VALUES ('20170830200947055208552582025791', 'procurement_printView', '打印退货单', null, '20170830200418252654557431739635', '/procurement/returnProcurementPrintView', '打印退货单');
INSERT INTO `auth_operation` VALUES ('20170830203035959990263517692453', 'null_', '库存列表', null, '20170830203014829529478121512844', '/inventory/list', '库存列表');
INSERT INTO `auth_operation` VALUES ('20170830203053742545387620019408', 'inventory_view', '查看库存', null, '20170830203014829529478121512844', '/inventory/view', '查看库存');
INSERT INTO `auth_operation` VALUES ('20170830203204411619479342360450', 'null_', '库存调拨列表', null, '20170830203138578743848208894007', '/allocation/list', '库存调拨列表');
INSERT INTO `auth_operation` VALUES ('20170830203229059912520138805051', 'allocation_view', '查看库存调拨详情', null, '20170830203138578743848208894007', '/allocation/view', '查看库存调拨详情');
INSERT INTO `auth_operation` VALUES ('20170830203245078859643401520432', 'allocation_input', '新增库存调拨', null, '20170830203138578743848208894007', '/allocation/input', '新增库存调拨');
INSERT INTO `auth_operation` VALUES ('20170830203314561783574956214499', 'null_', '保存库存调拨操作', null, '20170830203138578743848208894007', '/allocation/saveOrUpdate', '保存库存调拨操作');
INSERT INTO `auth_operation` VALUES ('20170830203337046887089951104842', 'null_', '根据二维码id获取商品并保存记录', null, '20170830203138578743848208894007', '/qrcode/getQrcodeByQrcodeId', '根据二维码id获取商品并保存记录');
INSERT INTO `auth_operation` VALUES ('20170830203412170253996782685499', 'null_', '删除调拨记录', null, '20170830203138578743848208894007', '/allocation/doDelete', '删除调拨记录');
INSERT INTO `auth_operation` VALUES ('20170830203434857895994524825578', 'null_', '提交调拨单', null, '20170830203138578743848208894007', '/allocation/submitAllocation', '提交调拨单');
INSERT INTO `auth_operation` VALUES ('20170830203454874645851788208264', 'allocation_delete', '删除调拨单', null, '20170830203138578743848208894007', '/allocation/doAllDelete', '删除调拨单');
INSERT INTO `auth_operation` VALUES ('20170830203616566096519330461855', 'null_', '盘点单列表', null, '20170830203543201341540025481647', '/checkstorage/list', '盘点单列表');
INSERT INTO `auth_operation` VALUES ('20170830203633152858219054080187', 'checkstorage_view', '查看盘点单详情', null, '20170830203543201341540025481647', '/checkstorage/view', '查看盘点单详情');
INSERT INTO `auth_operation` VALUES ('20170830203652475742148953065984', 'checkstorage_input', '新建盘点单', null, '20170830203543201341540025481647', '/checkstorage/input', '新建盘点单');
INSERT INTO `auth_operation` VALUES ('20170830203716513129724449127565', 'null_', '盘点单保存操作', null, '20170830203543201341540025481647', '/checkstorage/saveOrUpdate', '盘点单保存操作');
INSERT INTO `auth_operation` VALUES ('20170830203736964161934704787780', 'null_', '根据主产品Id和仓库Id获取子商品', null, '20170830203543201341540025481647', '/goods/getGoodsChildListByInventoryGoodsId', '根据主产品Id和仓库Id获取子商品');
INSERT INTO `auth_operation` VALUES ('20170830203752350522933646435726', 'null_', '保存盘点明细', null, '20170830203543201341540025481647', '/checkstorage/saveCheckstorageGoodsByGoodsId', '保存盘点明细');
INSERT INTO `auth_operation` VALUES ('20170830203813863424129297763009', 'null_', '删除没有完成盘点的明细', null, '20170830203543201341540025481647', '/checkstorage/doDelete', '删除没有完成盘点的明细');
INSERT INTO `auth_operation` VALUES ('20170830203836527089635691439736', 'null_', '库存对比', null, '20170830203543201341540025481647', '/checkstorage/doCheckstorage', '库存对比');
INSERT INTO `auth_operation` VALUES ('20170830203858873403908013613747', 'null_', '提交盘库单', null, '20170830203543201341540025481647', '/checkstorage/submitCheckstorage', '提交盘库单');
INSERT INTO `auth_operation` VALUES ('20170830204039137295666638698705', 'null_', '打印二维码', null, '20170830204008872143102098236806', '/qrcode/input', '打印二维码');
INSERT INTO `auth_operation` VALUES ('20170830204059190526804874997134', 'null_', '生成二维码并入库', null, '20170830204008872143102098236806', '/qrcode/saveOrUpdate', '生成二维码并入库');
INSERT INTO `auth_operation` VALUES ('20170830204126165088235734958805', 'null_', '跳转打印页面', null, '20170830204008872143102098236806', '/qrcode/printQRCode', '跳转打印页面');
INSERT INTO `auth_operation` VALUES ('20170830204321749837379879602702', 'null_', '二维码列表', null, '20170830204300007556616765694571', '/qrcode/list', '二维码列表');
INSERT INTO `auth_operation` VALUES ('20170830204349041238399100946574', 'qrcode_print_one_again', '补印', null, '20170830204300007556616765694571', '/qrcode/printQRCode', '补印');
INSERT INTO `auth_operation` VALUES ('20170830210050983654416591528041', 'null_', '采购列表', null, '20170830210032500639302088394405', '/finance/procurementList', '采购列表');
INSERT INTO `auth_operation` VALUES ('20170830210108147838673454239815', 'finance_view', '采购单详情', null, '20170830210032500639302088394405', '/finance/procurementView', '采购单详情');
INSERT INTO `auth_operation` VALUES ('20170830210244944377208133449940', 'null_', '充值列表', null, '20170830210224485662374233983717', '/finance/rechargeRecordList', '充值列表');
INSERT INTO `auth_operation` VALUES ('20170830210350828615376414330570', 'null_', '订单列表', null, '20170830210326269196310192189589', '/finance/orderList', '订单列表');
INSERT INTO `auth_operation` VALUES ('20170830210422095476470737738774', 'finance_view', '订单详情', null, '20170830210326269196310192189589', '/finance/orderView', '订单详情');
INSERT INTO `auth_operation` VALUES ('20170830211545739797129742299757', 'null_', '品牌列表', null, '20170830211521443870931033782224', '/brand/list', '品牌列表');
INSERT INTO `auth_operation` VALUES ('20170830211608287007426469438342', 'brand_input', '添加/编辑品牌信息', null, '20170830211521443870931033782224', '/brand/input', '添加/编辑品牌信息');
INSERT INTO `auth_operation` VALUES ('20170830211626971107596734913926', 'brand_view', '查看品牌信息', null, '20170830211521443870931033782224', '/brand/view', '查看品牌信息');
INSERT INTO `auth_operation` VALUES ('20170830211716018298124906467040', 'brand_delete', '删除品牌信息', null, '20170830211521443870931033782224', '/brand/doDelete', '删除品牌信息');
INSERT INTO `auth_operation` VALUES ('20170830211751786212522408000578', 'null_', '保存品牌信息', null, '20170830211521443870931033782224', '/brand/saveOrUpdate', '保存品牌信息');
INSERT INTO `auth_operation` VALUES ('20170830211921560895807710877489', 'null_', '列表', null, '20170830211859067594508738262698', '/classification/list', '列表');
INSERT INTO `auth_operation` VALUES ('20170830211950087115438341093784', 'null_', '分类树数据', null, '20170830211859067594508738262698', '/classification/getClassificationTree', '分类树数据');
INSERT INTO `auth_operation` VALUES ('20170830212014158352628251425243', 'class_addOrUpdate', '添加修改', null, '20170830211859067594508738262698', '/classification/goAddOrUpdate', '添加修改');
INSERT INTO `auth_operation` VALUES ('20170830212033335458755658047737', 'class_doAddOrUpdate', '提交添加修改', null, '20170830211859067594508738262698', '/classification/doAddOrUpdate', '提交添加修改');
INSERT INTO `auth_operation` VALUES ('20170830212056944298966506560326', 'class_delete', '删除', null, '20170830211859067594508738262698', '/classification/doDelete', '删除');
INSERT INTO `auth_operation` VALUES ('20170830212113637870012701083910', 'class_showHide', '显示隐藏', null, '20170830211859067594508738262698', '/classification/showHideNode', '显示隐藏');
INSERT INTO `auth_operation` VALUES ('20170830212135769405690260315679', 'null_', '属性列表', null, '20170830211859067594508738262698', '/classification/otherAttrJsonList', '属性列表');
INSERT INTO `auth_operation` VALUES ('20170830212157375035684564351454', 'otherAttrJson_addOrUpdate', '属性添加或修改', null, '20170830211859067594508738262698', '/classification/otherAttrJsonAddOrUpdate', '属性添加或修改');
INSERT INTO `auth_operation` VALUES ('20170830212228299103924413492470', 'otherAttrJson_doAddOrUpdate', '提交属性添加或修改', null, '20170830211859067594508738262698', 'classification/otherAttrJsonDoAddOrUpdate', '提交属性添加或修改');
INSERT INTO `auth_operation` VALUES ('20170830212254780925581597225004', 'otherAttrJson_delete', '删除属性', null, '20170830211859067594508738262698', '/classification/otherAttrJsonDoDelete', '删除属性');
INSERT INTO `auth_operation` VALUES ('20170830212332619600555298135658', 'class_goodsChild', '拿取子产品', null, '20170830211859067594508738262698', '/classification/goodsChild', '拿取子产品');
INSERT INTO `auth_operation` VALUES ('20170830212359656989384123764127', 'class_getTwoClassification', '获取二级分类', null, '20170830211859067594508738262698', '/classification/getTwoClassification', '获取二级分类');
INSERT INTO `auth_operation` VALUES ('20170830212534459278207549854018', 'null_', '单位列表', null, '20170830212500858165271076518856', '/specification/list', '单位列表');
INSERT INTO `auth_operation` VALUES ('20170830212556246765793315531106', 'specification_input', '新建/修改单位', null, '20170830212500858165271076518856', '/specification/input', '新建/修改单位');
INSERT INTO `auth_operation` VALUES ('20170830212611859339507179554965', 'specification_view', '查看单位', null, '20170830212500858165271076518856', '/specification/view', '查看单位');
INSERT INTO `auth_operation` VALUES ('20170830212627419785295268488307', 'specification_delete', '删除单位', null, '20170830212500858165271076518856', '/specification/doDelete', '删除单位');
INSERT INTO `auth_operation` VALUES ('20170830212648265015864575748796', 'null_', '单位修改新建操作', null, '20170830212500858165271076518856', '/specification/saveOrUpdate', '单位修改新建操作');
INSERT INTO `auth_operation` VALUES ('20170830212803180811449554456231', 'null_', '供应商列表', null, '20170830212742847304965710849167', '/vende/list', '供应商列表');
INSERT INTO `auth_operation` VALUES ('20170830212914025931296641205275', 'vende_input', '添加/修改供应商', null, '20170830212742847304965710849167', '/vende/input', '添加/修改供应商');
INSERT INTO `auth_operation` VALUES ('20170830212929046902239455990989', 'vende_view', '查看供应商', null, '20170830212742847304965710849167', '/vende/view', '查看供应商');
INSERT INTO `auth_operation` VALUES ('20170830212943299510229978750685', 'vende_delete', '删除供应商', null, '20170830212742847304965710849167', '/vende/doDelete', '删除供应商');
INSERT INTO `auth_operation` VALUES ('20170830213007959971201919448803', 'null_', '供应商-获取下级地区列表', null, '20170830212742847304965710849167', '/vende/getAjaxAreaByAreaId', '供应商-获取下级地区列表');
INSERT INTO `auth_operation` VALUES ('20170830213023939361611037584704', 'null_', '保存供应商', null, '20170830212742847304965710849167', '/vende/saveOrUpdate', '保存供应商');
INSERT INTO `auth_operation` VALUES ('20170830213135099233361023687146', 'null_', '仓库列表', null, '20170830213114654521981752595705', '/storage/list', '仓库列表');
INSERT INTO `auth_operation` VALUES ('20170830213149064945692852236219', 'storage_input', '添加/编辑仓库', null, '20170830213114654521981752595705', '/storage/input', '添加/编辑仓库');
INSERT INTO `auth_operation` VALUES ('20170830213202742967167983709658', 'storage_view', '查看仓库', null, '20170830213114654521981752595705', '/storage/view', '查看仓库');
INSERT INTO `auth_operation` VALUES ('20170830213215906553105841332218', 'storage_stop', '仓库停用', null, '20170830213114654521981752595705', '/storage/doStorageStop', '仓库停用');
INSERT INTO `auth_operation` VALUES ('20170830213233450633913008953329', 'storage_start', '仓库启用', null, '20170830213114654521981752595705', '/storage/doStorageStart', '仓库启用');
INSERT INTO `auth_operation` VALUES ('20170830213253940472094124583770', 'storage_delete', '删除仓库', null, '20170830213114654521981752595705', '/storage/doDelete', '删除仓库');
INSERT INTO `auth_operation` VALUES ('20170830213311100232731582212618', 'null_', '保存仓库信息', null, '20170830213114654521981752595705', '/storage/saveOrUpdate', '保存仓库信息');
INSERT INTO `auth_operation` VALUES ('20170830213704353099274706931817', 'null_', '服务费档位列表', null, '20170830213637287649377336464713', '/storeBonus/list', '服务费档位列表');
INSERT INTO `auth_operation` VALUES ('20170830213718045711614226852092', 'storeBonus_input', '服务费档位保存/修改页面', null, '20170830213637287649377336464713', '/storeBonus/input', '服务费档位保存/修改页面');
INSERT INTO `auth_operation` VALUES ('20170830213733907673564571219506', 'storeBonus_saveOrUpdate', '服务费档位保存修改', null, '20170830213637287649377336464713', '/storeBonus/saveOrUpdate', '服务费档位保存修改');
INSERT INTO `auth_operation` VALUES ('20170830213747348506915128859724', 'storeBonus_delete', '删除档位', null, '20170830213637287649377336464713', '/storeBonus/doDelete', '删除档位');
INSERT INTO `auth_operation` VALUES ('20170830213953940366539874174465', 'null_', '返现列表', null, '20170830213928619714435380492216', '/backCash/list', '返现列表');
INSERT INTO `auth_operation` VALUES ('20170830214006843684625415051517', 'backCash_input', '返现设置', null, '20170830213928619714435380492216', '/backCash/input', '返现设置');
INSERT INTO `auth_operation` VALUES ('20170830214022791576408892303322', 'null_', '返现保存或修改', null, '20170830213928619714435380492216', '/backCash/saveOrUpdate', '返现保存或修改');
INSERT INTO `auth_operation` VALUES ('20170830214041734597098657415801', 'backCash_delete', '删除返现', null, '20170830213928619714435380492216', '/backCash/doDelete', '删除返现');
INSERT INTO `auth_operation` VALUES ('20170830214153268802138626499532', 'null_', '充值档位列表', null, '20170830214134550927178354397788', '/consumeBonus/list', '充值档位列表');
INSERT INTO `auth_operation` VALUES ('20170830214401798214742782123975', 'consumeBonus_input', '充值提成档位新建/修改页面', null, '20170830214134550927178354397788', '/consumeBonus/input', '充值提成档位新建/修改页面');
INSERT INTO `auth_operation` VALUES ('20170830214415258393708769574832', 'null_', '充值提成档位保存/修改', null, '20170830214134550927178354397788', '/consumeBonus/saveOrUpdate', '充值提成档位保存/修改');
INSERT INTO `auth_operation` VALUES ('20170830214434115909390449265146', 'consumeBonus_delete', '删除提成档位', null, '20170830214134550927178354397788', '/consumeBonus/doDelete', '删除提成档位');
INSERT INTO `auth_operation` VALUES ('20170830214738035600358988957724', 'null_', '提成金额列表', null, '20170830214722853299084468988221', '/registerBonus/list', '提成金额列表');
INSERT INTO `auth_operation` VALUES ('20170830214752934809972100332433', 'registerBonus_input', '提成金额修改', null, '20170830214722853299084468988221', '/registerBonus/input', '提成金额修改');
INSERT INTO `auth_operation` VALUES ('20170830214807111720016409648219', 'null_', '提成金额修改', null, '20170830214722853299084468988221', '/registerBonus/saveOrUpdate', '提成金额修改');
INSERT INTO `auth_operation` VALUES ('20170830215111552861387885084073', 'null_', '提成比例', null, '20170830215054894588174665620170', '/bonus/input', '提成比例');
INSERT INTO `auth_operation` VALUES ('20170830215124930957317542739923', 'null_', '保存提成比例', null, '20170830215054894588174665620170', '/bonus/saveOrUpdate', '保存提成比例');
INSERT INTO `auth_operation` VALUES ('20170830215320842455637439865516', 'null_', '上传微信轮播图', null, '20170830215258813602882080472084', '/banner/input', '上传微信轮播图');
INSERT INTO `auth_operation` VALUES ('20170830215338459584495438169410', 'null_', '上传微信轮播图', null, '20170830215258813602882080472084', '/banner/saveOrUpdate', '上传微信轮播图');
INSERT INTO `auth_operation` VALUES ('20170830215757313960577375204946', 'null_', '余额记录', null, '20170830215734365360148127838984', '/consume/list', '余额记录');
INSERT INTO `auth_operation` VALUES ('20170830220441139694103448196396', 'null_', '开购物小票', null, '20170830220418115613075933228358', '/order/saleOrderInput', '开购物小票');
INSERT INTO `auth_operation` VALUES ('20170830220458339411164578781860', 'null_', '通过产品二维码获取产品信息', null, '20170830220418115613075933228358', '/goods/getGoodsByQrcodeId', '通过产品二维码获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170830220543436366673074942046', 'null_', '保存小票信息', null, '20170830220418115613075933228358', '/order/saveSaleOrderInpute', '保存小票信息');
INSERT INTO `auth_operation` VALUES ('20170830220601087993196261449532', 'null_', '获取会员信息', null, '20170830220418115613075933228358', '/customer/getCustomerByPhone', '获取会员信息');
INSERT INTO `auth_operation` VALUES ('20170830220616963034804233346995', 'null_', '打印销售小票', null, '20170830220418115613075933228358', '/order/salePrintView', '打印销售小票');
INSERT INTO `auth_operation` VALUES ('20170830220818308255756136442249', 'null_', '开具优惠小票', null, '20170830220758624700709841742603', '/order/saleOrderInput', '开具优惠小票');
INSERT INTO `auth_operation` VALUES ('20170830220831577355506263810937', 'null_', 'qrcodeID获取产品信息', null, '20170830220758624700709841742603', '/goods/getGoodsByQrcodeId	qrcodeID', 'qrcodeID获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170830220845865071616932248992', 'null_', '保存优惠小票信息', null, '20170830220758624700709841742603', '/order/saveSaleOrderInpute', '保存优惠小票信息');
INSERT INTO `auth_operation` VALUES ('20170830220858315326988400656258', 'null_', '打印销售小票', null, '20170830220758624700709841742603', '/order/salePrintView', '打印销售小票');
INSERT INTO `auth_operation` VALUES ('20170830221206067540701643775772', 'null_', '创建/修改换货单', null, '20170830221143028763978658679598', '/order/changeInput', '创建/修改换货单');
INSERT INTO `auth_operation` VALUES ('20170830221342485829692444578458', 'order_sameChangeInput', '创建/修改同商品换货单', null, '20170830221255184869187266662568', '/order/sameChangeInput', '创建/修改同商品换货单');
INSERT INTO `auth_operation` VALUES ('20170831090823404895520550183036', 'null_', '依据QrCodeID获取产品信息', null, '20170830221143028763978658679598', '/qrcode/getQrcodeByQrcodeIdForOrder', '依据QrCodeID获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170831090842394067468749624482', 'null_', '验证商品售出', null, '20170830221143028763978658679598', '/order/qrcodeIsSale', '验证商品售出');
INSERT INTO `auth_operation` VALUES ('20170831090904530255190582381704', 'null_', '保存换货单', null, '20170830221143028763978658679598', '/order/changeSaveOrUpdate', '保存换货单');
INSERT INTO `auth_operation` VALUES ('20170831091037931301204391574018', 'null_', '依据QrCodeID获取产品信息', null, '20170830221255184869187266662568', '/qrcode/getQrcodeByQrcodeIdForOrder', '依据QrCodeID获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170831091054757756440391549622', 'null_', '验证商品售出', null, '20170830221255184869187266662568', '/order/qrcodeIsSale', '验证商品售出');
INSERT INTO `auth_operation` VALUES ('20170831091114663636182485116000', 'null_', '保存同商品换货单', null, '20170830221255184869187266662568', '/order/sameChangeSaveOrUpdate', '保存同商品换货单');
INSERT INTO `auth_operation` VALUES ('20170831091134477383412239547365', 'null_', '小票打印', null, '20170830221255184869187266662568', '/order/sameChangePrintView', '小票打印');
INSERT INTO `auth_operation` VALUES ('20170831091351799340740492080238', 'null_', '小票打印', null, '20170830221143028763978658679598', '/order/changePrintView', '小票打印');
INSERT INTO `auth_operation` VALUES ('20170831091452630349570747589312', 'null_', '添加退货单', null, '20170830221450704419578232369378', '/order/returnInput', '添加退货单');
INSERT INTO `auth_operation` VALUES ('20170831091509550904465168486741', 'null_', '依据QrCodeID获取产品信息', null, '20170830221450704419578232369378', '/qrcode/getQrcodeByQrcodeIdForOrder', '依据QrCodeID获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170831091524660883084183578190', 'null_', '验证商品售出', null, '20170830221450704419578232369378', '/order/qrcodeIsSale', '验证商品售出');
INSERT INTO `auth_operation` VALUES ('20170831091541134657816842497374', 'null_', '保存退货单', null, '20170830221450704419578232369378', '/order/returnSaveOrUpdate', '保存退货单');
INSERT INTO `auth_operation` VALUES ('20170831091607069781971137922926', 'null_', '小票打印', null, '20170830221450704419578232369378', '/order/returnPrintView', '小票打印');
INSERT INTO `auth_operation` VALUES ('20170831092359419731612772798077', 'null_', '同商品换货单', null, '20170830221255184869187266662568', '/order/sameChangeList', '同商品换货单');
INSERT INTO `auth_operation` VALUES ('20170831100530218510588540721908', 'null_', '购物小票（预约）', null, '20170831100443749421767820382012', '/order/reserveOrderInput', '购物小票（预约）');
INSERT INTO `auth_operation` VALUES ('20170831100622636533463463390766', 'null_', '通过产品二维码获取产品信息', null, '20170831100443749421767820382012', '/goods/getGoodsByQrcodeId', '通过产品二维码获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170831100640590241918773881571', 'null_', '保存小票信息', null, '20170831100443749421767820382012', '/order/saveReserveOrderInpute', '保存小票信息');
INSERT INTO `auth_operation` VALUES ('20170831100656906158826502178716', 'null_', '获取会员信息', null, '20170831100443749421767820382012', '/customer/getCustomerByPhone', '获取会员信息');
INSERT INTO `auth_operation` VALUES ('20170831100733813001561918127715', 'null_', '打印销售小票', null, '20170831100443749421767820382012', '/order/reservePrintView', '打印销售小票');
INSERT INTO `auth_operation` VALUES ('20170831105807772263557378087647', 'null_', '开具优惠小票（预约）', null, '20170831105709637433542084155567', '/order/reserveOrderInput', '开具优惠小票（预约）');
INSERT INTO `auth_operation` VALUES ('20170831105832739400369125491431', 'null_', 'qrcodeID获取产品信息', null, '20170831105709637433542084155567', '/goods/getGoodsByQrcodeId', 'qrcodeID获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170831105927984316407217054495', 'null_', '保存优惠小票信息（预约）', null, '20170831105709637433542084155567', '/order/saveReserveOrderInpute', '保存优惠小票信息（预约）');
INSERT INTO `auth_operation` VALUES ('20170831110000215992981890414702', 'null_', '打印优惠小票（预约）', null, '20170831105709637433542084155567', '/order/reservePrintView', '打印优惠小票（预约）');
INSERT INTO `auth_operation` VALUES ('20170831114645428580227358769013', 'null_', '售后列表', null, '20170831114538119517520094403238', '/orderAfterSale/list', '售后列表');
INSERT INTO `auth_operation` VALUES ('20170831114800589839023932430424', 'orderAfterSale_input', '添加修改售后页面', null, '20170831114538119517520094403238', '/orderAfterSale/input', '添加修改售后页面');
INSERT INTO `auth_operation` VALUES ('20170831114900835577449018434717', 'orderAfterSale_view', '查看售后详情', null, '20170831114538119517520094403238', '/orderAfterSale/view', '查看售后详情');
INSERT INTO `auth_operation` VALUES ('20170831115232110312229633735226', 'null_', '更新保存售后', null, '20170831114538119517520094403238', '/orderAfterSale/saveOrUpdate', '更新保存售后');
INSERT INTO `auth_operation` VALUES ('20170831151508090096348255140737', 'null_', '获取产品', null, '20170831105709637433542084155567', '/goods/getSubGoodsByGoodsId', '获取产品');
INSERT INTO `auth_operation` VALUES ('20170831151803868414915813007770', 'null_', '预约发货添加二维码', null, '20170831100443749421767820382012', '/order/receiverAddQrcode', '预约发货添加二维码');
INSERT INTO `auth_operation` VALUES ('20170831151823302739455915673552', 'null_', '预约发货添加二维码', null, '20170831105709637433542084155567', '/order/receiverAddQrcode', '预约发货添加二维码');
INSERT INTO `auth_operation` VALUES ('20170831152357551036226051636426', 'null_', '根据qrcodeId获取订单', null, '20170831114538119517520094403238', '/order/getOrderByQrcode', '根据qrcodeId获取订单');
INSERT INTO `auth_operation` VALUES ('20170831153446708399055356111151', 'null_', '获取产品', null, '20170831100443749421767820382012', '/goods/getSubGoodsByGoodsId', '获取产品');
INSERT INTO `auth_operation` VALUES ('20170831155353912975629355468740', 'null_', '依据QrCodeID获取产品信息', null, '20170831114538119517520094403238', '/qrcode/getQrcodeByQrcodeIdForOrder', '依据QrCodeID获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170831160301978356681033009495', 'null_', '获取产品详细信息', null, '20170831105709637433542084155567', '/goods/getGoodsByGoodsId', '获取产品详细信息');
INSERT INTO `auth_operation` VALUES ('20170831160345075705059483322899', 'null_', '获取产品详细信息', null, '20170831100443749421767820382012', '/goods/getGoodsByGoodsId', '获取产品详细信息');
INSERT INTO `auth_operation` VALUES ('20170831160929813718586152163894', 'null_', '验证商品售出', null, '20170831114538119517520094403238', '/order/qrcodeIsSale', '验证商品售出');
INSERT INTO `auth_operation` VALUES ('20170831194928591993895137777340', 'null_', '预约订单', null, '20170831194907675599943884893329', '/order/list', '预约订单');
INSERT INTO `auth_operation` VALUES ('20170831195009050642469076420197', 'order_print', '打印预约小票', null, '20170831194907675599943884893329', '/order/reservePrintView', '打印预约小票');
INSERT INTO `auth_operation` VALUES ('20170831195023482521793792970228', 'order_view', '订单详情', null, '20170831194907675599943884893329', '/order/view', '订单详情');
INSERT INTO `auth_operation` VALUES ('20170831195040034729068633839551', 'order_updateOrderStateBySeven', '放弃未支付订单', null, '20170831194907675599943884893329', '/order/updateOrderStateBySeven', '放弃未支付订单');
INSERT INTO `auth_operation` VALUES ('20170831195216339672525627852736', 'update_reserveOrder', '补充定金、添加商品电子券等', null, '20170831194907675599943884893329', '/order/reserveOrderInput', '补充定金、添加商品电子券等');
INSERT INTO `auth_operation` VALUES ('20170901100139965704435342990821', 'null_', '保存预约订单信息', null, '20170831194907675599943884893329', '/order/saveReserveOrderInpute', '保存预约订单信息');
INSERT INTO `auth_operation` VALUES ('20170901153144857148236038988572', 'null_', '预约单添加发货二维码', null, '20170831194907675599943884893329', '/order/receiverAddQrcode', '预约单添加发货二维码');
INSERT INTO `auth_operation` VALUES ('20170903114028678088245834557756', 'null_', '预约发货删除发货商品', null, '20170831194907675599943884893329', '/order/receiverDeleteQrcode', '预约发货删除发货商品');
INSERT INTO `auth_operation` VALUES ('20170903114049036745632083980819', 'null_', '预约发货删除发货商品', null, '20170831100443749421767820382012', '/order/receiverDeleteQrcode', '预约发货删除发货商品');
INSERT INTO `auth_operation` VALUES ('20170903114110313707730683715233', 'null_', '预约发货删除发货二维码', null, '20170831105709637433542084155567', '/order/receiverDeleteQrcode', '预约发货删除发货二维码');
INSERT INTO `auth_operation` VALUES ('20170903180432355151941160708866', 'null_', '领取赠品', null, '20170903180412513771883642819392', '/order/putOutGoods', '领取赠品');
INSERT INTO `auth_operation` VALUES ('20170903180519579482726039960703', 'null_', '删除赠品', null, '20170903180412513771883642819392', '/order/orderDeletePutOutGoods', '删除赠品');
INSERT INTO `auth_operation` VALUES ('20170903180544183461643173366071', 'null_', '绑定赠品', null, '20170903180412513771883642819392', '/order/orderAddPutOutGoods', '绑定赠品');
INSERT INTO `auth_operation` VALUES ('20170904150239606714972744877387', 'null_', '跳转到开具换够小票页面', null, '20170904150043523454182167230607', '/order/changeEnoughOrderInput', '跳转到开具换够小票页面');
INSERT INTO `auth_operation` VALUES ('20170904175300784586361494430869', 'null_', '保存换够订单', null, '20170904150043523454182167230607', '/order/saveChangeEnough', '保存换够订单');
INSERT INTO `auth_operation` VALUES ('20170904175332298223515237901620', 'null_', '打印换够订单小票', null, '20170904150043523454182167230607', '/order/changeEnoughPrintView', '打印换够订单小票');
INSERT INTO `auth_operation` VALUES ('20170905113155848870149109594597', 'null_', '换购订单列表', null, '20170905113126581783386129837052', '/order/changeEnoughList', '换购订单列表');
INSERT INTO `auth_operation` VALUES ('20170905113242807250344710772052', 'order_updateOrderStateBySeven', '放弃换购订单', null, '20170905113126581783386129837052', '/order/updateOrderStateBySeven', '放弃换购订单');
INSERT INTO `auth_operation` VALUES ('20170905113330921312698830955315', 'order_changeEnoughView', '查看换购订单', null, '20170905113126581783386129837052', '/order/changeEnoughView', '查看换购订单');
INSERT INTO `auth_operation` VALUES ('20170905113416727887433703595827', 'order_changeEnoughPrint', '打印换购小票', null, '20170905113126581783386129837052', '/order/changeEnoughPrintView', '打印换购小票');
INSERT INTO `auth_operation` VALUES ('20170905113504020421380883183230', 'update_changeEnoughDelivery', '换购发货', null, '20170905113126581783386129837052', '/order/changeEnoughDelivery', '换购发货');
INSERT INTO `auth_operation` VALUES ('20170905113527017787367647264735', 'null_', '保存换购订单信息', null, '20170905113126581783386129837052', '/order/saveChangeEnough', '保存换购订单信息');
INSERT INTO `auth_operation` VALUES ('20170905113550583917552134277788', 'null_', '换购发货添加产品', null, '20170905113126581783386129837052', '/order/receiverAddQrcode', '换购发货添加产品');
INSERT INTO `auth_operation` VALUES ('20170905113623239713079956275085', 'null_', '换购发货删除发货产品', null, '20170905113126581783386129837052', '/order/receiverDeleteQrcode', '换购发货删除发货产品');
INSERT INTO `auth_operation` VALUES ('20170907092816706567755421800685', 'null_', '线上订单', null, '20170907092643759540912159475573', '/order/list', '线上订单');
INSERT INTO `auth_operation` VALUES ('20170907092905667444730868854461', 'order_print', '打印线上小票', null, '20170907092643759540912159475573', '/order/receiverPrintView', '打印线上小票');
INSERT INTO `auth_operation` VALUES ('20170907092941081416231974508693', 'order_receiverView', '订单详情', null, '20170907092643759540912159475573', '/order/receiverView', '订单详情');
INSERT INTO `auth_operation` VALUES ('20170907094718749000255953529561', 'order_updateOrderStateBySeven', '放弃未支付订单', null, '20170907092643759540912159475573', '/order/updateOrderStateBySeven', '放弃未支付订单');
INSERT INTO `auth_operation` VALUES ('20170907094807810637041668595090', 'update_receiverOrder', '线上发货', null, '20170907092643759540912159475573', '/order/receiverOrderInput', '线上发货');
INSERT INTO `auth_operation` VALUES ('20170907095656314297389811334079', 'order_receiverSaveOrUpdate', '保存线上订单修改', null, '20170907092643759540912159475573', '/order/receiverSaveOrUpdate', '保存线上订单修改');
INSERT INTO `auth_operation` VALUES ('20170907113016192242097875915353', 'null_', '线上发货添加产品', null, '20170907092643759540912159475573', '/order/receiverAddQrcode', '线上发货添加产品');
INSERT INTO `auth_operation` VALUES ('20170907113039105692559015054956', 'null_', '线上发货删除发货产品', null, '20170907092643759540912159475573', '/order/receiverDeleteQrcode', '线上发货删除发货产品');
INSERT INTO `auth_operation` VALUES ('20170907114207812733794319489273', 'null_', '电子券列表', null, '20170907114119815524412901088376', '/eticket/list', '电子券列表');
INSERT INTO `auth_operation` VALUES ('20170907114304276330147804838057', 'eticket_add', '添加修改电子券', null, '20170907114119815524412901088376', '/eticket/goAddEticket', '添加修改电子券');
INSERT INTO `auth_operation` VALUES ('20170907114412556152040297381592', 'eticket_view', '查看电子券信息', null, '20170907114119815524412901088376', '/eticket/view', '查看电子券信息');
INSERT INTO `auth_operation` VALUES ('20170907114640747376885135765495', 'eticket_delete', '删除电子券', null, '20170907114119815524412901088376', '/eticket/doDelete', '删除电子券');
INSERT INTO `auth_operation` VALUES ('20170907114753825441083226454960', 'null_', '保存电子券', null, '20170907114119815524412901088376', '/eticket/saveOrUpdate', '保存电子券');
INSERT INTO `auth_operation` VALUES ('20170907165029522335615529193706', 'null_', '手动发放电子券', null, '20170907164732612865647529918420', '/eticket/goManualOutEticket', '手动发放电子券');
INSERT INTO `auth_operation` VALUES ('20170907165126557437318537093200', 'null_', '保存发放记录（手动）', null, '20170907164732612865647529918420', '/eticket/doManualOutEticket', '保存发放记录（手动）');
INSERT INTO `auth_operation` VALUES ('20170907165152275636208437527398', 'null_', '获取会员信息', null, '20170907164732612865647529918420', '/customer/getCustomerByPhone', '获取会员信息');
INSERT INTO `auth_operation` VALUES ('20170907182553584956568310348857', 'null_', '电子券发放明细', null, '20170907182526490723820173687401', '/eticketoutRecord/getListEticketOut', '电子券发放明细');
INSERT INTO `auth_operation` VALUES ('20170907183023272287485611057247', 'eticket_out_view', '查看电子券发放详情', null, '20170907182526490723820173687401', '/eticketoutRecord/view', '查看电子券发放详情');
INSERT INTO `auth_operation` VALUES ('20170908154715065392450588822540', 'null_', '邮费设置', null, '20170908153123715153718590969758', '/postageBonus/input', '邮费设置列表');
INSERT INTO `auth_operation` VALUES ('20170908154907665052260655352326', 'null_', '保存邮费设置', null, '20170908153123715153718590969758', '/postageBonus/saveOrUpdate', '保存邮费设置');
INSERT INTO `auth_operation` VALUES ('20170908164600654236947035456033', 'null_', '录入电子券', null, '20170830220418115613075933228358', '/order/goAddEticket', '录入电子券');
INSERT INTO `auth_operation` VALUES ('20170908164637249113057833886067', 'null_', '绑定电子券', null, '20170830220418115613075933228358', '/order/bindEticket', '绑定电子券');
INSERT INTO `auth_operation` VALUES ('20170908165336421284973988198395', 'null_', '绑定电子券', null, '20170831100443749421767820382012', '/order/bindEticket', '绑定电子券');
INSERT INTO `auth_operation` VALUES ('20170910113123672248751003231531', 'null_', '充值详情', null, '20170910113052263946187698109753', '/rechargeRecord/list', '充值详情');
INSERT INTO `auth_operation` VALUES ('20170911094655689445048898942678', 'null_', '绑定叠加活动', null, '20170830220418115613075933228358', '/order/bindNoScopeGroup', '绑定叠加活动');
INSERT INTO `auth_operation` VALUES ('20170911094922268320654710253637', 'null_', '绑定叠加活动', null, '20170831100443749421767820382012', '/order/bindNoScopeGroup', '绑定叠加活动');
INSERT INTO `auth_operation` VALUES ('20170911095026462677559486668955', 'null_', '绑定叠加活动', null, '20170831194907675599943884893329', '/order/bindNoScopeGroup', '绑定叠加活动');
INSERT INTO `auth_operation` VALUES ('20170911095054523990285018108292', 'null_', '绑定电子券', null, '20170831194907675599943884893329', '/order/bindEticket', '绑定电子券');
INSERT INTO `auth_operation` VALUES ('20170912113755646018707385325628', 'update_sendGoodsOrder', '线上订单发货', null, '20170907092643759540912159475573', '/order/sendGoodsOrder', '线上订单发货');
INSERT INTO `auth_operation` VALUES ('20170912120053597870729912858917', 'null_', '线上订单确认发货', null, '20170907092643759540912159475573', '/order/updateSendGoodsOrder', '线上订单确认发货');
INSERT INTO `auth_operation` VALUES ('20170916095240849462192551293436', 'null_', '根据小票code获取主订单Id', null, '20170830221143028763978658679598', '/order/getOrderIdByCode', '根据小票code获取主订单Id');
INSERT INTO `auth_operation` VALUES ('20170916095331707759852167149094', 'null_', '根据小票code获取主订单Id', null, '20170830191420447290774284855126', '/order/getOrderIdByCode', '根据小票code获取主订单Id');
INSERT INTO `auth_operation` VALUES ('20170916095358943807003129800255', 'null_', '根据小票code获取主订单Id', null, '20170830221255184869187266662568', '/order/getOrderIdByCode', '根据小票code获取主订单Id');
INSERT INTO `auth_operation` VALUES ('20170916095417736673997130879242', 'null_', '根据小票code获取主订单Id', null, '20170830221450704419578232369378', '/order/getOrderIdByCode', '根据小票code获取主订单Id');
INSERT INTO `auth_operation` VALUES ('20170916163724303097069751269314', 'null_', '赔偿列表', null, '20170916163654602342670688229142', '/order/reparationList', '赔偿列表');
INSERT INTO `auth_operation` VALUES ('20170916163901861046502203638949', 'order_reparationInput', '添加赔偿单', null, '20170916163654602342670688229142', '/order/reparationInput', '添加赔偿单');
INSERT INTO `auth_operation` VALUES ('20170916163958790529678667118252', 'order_reparationView', '查看赔偿单', null, '20170916163654602342670688229142', '/order/reparationView', '查看赔偿单');
INSERT INTO `auth_operation` VALUES ('20170916164016107594858863182496', 'null_', '依据QrCodeID获取产品信息', null, '20170916163654602342670688229142', '/qrcode/getQrcodeByQrcodeIdForOrder', '依据QrCodeID获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170916164037923667795040718652', 'null_', '验证商品售出', null, '20170916163654602342670688229142', '/order/qrcodeIsSale', '验证商品售出');
INSERT INTO `auth_operation` VALUES ('20170916164113835389106834567854', 'null_', '保存赔偿单', null, '20170916163654602342670688229142', '/order/reparationSaveOrUpdate', '保存赔偿单');
INSERT INTO `auth_operation` VALUES ('20170916164143755445838165104916', 'order_updateOrderStateBySeven', '放弃未支付订单', null, '20170916163654602342670688229142', '/order/updateOrderStateBySeven', '放弃未支付订单');
INSERT INTO `auth_operation` VALUES ('20170916164214964427278019725301', 'order_print', '小票打印', null, '20170916163654602342670688229142', '/order/reparationPrintView', '小票打印');
INSERT INTO `auth_operation` VALUES ('20170916165431476387382755573241', 'null_', '添加赔偿单', null, '20170916165347531655467952102185', '/order/reparationInput', '添加赔偿单');
INSERT INTO `auth_operation` VALUES ('20170916165502733626647149030660', 'null_', '依据QrCodeID获取产品信息', null, '20170916165347531655467952102185', '/qrcode/getQrcodeByQrcodeIdForOrder', '依据QrCodeID获取产品信息');
INSERT INTO `auth_operation` VALUES ('20170916165534667876041212707490', 'null_', '验证商品售出', null, '20170916165347531655467952102185', '/order/qrcodeIsSale', '验证商品售出');
INSERT INTO `auth_operation` VALUES ('20170916165559577958394747825714', 'null_', '保存赔偿单', null, '20170916165347531655467952102185', '/order/reparationSaveOrUpdate', '保存赔偿单');
INSERT INTO `auth_operation` VALUES ('20170916165646095331319071838045', 'null_', '小票打印', null, '20170916165347531655467952102185', '/order/reparationPrintView', '小票打印');
INSERT INTO `auth_operation` VALUES ('20170916165720549363162332329020', 'null_', '根据小票code获取主订单Id', null, '20170916165347531655467952102185', '/order/getOrderIdByCode', '根据小票code获取主订单Id');
INSERT INTO `auth_operation` VALUES ('20170918181854194949139886885703', 'null_', '交接班列表', null, '20170830190303393232437385332999', '/CashierUserLoginAndLogout/list', '交接班列表');
INSERT INTO `auth_operation` VALUES ('20170918181955966248682428787380', 'jiaojie_view', '交接班详情', null, '20170830190303393232437385332999', '/CashierUserLoginAndLogout/view', '交接班详情');
INSERT INTO `auth_operation` VALUES ('20170918182020409039712412389128', 'jiaojie_finish', '交接班结算', null, '20170830190303393232437385332999', '/CashierUserLoginAndLogout/doLogoutStart', '交接班结算');
INSERT INTO `auth_operation` VALUES ('20170919105424111833192601608514', 'null_', '商品编号排空', null, '20170830193127615704538008702005', '/goods/isGoodsExist', '商品编号排空');
INSERT INTO `auth_operation` VALUES ('20170919105436504885981107589146', 'null_', '商品编号排空', null, '20170830193127615704538008702005', '/goods/validateGoodsIsExist', '商品编号排空');
INSERT INTO `auth_operation` VALUES ('20170920140745267011260090240658', 'null_', '服务费记录列表', null, '20170920140721113396713522018300', '/storeBonusDetil/list', '服务费记录列表');
INSERT INTO `auth_operation` VALUES ('20170920140803096478069341153065', 'storeBonusDetil_view', '服务费记录详情', null, '20170920140721113396713522018300', '/storeBonusDetil/view', '服务费记录详情');
INSERT INTO `auth_operation` VALUES ('20170920140822347202540523420220', 'storeBonusDetil_sendMoney', '服务费支付确认', null, '20170920140721113396713522018300', '/storeBonusDetil/sendMoney', '服务费支付确认');
INSERT INTO `auth_operation` VALUES ('20170920140947416909536639981514', 'null_', '充值提成记录', null, '20170920140918836827561129524509', '/consumeBonusDetail/list', '充值提成记录');
INSERT INTO `auth_operation` VALUES ('20170920141005562881234214761079', 'consumeBonusDetail_view', '充值提成记录详情', null, '20170920140918836827561129524509', '/consumeBonusDetail/view', '充值提成记录详情');
INSERT INTO `auth_operation` VALUES ('20170920141025407265257309693312', 'consumeBonusDetail_sendMoney', '充值提成发放', null, '20170920140918836827561129524509', '/consumeBonusDetail/sendMoney', '充值提成发放');
INSERT INTO `auth_operation` VALUES ('20170920141154791767911247644874', 'null_', '注册提成记录列表', null, '20170920141135562731777711168645', '/registerBonusDetil/list', '注册提成记录列表');
INSERT INTO `auth_operation` VALUES ('20170920141210543250590234726262', 'registerBonusDetil_view', '注册提成记录详情', null, '20170920141135562731777711168645', '/registerBonusDetil/view', '注册提成记录详情');
INSERT INTO `auth_operation` VALUES ('20170920141224766843662826484521', 'registerBonusDetil_send', '发放提成', null, '20170920141135562731777711168645', '/registerBonusDetil/send', '发放提成');
INSERT INTO `auth_operation` VALUES ('20170920141431385359016644165093', 'null_', '销售提成记录', null, '20170920141344151285783658252960', '/bonusDetail/list', '销售提成记录');
INSERT INTO `auth_operation` VALUES ('20170920141451888300436029977808', 'bonusDetail_view', '销售提成记录详情', null, '20170920141344151285783658252960', '/bonusDetail/view', '销售提成记录详情');
INSERT INTO `auth_operation` VALUES ('20170920141524213004389058874550', 'bonusDetail_sendMoney', '销售提成发放', null, '20170920141344151285783658252960', '/bonusDetail/sendMoney', '销售提成发放');
INSERT INTO `auth_operation` VALUES ('20170920185233891297375045205753', 'null_', '门店列表', null, '20170920185136363603167195101193', '/store/list', '门店列表');
INSERT INTO `auth_operation` VALUES ('20170920185248432104988892736289', 'store_input', '新建/修改门店信息', null, '20170920185136363603167195101193', '/store/input', '新建/修改门店信息');
INSERT INTO `auth_operation` VALUES ('20170920185301776491582754867218', 'store_view', '查看门店信息', null, '20170920185136363603167195101193', '/store/view', '查看门店信息');
INSERT INTO `auth_operation` VALUES ('20170920185318266552556934711554', 'store_delete', '删除门店', null, '20170920185136363603167195101193', '/store/doDelete', '删除门店');
INSERT INTO `auth_operation` VALUES ('20170920185331713157634852062585', 'null_', '保存门店信息', null, '20170920185136363603167195101193', '/store/saveOrUpdate', '保存门店信息');
INSERT INTO `auth_operation` VALUES ('20170920185347086317649214496076', 'null_', '修改时验证门店编号可用', null, '20170920185136363603167195101193', '/store/validateStoreIsExist', '修改时验证门店编号可用');
INSERT INTO `auth_operation` VALUES ('20170920185402412581661787792633', 'null_', '添加时验证门店编号可用', null, '20170920185136363603167195101193', '/store/isStoreExist', '添加时验证门店编号可用');
INSERT INTO `auth_operation` VALUES ('20170920185415888518048606670192', 'store_stop', '门店停业', null, '20170920185136363603167195101193', '/store/doStoreStop', '门店停业');
INSERT INTO `auth_operation` VALUES ('20170920185427615570648903631122', 'store_start', '门店营业', null, '20170920185136363603167195101193', '/store/doStoreStart', '门店营业');
INSERT INTO `auth_operation` VALUES ('20171027101916694038552298735973', 'null_', '售后获取订单信息', null, '20170831114538119517520094403238', '/order/getOrderIdByCode', '售后获取订单信息');
INSERT INTO `auth_operation` VALUES ('20180203162401591535506213192114', 'null_', '营收统计', null, '20180201144329056933959728668571', '/statistics/saleList', '营收统计');
INSERT INTO `auth_operation` VALUES ('20180206141337569109896255109979', 'null_', '销量统计', null, '20180201144620369755932574915577', '/statistics/amountList', '销量统计');
INSERT INTO `auth_operation` VALUES ('20180206154545333147010922726789', 'null_', '业绩统计', null, '20180201144944586115870231089286', '/statistics/achievementList', '业绩统计');
INSERT INTO `auth_operation` VALUES ('20180210170243988199819071714076', 'checkstorage_doDeleteEmpty', '删除空的盘点单', null, '20170830203543201341540025481647', '/checkstorage/doDeleteEmpty', '删除空的盘点单');
INSERT INTO `auth_operation` VALUES ('222', 'null_', '角色列表', null, '00000000000000000000000000000003', '/role/list', '角色列表');
INSERT INTO `auth_operation` VALUES ('333', 'null_', '菜单列表', null, '00000000000000000000000000000004', '/function/list', '菜单列表');
INSERT INTO `auth_operation` VALUES ('444', 'null_', '功能树', null, '00000000000000000000000000000004', '/function/getFunctionTree', '获取功能树');
INSERT INTO `auth_operation` VALUES ('555', 'null_', '跳转至添加或修改页面', null, '00000000000000000000000000000004', '/function/goAddOrUpdate', '跳转至添加或修改页面');
INSERT INTO `auth_operation` VALUES ('666', 'null_', '添加或修改功能', null, '00000000000000000000000000000004', '/function/doAddOrUpdate', '添加或修改功能');
INSERT INTO `auth_operation` VALUES ('777', 'null_', '操作列表', null, '00000000000000000000000000000004', '/operation/list', '操作列表');
INSERT INTO `auth_operation` VALUES ('888', 'null_', '跳转至添加操作', null, '00000000000000000000000000000004', '/operation/goAddOrUpdate', '跳转添加操作');
INSERT INTO `auth_operation` VALUES ('999', 'null_', '删除菜单', null, '00000000000000000000000000000004', '/function/doDelete', '删除菜单');
INSERT INTO `auth_operation` VALUES ('aaa', 'null_', '删除操作', null, '00000000000000000000000000000004', '/operation/doDelete', '删除操作');

-- ----------------------------
-- Table structure for auth_role
-- ----------------------------
DROP TABLE IF EXISTS `auth_role`;
CREATE TABLE `auth_role` (
  `id` varchar(32) NOT NULL,
  `name` varchar(256) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `roleKey` varchar(256) DEFAULT NULL,
  `type` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_role
-- ----------------------------
INSERT INTO `auth_role` VALUES ('20160705172222485975228559014888', '系统管理员', '系统管理员', 'administrator', '1');
INSERT INTO `auth_role` VALUES ('20161222113705166483235779248713', '管理员', '管理员', 'admin', '2');
INSERT INTO `auth_role` VALUES ('20161226105333229671150841475606', '店长', '店长', 'store_admin', '3');
INSERT INTO `auth_role` VALUES ('20170719142123261720369578658104', '收银', '收银', 'client_login', '3');
INSERT INTO `auth_role` VALUES ('20170731153423763187360535282191', '导购', '导购', 'guide', '3');
INSERT INTO `auth_role` VALUES ('20170809180719312149709311355949', '门店开票账号', '门店开票账号', 'kaipiao', '3');
INSERT INTO `auth_role` VALUES ('20170922175728329467199921325795', '主管', '主管门店 ', '002', '2');
INSERT INTO `auth_role` VALUES ('20170922180707233706443457677967', '服务台', '小商品部门', '001', '3');

-- ----------------------------
-- Table structure for auth_role_function
-- ----------------------------
DROP TABLE IF EXISTS `auth_role_function`;
CREATE TABLE `auth_role_function` (
  `id` varchar(32) NOT NULL,
  `roleId` varchar(32) DEFAULT NULL,
  `functionId` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_role_function
-- ----------------------------
INSERT INTO `auth_role_function` VALUES ('20161222112417789225287512884598', '20160705172222485975228559014888', '00000000000000000000000000000002');
INSERT INTO `auth_role_function` VALUES ('20161222112417817145705652143824', '20160705172222485975228559014888', '00000000000000000000000000000003');
INSERT INTO `auth_role_function` VALUES ('20161222112417819896481510696799', '20160705172222485975228559014888', '00000000000000000000000000000004');
INSERT INTO `auth_role_function` VALUES ('20161222112417820484033347198418', '20160705172222485975228559014888', '00000000000000000000000000000001');
INSERT INTO `auth_role_function` VALUES ('20170922181033355342406259888603', '20170922180707233706443457677967', '20170830191749488648028410600993');
INSERT INTO `auth_role_function` VALUES ('20170922181033356037326706847920', '20170922180707233706443457677967', '20170903180412513771883642819392');
INSERT INTO `auth_role_function` VALUES ('20170922181033357794458437866823', '20170922180707233706443457677967', '20170916163654602342670688229142');
INSERT INTO `auth_role_function` VALUES ('20170922181033357998890328059435', '20170922180707233706443457677967', '20170905113126581783386129837052');
INSERT INTO `auth_role_function` VALUES ('20170922181033358461617776455119', '20170922180707233706443457677967', '20170830185731628896338072062993');
INSERT INTO `auth_role_function` VALUES ('20170922181033358555085211133534', '20170922180707233706443457677967', '20170830221450704419578232369378');
INSERT INTO `auth_role_function` VALUES ('20170922181033359138237191528458', '20170922180707233706443457677967', '20170904150043523454182167230607');
INSERT INTO `auth_role_function` VALUES ('20170922181033360838012364223182', '20170922180707233706443457677967', '20170830220333421103573820212235');
INSERT INTO `auth_role_function` VALUES ('20170922181033360976834686786925', '20170922180707233706443457677967', '20170916165347531655467952102185');
INSERT INTO `auth_role_function` VALUES ('20170922181246109041645986013742', '20170809180719312149709311355949', '20170830220418115613075933228358');
INSERT INTO `auth_role_function` VALUES ('20170922181246111576689550386486', '20170809180719312149709311355949', '20170830220758624700709841742603');
INSERT INTO `auth_role_function` VALUES ('20170922181246112511123458131176', '20170809180719312149709311355949', '20170830221143028763978658679598');
INSERT INTO `auth_role_function` VALUES ('20170922181246114211008009450811', '20170809180719312149709311355949', '20170830221255184869187266662568');
INSERT INTO `auth_role_function` VALUES ('20170922181246115093090095863841', '20170809180719312149709311355949', '20170830221450704419578232369378');
INSERT INTO `auth_role_function` VALUES ('20170922181246116228326218597058', '20170809180719312149709311355949', '20170831100443749421767820382012');
INSERT INTO `auth_role_function` VALUES ('20170922181246118717903903092339', '20170809180719312149709311355949', '20170831105709637433542084155567');
INSERT INTO `auth_role_function` VALUES ('20170922181246119928118506187299', '20170809180719312149709311355949', '20170904150043523454182167230607');
INSERT INTO `auth_role_function` VALUES ('20170922181246120310444892827836', '20170809180719312149709311355949', '20170916165347531655467952102185');
INSERT INTO `auth_role_function` VALUES ('20170922181246122595644792238949', '20170809180719312149709311355949', '20170830220333421103573820212235');
INSERT INTO `auth_role_function` VALUES ('20170922181246123873006836410582', '20170809180719312149709311355949', '20170830185731628896338072062993');
INSERT INTO `auth_role_function` VALUES ('20170922181246124053932452846174', '20170809180719312149709311355949', '20170830190702794379289348317756');
INSERT INTO `auth_role_function` VALUES ('20170922181246125925370273320467', '20170809180719312149709311355949', '20170830190959210674064146816515');
INSERT INTO `auth_role_function` VALUES ('20170922181246127753792189390413', '20170809180719312149709311355949', '20170830191420447290774284855126');
INSERT INTO `auth_role_function` VALUES ('20170922181246128812297975445176', '20170809180719312149709311355949', '20170830191749488648028410600993');
INSERT INTO `auth_role_function` VALUES ('20170922181246130995789549569573', '20170809180719312149709311355949', '20170831194907675599943884893329');
INSERT INTO `auth_role_function` VALUES ('20170922181246131802632774382215', '20170809180719312149709311355949', '20170905113126581783386129837052');
INSERT INTO `auth_role_function` VALUES ('20170922181246132484267951214417', '20170809180719312149709311355949', '20170907092643759540912159475573');
INSERT INTO `auth_role_function` VALUES ('20170922181246133584934756415281', '20170809180719312149709311355949', '20170916163654602342670688229142');
INSERT INTO `auth_role_function` VALUES ('20180210170258093522345383742218', '20161222113705166483235779248713', '00000000000000000000000000000002');
INSERT INTO `auth_role_function` VALUES ('20180210170258095184866521151601', '20161222113705166483235779248713', '00000000000000000000000000000001');
INSERT INTO `auth_role_function` VALUES ('20180210170258096352559949083433', '20161222113705166483235779248713', '20170830183909707277064130641973');
INSERT INTO `auth_role_function` VALUES ('20180210170258097156774187214383', '20161222113705166483235779248713', '20170830183816171550789786359428');
INSERT INTO `auth_role_function` VALUES ('20180210170258098342055786434045', '20161222113705166483235779248713', '20170830185504559062723332631547');
INSERT INTO `auth_role_function` VALUES ('20180210170258099025982821457257', '20161222113705166483235779248713', '20170910113052263946187698109753');
INSERT INTO `auth_role_function` VALUES ('20180210170258101543501647910807', '20161222113705166483235779248713', '20170830185429920178209535439591');
INSERT INTO `auth_role_function` VALUES ('20180210170258102040302603624016', '20161222113705166483235779248713', '20170830190303393232437385332999');
INSERT INTO `auth_role_function` VALUES ('20180210170258103188588359384091', '20161222113705166483235779248713', '20170830190702794379289348317756');
INSERT INTO `auth_role_function` VALUES ('20180210170258104568173894173116', '20161222113705166483235779248713', '20170830190959210674064146816515');
INSERT INTO `auth_role_function` VALUES ('20180210170258106078552044993384', '20161222113705166483235779248713', '20170830191420447290774284855126');
INSERT INTO `auth_role_function` VALUES ('20180210170258107506993572208651', '20161222113705166483235779248713', '20170830191749488648028410600993');
INSERT INTO `auth_role_function` VALUES ('20180210170258108639561246910020', '20161222113705166483235779248713', '20170830215734365360148127838984');
INSERT INTO `auth_role_function` VALUES ('20180210170258110537667556620781', '20161222113705166483235779248713', '20170831194907675599943884893329');
INSERT INTO `auth_role_function` VALUES ('20180210170258111895732615252333', '20161222113705166483235779248713', '20170903180412513771883642819392');
INSERT INTO `auth_role_function` VALUES ('20180210170258112029338234859592', '20161222113705166483235779248713', '20170905113126581783386129837052');
INSERT INTO `auth_role_function` VALUES ('20180210170258114533119598628661', '20161222113705166483235779248713', '20170907092643759540912159475573');
INSERT INTO `auth_role_function` VALUES ('20180210170258115666709648099503', '20161222113705166483235779248713', '20170916163654602342670688229142');
INSERT INTO `auth_role_function` VALUES ('20180210170258116202208203183546', '20161222113705166483235779248713', '20170830185731628896338072062993');
INSERT INTO `auth_role_function` VALUES ('20180210170258117765175260197987', '20161222113705166483235779248713', '20170830193127615704538008702005');
INSERT INTO `auth_role_function` VALUES ('20180210170258119410690188502110', '20161222113705166483235779248713', '20170830204008872143102098236806');
INSERT INTO `auth_role_function` VALUES ('20180210170258120929288406022363', '20161222113705166483235779248713', '20170830204300007556616765694571');
INSERT INTO `auth_role_function` VALUES ('20180210170258121340903006750734', '20161222113705166483235779248713', '20170830192801090374131261177687');
INSERT INTO `auth_role_function` VALUES ('20180210170258122663551387004037', '20161222113705166483235779248713', '20170830194954276445047746311165');
INSERT INTO `auth_role_function` VALUES ('20180210170258123786398593768910', '20161222113705166483235779248713', '20170830194834837619463546970437');
INSERT INTO `auth_role_function` VALUES ('20180210170258124690540513328164', '20161222113705166483235779248713', '20170830195737455259940359442166');
INSERT INTO `auth_role_function` VALUES ('20180210170258125791278197368955', '20161222113705166483235779248713', '20170830200418252654557431739635');
INSERT INTO `auth_role_function` VALUES ('20180210170258126918491743289386', '20161222113705166483235779248713', '20170830195608709484577230290915');
INSERT INTO `auth_role_function` VALUES ('20180210170258127950709957845911', '20161222113705166483235779248713', '20170830203014829529478121512844');
INSERT INTO `auth_role_function` VALUES ('20180210170258128887681780042411', '20161222113705166483235779248713', '20170830203138578743848208894007');
INSERT INTO `auth_role_function` VALUES ('20180210170258129709009827588070', '20161222113705166483235779248713', '20170830203543201341540025481647');
INSERT INTO `auth_role_function` VALUES ('20180210170258130934445556547996', '20161222113705166483235779248713', '20170830202942936037599981591778');
INSERT INTO `auth_role_function` VALUES ('20180210170258131850396613057259', '20161222113705166483235779248713', '20170830210032500639302088394405');
INSERT INTO `auth_role_function` VALUES ('20180210170258132399741107194143', '20161222113705166483235779248713', '20170830210224485662374233983717');
INSERT INTO `auth_role_function` VALUES ('20180210170258133571063413081995', '20161222113705166483235779248713', '20170830210326269196310192189589');
INSERT INTO `auth_role_function` VALUES ('20180210170258135007053201809772', '20161222113705166483235779248713', '20170830205906169522332142318231');
INSERT INTO `auth_role_function` VALUES ('20180210170258136262958825630760', '20161222113705166483235779248713', '20170907114119815524412901088376');
INSERT INTO `auth_role_function` VALUES ('20180210170258137969996118189449', '20161222113705166483235779248713', '20170907164732612865647529918420');
INSERT INTO `auth_role_function` VALUES ('20180210170258138196752698095631', '20161222113705166483235779248713', '20170830210506906087510933120077');
INSERT INTO `auth_role_function` VALUES ('20180210170258138451192123574243', '20161222113705166483235779248713', '20170907182526490723820173687401');
INSERT INTO `auth_role_function` VALUES ('20180210170258139512368182226050', '20161222113705166483235779248713', '20170830210957723327387304558240');
INSERT INTO `auth_role_function` VALUES ('20180210170258139705978331684276', '20161222113705166483235779248713', '20170831114538119517520094403238');
INSERT INTO `auth_role_function` VALUES ('20180210170258140502734367603031', '20161222113705166483235779248713', '20170920140918836827561129524509');
INSERT INTO `auth_role_function` VALUES ('20180210170258140966844194979022', '20161222113705166483235779248713', '20170920140721113396713522018300');
INSERT INTO `auth_role_function` VALUES ('20180210170258141344021606889066', '20161222113705166483235779248713', '20170920141135562731777711168645');
INSERT INTO `auth_role_function` VALUES ('20180210170258141967948749888769', '20161222113705166483235779248713', '20170920141344151285783658252960');
INSERT INTO `auth_role_function` VALUES ('20180210170258142396875190854943', '20161222113705166483235779248713', '20170920120227832495591402472122');
INSERT INTO `auth_role_function` VALUES ('20180210170258143028445671653830', '20161222113705166483235779248713', '20180201144620369755932574915577');
INSERT INTO `auth_role_function` VALUES ('20180210170258143306500270612455', '20161222113705166483235779248713', '20180201144329056933959728668571');
INSERT INTO `auth_role_function` VALUES ('20180210170258144450685168105180', '20161222113705166483235779248713', '20180201144944586115870231089286');
INSERT INTO `auth_role_function` VALUES ('20180210170258144722776364327780', '20161222113705166483235779248713', '20180201143903638866869668932234');
INSERT INTO `auth_role_function` VALUES ('20180210170258145067022745330580', '20161222113705166483235779248713', '20170830211521443870931033782224');
INSERT INTO `auth_role_function` VALUES ('20180210170258145558590596262388', '20161222113705166483235779248713', '20170920185136363603167195101193');
INSERT INTO `auth_role_function` VALUES ('20180210170258146203509351812518', '20161222113705166483235779248713', '20170830212500858165271076518856');
INSERT INTO `auth_role_function` VALUES ('20180210170258146997422537327684', '20161222113705166483235779248713', '20170830211859067594508738262698');
INSERT INTO `auth_role_function` VALUES ('20180210170258147115435721828722', '20161222113705166483235779248713', '20170830212742847304965710849167');
INSERT INTO `auth_role_function` VALUES ('20180210170258147250207462930248', '20161222113705166483235779248713', '20170830213114654521981752595705');
INSERT INTO `auth_role_function` VALUES ('20180210170258148850247369024910', '20161222113705166483235779248713', '20170830213637287649377336464713');
INSERT INTO `auth_role_function` VALUES ('20180210170258149691028291925994', '20161222113705166483235779248713', '20170830214134550927178354397788');
INSERT INTO `auth_role_function` VALUES ('20180210170258149902184567126014', '20161222113705166483235779248713', '20170830213928619714435380492216');
INSERT INTO `auth_role_function` VALUES ('20180210170258150348264370494769', '20161222113705166483235779248713', '20170830215054894588174665620170');
INSERT INTO `auth_role_function` VALUES ('20180210170258150515878283294688', '20161222113705166483235779248713', '20170830214722853299084468988221');
INSERT INTO `auth_role_function` VALUES ('20180210170258151433564904428999', '20161222113705166483235779248713', '20170830215258813602882080472084');
INSERT INTO `auth_role_function` VALUES ('20180210170258151872653401744452', '20161222113705166483235779248713', '20170908153123715153718590969758');
INSERT INTO `auth_role_function` VALUES ('20180210170258152803812830480058', '20161222113705166483235779248713', '20170830211023632413917401921109');
INSERT INTO `auth_role_function` VALUES ('20180210170312188501560916341897', '20161226105333229671150841475606', '20170830190702794379289348317756');
INSERT INTO `auth_role_function` VALUES ('20180210170312190677693977950120', '20161226105333229671150841475606', '20170830190959210674064146816515');
INSERT INTO `auth_role_function` VALUES ('20180210170312192032880631721672', '20161226105333229671150841475606', '20170830191420447290774284855126');
INSERT INTO `auth_role_function` VALUES ('20180210170312194612008818042056', '20161226105333229671150841475606', '20170830191749488648028410600993');
INSERT INTO `auth_role_function` VALUES ('20180210170312196499166903340373', '20161226105333229671150841475606', '20170831194907675599943884893329');
INSERT INTO `auth_role_function` VALUES ('20180210170312198916936362515131', '20161226105333229671150841475606', '20170905113126581783386129837052');
INSERT INTO `auth_role_function` VALUES ('20180210170312200375392329264945', '20161226105333229671150841475606', '20170907092643759540912159475573');
INSERT INTO `auth_role_function` VALUES ('20180210170312201939984776496635', '20161226105333229671150841475606', '20170916163654602342670688229142');
INSERT INTO `auth_role_function` VALUES ('20180210170312203465603418539523', '20161226105333229671150841475606', '20170830185731628896338072062993');
INSERT INTO `auth_role_function` VALUES ('20180210170312205122126615301479', '20161226105333229671150841475606', '20170830193127615704538008702005');
INSERT INTO `auth_role_function` VALUES ('20180210170312207824368164846243', '20161226105333229671150841475606', '20170830204008872143102098236806');
INSERT INTO `auth_role_function` VALUES ('20180210170312209363208578462907', '20161226105333229671150841475606', '20170830204300007556616765694571');
INSERT INTO `auth_role_function` VALUES ('20180210170312211317909013442364', '20161226105333229671150841475606', '20170830192801090374131261177687');
INSERT INTO `auth_role_function` VALUES ('20180210170312212104211484301425', '20161226105333229671150841475606', '20170830195737455259940359442166');
INSERT INTO `auth_role_function` VALUES ('20180210170312214621656119377020', '20161226105333229671150841475606', '20170830200418252654557431739635');
INSERT INTO `auth_role_function` VALUES ('20180210170312216274931928162340', '20161226105333229671150841475606', '20170830195608709484577230290915');
INSERT INTO `auth_role_function` VALUES ('20180210170312218318462260195407', '20161226105333229671150841475606', '20170830203014829529478121512844');
INSERT INTO `auth_role_function` VALUES ('20180210170312220701671145365403', '20161226105333229671150841475606', '20170830203138578743848208894007');
INSERT INTO `auth_role_function` VALUES ('20180210170312222246537166830835', '20161226105333229671150841475606', '20170830203543201341540025481647');
INSERT INTO `auth_role_function` VALUES ('20180210170312224187853234584185', '20161226105333229671150841475606', '20170830202942936037599981591778');
INSERT INTO `auth_role_function` VALUES ('20180210170346167062071934647853', '20170922175728329467199921325795', '20170830195737455259940359442166');
INSERT INTO `auth_role_function` VALUES ('20180210170346168807890112511017', '20170922175728329467199921325795', '20170830200418252654557431739635');
INSERT INTO `auth_role_function` VALUES ('20180210170346170353977779582403', '20170922175728329467199921325795', '20170830195608709484577230290915');
INSERT INTO `auth_role_function` VALUES ('20180210170346173461492261025282', '20170922175728329467199921325795', '20170830203014829529478121512844');
INSERT INTO `auth_role_function` VALUES ('20180210170346174927378139403769', '20170922175728329467199921325795', '20170830203138578743848208894007');
INSERT INTO `auth_role_function` VALUES ('20180210170346176048327087946650', '20170922175728329467199921325795', '20170830203543201341540025481647');
INSERT INTO `auth_role_function` VALUES ('20180210170346178291374797057975', '20170922175728329467199921325795', '20170830202942936037599981591778');
INSERT INTO `auth_role_function` VALUES ('20180210170346179712037518058386', '20170922175728329467199921325795', '20170831114538119517520094403238');
INSERT INTO `auth_role_function` VALUES ('20180210170346181489022396837460', '20170922175728329467199921325795', '20170830210957723327387304558240');

-- ----------------------------
-- Table structure for auth_role_operation
-- ----------------------------
DROP TABLE IF EXISTS `auth_role_operation`;
CREATE TABLE `auth_role_operation` (
  `id` varchar(32) NOT NULL,
  `roleId` varchar(32) DEFAULT NULL,
  `operationId` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_role_operation
-- ----------------------------
INSERT INTO `auth_role_operation` VALUES ('20161222112417848472325163523694', '20160705172222485975228559014888', '20160705173708298339710350880482');
INSERT INTO `auth_role_operation` VALUES ('20161222112417849142260351224999', '20160705172222485975228559014888', '20160705173629616968434636852659');
INSERT INTO `auth_role_operation` VALUES ('20161222112417850163595045703073', '20160705172222485975228559014888', '20160729093555797174858758576230');
INSERT INTO `auth_role_operation` VALUES ('20161222112417851775826927857216', '20160705172222485975228559014888', '20160923185725165167906668432284');
INSERT INTO `auth_role_operation` VALUES ('20161222112417852746506731372328', '20160705172222485975228559014888', '20160929162353043476535209444353');
INSERT INTO `auth_role_operation` VALUES ('20161222112417853701406539441125', '20160705172222485975228559014888', '111');
INSERT INTO `auth_role_operation` VALUES ('20161222112417854092015533733719', '20160705172222485975228559014888', '20160415165703568268531935319815');
INSERT INTO `auth_role_operation` VALUES ('20161222112417855269268609668480', '20160705172222485975228559014888', '20160415165805876615746724249243');
INSERT INTO `auth_role_operation` VALUES ('20161222112417856142204994769088', '20160705172222485975228559014888', '20160415171804273019813454226532');
INSERT INTO `auth_role_operation` VALUES ('20161222112417857438465238141696', '20160705172222485975228559014888', '20160420141639347226653157950297');
INSERT INTO `auth_role_operation` VALUES ('20161222112417858986753331358007', '20160705172222485975228559014888', '20160729093543406383295943985668');
INSERT INTO `auth_role_operation` VALUES ('20161222112417859253260693899712', '20160705172222485975228559014888', '20160415140059891937043500787708');
INSERT INTO `auth_role_operation` VALUES ('20161222112417860985990005198836', '20160705172222485975228559014888', '20160415140315589488357298679758');
INSERT INTO `auth_role_operation` VALUES ('20161222112417861729951041539716', '20160705172222485975228559014888', '20160415143651840724315934364923');
INSERT INTO `auth_role_operation` VALUES ('20161222112417862013107068494759', '20160705172222485975228559014888', '20160415140650979215674794451962');
INSERT INTO `auth_role_operation` VALUES ('20161222112417862626144700591701', '20160705172222485975228559014888', '20160415164935962215115835027222');
INSERT INTO `auth_role_operation` VALUES ('20161222112417864786135099124101', '20160705172222485975228559014888', '222');
INSERT INTO `auth_role_operation` VALUES ('20161222112417865473739884604519', '20160705172222485975228559014888', '000');
INSERT INTO `auth_role_operation` VALUES ('20161222112417866240143211222661', '20160705172222485975228559014888', '333');
INSERT INTO `auth_role_operation` VALUES ('20161222112417866391286956162198', '20160705172222485975228559014888', '444');
INSERT INTO `auth_role_operation` VALUES ('20161222112417867767199969018607', '20160705172222485975228559014888', '555');
INSERT INTO `auth_role_operation` VALUES ('20161222112417868239599168158633', '20160705172222485975228559014888', '666');
INSERT INTO `auth_role_operation` VALUES ('20161222112417869007715521100182', '20160705172222485975228559014888', '777');
INSERT INTO `auth_role_operation` VALUES ('20161222112417870233531174648265', '20160705172222485975228559014888', '888');
INSERT INTO `auth_role_operation` VALUES ('20161222112417870946467574598341', '20160705172222485975228559014888', '999');
INSERT INTO `auth_role_operation` VALUES ('20161222112417871270566191247110', '20160705172222485975228559014888', 'aaa');
INSERT INTO `auth_role_operation` VALUES ('20170922181033431870299364412830', '20170922180707233706443457677967', '20170905113242807250344710772052');
INSERT INTO `auth_role_operation` VALUES ('20170922181033432020855339230470', '20170922180707233706443457677967', '20170905113330921312698830955315');
INSERT INTO `auth_role_operation` VALUES ('20170922181033433906767523492754', '20170922180707233706443457677967', '20170905113416727887433703595827');
INSERT INTO `auth_role_operation` VALUES ('20170922181033435853319260262335', '20170922180707233706443457677967', '20170905113504020421380883183230');
INSERT INTO `auth_role_operation` VALUES ('20170922181033436033480606914412', '20170922180707233706443457677967', '20170916163958790529678667118252');
INSERT INTO `auth_role_operation` VALUES ('20170922181033437129755511428005', '20170922180707233706443457677967', '20170916163901861046502203638949');
INSERT INTO `auth_role_operation` VALUES ('20170922181033439663856227021601', '20170922180707233706443457677967', '20170916164143755445838165104916');
INSERT INTO `auth_role_operation` VALUES ('20170922181033440751823976817071', '20170922180707233706443457677967', '20170916164214964427278019725301');
INSERT INTO `auth_role_operation` VALUES ('20170922181033441910051300559439', '20170922180707233706443457677967', '20170830191833743610957280978678');
INSERT INTO `auth_role_operation` VALUES ('20170922181033442958954828038681', '20170922180707233706443457677967', '20170830191851344574311818941542');
INSERT INTO `auth_role_operation` VALUES ('20170922181033444266302520688041', '20170922180707233706443457677967', '20170830192032675542147064290037');
INSERT INTO `auth_role_operation` VALUES ('20170922181033445574906234810829', '20170922180707233706443457677967', '20170830192054683460859544871283');
INSERT INTO `auth_role_operation` VALUES ('20170922181033446550871001286143', '20170922180707233706443457677967', '20170830203053742545387620019408');
INSERT INTO `auth_role_operation` VALUES ('20170922181246176648368857859173', '20170809180719312149709311355949', '');
INSERT INTO `auth_role_operation` VALUES ('20170922181246178284577884767120', '20170809180719312149709311355949', '20170830221342485829692444578458');
INSERT INTO `auth_role_operation` VALUES ('20170922181246179318372199887326', '20170809180719312149709311355949', '20170830190749437593611799583348');
INSERT INTO `auth_role_operation` VALUES ('20170922181246181736332274564029', '20170809180719312149709311355949', '20170830190806693389915480819873');
INSERT INTO `auth_role_operation` VALUES ('20170922181246182973332133605595', '20170809180719312149709311355949', '20170830190828376902478881510993');
INSERT INTO `auth_role_operation` VALUES ('20170922181246183376380705928099', '20170809180719312149709311355949', '20170830191052591570764290093428');
INSERT INTO `auth_role_operation` VALUES ('20170922181246184189238149335759', '20170809180719312149709311355949', '20170830191112598727093983747834');
INSERT INTO `auth_role_operation` VALUES ('20170922181246185352235141752696', '20170809180719312149709311355949', '20170830191232595410869912724090');
INSERT INTO `auth_role_operation` VALUES ('20170922181246187284163836485458', '20170809180719312149709311355949', '20170830191258161989305015042996');
INSERT INTO `auth_role_operation` VALUES ('20170922181246188259076684408144', '20170809180719312149709311355949', '20170830191505864748906036206883');
INSERT INTO `auth_role_operation` VALUES ('20170922181246189943552672846801', '20170809180719312149709311355949', '20170830191522823371398187741710');
INSERT INTO `auth_role_operation` VALUES ('20170922181246190167824464974520', '20170809180719312149709311355949', '20170830191631242284938401241106');
INSERT INTO `auth_role_operation` VALUES ('20170922181246192677010866650685', '20170809180719312149709311355949', '20170830191649218225294187613654');
INSERT INTO `auth_role_operation` VALUES ('20170922181246193745386307436015', '20170809180719312149709311355949', '20170830191833743610957280978678');
INSERT INTO `auth_role_operation` VALUES ('20170922181246195359919942357365', '20170809180719312149709311355949', '20170830191851344574311818941542');
INSERT INTO `auth_role_operation` VALUES ('20170922181246196809125919840240', '20170809180719312149709311355949', '20170830192032675542147064290037');
INSERT INTO `auth_role_operation` VALUES ('20170922181246197691150434819857', '20170809180719312149709311355949', '20170831195009050642469076420197');
INSERT INTO `auth_role_operation` VALUES ('20170922181246197698129721588223', '20170809180719312149709311355949', '20170830192054683460859544871283');
INSERT INTO `auth_role_operation` VALUES ('20170922181246198820777317438096', '20170809180719312149709311355949', '20170831195023482521793792970228');
INSERT INTO `auth_role_operation` VALUES ('20170922181246199019020940911050', '20170809180719312149709311355949', '20170831195216339672525627852736');
INSERT INTO `auth_role_operation` VALUES ('20170922181246199192973650311561', '20170809180719312149709311355949', '20170831195040034729068633839551');
INSERT INTO `auth_role_operation` VALUES ('20170922181246200962947746253184', '20170809180719312149709311355949', '20170905113242807250344710772052');
INSERT INTO `auth_role_operation` VALUES ('20170922181246201134326358278474', '20170809180719312149709311355949', '20170905113416727887433703595827');
INSERT INTO `auth_role_operation` VALUES ('20170922181246201957307446042702', '20170809180719312149709311355949', '20170905113330921312698830955315');
INSERT INTO `auth_role_operation` VALUES ('20170922181246202331567687781325', '20170809180719312149709311355949', '20170905113504020421380883183230');
INSERT INTO `auth_role_operation` VALUES ('20170922181246202943225911885960', '20170809180719312149709311355949', '20170907092905667444730868854461');
INSERT INTO `auth_role_operation` VALUES ('20170922181246203813239616976691', '20170809180719312149709311355949', '20170907092941081416231974508693');
INSERT INTO `auth_role_operation` VALUES ('20170922181246204076534630089755', '20170809180719312149709311355949', '20170907094718749000255953529561');
INSERT INTO `auth_role_operation` VALUES ('20170922181246204569865214620036', '20170809180719312149709311355949', '20170907094807810637041668595090');
INSERT INTO `auth_role_operation` VALUES ('20170922181246205659429263217794', '20170809180719312149709311355949', '20170907095656314297389811334079');
INSERT INTO `auth_role_operation` VALUES ('20170922181246215151038263696191', '20170809180719312149709311355949', '20170912113755646018707385325628');
INSERT INTO `auth_role_operation` VALUES ('20170922181246216350844450681681', '20170809180719312149709311355949', '20170916163958790529678667118252');
INSERT INTO `auth_role_operation` VALUES ('20170922181246216411282006425295', '20170809180719312149709311355949', '20170916163901861046502203638949');
INSERT INTO `auth_role_operation` VALUES ('20170922181246217546212381450520', '20170809180719312149709311355949', '20170916164143755445838165104916');
INSERT INTO `auth_role_operation` VALUES ('20170922181246218424708032560648', '20170809180719312149709311355949', '20170916164214964427278019725301');
INSERT INTO `auth_role_operation` VALUES ('20180210170258258049851134041815', '20161222113705166483235779248713', '20160415165703568268531935319815');
INSERT INTO `auth_role_operation` VALUES ('20180210170258260885304776428480', '20161222113705166483235779248713', '20170830184346154378900435400313');
INSERT INTO `auth_role_operation` VALUES ('20180210170258262375532293084819', '20161222113705166483235779248713', '20170830184319456073557599752722');
INSERT INTO `auth_role_operation` VALUES ('20180210170258264164890652253593', '20161222113705166483235779248713', '20160729093543406383295943985668');
INSERT INTO `auth_role_operation` VALUES ('20180210170258265410109315796324', '20161222113705166483235779248713', '20160415171804273019813454226532');
INSERT INTO `auth_role_operation` VALUES ('20180210170258267612797531843964', '20161222113705166483235779248713', '20170830185932577318472877017944');
INSERT INTO `auth_role_operation` VALUES ('20180210170258269007336681328283', '20161222113705166483235779248713', '20170830185601323048968454631701');
INSERT INTO `auth_role_operation` VALUES ('20180210170258271095354656719496', '20161222113705166483235779248713', '20170830184406104305961735404828');
INSERT INTO `auth_role_operation` VALUES ('20180210170258273675551562417650', '20161222113705166483235779248713', '20170830185621893270687419528888');
INSERT INTO `auth_role_operation` VALUES ('20180210170258275582577728951692', '20161222113705166483235779248713', '20170830190205580287657077040418');
INSERT INTO `auth_role_operation` VALUES ('20180210170258277616345535047994', '20161222113705166483235779248713', '20170830190229971356700987658972');
INSERT INTO `auth_role_operation` VALUES ('20180210170258279990206992653192', '20161222113705166483235779248713', '20170830190022291914134875612169');
INSERT INTO `auth_role_operation` VALUES ('20180210170258281926792758754076', '20161222113705166483235779248713', '20170830190000632494456207448978');
INSERT INTO `auth_role_operation` VALUES ('20180210170258283764494529304146', '20161222113705166483235779248713', '20170830190806693389915480819873');
INSERT INTO `auth_role_operation` VALUES ('20180210170258285756613793978460', '20161222113705166483235779248713', '20170830190749437593611799583348');
INSERT INTO `auth_role_operation` VALUES ('20180210170258287501610437111863', '20161222113705166483235779248713', '20170830191112598727093983747834');
INSERT INTO `auth_role_operation` VALUES ('20180210170258289482131511360153', '20161222113705166483235779248713', '20170830191232595410869912724090');
INSERT INTO `auth_role_operation` VALUES ('20180210170258290675676406221317', '20161222113705166483235779248713', '20170830191052591570764290093428');
INSERT INTO `auth_role_operation` VALUES ('20180210170258291112622469977157', '20161222113705166483235779248713', '20170830190828376902478881510993');
INSERT INTO `auth_role_operation` VALUES ('20180210170258291150510558936674', '20161222113705166483235779248713', '20170830191649218225294187613654');
INSERT INTO `auth_role_operation` VALUES ('20180210170258292372228558270025', '20161222113705166483235779248713', '20170830191258161989305015042996');
INSERT INTO `auth_role_operation` VALUES ('20180210170258293066738226069239', '20161222113705166483235779248713', '20170830191833743610957280978678');
INSERT INTO `auth_role_operation` VALUES ('20180210170258294772174368018540', '20161222113705166483235779248713', '20170830191522823371398187741710');
INSERT INTO `auth_role_operation` VALUES ('20180210170258295030564233877164', '20161222113705166483235779248713', '20170830191505864748906036206883');
INSERT INTO `auth_role_operation` VALUES ('20180210170258295751967989261535', '20161222113705166483235779248713', '20170830192032675542147064290037');
INSERT INTO `auth_role_operation` VALUES ('20180210170258296473988996584272', '20161222113705166483235779248713', '20170830191631242284938401241106');
INSERT INTO `auth_role_operation` VALUES ('20180210170258297714539423335106', '20161222113705166483235779248713', '20170830191851344574311818941542');
INSERT INTO `auth_role_operation` VALUES ('20180210170258298236148785653084', '20161222113705166483235779248713', '20170830215554867716459892250302');
INSERT INTO `auth_role_operation` VALUES ('20180210170258299625441470223091', '20161222113705166483235779248713', '20170830193222502820225571239715');
INSERT INTO `auth_role_operation` VALUES ('20180210170258300594907214921182', '20161222113705166483235779248713', '20170830215544128945562478386449');
INSERT INTO `auth_role_operation` VALUES ('20180210170258301314245886999900', '20161222113705166483235779248713', '20170830192054683460859544871283');
INSERT INTO `auth_role_operation` VALUES ('20180210170258301988462269796527', '20161222113705166483235779248713', '20170830220201224479919528345484');
INSERT INTO `auth_role_operation` VALUES ('20180210170258302658580403158429', '20161222113705166483235779248713', '20170830220145426040278671555187');
INSERT INTO `auth_role_operation` VALUES ('20180210170258303919243936080991', '20161222113705166483235779248713', '20170830215949915838182861979320');
INSERT INTO `auth_role_operation` VALUES ('20180210170258304674350049094752', '20161222113705166483235779248713', '20170830193421061689978568425583');
INSERT INTO `auth_role_operation` VALUES ('20180210170258304918239731606439', '20161222113705166483235779248713', '20170830193238046005494334668906');
INSERT INTO `auth_role_operation` VALUES ('20180210170258305273857139230631', '20161222113705166483235779248713', '20170830193505037098024646042053');
INSERT INTO `auth_role_operation` VALUES ('20180210170258306734733778945876', '20161222113705166483235779248713', '20170830195224496291856286404584');
INSERT INTO `auth_role_operation` VALUES ('20180210170258307684447813100343', '20161222113705166483235779248713', '20170830193443869546062429795974');
INSERT INTO `auth_role_operation` VALUES ('20180210170258308850256790399674', '20161222113705166483235779248713', '20170830220005504841769677323352');
INSERT INTO `auth_role_operation` VALUES ('20180210170258309567973177741074', '20161222113705166483235779248713', '20170830193255125760891065708665');
INSERT INTO `auth_role_operation` VALUES ('20180210170258309698977040858712', '20161222113705166483235779248713', '20170830193528425979326277446232');
INSERT INTO `auth_role_operation` VALUES ('20180210170258310503904262636286', '20161222113705166483235779248713', '20170830195314785640772998552609');
INSERT INTO `auth_role_operation` VALUES ('20180210170258311442086309398252', '20161222113705166483235779248713', '20170830204349041238399100946574');
INSERT INTO `auth_role_operation` VALUES ('20180210170258312441369392132824', '20161222113705166483235779248713', '20170830195952927735812968924402');
INSERT INTO `auth_role_operation` VALUES ('20180210170258313101628970816381', '20161222113705166483235779248713', '20170830200010440770258081239747');
INSERT INTO `auth_role_operation` VALUES ('20180210170258313630274858868699', '20161222113705166483235779248713', '20170830195251191262648827672964');
INSERT INTO `auth_role_operation` VALUES ('20180210170258314819392707220221', '20161222113705166483235779248713', '20170830200138467141485172827079');
INSERT INTO `auth_role_operation` VALUES ('20180210170258315463220592531911', '20161222113705166483235779248713', '20170830195837172395553321840017');
INSERT INTO `auth_role_operation` VALUES ('20180210170258316997900977120834', '20161222113705166483235779248713', '20170830200510672214993873192328');
INSERT INTO `auth_role_operation` VALUES ('20180210170258317314166964028090', '20161222113705166483235779248713', '20170830200225095851015197490178');
INSERT INTO `auth_role_operation` VALUES ('20180210170258317967833785352826', '20161222113705166483235779248713', '20170830200927016251907168067342');
INSERT INTO `auth_role_operation` VALUES ('20180210170258318342664727096297', '20161222113705166483235779248713', '20170830200652734808802789393289');
INSERT INTO `auth_role_operation` VALUES ('20180210170258318719219474745234', '20161222113705166483235779248713', '20170830200035607992811693777952');
INSERT INTO `auth_role_operation` VALUES ('20180210170258319773801888445066', '20161222113705166483235779248713', '20170830200122024157882634843521');
INSERT INTO `auth_role_operation` VALUES ('20180210170258319857624242065114', '20161222113705166483235779248713', '20170830200635789169186303647746');
INSERT INTO `auth_role_operation` VALUES ('20180210170258320330909350308336', '20161222113705166483235779248713', '20170830200711652334092203833713');
INSERT INTO `auth_role_operation` VALUES ('20180210170258320836262099040257', '20161222113705166483235779248713', '20170830203245078859643401520432');
INSERT INTO `auth_role_operation` VALUES ('20180210170258321088814682757841', '20161222113705166483235779248713', '20170830200947055208552582025791');
INSERT INTO `auth_role_operation` VALUES ('20180210170258321959069528031899', '20161222113705166483235779248713', '20170830203229059912520138805051');
INSERT INTO `auth_role_operation` VALUES ('20180210170258322193434296061536', '20161222113705166483235779248713', '20170830203652475742148953065984');
INSERT INTO `auth_role_operation` VALUES ('20180210170258322580308299372441', '20161222113705166483235779248713', '20170830203053742545387620019408');
INSERT INTO `auth_role_operation` VALUES ('20180210170258323514381817020600', '20161222113705166483235779248713', '20170830200800396241502855800517');
INSERT INTO `auth_role_operation` VALUES ('20180210170258323593735522231762', '20161222113705166483235779248713', '20170830203454874645851788208264');
INSERT INTO `auth_role_operation` VALUES ('20180210170258324338530665178062', '20161222113705166483235779248713', '20170830212014158352628251425243');
INSERT INTO `auth_role_operation` VALUES ('20180210170258324536361844012073', '20161222113705166483235779248713', '20170830211608287007426469438342');
INSERT INTO `auth_role_operation` VALUES ('20180210170258325095100216571725', '20161222113705166483235779248713', '20170830212113637870012701083910');
INSERT INTO `auth_role_operation` VALUES ('20180210170258325457158164333811', '20161222113705166483235779248713', '20170830203633152858219054080187');
INSERT INTO `auth_role_operation` VALUES ('20180210170258325596256344034543', '20161222113705166483235779248713', '20170830211626971107596734913926');
INSERT INTO `auth_role_operation` VALUES ('20180210170258326147279337211581', '20161222113705166483235779248713', '20170830210108147838673454239815');
INSERT INTO `auth_role_operation` VALUES ('20180210170258326199165172592570', '20161222113705166483235779248713', '20170830211716018298124906467040');
INSERT INTO `auth_role_operation` VALUES ('20180210170258327478012136173694', '20161222113705166483235779248713', '20170830212157375035684564351454');
INSERT INTO `auth_role_operation` VALUES ('20180210170258328232873460076045', '20161222113705166483235779248713', '20170830212056944298966506560326');
INSERT INTO `auth_role_operation` VALUES ('20180210170258328260516896200970', '20161222113705166483235779248713', '20170830212254780925581597225004');
INSERT INTO `auth_role_operation` VALUES ('20180210170258329036894858495980', '20161222113705166483235779248713', '20170830212611859339507179554965');
INSERT INTO `auth_role_operation` VALUES ('20180210170258329749169752498594', '20161222113705166483235779248713', '20170830212033335458755658047737');
INSERT INTO `auth_role_operation` VALUES ('20180210170258330913763425297429', '20161222113705166483235779248713', '20170830212627419785295268488307');
INSERT INTO `auth_role_operation` VALUES ('20180210170258330944077928946881', '20161222113705166483235779248713', '20170830212228299103924413492470');
INSERT INTO `auth_role_operation` VALUES ('20180210170258331060133497120015', '20161222113705166483235779248713', '20170830212929046902239455990989');
INSERT INTO `auth_role_operation` VALUES ('20180210170258331440113728854487', '20161222113705166483235779248713', '20170830213202742967167983709658');
INSERT INTO `auth_role_operation` VALUES ('20180210170258331796840228558067', '20161222113705166483235779248713', '20170830212359656989384123764127');
INSERT INTO `auth_role_operation` VALUES ('20180210170258332379401859181786', '20161222113705166483235779248713', '20170830212332619600555298135658');
INSERT INTO `auth_role_operation` VALUES ('20180210170258332568983202411627', '20161222113705166483235779248713', '20170830212943299510229978750685');
INSERT INTO `auth_role_operation` VALUES ('20180210170258333648962389181361', '20161222113705166483235779248713', '20170830212556246765793315531106');
INSERT INTO `auth_role_operation` VALUES ('20180210170258334385748155179730', '20161222113705166483235779248713', '20170830212914025931296641205275');
INSERT INTO `auth_role_operation` VALUES ('20180210170258334629265070116192', '20161222113705166483235779248713', '20170830213747348506915128859724');
INSERT INTO `auth_role_operation` VALUES ('20180210170258334974661367195086', '20161222113705166483235779248713', '20170830213149064945692852236219');
INSERT INTO `auth_role_operation` VALUES ('20180210170258335057345463159920', '20161222113705166483235779248713', '20170830213233450633913008953329');
INSERT INTO `auth_role_operation` VALUES ('20180210170258335087204959973763', '20161222113705166483235779248713', '20170830214041734597098657415801');
INSERT INTO `auth_role_operation` VALUES ('20180210170258336440867694428688', '20161222113705166483235779248713', '20170830214752934809972100332433');
INSERT INTO `auth_role_operation` VALUES ('20180210170258336620863989961211', '20161222113705166483235779248713', '20170830213733907673564571219506');
INSERT INTO `auth_role_operation` VALUES ('20180210170258336841789801326771', '20161222113705166483235779248713', '20170830213215906553105841332218');
INSERT INTO `auth_role_operation` VALUES ('20180210170258337388450980335453', '20161222113705166483235779248713', '20170831195216339672525627852736');
INSERT INTO `auth_role_operation` VALUES ('20180210170258337604728389708478', '20161222113705166483235779248713', '20170830214434115909390449265146');
INSERT INTO `auth_role_operation` VALUES ('20180210170258338061840325183957', '20161222113705166483235779248713', '20170830214401798214742782123975');
INSERT INTO `auth_role_operation` VALUES ('20180210170258338383947629761360', '20161222113705166483235779248713', '20170830214006843684625415051517');
INSERT INTO `auth_role_operation` VALUES ('20180210170258338475155135288918', '20161222113705166483235779248713', '20170830213253940472094124583770');
INSERT INTO `auth_role_operation` VALUES ('20180210170258339097207219572070', '20161222113705166483235779248713', '20170831195023482521793792970228');
INSERT INTO `auth_role_operation` VALUES ('20180210170258339966136624140557', '20161222113705166483235779248713', '20170831195040034729068633839551');
INSERT INTO `auth_role_operation` VALUES ('20180210170258340660989120793833', '20161222113705166483235779248713', '20170905113330921312698830955315');
INSERT INTO `auth_role_operation` VALUES ('20180210170258340926602321205446', '20161222113705166483235779248713', '20170905113416727887433703595827');
INSERT INTO `auth_role_operation` VALUES ('20180210170258341096984071720167', '20161222113705166483235779248713', '20170905113242807250344710772052');
INSERT INTO `auth_role_operation` VALUES ('20180210170258341324459327991503', '20161222113705166483235779248713', '20170830213718045711614226852092');
INSERT INTO `auth_role_operation` VALUES ('20180210170258342097893569952634', '20161222113705166483235779248713', '20170907114304276330147804838057');
INSERT INTO `auth_role_operation` VALUES ('20180210170258342136509945572081', '20161222113705166483235779248713', '20170831114800589839023932430424');
INSERT INTO `auth_role_operation` VALUES ('20180210170258342937175039821213', '20161222113705166483235779248713', '20170905113504020421380883183230');
INSERT INTO `auth_role_operation` VALUES ('20180210170258343144197528445630', '20161222113705166483235779248713', '20170907114640747376885135765495');
INSERT INTO `auth_role_operation` VALUES ('20180210170258343472954433932714', '20161222113705166483235779248713', '20170907183023272287485611057247');
INSERT INTO `auth_role_operation` VALUES ('20180210170258344471864825111428', '20161222113705166483235779248713', '20170907092905667444730868854461');
INSERT INTO `auth_role_operation` VALUES ('20180210170258344598519121514065', '20161222113705166483235779248713', '20170831114900835577449018434717');
INSERT INTO `auth_role_operation` VALUES ('20180210170258345023554576456957', '20161222113705166483235779248713', '20170907094718749000255953529561');
INSERT INTO `auth_role_operation` VALUES ('20180210170258345482414812100260', '20161222113705166483235779248713', '20170907092941081416231974508693');
INSERT INTO `auth_role_operation` VALUES ('20180210170258345565586229462288', '20161222113705166483235779248713', '20170831195009050642469076420197');
INSERT INTO `auth_role_operation` VALUES ('20180210170258346163044156998984', '20161222113705166483235779248713', '20170907114412556152040297381592');
INSERT INTO `auth_role_operation` VALUES ('20180210170258346176751055550841', '20161222113705166483235779248713', '20170916164143755445838165104916');
INSERT INTO `auth_role_operation` VALUES ('20180210170258347116415926670817', '20161222113705166483235779248713', '20170907094807810637041668595090');
INSERT INTO `auth_role_operation` VALUES ('20180210170258347871633325942626', '20161222113705166483235779248713', '20170912113755646018707385325628');
INSERT INTO `auth_role_operation` VALUES ('20180210170258348255022681487064', '20161222113705166483235779248713', '20170918181955966248682428787380');
INSERT INTO `auth_role_operation` VALUES ('20180210170258348666891449648006', '20161222113705166483235779248713', '20170916163901861046502203638949');
INSERT INTO `auth_role_operation` VALUES ('20180210170258349217017977540015', '20161222113705166483235779248713', '20170907095656314297389811334079');
INSERT INTO `auth_role_operation` VALUES ('20180210170258349772942405015694', '20161222113705166483235779248713', '20170916164214964427278019725301');
INSERT INTO `auth_role_operation` VALUES ('20180210170258350240707929746424', '20161222113705166483235779248713', '20170920141005562881234214761079');
INSERT INTO `auth_role_operation` VALUES ('20180210170258350283470258655826', '20161222113705166483235779248713', '20170920140822347202540523420220');
INSERT INTO `auth_role_operation` VALUES ('20180210170258350591270134357124', '20161222113705166483235779248713', '20170918182020409039712412389128');
INSERT INTO `auth_role_operation` VALUES ('20180210170258351395566470900836', '20161222113705166483235779248713', '20170920185248432104988892736289');
INSERT INTO `auth_role_operation` VALUES ('20180210170258351651038734364263', '20161222113705166483235779248713', '20170916163958790529678667118252');
INSERT INTO `auth_role_operation` VALUES ('20180210170258352343088286341516', '20161222113705166483235779248713', '20170920140803096478069341153065');
INSERT INTO `auth_role_operation` VALUES ('20180210170258352725709048952734', '20161222113705166483235779248713', '20170920141210543250590234726262');
INSERT INTO `auth_role_operation` VALUES ('20180210170258353148794979836791', '20161222113705166483235779248713', '20170920141025407265257309693312');
INSERT INTO `auth_role_operation` VALUES ('20180210170258353416683116847646', '20161222113705166483235779248713', '20170920141524213004389058874550');
INSERT INTO `auth_role_operation` VALUES ('20180210170258354084607301879813', '20161222113705166483235779248713', '20170920141224766843662826484521');
INSERT INTO `auth_role_operation` VALUES ('20180210170258354322537285102759', '20161222113705166483235779248713', '20170920141451888300436029977808');
INSERT INTO `auth_role_operation` VALUES ('20180210170258355167123301515279', '20161222113705166483235779248713', '20170920185318266552556934711554');
INSERT INTO `auth_role_operation` VALUES ('20180210170258355435962345834585', '20161222113705166483235779248713', '20170920185301776491582754867218');
INSERT INTO `auth_role_operation` VALUES ('20180210170258355702612724057954', '20161222113705166483235779248713', '20170920185415888518048606670192');
INSERT INTO `auth_role_operation` VALUES ('20180210170258356000914885607408', '20161222113705166483235779248713', '20170920185427615570648903631122');
INSERT INTO `auth_role_operation` VALUES ('20180210170258356186941625935578', '20161222113705166483235779248713', '20180210170243988199819071714076');
INSERT INTO `auth_role_operation` VALUES ('20180210170312339208285236264027', '20161226105333229671150841475606', '20170830195837172395553321840017');
INSERT INTO `auth_role_operation` VALUES ('20180210170312341899318058345356', '20161226105333229671150841475606', '20170830200010440770258081239747');
INSERT INTO `auth_role_operation` VALUES ('20180210170312343495497076301116', '20161226105333229671150841475606', '20170830195952927735812968924402');
INSERT INTO `auth_role_operation` VALUES ('20180210170312345353431725706914', '20161226105333229671150841475606', '20170830200510672214993873192328');
INSERT INTO `auth_role_operation` VALUES ('20180210170312347162566525003469', '20161226105333229671150841475606', '20170830200635789169186303647746');
INSERT INTO `auth_role_operation` VALUES ('20180210170312349441150671793942', '20161226105333229671150841475606', '20170830200652734808802789393289');
INSERT INTO `auth_role_operation` VALUES ('20180210170312351677673540696602', '20161226105333229671150841475606', '20170830190749437593611799583348');
INSERT INTO `auth_role_operation` VALUES ('20180210170312352445376419611891', '20161226105333229671150841475606', '20170830190806693389915480819873');
INSERT INTO `auth_role_operation` VALUES ('20180210170312354832094405448809', '20161226105333229671150841475606', '20170830190828376902478881510993');
INSERT INTO `auth_role_operation` VALUES ('20180210170312356955662302834064', '20161226105333229671150841475606', '20170830191052591570764290093428');
INSERT INTO `auth_role_operation` VALUES ('20180210170312358049979488379769', '20161226105333229671150841475606', '20170830191112598727093983747834');
INSERT INTO `auth_role_operation` VALUES ('20180210170312360818398040374089', '20161226105333229671150841475606', '20170830191258161989305015042996');
INSERT INTO `auth_role_operation` VALUES ('20180210170312362660541037645212', '20161226105333229671150841475606', '20170830191232595410869912724090');
INSERT INTO `auth_role_operation` VALUES ('20180210170312364640284440231300', '20161226105333229671150841475606', '20170830191505864748906036206883');
INSERT INTO `auth_role_operation` VALUES ('20180210170312365868398862818416', '20161226105333229671150841475606', '20170830191631242284938401241106');
INSERT INTO `auth_role_operation` VALUES ('20180210170312367982541922778662', '20161226105333229671150841475606', '20170830191522823371398187741710');
INSERT INTO `auth_role_operation` VALUES ('20180210170312369527019054405594', '20161226105333229671150841475606', '20170830191833743610957280978678');
INSERT INTO `auth_role_operation` VALUES ('20180210170312370652403824442449', '20161226105333229671150841475606', '20170830191649218225294187613654');
INSERT INTO `auth_role_operation` VALUES ('20180210170312372062208975627888', '20161226105333229671150841475606', '20170830192032675542147064290037');
INSERT INTO `auth_role_operation` VALUES ('20180210170312374086252875637821', '20161226105333229671150841475606', '20170830191851344574311818941542');
INSERT INTO `auth_role_operation` VALUES ('20180210170312376082905592270862', '20161226105333229671150841475606', '20170830192054683460859544871283');
INSERT INTO `auth_role_operation` VALUES ('20180210170312377330205372269042', '20161226105333229671150841475606', '20170831195009050642469076420197');
INSERT INTO `auth_role_operation` VALUES ('20180210170312379808911278877675', '20161226105333229671150841475606', '20170831195023482521793792970228');
INSERT INTO `auth_role_operation` VALUES ('20180210170312381342702892079975', '20161226105333229671150841475606', '20170831195040034729068633839551');
INSERT INTO `auth_role_operation` VALUES ('20180210170312382746008220996516', '20161226105333229671150841475606', '20170905113242807250344710772052');
INSERT INTO `auth_role_operation` VALUES ('20180210170312384244589246374432', '20161226105333229671150841475606', '20170905113330921312698830955315');
INSERT INTO `auth_role_operation` VALUES ('20180210170312386294043652450289', '20161226105333229671150841475606', '20170831195216339672525627852736');
INSERT INTO `auth_role_operation` VALUES ('20180210170312388393423160228801', '20161226105333229671150841475606', '20170905113504020421380883183230');
INSERT INTO `auth_role_operation` VALUES ('20180210170312388506515314477928', '20161226105333229671150841475606', '20170905113416727887433703595827');
INSERT INTO `auth_role_operation` VALUES ('20180210170312389995663731236686', '20161226105333229671150841475606', '20170907092905667444730868854461');
INSERT INTO `auth_role_operation` VALUES ('20180210170312390030202818195100', '20161226105333229671150841475606', '20170907094718749000255953529561');
INSERT INTO `auth_role_operation` VALUES ('20180210170312391649877556546105', '20161226105333229671150841475606', '20170907092941081416231974508693');
INSERT INTO `auth_role_operation` VALUES ('20180210170312392187574745660156', '20161226105333229671150841475606', '20170907094807810637041668595090');
INSERT INTO `auth_role_operation` VALUES ('20180210170312393275617956511180', '20161226105333229671150841475606', '20170907095656314297389811334079');
INSERT INTO `auth_role_operation` VALUES ('20180210170312393562142953432236', '20161226105333229671150841475606', '20170912113755646018707385325628');
INSERT INTO `auth_role_operation` VALUES ('20180210170312394346331623854843', '20161226105333229671150841475606', '20170916164143755445838165104916');
INSERT INTO `auth_role_operation` VALUES ('20180210170312395266827077707463', '20161226105333229671150841475606', '20170916163958790529678667118252');
INSERT INTO `auth_role_operation` VALUES ('20180210170312396006299067530176', '20161226105333229671150841475606', '20170916163901861046502203638949');
INSERT INTO `auth_role_operation` VALUES ('20180210170312396707893788961842', '20161226105333229671150841475606', '20170916164214964427278019725301');
INSERT INTO `auth_role_operation` VALUES ('20180210170312397722882212389907', '20161226105333229671150841475606', '20170830203053742545387620019408');
INSERT INTO `auth_role_operation` VALUES ('20180210170312398390478036423017', '20161226105333229671150841475606', '20170830204349041238399100946574');
INSERT INTO `auth_role_operation` VALUES ('20180210170312399072849215782369', '20161226105333229671150841475606', '20170830203229059912520138805051');
INSERT INTO `auth_role_operation` VALUES ('20180210170312399078359189382776', '20161226105333229671150841475606', '20170830203454874645851788208264');
INSERT INTO `auth_role_operation` VALUES ('20180210170312400342750705308937', '20161226105333229671150841475606', '20170830203652475742148953065984');
INSERT INTO `auth_role_operation` VALUES ('20180210170312401202780031653274', '20161226105333229671150841475606', '20170830203245078859643401520432');
INSERT INTO `auth_role_operation` VALUES ('20180210170312402803799732417301', '20161226105333229671150841475606', '20170830203633152858219054080187');
INSERT INTO `auth_role_operation` VALUES ('20180210170312403516935204235028', '20161226105333229671150841475606', '20170830193238046005494334668906');
INSERT INTO `auth_role_operation` VALUES ('20180210170312403928650245790827', '20161226105333229671150841475606', '20170830193222502820225571239715');
INSERT INTO `auth_role_operation` VALUES ('20180210170312404366233286798455', '20161226105333229671150841475606', '20170830193421061689978568425583');
INSERT INTO `auth_role_operation` VALUES ('20180210170312405675172128630830', '20161226105333229671150841475606', '20170830193443869546062429795974');
INSERT INTO `auth_role_operation` VALUES ('20180210170312406034662205801099', '20161226105333229671150841475606', '20170830193528425979326277446232');
INSERT INTO `auth_role_operation` VALUES ('20180210170312407488492552621902', '20161226105333229671150841475606', '20170830193505037098024646042053');
INSERT INTO `auth_role_operation` VALUES ('20180210170312408755940645538670', '20161226105333229671150841475606', '20180210170243988199819071714076');
INSERT INTO `auth_role_operation` VALUES ('20180210170346272973407608378900', '20170922175728329467199921325795', '20170830195837172395553321840017');
INSERT INTO `auth_role_operation` VALUES ('20180210170346274192984138853741', '20170922175728329467199921325795', '20170830200122024157882634843521');
INSERT INTO `auth_role_operation` VALUES ('20180210170346275643932903116127', '20170922175728329467199921325795', '20170830195952927735812968924402');
INSERT INTO `auth_role_operation` VALUES ('20180210170346277334504144240382', '20170922175728329467199921325795', '20170830200510672214993873192328');
INSERT INTO `auth_role_operation` VALUES ('20180210170346279151113004518232', '20170922175728329467199921325795', '20170830200138467141485172827079');
INSERT INTO `auth_role_operation` VALUES ('20180210170346281695704890775345', '20170922175728329467199921325795', '20170830200010440770258081239747');
INSERT INTO `auth_role_operation` VALUES ('20180210170346282107017959954523', '20170922175728329467199921325795', '20170830200652734808802789393289');
INSERT INTO `auth_role_operation` VALUES ('20180210170346284333119548576156', '20170922175728329467199921325795', '20170830200635789169186303647746');
INSERT INTO `auth_role_operation` VALUES ('20180210170346286474045469843529', '20170922175728329467199921325795', '20170830200800396241502855800517');
INSERT INTO `auth_role_operation` VALUES ('20180210170346287165374453154682', '20170922175728329467199921325795', '20170830200947055208552582025791');
INSERT INTO `auth_role_operation` VALUES ('20180210170346289964842370321332', '20170922175728329467199921325795', '20170831114800589839023932430424');
INSERT INTO `auth_role_operation` VALUES ('20180210170346290491565429024738', '20170922175728329467199921325795', '20170830200225095851015197490178');
INSERT INTO `auth_role_operation` VALUES ('20180210170346292207819810165902', '20170922175728329467199921325795', '20170831114900835577449018434717');
INSERT INTO `auth_role_operation` VALUES ('20180210170346294941578949193353', '20170922175728329467199921325795', '20170830203229059912520138805051');
INSERT INTO `auth_role_operation` VALUES ('20180210170346296950731594351979', '20170922175728329467199921325795', '20170830203245078859643401520432');
INSERT INTO `auth_role_operation` VALUES ('20180210170346297008247952606921', '20170922175728329467199921325795', '20170830203053742545387620019408');
INSERT INTO `auth_role_operation` VALUES ('20180210170346299727741245915644', '20170922175728329467199921325795', '20170830203633152858219054080187');
INSERT INTO `auth_role_operation` VALUES ('20180210170346300804861805619123', '20170922175728329467199921325795', '20170830203652475742148953065984');
INSERT INTO `auth_role_operation` VALUES ('20180210170346302875130466959881', '20170922175728329467199921325795', '20180210170243988199819071714076');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` varchar(32) NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `roleId` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '用户名称',
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '联系电话',
  `state` varchar(5) DEFAULT NULL,
  `openId` varchar(255) DEFAULT NULL COMMENT '微信的openid',
  `ft` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `lt` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `fu` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `lu` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `store_id` varchar(32) DEFAULT NULL COMMENT '关联门店',
  `userCode` varchar(50) DEFAULT NULL COMMENT '工号',
  `job` varchar(50) DEFAULT NULL COMMENT '职位',
  `joinTime` timestamp NULL DEFAULT NULL COMMENT '入职时间',
  `idCard` varchar(25) DEFAULT NULL COMMENT '身份证号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('00000000000000000000000000000000', 'sysadmin', 'e10adc3949ba59abbe56e057f20f883e', '20160705172222485975228559014888', '系统管理员', null, '1', null, null, null, null, null, null, null, null, null, null);
INSERT INTO `auth_user` VALUES ('20161222113810681189580305593289', 'admin1', 'e10adc3949ba59abbe56e057f20f883e', '20161222113705166483235779248713', '管理员一号', '15044940362', '1', null, null, '2016-12-24 11:48:58', null, null, null, null, null, null, null);
INSERT INTO `auth_user` VALUES ('20170719183526150581078930499570', 'shouyin1', 'e10adc3949ba59abbe56e057f20f883e', '20170719142123261720369578658104', '收银测试1号', '13111111111', '0', null, '2017-07-19 18:35:26', '2017-09-22 15:26:22', '20161222113810681189580305593289', '20161222113810681189580305593289', '', 'shouyin1', '收银', '2017-07-19 00:00:00', null);
INSERT INTO `auth_user` VALUES ('20170809180827327513862826903895', 'kaipiao1', 'e10adc3949ba59abbe56e057f20f883e', '20170809180719312149709311355949', '开票一号', '13111111111', '0', null, '2017-08-09 18:08:27', '2017-09-22 15:26:35', '20161222113810681189580305593289', '20161222113810681189580305593289', '20170919102942520084783958364000', 'kaipiao1', '开票账号', '2017-08-09 00:00:00', null);
INSERT INTO `auth_user` VALUES ('20170920192053068616963784063725', '777777', 'e10adc3949ba59abbe56e057f20f883e', '20170809180719312149709311355949', 'test', '13012341234', '0', null, '2017-09-20 19:20:53', '2017-09-22 15:26:18', '20170919104453959974112314324476', '20161222113810681189580305593289', '20170919102942520084783958364000', null, '阿什顿发斯蒂芬阿什顿', '2017-09-20 00:00:00', '');
INSERT INTO `auth_user` VALUES ('20170922171947376165547181122780', 'dg0001', 'e10adc3949ba59abbe56e057f20f883e', '20170731153423763187360535282191', '王一', '16600000001', '1', null, '2017-09-22 17:19:47', '2018-03-04 14:37:03', '20161222113810681189580305593289', '20161222113810681189580305593289', null, null, '导购', '2017-08-17 00:00:00', '110102199901013277');
INSERT INTO `auth_user` VALUES ('20170922182244405544128921993049', 'kaipiao1', 'e10adc3949ba59abbe56e057f20f883e', '20161226105333229671150841475606', '运动店1店长', '13256987412', '1', null, '2017-09-22 18:22:44', '2018-03-20 16:41:57', '20161222113810681189580305593289', '20161222113810681189580305593289', '20171020141842757704681968303771', null, '店长', '2017-09-12 00:00:00', '120103199901014956');
INSERT INTO `auth_user` VALUES ('20170922185727099238253094005520', 'zhuguan', 'e10adc3949ba59abbe56e057f20f883e', '20170922175728329467199921325795', '主管', '15661456122', '1', null, '2017-09-22 18:57:27', null, '20161222113810681189580305593289', null, '', null, '主管', '2017-09-22 00:00:00', '120103199901014956');
INSERT INTO `auth_user` VALUES ('20170922192735138176357766606813', 'kaipiao', 'e10adc3949ba59abbe56e057f20f883e', '20170809180719312149709311355949', '运动店开票', '15661451612', '1', null, '2017-09-22 19:27:35', '2018-03-20 16:42:12', '20161222113810681189580305593289', '20161222113810681189580305593289', '20171020141842757704681968303771', null, '开票', '2017-09-22 00:00:00', '120103199901014956');
INSERT INTO `auth_user` VALUES ('20170922195030757264333921841291', 'shouyin1', 'e10adc3949ba59abbe56e057f20f883e', '20170719142123261720369578658104', '收银1', '15661245455', '1', null, '2017-09-22 19:50:30', null, '20161222113810681189580305593289', null, '', null, 'sdf', '2017-09-22 00:00:00', '120103199901014956');
INSERT INTO `auth_user` VALUES ('20170923163938680812505983823051', 'shouyin2', 'e10adc3949ba59abbe56e057f20f883e', '20170719142123261720369578658104', '森收银2', '15044940362', '1', null, '2017-09-23 16:39:38', '2018-03-12 10:02:09', '00000000000000000000000000000000', '20161222113810681189580305593289', '20180122101904528474410614949352', null, 'shouyin2', '2017-09-23 00:00:00', '152601199302251636');
INSERT INTO `auth_user` VALUES ('20170923171444523929901468294484', 'xspkaipiao', 'e10adc3949ba59abbe56e057f20f883e', '20170809180719312149709311355949', '小商品开票', '15661451612', '1', null, '2017-09-23 17:14:44', '2018-03-09 14:29:57', '20161222113810681189580305593289', '20161222113810681189580305593289', '20170922155512650796375955980227', null, '323', '2017-09-23 00:00:00', '120101199901017257');
INSERT INTO `auth_user` VALUES ('20170923171526998256904440384054', 'xspdy1', 'e10adc3949ba59abbe56e057f20f883e', '20170922180707233706443457677967', '小商品店员', '15661451612', '0', null, '2017-09-23 17:15:26', '2018-03-08 09:38:40', '20161222113810681189580305593289', '20161222113810681189580305593289', null, null, 'sds', '2017-09-23 00:00:00', '120101199901017257');
INSERT INTO `auth_user` VALUES ('20170925103713874175976363098240', 'dianzhang2', 'e10adc3949ba59abbe56e057f20f883e', '20161226105333229671150841475606', '测试店店长2', '15623654789', '1', null, '2017-09-25 10:37:13', '2018-01-22 10:19:38', '20161222113810681189580305593289', '20161222113810681189580305593289', '20180122101904528474410614949352', null, 'sdsf', '2017-09-25 00:00:00', '120103199901017073');
INSERT INTO `auth_user` VALUES ('20170925104833839272877986863829', 'kaipiao2', 'e10adc3949ba59abbe56e057f20f883e', '20170809180719312149709311355949', '测试开票帐号2', '15644555223', '1', null, '2017-09-25 10:48:33', '2018-01-22 10:19:44', '20161222113810681189580305593289', '20161222113810681189580305593289', '20180122101904528474410614949352', null, 'sds', '2017-09-25 00:00:00', '120103199901017073');
INSERT INTO `auth_user` VALUES ('20171017150922513599443544525482', '123123', '4297f44b13955235245b2497399d7a93', '20170731153423763187360535282191', '123123', '18645260566', '0', null, '2017-10-17 15:09:22', '2017-10-17 15:09:49', '20161222113810681189580305593289', '20161222113810681189580305593289', '20170922154932923123004764987340', null, 'sd', '2017-10-10 00:00:00', '');
INSERT INTO `auth_user` VALUES ('20171020155533327011935951200187', 'daogou2', 'e10adc3949ba59abbe56e057f20f883e', '20170731153423763187360535282191', '测试导购', '15044940362', '1', null, '2017-10-20 15:55:33', '2018-01-22 10:19:49', '20161222113810681189580305593289', '20161222113810681189580305593289', '20180122101904528474410614949352', null, '导购', '2017-10-20 00:00:00', '');
INSERT INTO `auth_user` VALUES ('20171024104923312406307104720694', 'shouyin3', 'e10adc3949ba59abbe56e057f20f883e', '20170719142123261720369578658104', '王大妞收银3', '18697409064', '0', null, '2017-10-24 10:49:23', '2018-01-22 10:12:00', '20161222113810681189580305593289', '20161222113810681189580305593289', null, null, '收银', '2017-10-24 00:00:00', '');
INSERT INTO `auth_user` VALUES ('20171026141918543143235192020064', 'zhuguan1', 'e10adc3949ba59abbe56e057f20f883e', '20170922175728329467199921325795', '测试主管', '13012341234', '0', null, '2017-10-26 14:19:18', '2017-10-27 10:26:21', '20161222113810681189580305593289', '20161222113810681189580305593289', '20171020141842757704681968303771', null, 'zg', '2017-10-26 00:00:00', '');
INSERT INTO `auth_user` VALUES ('20171027102652458235566336543814', 'zhuguan2', 'e10adc3949ba59abbe56e057f20f883e', '20170922175728329467199921325795', '测试主管2', '18697409064', '1', null, '2017-10-27 10:26:52', '2018-01-22 10:19:55', '20161222113810681189580305593289', '20161222113810681189580305593289', '20180122101904528474410614949352', null, '刘主管', '2017-10-27 00:00:00', '');
INSERT INTO `auth_user` VALUES ('20180308094048129590536181219317', 'daogou', 'e10adc3949ba59abbe56e057f20f883e', '20170731153423763187360535282191', '导购', '16600000002', '1', null, '2018-03-08 09:40:48', '2018-03-08 09:53:09', '20161222113810681189580305593289', '20161222113810681189580305593289', '20180122101904528474410614949352', null, '导购', '2018-03-08 00:00:00', '120101199901017257');
INSERT INTO `auth_user` VALUES ('20180403102452843217051878132227', '123456', 'e10adc3949ba59abbe56e057f20f883e', '20161226105333229671150841475606', '12123', '15044940362', '1', null, '2018-04-03 10:24:52', null, '20161222113810681189580305593289', null, '20170922155758751662910860438310', null, '11', '2018-04-03 00:00:00', '');
INSERT INTO `auth_user` VALUES ('20180510181303709015109936530549', 'kaipiao003', 'e10adc3949ba59abbe56e057f20f883e', '20170809180719312149709311355949', '女鞋开票', '13111111111', '1', null, '2018-05-10 18:13:03', null, '20161222113810681189580305593289', null, '20170922155758751662910860438310', null, '阿斯顿撒', '2018-05-10 00:00:00', '445300199509191510');

-- ----------------------------
-- Table structure for sys_attachment
-- ----------------------------
DROP TABLE IF EXISTS `sys_attachment`;
CREATE TABLE `sys_attachment` (
  `id` char(32) NOT NULL,
  `id_owner` char(32) DEFAULT NULL COMMENT '该附件归属于那个业务数据的',
  `path` varchar(200) DEFAULT NULL,
  `serverFilename` varchar(200) DEFAULT NULL,
  `sourceFilename` varchar(200) DEFAULT NULL,
  `fileNum` int(11) DEFAULT NULL,
  `fileSize` varchar(50) DEFAULT NULL,
  `fileKind` varchar(20) DEFAULT NULL,
  `status` char(1) DEFAULT NULL COMMENT '0:临时文件（表单未入库）\r\n            1:正在使用\r\n            2:已删除',
  `configCode` varchar(50) DEFAULT NULL,
  `ft` char(19) DEFAULT NULL COMMENT 'first Time',
  `lt` char(19) DEFAULT NULL COMMENT 'last Time',
  `fu` char(32) DEFAULT NULL COMMENT 'First user',
  `lu` char(32) DEFAULT NULL COMMENT 'last user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_attachment
-- ----------------------------
INSERT INTO `sys_attachment` VALUES ('20170922154927876000992869303135', '20170922154932923123004764987340', '2017/', '20170922154927791437803056617015.jpg', '似水年华.jpg', '1', '164805', null, '1', 'default', '2017-09-22 15:49:27', '2017-09-22 15:49:33', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922154930203120078319987891', '20170922154932923123004764987340', '2017/', '20170922154930200336304567884959.jpg', '似水年华.jpg', null, '164805', null, '1', 'default', '2017-09-22 15:49:30', '2017-09-22 15:49:33', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922155112836669183021997000', '20170922155207290634168580342140', '2017/', '20170922155112833450603209076461.jpg', '帛卡袖.jpg', '1', '373552', null, '1', 'default', '2017-09-22 15:51:12', '2017-09-22 15:52:07', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922155113082067057418028864', '20170922155207290634168580342140', '2017/', '20170922155113079715492970510977.jpg', '帛卡袖2.jpg', null, '376089', null, '1', 'default', '2017-09-22 15:51:13', '2017-09-22 15:52:07', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922155300154527587977596522', '20170922155301527135602974909688', '2017/', '20170922155300151075110395383702.jpg', '生日.jpg', null, '238355', null, '1', 'default', '2017-09-22 15:53:00', '2017-09-22 15:53:01', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922155510097217577978498212', '20170922155512650796375955980227', '2017/', '20170922155510081292853178086578.jpg', '生日.jpg', null, '238355', null, '1', 'default', '2017-09-22 15:55:10', '2017-09-22 15:55:12', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922163534731749647257687939', null, '2017/', '20170922163534720619752882009558.jpg', '生日.jpg', '2', '238355', null, '2', 'default', '2017-09-22 16:35:34', '2017-09-22 16:35:42', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922163540406651891367943636', null, '2017/', '20170922163540403452830114316434.jpg', '首页滚动banner.jpg', '1', '308966', null, '2', 'default', '2017-09-22 16:35:40', '2017-09-22 16:35:42', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922163540996993485270486531', null, '2017/', '20170922163540992055707537292106.jpg', '首页滚动banner2.jpg', null, '1104579', null, '2', 'default', '2017-09-22 16:35:40', '2017-09-22 16:35:42', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922164343424619869269498177', null, '2017/', '20170922164343420376097794898704.png', '微信截图_20170919102734.png', '6', '754053', null, '2', 'default', '2017-09-22 16:43:43', '2017-09-22 16:43:48', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922164343860630996760375947', null, '2017/', '20170922164343856053646178814864.png', '微信截图_20170919102752.png', '5', '1010257', null, '2', 'default', '2017-09-22 16:43:43', '2017-09-22 16:43:48', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922164344234231510551507980', null, '2017/', '20170922164344230349785561170363.png', '微信截图_20170919102800.png', '4', '847431', null, '2', 'default', '2017-09-22 16:43:44', '2017-09-22 16:43:48', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922164344665981773134801577', null, '2017/', '20170922164344662649626615522514.png', '微信截图_20170919102805.png', '3', '960637', null, '2', 'default', '2017-09-22 16:43:44', '2017-09-22 16:43:48', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922164344983275893774264503', null, '2017/', '20170922164344980608948192300544.png', '微信截图_20170919102815.png', '2', '840216', null, '2', 'default', '2017-09-22 16:43:44', '2017-09-22 16:43:48', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922164345379497679215241619', null, '2017/', '20170922164345376025965015489541.png', '微信截图_20170919102821.png', '1', '947382', null, '2', 'default', '2017-09-22 16:43:45', '2017-09-22 16:43:48', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922164345738116572714154450', null, '2017/', '20170922164345735372826832048400.png', '微信截图_20170919102828.png', null, '979408', null, '2', 'default', '2017-09-22 16:43:45', '2017-09-22 16:43:48', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922164750490208137983108679', null, '2017/', '20170922164750487530463293548063.png', '微信截图_20170919103244.png', '4', '933490', null, '2', 'default', '2017-09-22 16:47:50', '2017-09-22 16:47:53', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922164750731860701433244527', null, '2017/', '20170922164750728510488494053485.png', '微信截图_20170919103251.png', '3', '549960', null, '2', 'default', '2017-09-22 16:47:50', '2017-09-22 16:47:53', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922164751036807207852329305', null, '2017/', '20170922164751033903154278886652.png', '微信截图_20170919103258.png', '2', '757680', null, '2', 'default', '2017-09-22 16:47:51', '2017-09-22 16:47:53', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922164751350966933401381711', null, '2017/', '20170922164751347743974071537777.png', '微信截图_20170919103304.png', '1', '657646', null, '2', 'default', '2017-09-22 16:47:51', '2017-09-22 16:47:53', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922164751653735052947973998', null, '2017/', '20170922164751650746110598274589.png', '微信截图_20170919103312.png', null, '707601', null, '2', 'default', '2017-09-22 16:47:51', '2017-09-22 16:47:53', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165026985866227008610794', '20170922165036441661166265911438', '2017/', '20170922165026981368662538411444.png', '微信截图_20170919110116.png', '10', '1449135', null, '1', 'default', '2017-09-22 16:50:26', '2017-09-22 16:50:36', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165027480408680131777070', '20170922165036441661166265911438', '2017/', '20170922165027476749680574066268.png', '微信截图_20170919110126.png', '9', '669983', null, '1', 'default', '2017-09-22 16:50:27', '2017-09-22 16:50:36', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165028545810426447360337', '20170922165036441661166265911438', '2017/', '20170922165028101290356975843988.png', '微信截图_20170919110134.png', '8', '1478066', null, '1', 'default', '2017-09-22 16:50:28', '2017-09-22 16:50:36', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165029043652273963123980', '20170922165036441661166265911438', '2017/', '20170922165029040313100809810633.png', '微信截图_20170919110140.png', '7', '930411', null, '1', 'default', '2017-09-22 16:50:29', '2017-09-22 16:50:36', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165029478494416777581787', '20170922165036441661166265911438', '2017/', '20170922165029466850550388020787.png', '微信截图_20170919110146.png', '6', '905111', null, '1', 'default', '2017-09-22 16:50:29', '2017-09-22 16:50:36', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165030275909537858649147', '20170922165036441661166265911438', '2017/', '20170922165030270648345359532798.png', '微信截图_20170919110155.png', '5', '1462316', null, '1', 'default', '2017-09-22 16:50:30', '2017-09-22 16:50:36', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165030697888383105895140', '20170922165036441661166265911438', '2017/', '20170922165030694505725496279739.png', '微信截图_20170919110202.png', '4', '829432', null, '1', 'default', '2017-09-22 16:50:30', '2017-09-22 16:50:36', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165031047727720107490264', '20170922165036441661166265911438', '2017/', '20170922165031044981392069819631.png', '微信截图_20170919110209.png', '3', '885144', null, '1', 'default', '2017-09-22 16:50:31', '2017-09-22 16:50:36', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165031544971929876168822', '20170922165036441661166265911438', '2017/', '20170922165031540592715760043214.png', '微信截图_20170919110217.png', '2', '1419148', null, '1', 'default', '2017-09-22 16:50:31', '2017-09-22 16:50:36', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165031903902995666264576', '20170922165036441661166265911438', '2017/', '20170922165031899229207811597666.png', '微信截图_20170919110223.png', '1', '881823', null, '1', 'default', '2017-09-22 16:50:31', '2017-09-22 16:50:36', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165032366074803102175195', '20170922165036441661166265911438', '2017/', '20170922165032362097272925434376.png', '微信截图_20170919110230.png', null, '1457601', null, '1', 'default', '2017-09-22 16:50:32', '2017-09-22 16:50:36', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165738942007495384354600', null, '2017/', '20170922165738923293400783194019.png', '微信截图_20170922165609.png', '9', '1065706', null, '2', 'default', '2017-09-22 16:57:38', '2017-09-22 16:57:51', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165739377497337890331575', null, '2017/', '20170922165739369955503531309191.png', '微信截图_20170922165615.png', '8', '919059', null, '2', 'default', '2017-09-22 16:57:39', '2017-09-22 16:57:51', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165739760620713723773619', null, '2017/', '20170922165739754924700223720753.png', '微信截图_20170922165621.png', '7', '948197', null, '2', 'default', '2017-09-22 16:57:39', '2017-09-22 16:57:51', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165740224433511790107921', null, '2017/', '20170922165740218665584268330830.png', '微信截图_20170922165628.png', '6', '696894', null, '2', 'default', '2017-09-22 16:57:40', '2017-09-22 16:57:51', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165740565057228258873744', null, '2017/', '20170922165740530714346557480085.png', '微信截图_20170922165634.png', '5', '721184', null, '2', 'default', '2017-09-22 16:57:40', '2017-09-22 16:57:51', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165740920999496460656555', null, '2017/', '20170922165740917774571900905322.png', '微信截图_20170922165639.png', '4', '749581', null, '2', 'default', '2017-09-22 16:57:40', '2017-09-22 16:57:51', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165741248057012873650244', null, '2017/', '20170922165741243377101432088838.png', '微信截图_20170922165645.png', '3', '743583', null, '2', 'default', '2017-09-22 16:57:41', '2017-09-22 16:57:51', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165741499839803609004887', null, '2017/', '20170922165741495163662322557733.png', '微信截图_20170922165651.png', '2', '698057', null, '2', 'default', '2017-09-22 16:57:41', '2017-09-22 16:57:51', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165741787720689556163872', null, '2017/', '20170922165741783420575140174077.png', '微信截图_20170922165657.png', '1', '762557', null, '2', 'default', '2017-09-22 16:57:41', '2017-09-22 16:57:51', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165742080574429600237374', null, '2017/', '20170922165742075829058820367923.png', '微信截图_20170922165704.png', null, '723455', null, '2', 'default', '2017-09-22 16:57:42', '2017-09-22 16:57:51', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165930866635839874672285', null, '2017/', '20170922165930858243298736801043.png', '微信截图_20170921192554.png', '8', '661757', null, '2', 'default', '2017-09-22 16:59:30', '2017-09-22 16:59:37', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165931228088941058637650', null, '2017/', '20170922165931224135125147738276.png', '微信截图_20170921192601.png', '7', '634736', null, '2', 'default', '2017-09-22 16:59:31', '2017-09-22 16:59:37', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165931471399006881623623', null, '2017/', '20170922165931465947748563741763.png', '微信截图_20170921192608.png', '6', '454511', null, '2', 'default', '2017-09-22 16:59:31', '2017-09-22 16:59:37', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165931828369288100918458', null, '2017/', '20170922165931820041798805474695.png', '微信截图_20170921192615.png', '5', '462678', null, '2', 'default', '2017-09-22 16:59:31', '2017-09-22 16:59:37', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165932166135239325792212', null, '2017/', '20170922165932162694518541242516.png', '微信截图_20170921192623.png', '4', '592183', null, '2', 'default', '2017-09-22 16:59:32', '2017-09-22 16:59:37', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165932325561350282021659', null, '2017/', '20170922165932320068279210127104.png', '微信截图_20170921192630.png', '3', '416238', null, '2', 'default', '2017-09-22 16:59:32', '2017-09-22 16:59:37', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165932587982662568287812', null, '2017/', '20170922165932581765725635907199.png', '微信截图_20170921192638.png', '2', '568585', null, '2', 'default', '2017-09-22 16:59:32', '2017-09-22 16:59:37', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165932829863043259337307', null, '2017/', '20170922165932825268382121119309.png', '微信截图_20170921192645.png', '1', '462930', null, '2', 'default', '2017-09-22 16:59:32', '2017-09-22 16:59:37', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922165933084822469648141111', null, '2017/', '20170922165933080824779078181749.png', '微信截图_20170921192651.png', null, '433577', null, '2', 'default', '2017-09-22 16:59:33', '2017-09-22 16:59:37', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922170517051514536088134685', '20170922170523551944134261972825', '2017/', '20170922170517047594851670079254.jpg', 'TB2biBjsHJkpuFjy1zcXXa5FFXa-619123122.jpg', '8', '317866', null, '1', 'default', '2017-09-22 17:05:17', '2017-09-22 17:05:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922170517982434148003161647', '20170922170523551944134261972825', '2017/', '20170922170517977230059237022300.jpg', 'TB2e3ZcswJkpuFjSszcXXXfsFXa-619123122.jpg', '7', '306164', null, '1', 'default', '2017-09-22 17:05:17', '2017-09-22 17:05:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922170518334177534793598068', '20170922170523551944134261972825', '2017/', '20170922170518331753653350660264.jpg', 'TB2l9JvsHXlpuFjy1zbXXb_qpXa-619123122.jpg', '6', '217747', null, '1', 'default', '2017-09-22 17:05:18', '2017-09-22 17:05:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922170518689063031304122935', '20170922170523551944134261972825', '2017/', '20170922170518684380163874967896.jpg', 'TB2EMQcswJkpuFjSszcXXXfsFXa-619123122.jpg', '5', '568829', null, '1', 'default', '2017-09-22 17:05:18', '2017-09-22 17:05:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922170518992135125834152980', '20170922170523551944134261972825', '2017/', '20170922170518989965971995828569.jpg', 'TB2JFdysHVkpuFjSspcXXbSMVXa-619123122.jpg', '4', '366688', null, '1', 'default', '2017-09-22 17:05:18', '2017-09-22 17:05:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922170519233946709808106145', '20170922170523551944134261972825', '2017/', '20170922170519230186166263285729.jpg', 'TB2F4hpsMxlpuFjSszbXXcSVpXa-619123122.jpg', '3', '134033', null, '1', 'default', '2017-09-22 17:05:19', '2017-09-22 17:05:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922170519648298127757151900', '20170922170523551944134261972825', '2017/', '20170922170519646043927347213367.jpg', 'TB2KTHobYsTMeJjSszhXXcGCFXa-619123122.jpg', '2', '320494', null, '1', 'default', '2017-09-22 17:05:19', '2017-09-22 17:05:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922170519907344642631380970', '20170922170523551944134261972825', '2017/', '20170922170519904824320939406800.jpg', 'TB2ba_6XbjhFuJjSZFqXXabgXXa-619123122.jpg', '1', '181273', null, '1', 'default', '2017-09-22 17:05:19', '2017-09-22 17:05:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922170520085225203562353102', '20170922170523551944134261972825', '2017/', '20170922170520083961529956422983.jpg', 'TB2YA63XoYiFuJjSZFEXXbaLXXa-619123122.jpg', null, '230961', null, '1', 'default', '2017-09-22 17:05:20', '2017-09-22 17:05:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922170737825582883472505335', '20170922155758751662910860438310', '2017/', '20170922170737822982198639262197.jpg', '泰和源.jpg', '1', '379644', null, '1', 'default', '2017-09-22 17:07:37', '2017-09-22 17:07:43', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922170742542822881241308776', '20170922155758751662910860438310', '2017/', '20170922170742516992230171489460.jpg', '生日.jpg', null, '238355', null, '1', 'default', '2017-09-22 17:07:42', '2017-09-22 17:07:43', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922171739732134888346370955', null, '2017/', '20170922171739727525634923248312.png', '微信截图_20170921192730.png', '9', '722394', null, '2', 'default', '2017-09-22 17:17:39', '2017-09-22 17:17:44', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922171740099997004517206915', null, '2017/', '20170922171740095884025781768282.png', '微信截图_20170921192736.png', '8', '917365', null, '2', 'default', '2017-09-22 17:17:40', '2017-09-22 17:17:44', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922171740389318746473063697', null, '2017/', '20170922171740386952688875366255.png', '微信截图_20170921192743.png', '7', '756735', null, '2', 'default', '2017-09-22 17:17:40', '2017-09-22 17:17:44', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922171740639404846957108128', null, '2017/', '20170922171740636622815916351769.png', '微信截图_20170921192754.png', '6', '689444', null, '2', 'default', '2017-09-22 17:17:40', '2017-09-22 17:17:44', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922171740994718306970589594', null, '2017/', '20170922171740990514473288549422.png', '微信截图_20170921192800.png', '5', '677265', null, '2', 'default', '2017-09-22 17:17:40', '2017-09-22 17:17:44', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922171741258484435509996740', null, '2017/', '20170922171741255925927756474559.png', '微信截图_20170921192807.png', '4', '633221', null, '2', 'default', '2017-09-22 17:17:41', '2017-09-22 17:17:44', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922171741610030914406028744', null, '2017/', '20170922171741606417676384297297.png', '微信截图_20170921192813.png', '3', '778177', null, '2', 'default', '2017-09-22 17:17:41', '2017-09-22 17:17:44', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922171741883443231099893232', null, '2017/', '20170922171741881813507843933119.png', '微信截图_20170921192820.png', '2', '682167', null, '2', 'default', '2017-09-22 17:17:41', '2017-09-22 17:17:44', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922171742167133302211290848', null, '2017/', '20170922171742164902815281354332.png', '微信截图_20170921192827.png', '1', '781285', null, '2', 'default', '2017-09-22 17:17:42', '2017-09-22 17:17:44', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170922171742503127356397397313', null, '2017/', '20170922171742500963189937159230.png', '微信截图_20170921192834.png', null, '923070', null, '2', 'default', '2017-09-22 17:17:42', '2017-09-22 17:17:44', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20170926104003551289570621185226', '20170926103923003853017209983477', '2017/', '20170926104003516071765340491270.png', '微信截图_20170921115202.png', '5', '70174', null, '1', 'default', '2017-09-26 10:40:03', '2017-09-26 10:40:05', '20170923171444523929901468294484', '20170923171444523929901468294484');
INSERT INTO `sys_attachment` VALUES ('20170926104003758498742051780551', '20170926103923003853017209983477', '2017/', '20170926104003756667182316069720.png', '微信截图_20170921135505.png', '4', '116437', null, '1', 'default', '2017-09-26 10:40:03', '2017-09-26 10:40:05', '20170923171444523929901468294484', '20170923171444523929901468294484');
INSERT INTO `sys_attachment` VALUES ('20170926104003913728196764530004', '20170926103923003853017209983477', '2017/', '20170926104003873435042347993630.png', '微信截图_20170921150905.png', '3', '84707', null, '1', 'default', '2017-09-26 10:40:03', '2017-09-26 10:40:05', '20170923171444523929901468294484', '20170923171444523929901468294484');
INSERT INTO `sys_attachment` VALUES ('20170926104004059301559536060040', '20170926103923003853017209983477', '2017/', '20170926104004045313144976392532.png', '微信截图_20170921151056.png', '2', '88267', null, '1', 'default', '2017-09-26 10:40:04', '2017-09-26 10:40:05', '20170923171444523929901468294484', '20170923171444523929901468294484');
INSERT INTO `sys_attachment` VALUES ('20170926104004189785238052541583', '20170926103923003853017209983477', '2017/', '20170926104004186551827040359898.png', '微信截图_20170921175223.png', '1', '57693', null, '1', 'default', '2017-09-26 10:40:04', '2017-09-26 10:40:05', '20170923171444523929901468294484', '20170923171444523929901468294484');
INSERT INTO `sys_attachment` VALUES ('20170926104004342517740398378125', '20170926103923003853017209983477', '2017/', '20170926104004339451565698466369.png', '微信截图_20170921182934.png', null, '50542', null, '1', 'default', '2017-09-26 10:40:04', '2017-09-26 10:40:05', '20170923171444523929901468294484', '20170923171444523929901468294484');
INSERT INTO `sys_attachment` VALUES ('20171014165249438666141233597071', '20171014165251008459951743489247', '2017/', '20171014165249393534635017167424.jpg', '天和采购单示例.jpg', null, '142007', null, '1', 'default', '2017-10-14 16:52:49', '2017-10-14 16:52:51', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171016091029809375980919789485', null, null, '20171016091029805403567250479632.jpg', '天和采购单示例.jpg', null, '142007', null, '0', null, '2017-10-16 09:10:29', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171016091508303234433071465904', null, null, '20171016091508300360133946823376.jpg', '天和采购单示例.jpg', null, '142007', null, '0', null, '2017-10-16 09:15:08', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171016091624869745905617566275', null, null, '20171016091624865098805177289487.jpg', '天和采购单示例.jpg', null, '142007', null, '0', null, '2017-10-16 09:16:24', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171016092805509228002814613801', null, null, '20171016092805481903718143627959.jpg', '天和采购单示例.jpg', null, '142007', null, '0', null, '2017-10-16 09:28:05', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171016094300114090526848811466', '20171016094309465163388680954678', '2017/', '20171016094300100663619858587679.jpg', '天和采购单示例.jpg', null, '142007', null, '1', 'default', '2017-10-16 09:43:00', '2017-10-16 09:43:09', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171020141833172613983316219797', null, '2017/', '20171020141833127595281773080158.jpg', 'u=3427041618,3123579981&fm=27&gp=0.jpg', '3', '17727', null, '2', 'default', '2017-10-20 14:18:33', '2017-10-20 14:18:42', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171020141833317270515292480812', null, '2017/', '20171020141833315680538298054410.jpg', 'u=4210012142,1354914358&fm=27&gp=0.jpg', '2', '15328', null, '2', 'default', '2017-10-20 14:18:33', '2017-10-20 14:18:42', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171020141838580272126199254437', null, '2017/', '20171020141838577697963053825110.jpg', 'u=2764064144,1935905132&fm=27&gp=0.jpg', '1', '16159', null, '2', 'default', '2017-10-20 14:18:38', '2017-10-20 14:18:42', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171020141838737331726676766410', null, '2017/', '20171020141838736740988457609748.jpg', 'u=3962903050,3545548278&fm=27&gp=0.jpg', null, '49486', null, '2', 'default', '2017-10-20 14:18:38', '2017-10-20 14:18:42', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171020144121970846167886999731', null, null, '20171020144121968879909476511041.jpg', 'TB21DrPclUSMeJjSszeXXcKgpXa_!!726907174.jpg', null, '399516', null, '0', null, '2017-10-20 14:41:21', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171020144235133383438665158842', null, null, '20171020144235131090889560348116.jpg', 'TB2nbTScbwTMeJjSszfXXXbtFXa_!!726907174.jpg', null, '644801', null, '0', null, '2017-10-20 14:42:35', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171020144235435884209228195850', null, null, '20171020144235434234422153199654.jpg', 'TB2Qx6RclUSMeJjSspfXXX0VFXa_!!726907174.jpg', null, '485669', null, '0', null, '2017-10-20 14:42:35', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171020144235616698752497356982', null, null, '20171020144235614326154787025125.jpg', 'TB2Bv8meo3IL1JjSZFMXXajrFXa_!!726907174.jpg', null, '125341', null, '0', null, '2017-10-20 14:42:35', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171020144703785012226746643349', null, '2017/', '20171020144703783482682206456987.jpg', 'TB2nbTScbwTMeJjSszfXXXbtFXa_!!726907174.jpg', '3', '644801', null, '2', 'default', '2017-10-20 14:47:03', '2017-10-20 14:47:10', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171020144704134445952892743271', null, '2017/', '20171020144704132369442219744116.jpg', 'TB2Qx6RclUSMeJjSspfXXX0VFXa_!!726907174.jpg', '2', '485669', null, '2', 'default', '2017-10-20 14:47:04', '2017-10-20 14:47:10', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171020144704492886170362359724', null, '2017/', '20171020144704490768020194131349.jpg', 'TB21DrPclUSMeJjSszeXXcKgpXa_!!726907174.jpg', '1', '399516', null, '2', 'default', '2017-10-20 14:47:04', '2017-10-20 14:47:10', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171020144704675589838293960172', null, '2017/', '20171020144704672825288950684587.jpg', 'TB2Bv8meo3IL1JjSZFMXXajrFXa_!!726907174.jpg', null, '125341', null, '2', 'default', '2017-10-20 14:47:04', '2017-10-20 14:47:10', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171020170549389455571707902754', null, '2017/', '20171020170549358622287486768547.jpg', 'TB2Tqb.aWmgSKJjSsplXXaICpXa_!!2261855709.jpg', '5', '171025', null, '2', 'default', '2017-10-20 17:05:49', '2017-10-20 17:05:57', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171020170552686141997395092465', null, '2017/', '20171020170552682514421227570904.jpg', 'TB2lGT9a6uhSKJjSspdXXc11XXa_!!2261855709.jpg', '4', '117624', null, '2', 'default', '2017-10-20 17:05:52', '2017-10-20 17:05:57', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171020170552973929328056137345', null, '2017/', '20171020170552971460522963551912.jpg', 'TB22cYPqUQIL1JjSZFhXXaDZFXa_!!2261855709.jpg', '3', '219031', null, '2', 'default', '2017-10-20 17:05:52', '2017-10-20 17:05:57', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171020170553138020716011823421', null, '2017/', '20171020170553136381788960412081.jpg', 'TB26V8pavBNTKJjSszeXXcu2VXa_!!2261855709.jpg', '2', '197124', null, '2', 'default', '2017-10-20 17:05:53', '2017-10-20 17:05:57', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171020170553372002631961289670', null, '2017/', '20171020170553369473859126696065.jpg', 'TB2q.JofbsTMeJjy1zeXXcOCVXa_!!2261855709.jpg', '1', '165918', null, '2', 'default', '2017-10-20 17:05:53', '2017-10-20 17:05:57', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171020170553841489335225940082', null, '2017/', '20171020170553839220436736594564.jpg', 'TB2jX4pavBNTKJjSszeXXcu2VXa_!!2261855709.jpg', null, '241064', null, '2', 'default', '2017-10-20 17:05:53', '2017-10-20 17:05:57', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021093326248079441854251837', null, null, '20171021093326235354234628588298.jpg', 'TB2Qx6RclUSMeJjSspfXXX0VFXa_!!726907174.jpg', null, '485669', null, '0', null, '2017-10-21 09:33:26', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171021093326436032493001371193', null, null, '20171021093326432998416693862392.jpg', 'TB21DrPclUSMeJjSszeXXcKgpXa_!!726907174.jpg', null, '399516', null, '0', null, '2017-10-21 09:33:26', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171021093326554968678683925388', null, null, '20171021093326532585148849400006.jpg', 'TB2Bv8meo3IL1JjSZFMXXajrFXa_!!726907174.jpg', null, '125341', null, '0', null, '2017-10-21 09:33:26', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171021093414461443305264921233', null, '2017/', '20171021093414458829662827919525.jpg', 'TB2nbTScbwTMeJjSszfXXXbtFXa_!!726907174.jpg', '11', '644801', null, '2', 'default', '2017-10-21 09:34:14', '2017-10-21 09:34:30', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021093428424406502065856034', null, '2017/', '20171021093428421627016673903362.jpg', 'TB2lGT9a6uhSKJjSspdXXc11XXa_!!2261855709.jpg', '10', '117624', null, '2', 'default', '2017-10-21 09:34:28', '2017-10-21 09:34:30', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021093501047413000659775933', '20170922165937277224378358837932', '2017/', '20171021093501039136479952070082.jpg', 'TB2jX4pavBNTKJjSszeXXcu2VXa_!!2261855709.jpg', '12', '241064', null, '1', 'default', '2017-10-21 09:35:01', '2017-10-21 09:35:02', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021093501354494533210248604', '20170922165937277224378358837932', '2017/', '20171021093501345683588156117214.jpg', 'TB2nbTScbwTMeJjSszfXXXbtFXa_!!726907174.jpg', '11', '644801', null, '1', 'default', '2017-10-21 09:35:01', '2017-10-21 09:35:02', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021093501522295221851579134', '20170922165937277224378358837932', '2017/', '20171021093501506260924885373480.jpg', 'TB2Qx6RclUSMeJjSspfXXX0VFXa_!!726907174.jpg', '10', '485669', null, '1', 'default', '2017-10-21 09:35:01', '2017-10-21 09:35:02', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021093501716746520043013424', '20170922165937277224378358837932', '2017/', '20171021093501712769772246584097.jpg', 'TB21DrPclUSMeJjSszeXXcKgpXa_!!726907174.jpg', '9', '399516', null, '1', 'default', '2017-10-21 09:35:01', '2017-10-21 09:35:02', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021093528697567153434619232', '20170922165751042747443964724774', '2017/', '20171021093528691349596387170671.jpg', 'TB2Tqb.aWmgSKJjSsplXXaICpXa_!!2261855709.jpg', '11', '171025', null, '1', 'default', '2017-10-21 09:35:28', '2017-10-21 09:35:30', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021093528890058180024660824', '20170922165751042747443964724774', '2017/', '20171021093528884199893501540303.jpg', 'TB2jX4pavBNTKJjSszeXXcu2VXa_!!2261855709.jpg', '10', '241064', null, '1', 'default', '2017-10-21 09:35:28', '2017-10-21 09:35:30', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021093610529629243877938370', '20170922164753384264999000703592', '2017/', '20171021093610522244271741815223.jpg', 'TB21DrPclUSMeJjSszeXXcKgpXa_!!726907174.jpg', '6', '399516', null, '1', 'default', '2017-10-21 09:36:10', '2017-10-21 09:36:11', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021093610700025616122603383', '20170922164753384264999000703592', '2017/', '20171021093610695985905823460280.jpg', 'TB2W3ZIiXXXXXXMXFXXXXXXXXXX_!!2707338231.jpg', '5', '164906', null, '1', 'default', '2017-10-21 09:36:10', '2017-10-21 09:36:11', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021093625375315572558155758', '20170922164348366833637124707254', '2017/', '20171021093625367531247434321104.jpg', 'TB2Tqb.aWmgSKJjSsplXXaICpXa_!!2261855709.jpg', '10', '171025', null, '1', 'default', '2017-10-21 09:36:25', '2017-10-21 09:36:26', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021093625521261467148804492', '20170922164348366833637124707254', '2017/', '20171021093625515669148991568123.jpg', 'TB2jX4pavBNTKJjSszeXXcu2VXa_!!2261855709.jpg', '9', '241064', null, '1', 'default', '2017-10-21 09:36:25', '2017-10-21 09:36:26', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021093625745959522246775164', '20170922164348366833637124707254', '2017/', '20171021093625738309827696413123.jpg', 'TB2nbTScbwTMeJjSszfXXXbtFXa_!!726907174.jpg', '8', '644801', null, '1', 'default', '2017-10-21 09:36:25', '2017-10-21 09:36:26', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021093625949841637542658247', '20170922164348366833637124707254', '2017/', '20171021093625931357349361783546.jpg', 'TB2Qx6RclUSMeJjSspfXXX0VFXa_!!726907174.jpg', '7', '485669', null, '1', 'default', '2017-10-21 09:36:25', '2017-10-21 09:36:26', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021111208724011600012622123', null, '2017/', '20171021111208718926605587777160.jpg', 'TB2nbTScbwTMeJjSszfXXXbtFXa_!!726907174.jpg', '5', '644801', null, '2', 'default', '2017-10-21 11:12:08', '2017-10-21 11:12:18', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021111215748533667454856094', null, '2017/', '20171021111215742574751590454395.jpg', 'TB2lGT9a6uhSKJjSspdXXc11XXa_!!2261855709.jpg', '4', '117624', null, '2', 'default', '2017-10-21 11:12:15', '2017-10-21 11:12:18', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021111216055360879311057061', null, '2017/', '20171021111216051115724891983906.jpg', 'TB2Tqb.aWmgSKJjSsplXXaICpXa_!!2261855709.jpg', '3', '171025', null, '2', 'default', '2017-10-21 11:12:16', '2017-10-21 11:12:18', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021111216481840556008193423', null, '2017/', '20171021111216474965419867222716.jpg', 'TB2nbTScbwTMeJjSszfXXXbtFXa_!!726907174.jpg', '2', '644801', null, '2', 'default', '2017-10-21 11:12:16', '2017-10-21 11:12:18', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021112408749357818931193953', null, '2017/', '20171021112408746186718850995771.jpg', 'TB2kqXhipXXXXXFXXXXXXXXXXXX_!!2707338231.jpg', '6', '135167', null, '2', 'default', '2017-10-21 11:24:08', '2017-10-21 11:24:11', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021112408992097917903884776', null, '2017/', '20171021112408989422340848831233.gif', '58c784d0Neb3e7b5b.gif', '5', '299573', null, '2', 'default', '2017-10-21 11:24:08', '2017-10-21 11:24:11', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021112409156102554183016644', null, '2017/', '20171021112409152289372612380710.jpg', '5657eec4N3a322979.jpg', '4', '192681', null, '2', 'default', '2017-10-21 11:24:09', '2017-10-21 11:24:11', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171021112409384936004936809215', null, '2017/', '20171021112409382021849866228000.jpg', '59c8a610N0ed0d66a.jpg', '3', '322297', null, '2', 'default', '2017-10-21 11:24:09', '2017-10-21 11:24:11', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024144107191784199434896723', '20171020170557715117684770670802', '2017/', '20171024144107097812800343429849.jpg', 'TB26V8pavBNTKJjSszeXXcu2VXa_!!2261855709.jpg', '12', '197124', null, '1', 'default', '2017-10-24 14:41:07', '2017-10-24 14:41:18', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024144112493393052535158037', '20171020170557715117684770670802', '2017/', '20171024144112491268439778457103.jpg', 'TB2lGT9a6uhSKJjSspdXXc11XXa_!!2261855709.jpg', '11', '117624', null, '1', 'default', '2017-10-24 14:41:12', '2017-10-24 14:41:18', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024144112680241170474808519', '20171020170557715117684770670802', '2017/', '20171024144112678846004194310451.jpg', 'TB22cYPqUQIL1JjSZFhXXaDZFXa_!!2261855709.jpg', '10', '219031', null, '1', 'default', '2017-10-24 14:41:12', '2017-10-24 14:41:18', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024144113026140388607041699', '20171020170557715117684770670802', '2017/', '20171024144113008343989141456437.jpg', 'TB26V8pavBNTKJjSszeXXcu2VXa_!!2261855709.jpg', '9', '197124', null, '1', 'default', '2017-10-24 14:41:13', '2017-10-24 14:41:18', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024144113239674736721689313', '20171020170557715117684770670802', '2017/', '20171024144113237626788664111159.jpg', 'TB2q.JofbsTMeJjy1zeXXcOCVXa_!!2261855709.jpg', '8', '165918', null, '1', 'default', '2017-10-24 14:41:13', '2017-10-24 14:41:18', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024144113820171849029635468', '20171020170557715117684770670802', '2017/', '20171024144113815308035764182887.jpg', 'TB2Tqb.aWmgSKJjSsplXXaICpXa_!!2261855709.jpg', '7', '171025', null, '1', 'default', '2017-10-24 14:41:13', '2017-10-24 14:41:18', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024144114348046792147396466', '20171020170557715117684770670802', '2017/', '20171024144114340554418670955744.jpg', 'TB2jX4pavBNTKJjSszeXXcu2VXa_!!2261855709.jpg', '6', '241064', null, '1', 'default', '2017-10-24 14:41:14', '2017-10-24 14:41:18', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024144129767918049588653063', '20171020143937478702840762092955', '2017/', '20171024144129764908517182772461.jpg', 'TB21DrPclUSMeJjSszeXXcKgpXa_!!726907174.jpg', '8', '399516', null, '1', 'default', '2017-10-24 14:41:29', '2017-10-24 14:41:40', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024144137117062045007385621', '20171020143937478702840762092955', '2017/', '20171024144137112696568338747112.jpg', 'TB2nbTScbwTMeJjSszfXXXbtFXa_!!726907174.jpg', '7', '644801', null, '1', 'default', '2017-10-24 14:41:37', '2017-10-24 14:41:40', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024144137561192503886588174', '20171020143937478702840762092955', '2017/', '20171024144137558432548409162369.jpg', 'TB2Qx6RclUSMeJjSspfXXX0VFXa_!!726907174.jpg', '6', '485669', null, '1', 'default', '2017-10-24 14:41:37', '2017-10-24 14:41:40', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024144137737038249148331148', '20171020143937478702840762092955', '2017/', '20171024144137735405150718146447.jpg', 'TB21DrPclUSMeJjSszeXXcKgpXa_!!726907174.jpg', '5', '399516', null, '1', 'default', '2017-10-24 14:41:37', '2017-10-24 14:41:40', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024144137917230104456440667', '20171020143937478702840762092955', '2017/', '20171024144137915647957963323603.jpg', 'TB2Bv8meo3IL1JjSZFMXXajrFXa_!!726907174.jpg', '4', '125341', null, '1', 'default', '2017-10-24 14:41:37', '2017-10-24 14:41:40', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024152033301702250172211249', '20171024152040666846121282909024', '2017/', '20171024152033292966724892134943.jpg', 'TB2HkL0btPJ3eJjSZFLXXab3FXa_!!685140573.jpg', '7', '383542', null, '1', 'default', '2017-10-24 15:20:33', '2017-10-24 15:20:40', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024152037882152655003953322', '20171024152040666846121282909024', '2017/', '20171024152037749707233764397399.png', 'TB2pFzXfYVkpuFjSspcXXbSMVXa-685140573.png', '6', '272247', null, '1', 'default', '2017-10-24 15:20:37', '2017-10-24 15:20:40', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024152038698671635148418133', '20171024152040666846121282909024', '2017/', '20171024152038106321465123259134.jpg', 'TB2mAdWgXXXXXbHXXXXXXXXXXXX-685140573.jpg', '5', '48447', null, '1', 'default', '2017-10-24 15:20:38', '2017-10-24 15:20:40', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024152038916214956306191660', '20171024152040666846121282909024', '2017/', '20171024152038839846030384731570.jpg', 'TB2Er.ghjlxYKJjSZFuXXaYlVXa_!!685140573.jpg', '4', '145160', null, '1', 'default', '2017-10-24 15:20:38', '2017-10-24 15:20:40', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024152039305038928653100243', '20171024152040666846121282909024', '2017/', '20171024152039143673529744105401.jpg', 'TB2.VXZr50TMKJjSZFNXXa_1FXa_!!685140573.jpg', '3', '301644', null, '1', 'default', '2017-10-24 15:20:39', '2017-10-24 15:20:40', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024152039467674310250938325', '20171024152040666846121282909024', '2017/', '20171024152039460741492503970307.jpg', 'TB2WvNQpgn.PuJjSZFkXXc_lpXa_!!685140573.jpg', '2', '177296', null, '1', 'default', '2017-10-24 15:20:39', '2017-10-24 15:20:40', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024152039722743019855625338', '20171024152040666846121282909024', '2017/', '20171024152039716466768209307019.jpg', 'TB2mhcnk.1HTKJjSZFmXXXeYFXa_!!685140573.jpg', '1', '320308', null, '1', 'default', '2017-10-24 15:20:39', '2017-10-24 15:20:40', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024152040037008327305792539', '20171024152040666846121282909024', '2017/', '20171024152040031096963575855079.jpg', 'TB2ecgKjI2vU1JjSZFwXXX2cpXa_!!685140573.jpg', null, '83940', null, '1', 'default', '2017-10-24 15:20:40', '2017-10-24 15:20:40', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024171944043036609920644441', null, '2017/', '20171024171944038115311863174894.jpg', 'TB2.VXZr50TMKJjSZFNXXa_1FXa_!!685140573.jpg', '10', '301644', null, '2', 'default', '2017-10-24 17:19:44', '2017-10-24 17:19:46', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024171944349097444190241798', null, '2017/', '20171024171944346724162048812161.jpg', 'TB2HkL0btPJ3eJjSZFLXXab3FXa_!!685140573.jpg', '9', '383542', null, '2', 'default', '2017-10-24 17:19:44', '2017-10-24 17:19:46', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024171944579770471344791417', null, '2017/', '20171024171944576464601243422570.jpg', 'TB26V8pavBNTKJjSszeXXcu2VXa_!!2261855709.jpg', '8', '197124', null, '2', 'default', '2017-10-24 17:19:44', '2017-10-24 17:19:46', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024171944935691624487006223', null, '2017/', '20171024171944932320281159349073.jpg', 'TB21DrPclUSMeJjSszeXXcKgpXa_!!726907174.jpg', '7', '399516', null, '2', 'default', '2017-10-24 17:19:44', '2017-10-24 17:19:46', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024171945112316842914923597', null, '2017/', '20171024171945107495278072841765.jpg', 'TB29_.NiXXXXXcBXpXXXXXXXXXX_!!2707338231.jpg', '6', '144003', null, '2', 'default', '2017-10-24 17:19:45', '2017-10-24 17:19:46', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024171945371893806789668474', null, '2017/', '20171024171945367107787537492751.jpg', '59c8a5feN1af0ffd7.jpg', '5', '272246', null, '2', 'default', '2017-10-24 17:19:45', '2017-10-24 17:19:46', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024171945510692144170031716', null, '2017/', '20171024171945505682021672296822.jpg', 'u=582920832,2235243092&fm=27&gp=0.jpg', '4', '9824', null, '2', 'default', '2017-10-24 17:19:45', '2017-10-24 17:19:46', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024172040133129910214309499', '20171020141842757704681968303771', '2017/', '20171024172040131523244513196590.png', 'TB2pFzXfYVkpuFjSspcXXbSMVXa-685140573.png', '4', '272247', null, '1', 'default', '2017-10-24 17:20:40', '2017-10-24 17:20:41', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024172100102730039839927649', '20171020141842757704681968303771', '2017/', '20171024172100098858565507567636.jpg', 'u=2764064144,1935905132&fm=27&gp=0.jpg', '6', '16159', null, '1', 'default', '2017-10-24 17:21:00', '2017-10-24 17:21:04', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024172100221236017910628309', '20171020141842757704681968303771', '2017/', '20171024172100219897895995697416.jpg', 'u=3962903050,3545548278&fm=27&gp=0.jpg', '5', '49486', null, '1', 'default', '2017-10-24 17:21:00', '2017-10-24 17:21:04', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024172100338777526125772792', '20171020141842757704681968303771', '2017/', '20171024172100334384463526155655.jpg', 'u=3427041618,3123579981&fm=27&gp=0.jpg', '4', '17727', null, '1', 'default', '2017-10-24 17:21:00', '2017-10-24 17:21:04', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024172100478189298257481806', '20171020141842757704681968303771', '2017/', '20171024172100474349579821183491.jpg', 'u=4210012142,1354914358&fm=27&gp=0.jpg', '3', '15328', null, '1', 'default', '2017-10-24 17:21:00', '2017-10-24 17:21:04', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024172100607415266374618576', '20171020141842757704681968303771', '2017/', '20171024172100602362581120607846.jpg', 'u=2340559760,775414142&fm=27&gp=0.jpg', '2', '17188', null, '1', 'default', '2017-10-24 17:21:00', '2017-10-24 17:21:04', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024172100691416317052189846', '20171020141842757704681968303771', '2017/', '20171024172100686164644792241749.jpg', 'u=81144390,3556002024&fm=27&gp=0.jpg', '1', '22628', null, '1', 'default', '2017-10-24 17:21:00', '2017-10-24 17:21:04', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024172543107967831168450987', '20171024172548067546195026358174', '2017/', '20171024172543100521768597928839.jpg', 'TB2jwTbhWagSKJjy0FhXXcrbFXa_!!2932942277.jpg', '3', '271734', null, '1', 'default', '2017-10-24 17:25:43', '2017-10-24 17:25:48', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024172543617697680425707627', '20171024172548067546195026358174', '2017/', '20171024172543613984878998897123.jpg', 'TB2ZDH0mWmWQ1JjSZPhXXXCJFXa_!!2932942277.jpg', '2', '327132', null, '1', 'default', '2017-10-24 17:25:43', '2017-10-24 17:25:48', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024172544223946472862833514', '20171024172548067546195026358174', '2017/', '20171024172544215231931380330410.jpg', 'TB2EhbGdn1z01JjSZFCXXXY.XXa_!!2932942277.jpg', '1', '749995', null, '1', 'default', '2017-10-24 17:25:44', '2017-10-24 17:25:48', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024172544863173457592014039', '20171024172548067546195026358174', '2017/', '20171024172544860651812833107149.jpg', 'TB2FVq2qy0TMKJjSZFNXXa_1FXa_!!2932942277.jpg', null, '1069699', null, '1', 'default', '2017-10-24 17:25:44', '2017-10-24 17:25:48', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024172850817221811315626001', '20171024172852789370734026677867', '2017/', '20171024172850812716265762208082.jpg', 'TB1Nnz0flcHL1JjSZFBXXaiGXXa_!!0-item_pic.jpg_b.jpg', null, '15765', null, '1', 'default', '2017-10-24 17:28:50', '2017-10-24 17:28:53', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173127055206797391904479', '20171024173129164418909766552237', '2017/', '20171024173127050286082772548664.jpg', 'TB2pvjwdrFkpuFjy1XcXXclapXa_!!1907247938.jpg', '3', '127107', null, '1', 'default', '2017-10-24 17:31:27', '2017-10-24 17:31:29', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173127210660240195075550', '20171024173129164418909766552237', '2017/', '20171024173127205487657952207197.jpg', 'TB20WsqebJmpuFjSZFwXXaE4VXa_!!1907247938.jpg', '2', '110231', null, '1', 'default', '2017-10-24 17:31:27', '2017-10-24 17:31:29', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173127360365452425160920', '20171024173129164418909766552237', '2017/', '20171024173127355252625922682882.jpg', 'TB2d5iQawJlpuFjSspjXXcT.pXa_!!1907247938.jpg', '1', '185498', null, '1', 'default', '2017-10-24 17:31:27', '2017-10-24 17:31:29', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173127513790389681989011', '20171024173129164418909766552237', '2017/', '20171024173127510036323843450961.jpg', 'TB25qYjdB0kpuFjy1zdXXXuUVXa_!!1907247938.jpg', null, '168093', null, '1', 'default', '2017-10-24 17:31:27', '2017-10-24 17:31:29', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173315172771182416635332', '20171024173323063359142148168544', '2017/', '20171024173315169876830983669620.jpg', 'TB2yPvIeb1K.eBjSsphXXcJOXXa_!!133708381.jpg', '4', '440982', null, '1', 'default', '2017-10-24 17:33:15', '2017-10-24 17:33:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173319742596733048931515', '20171024173323063359142148168544', '2017/', '20171024173319737453123819233958.jpg', 'TB2SnPUemKI.eBjy1zcXXXIOpXa_!!133708381.jpg', '3', '449023', null, '1', 'default', '2017-10-24 17:33:19', '2017-10-24 17:33:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173320009374120109371099', '20171024173323063359142148168544', '2017/', '20171024173320006724047284549175.jpg', 'TB2iJTJeheI.eBjSsplXXX6GFXa_!!133708381.jpg', '2', '436003', null, '1', 'default', '2017-10-24 17:33:20', '2017-10-24 17:33:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173320262837641666593808', '20171024173323063359142148168544', '2017/', '20171024173320260908490968703077.jpg', 'TB2KR1KaI2DjeFjSspnXXb20XXa_!!133708381.jpg', '1', '433468', null, '1', 'default', '2017-10-24 17:33:20', '2017-10-24 17:33:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173321553692619537831585', '20171024173323063359142148168544', '2017/', '20171024173320797742153979987408.jpg', 'TB2yPvIeb1K.eBjSsphXXcJOXXa_!!133708381.jpg', null, '440982', null, '1', 'default', '2017-10-24 17:33:21', '2017-10-24 17:33:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173718646295374817325190', '20171024173746518084596390323875', '2017/', '20171024173718642352764744172841.jpg', 'TB2AdRFfNlmpuFjSZPfXXc9iXXa_!!898571545.jpg', '2', '216679', null, '1', 'default', '2017-10-24 17:37:18', '2017-10-24 17:37:46', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173721396442966921806304', '20171024173746518084596390323875', '2017/', '20171024173721392451458536109233.jpg', 'TB2QjrRk3xlpuFjSszgXXcJdpXa_!!898571545.jpg', '1', '77150', null, '1', 'default', '2017-10-24 17:37:21', '2017-10-24 17:37:46', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173721652750209560624060', '20171024173746518084596390323875', '2017/', '20171024173721648391168048001415.jpg', 'TB2ZR0jeMJlpuFjSspjXXcT.pXa_!!898571545.jpg', null, '242234', null, '1', 'default', '2017-10-24 17:37:21', '2017-10-24 17:37:46', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173943432528234108065704', '20171024174001040202280272054699', '2017/', '20171024173943426432340347897684.jpg', 'TB2O2H_bOb_F1JjSZFzXXc6KXXa_!!1613434166.jpg', '2', '209275', null, '1', 'default', '2017-10-24 17:39:43', '2017-10-24 17:40:01', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173950876197985435918657', '20171024174001040202280272054699', '2017/', '20171024173950870565606489398333.jpg', 'TB2z.rWbS_9F1JjSZFrXXcrVFXa_!!1613434166.jpg', '1', '302938', null, '1', 'default', '2017-10-24 17:39:50', '2017-10-24 17:40:01', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024173951351847363109888602', '20171024174001040202280272054699', '2017/', '20171024173951159748157345192297.jpg', 'TB2XQxnaJqgF1JjSsziXXXL.XXa_!!1613434166.jpg', null, '303916', null, '1', 'default', '2017-10-24 17:39:51', '2017-10-24 17:40:01', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024174158198944825018255684', '20171024174201734162792776406068', '2017/', '20171024174158155153263313771798.jpg', 'TB2Xx0FaEdnpuFjSZPhXXbChpXa_!!2095351240.jpg', '4', '157254', null, '1', 'default', '2017-10-24 17:41:58', '2017-10-24 17:42:01', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024174158361179528520169487', '20171024174201734162792776406068', '2017/', '20171024174158358554895765506706.jpg', 'TB2a9xFaEhnpuFjSZFpXXcpuXXa_!!2095351240.jpg', '3', '243862', null, '1', 'default', '2017-10-24 17:41:58', '2017-10-24 17:42:01', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024174158598892951782943728', '20171024174201734162792776406068', '2017/', '20171024174158548194560394546400.jpg', 'TB2WPdFastnpuFjSZFKXXalFFXa_!!2095351240.jpg', '2', '160985', null, '1', 'default', '2017-10-24 17:41:58', '2017-10-24 17:42:01', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024174158711020904884431274', '20171024174201734162792776406068', '2017/', '20171024174158707169152384114420.jpg', 'TB2IT8VadmgF1Jjy1XaXXcSEFXa_!!2095351240.jpg', '1', '81390', null, '1', 'default', '2017-10-24 17:41:58', '2017-10-24 17:42:01', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024174158862499323863962722', '20171024174201734162792776406068', '2017/', '20171024174158857071380091993749.jpg', 'TB2R8FGaEhnpuFjSZFEXXX0PFXa_!!2095351240.jpg', null, '178972', null, '1', 'default', '2017-10-24 17:41:58', '2017-10-24 17:42:01', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024174407561850627136196436', '20171024174410113198261330319674', '2017/', '20171024174407555228691423050499.jpg', 'TB2RXe4XLTJXuFjSspeXXapipXa-420567757.jpg', '4', '534030', null, '1', 'default', '2017-10-24 17:44:07', '2017-10-24 17:44:10', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024174407821143964978738715', '20171024174410113198261330319674', '2017/', '20171024174407815411874327959504.jpg', 'TB2p_0pab1J.eBjSspnXXbUeXXa-420567757.jpg', '3', '414614', null, '1', 'default', '2017-10-24 17:44:07', '2017-10-24 17:44:10', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024174408113029442746523811', '20171024174410113198261330319674', '2017/', '20171024174408074036528640227767.jpg', 'TB2AAzBaheK.eBjSZFlXXaywXXa-420567757.jpg', '2', '248165', null, '1', 'default', '2017-10-24 17:44:08', '2017-10-24 17:44:10', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024174408438599869148856454', '20171024174410113198261330319674', '2017/', '20171024174408427817703814339152.jpg', 'TB21FFtabOJ.eBjy1XaXXbNupXa-420567757.jpg', '1', '394808', null, '1', 'default', '2017-10-24 17:44:08', '2017-10-24 17:44:10', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171024174408625950164050988301', '20171024174410113198261330319674', '2017/', '20171024174408621463145632686057.jpg', 'TB28VrzaiGO.eBjSZFjXXcU9FXa-420567757.jpg', null, '156216', null, '1', 'default', '2017-10-24 17:44:08', '2017-10-24 17:44:10', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025102933994391759128193878', '20171025102953587208765305615398', '2017/', '20171025102933858500663869785347.jpg', 'TB2WAipbaagSKJjy0FgXXcRqFXa_!!3175325124.jpg', '4', '342519', null, '1', 'default', '2017-10-25 10:29:33', '2017-10-25 10:29:54', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025102941169088344749808451', '20171025102953587208765305615398', '2017/', '20171025102941165964539822283503.jpg', 'TB21DAPiXcJL1JjSZFOXXcWlXXa_!!3175325124.jpg', '3', '370550', null, '1', 'default', '2017-10-25 10:29:41', '2017-10-25 10:29:54', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025102941366444768161137178', '20171025102953587208765305615398', '2017/', '20171025102941363322148222697159.jpg', 'TB2yhxXiC3PL1JjSZFtXXclRVXa_!!3175325124.jpg', '2', '306956', null, '1', 'default', '2017-10-25 10:29:41', '2017-10-25 10:29:54', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025102941566091651102364203', '20171025102953587208765305615398', '2017/', '20171025102941563323531995174382.jpg', 'TB2IY2xfgMPMeJjy1XdXXasrXXa_!!3175325124.jpg', '1', '195820', null, '1', 'default', '2017-10-25 10:29:41', '2017-10-25 10:29:54', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025102941830153708656649848', '20171025102953587208765305615398', '2017/', '20171025102941767848961811719699.jpg', 'TB2zUq9dGmWQ1JjSZPhXXXCJFXa_!!3175325124.jpg', null, '487131', null, '1', 'default', '2017-10-25 10:29:41', '2017-10-25 10:29:54', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025103237027801215068441540', '20171025103239036293356146737021', '2017/', '20171025103237025223794583540223.jpg', 'TB2jHR.kUQIL1JjSZFhXXaDZFXa_!!2072092771.jpg', '2', '366227', null, '1', 'default', '2017-10-25 10:32:37', '2017-10-25 10:32:39', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025103237196336452720429903', '20171025103239036293356146737021', '2017/', '20171025103237193775654488648377.jpg', 'TB2lcNdcuKAUKJjSZFzXXXdQFXa_!!2072092771.jpg', '1', '226174', null, '1', 'default', '2017-10-25 10:32:37', '2017-10-25 10:32:39', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025103237439338452913988581', '20171025103239036293356146737021', '2017/', '20171025103237436957919426906172.jpg', 'TB2mSo4j.l7MKJjSZFDXXaOEpXa_!!2072092771.jpg', null, '476656', null, '1', 'default', '2017-10-25 10:32:37', '2017-10-25 10:32:39', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025143357946740307626660652', '20171025143541496658690956288136', '2017/', '20171025143357937174865016840851.jpg', 'TB2mSo4j.l7MKJjSZFDXXaOEpXa_!!2072092771.jpg', null, '476656', null, '1', 'default', '2017-10-25 14:33:57', '2017-10-25 14:35:41', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025143554680284757203926796', '20171025143541496658690956288136', '2017/', '20171025143554483571627637915453.jpg', 'TB2jHR.kUQIL1JjSZFhXXaDZFXa_!!2072092771.jpg', '3', '366227', null, '1', 'default', '2017-10-25 14:35:54', '2017-10-25 14:35:56', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025143554865952844584250317', '20171025143541496658690956288136', '2017/', '20171025143554860650376690781869.jpg', 'TB2lcNdcuKAUKJjSZFzXXXdQFXa_!!2072092771.jpg', '2', '226174', null, '1', 'default', '2017-10-25 14:35:54', '2017-10-25 14:35:56', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025143555104796346584205765', '20171025143541496658690956288136', '2017/', '20171025143555102242085396645478.jpg', 'TB21DAPiXcJL1JjSZFOXXcWlXXa_!!3175325124.jpg', '1', '370550', null, '1', 'default', '2017-10-25 14:35:55', '2017-10-25 14:35:56', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025170518721209671754153093', '20170922171744928951383856667403', '2017/', '20171025170518686978565789134977.jpg', 'TB25aSutVXXXXavXpXXXXXXXXXX_!!792583507.jpg', '7', '411007', null, '1', 'default', '2017-10-25 17:05:18', '2017-10-25 17:05:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025170518977345324948685632', '20170922171744928951383856667403', '2017/', '20171025170518968341380649016493.jpg', 'TB2j09jtVXXXXbKXpXXXXXXXXXX_!!792583507.jpg', '6', '425811', null, '1', 'default', '2017-10-25 17:05:18', '2017-10-25 17:05:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025170521352617730913791338', '20170922171744928951383856667403', '2017/', '20171025170521344232085289999569.jpg', 'TB2egidtVXXXXctXpXXXXXXXXXX_!!792583507.jpg', '5', '440795', null, '1', 'default', '2017-10-25 17:05:21', '2017-10-25 17:05:23', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171025170521590567036946280332', '20170922171744928951383856667403', '2017/', '20171025170521587242589024250180.jpg', 'TB2sPndtVXXXXXwXXXXXXXXXXXX_!!792583507.jpg', '4', '210627', null, '1', 'default', '2017-10-25 17:05:21', '2017-10-25 17:05:22', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20171027102939143604783271142346', '20171027102942939666957140718059', '2017/', '20171027102939120204229154652420.jpg', 'TB25aSutVXXXXavXpXXXXXXXXXX_!!792583507.jpg', '4', '411007', null, '1', 'default', '2017-10-27 10:29:39', '2017-10-27 10:29:43', '20171027102652458235566336543814', '20171027102652458235566336543814');
INSERT INTO `sys_attachment` VALUES ('20171027102939480877958198437068', '20171027102942939666957140718059', '2017/', '20171027102939477683479790304567.jpg', 'TB2j09jtVXXXXbKXpXXXXXXXXXX_!!792583507.jpg', '3', '425811', null, '1', 'default', '2017-10-27 10:29:39', '2017-10-27 10:29:43', '20171027102652458235566336543814', '20171027102652458235566336543814');
INSERT INTO `sys_attachment` VALUES ('20171027102939749759456023353232', '20171027102942939666957140718059', '2017/', '20171027102939746461713996594582.jpg', 'TB2egidtVXXXXctXpXXXXXXXXXX_!!792583507.jpg', '2', '440795', null, '1', 'default', '2017-10-27 10:29:39', '2017-10-27 10:29:43', '20171027102652458235566336543814', '20171027102652458235566336543814');
INSERT INTO `sys_attachment` VALUES ('20171027102939893239274231905923', '20171027102942939666957140718059', '2017/', '20171027102939889650438234005955.jpg', 'TB2sPndtVXXXXXwXXXXXXXXXXXX_!!792583507.jpg', '1', '210627', null, '1', 'default', '2017-10-27 10:29:39', '2017-10-27 10:29:43', '20171027102652458235566336543814', '20171027102652458235566336543814');
INSERT INTO `sys_attachment` VALUES ('20171027102940145057831392885785', '20171027102942939666957140718059', '2017/', '20171027102940143458058866324480.jpg', 'TB2jHR.kUQIL1JjSZFhXXaDZFXa_!!2072092771.jpg', null, '366227', null, '1', 'default', '2017-10-27 10:29:40', '2017-10-27 10:29:43', '20171027102652458235566336543814', '20171027102652458235566336543814');
INSERT INTO `sys_attachment` VALUES ('20171027113654584439759106151125', '20171027113724031641949791734239', '2017/', '20171027113654581804518897456934.jpg', 'TB2aQX0kjihSKJjy0FlXXadEXXa_!!819984768.jpg', '5', '856487', null, '1', 'default', '2017-10-27 11:36:54', '2017-10-27 11:37:24', '20170925103713874175976363098240', '20170925103713874175976363098240');
INSERT INTO `sys_attachment` VALUES ('20171027113658570931361895225247', '20171027113724031641949791734239', '2017/', '20171027113658493462159207561150.jpg', 'TB2wRjQXMn85uJjSZFBXXXzZVXa_!!819984768.jpg', '4', '641691', null, '1', 'default', '2017-10-27 11:36:58', '2017-10-27 11:37:24', '20170925103713874175976363098240', '20170925103713874175976363098240');
INSERT INTO `sys_attachment` VALUES ('20171027113659337490325986340747', '20171027113724031641949791734239', '2017/', '20171027113659335698137832827058.jpg', 'TB2EtbPXG_85uJjSZFlXXXemXXa_!!819984768.jpg', '3', '443345', null, '1', 'default', '2017-10-27 11:36:59', '2017-10-27 11:37:24', '20170925103713874175976363098240', '20170925103713874175976363098240');
INSERT INTO `sys_attachment` VALUES ('20171027113701415712698829775870', '20171027113724031641949791734239', '2017/', '20171027113701413548686495616659.jpg', 'TB27vV3kjuhSKJjSspaXXXFgFXa_!!819984768.jpg', '2', '71670', null, '1', 'default', '2017-10-27 11:37:01', '2017-10-27 11:37:24', '20170925103713874175976363098240', '20170925103713874175976363098240');
INSERT INTO `sys_attachment` VALUES ('20171027113701794819107279210334', '20171027113724031641949791734239', '2017/', '20171027113701791515213983006451.jpg', 'TB2da_8ogoQMeJjy0FoXXcShVXa_!!819984768.jpg', '1', '551917', null, '1', 'default', '2017-10-27 11:37:01', '2017-10-27 11:37:24', '20170925103713874175976363098240', '20170925103713874175976363098240');
INSERT INTO `sys_attachment` VALUES ('20171027113702205361164257997877', '20171027113724031641949791734239', '2017/', '20171027113702203530120699492059.jpg', 'TB2kPYOXQv85uJjSZFPXXch4pXa_!!819984768.jpg', null, '666508', null, '1', 'default', '2017-10-27 11:37:02', '2017-10-27 11:37:24', '20170925103713874175976363098240', '20170925103713874175976363098240');
INSERT INTO `sys_attachment` VALUES ('20171101140841186111293763439691', '20171101140903110312178883636991', '2017/', '20171101140841172487576755800876.jpg', 'TB2aQX0kjihSKJjy0FlXXadEXXa_!!819984768.jpg', null, '856487', null, '1', 'default', '2017-11-01 14:08:41', '2017-11-01 14:09:03', '20171027102652458235566336543814', '20171027102652458235566336543814');
INSERT INTO `sys_attachment` VALUES ('20171103094741601808597882186290', '20171103094827378044976566360361', '2017/', '20171103094741568865450958563443.jpg', 'TB25aSutVXXXXavXpXXXXXXXXXX_!!792583507.jpg', '3', '411007', null, '1', 'default', '2017-11-03 09:47:41', '2017-11-03 09:48:27', '20171027102652458235566336543814', '20171027102652458235566336543814');
INSERT INTO `sys_attachment` VALUES ('20171103094741931567458855639445', '20171103094827378044976566360361', '2017/', '20171103094741855885540543890162.jpg', 'TB2j09jtVXXXXbKXpXXXXXXXXXX_!!792583507.jpg', '2', '425811', null, '1', 'default', '2017-11-03 09:47:41', '2017-11-03 09:48:27', '20171027102652458235566336543814', '20171027102652458235566336543814');
INSERT INTO `sys_attachment` VALUES ('20171103094742185084318100254850', '20171103094827378044976566360361', '2017/', '20171103094742179068572637519848.jpg', 'TB2egidtVXXXXctXpXXXXXXXXXX_!!792583507.jpg', '1', '440795', null, '1', 'default', '2017-11-03 09:47:42', '2017-11-03 09:48:27', '20171027102652458235566336543814', '20171027102652458235566336543814');
INSERT INTO `sys_attachment` VALUES ('20171103094742390999462338969744', '20171103094827378044976566360361', '2017/', '20171103094742384776641650865853.jpg', 'TB2sPndtVXXXXXwXXXXXXXXXXXX_!!792583507.jpg', null, '210627', null, '1', 'default', '2017-11-03 09:47:42', '2017-11-03 09:48:27', '20171027102652458235566336543814', '20171027102652458235566336543814');
INSERT INTO `sys_attachment` VALUES ('20171103094902561749803947636256', '20171103094923994355513933106585', '2017/', '20171103094902557533666275379943.jpg', 'TB2jHR.kUQIL1JjSZFhXXaDZFXa_!!2072092771.jpg', '2', '366227', null, '1', 'default', '2017-11-03 09:49:02', '2017-11-03 09:49:24', '20171027102652458235566336543814', '20171027102652458235566336543814');
INSERT INTO `sys_attachment` VALUES ('20171103094902861223713372793900', '20171103094923994355513933106585', '2017/', '20171103094902858109177262234684.jpg', 'TB2lcNdcuKAUKJjSZFzXXXdQFXa_!!2072092771.jpg', '1', '226174', null, '1', 'default', '2017-11-03 09:49:02', '2017-11-03 09:49:24', '20171027102652458235566336543814', '20171027102652458235566336543814');
INSERT INTO `sys_attachment` VALUES ('20171103094903194270841349791287', '20171103094923994355513933106585', '2017/', '20171103094903192359829576060710.jpg', 'TB2mSo4j.l7MKJjSZFDXXaOEpXa_!!2072092771.jpg', null, '476656', null, '1', 'default', '2017-11-03 09:49:03', '2017-11-03 09:49:24', '20171027102652458235566336543814', '20171027102652458235566336543814');
INSERT INTO `sys_attachment` VALUES ('20171103094949540695445894995666', null, null, '20171103094949478421436087645201.jpg', 'TB2wRjQXMn85uJjSZFBXXXzZVXa_!!819984768.jpg', null, '641691', null, '0', null, '2017-11-03 09:49:49', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103094949976415738042170667', null, null, '20171103094949973911951885187454.jpg', 'TB2EtbPXG_85uJjSZFlXXXemXXa_!!819984768.jpg', null, '443345', null, '0', null, '2017-11-03 09:49:49', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103094950127381958037631414', null, null, '20171103094950122211662032320561.jpg', 'TB27vV3kjuhSKJjSspaXXXFgFXa_!!819984768.jpg', null, '71670', null, '0', null, '2017-11-03 09:49:50', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103094950460377294314796172', null, null, '20171103094950457419166935098064.jpg', 'TB2da_8ogoQMeJjy0FoXXcShVXa_!!819984768.jpg', null, '551917', null, '0', null, '2017-11-03 09:49:50', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103094950777379855234971356', null, null, '20171103094950774744142466390724.jpg', 'TB2kPYOXQv85uJjSZFPXXch4pXa_!!819984768.jpg', null, '666508', null, '0', null, '2017-11-03 09:49:50', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103094951167240062536098166', null, null, '20171103094951159181908716125551.jpg', 'TB2aQX0kjihSKJjy0FlXXadEXXa_!!819984768.jpg', null, '856487', null, '0', null, '2017-11-03 09:49:51', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103095114427954806288848322', null, null, '20171103095114421290833205710961.jpg', 'TB2wRjQXMn85uJjSZFBXXXzZVXa_!!819984768.jpg', null, '641691', null, '0', null, '2017-11-03 09:51:14', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103095114839248314631918512', null, null, '20171103095114837070091147414582.jpg', 'TB2EtbPXG_85uJjSZFlXXXemXXa_!!819984768.jpg', null, '443345', null, '0', null, '2017-11-03 09:51:14', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103095115015288889471487919', null, null, '20171103095115011465935255152125.jpg', 'TB27vV3kjuhSKJjSspaXXXFgFXa_!!819984768.jpg', null, '71670', null, '0', null, '2017-11-03 09:51:15', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103095115380054967116556346', null, null, '20171103095115373349652723411983.jpg', 'TB2da_8ogoQMeJjy0FoXXcShVXa_!!819984768.jpg', null, '551917', null, '0', null, '2017-11-03 09:51:15', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103095115764992509135937929', null, null, '20171103095115758695078410865751.jpg', 'TB2kPYOXQv85uJjSZFPXXch4pXa_!!819984768.jpg', null, '666508', null, '0', null, '2017-11-03 09:51:15', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103095116296742977551245703', null, null, '20171103095116293993734190977230.jpg', 'TB2aQX0kjihSKJjy0FlXXadEXXa_!!819984768.jpg', null, '856487', null, '0', null, '2017-11-03 09:51:16', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103095948978320345233549269', null, null, '20171103095948969565861253700494.jpg', 'TB2wRjQXMn85uJjSZFBXXXzZVXa_!!819984768.jpg', null, '641691', null, '0', null, '2017-11-03 09:59:48', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171103095949307800147826716827', null, null, '20171103095949303858886074951872.jpg', 'TB2EtbPXG_85uJjSZFlXXXemXXa_!!819984768.jpg', null, '443345', null, '0', null, '2017-11-03 09:59:49', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171103095949502991038874580087', null, null, '20171103095949499944316981340537.jpg', 'TB27vV3kjuhSKJjSspaXXXFgFXa_!!819984768.jpg', null, '71670', null, '0', null, '2017-11-03 09:59:49', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171103095949836843415992445318', null, null, '20171103095949829863697123595399.jpg', 'TB2da_8ogoQMeJjy0FoXXcShVXa_!!819984768.jpg', null, '551917', null, '0', null, '2017-11-03 09:59:49', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171103095950134283916889087393', null, null, '20171103095950128230474142921138.jpg', 'TB2kPYOXQv85uJjSZFPXXch4pXa_!!819984768.jpg', null, '666508', null, '0', null, '2017-11-03 09:59:50', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171103095950448748173911023598', null, null, '20171103095950445182168833585306.jpg', 'TB2aQX0kjihSKJjy0FlXXadEXXa_!!819984768.jpg', null, '856487', null, '0', null, '2017-11-03 09:59:50', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171103100626070767115742312475', null, null, '20171103100626062294854727561661.jpg', 'TB2wRjQXMn85uJjSZFBXXXzZVXa_!!819984768.jpg', null, '641691', null, '0', null, '2017-11-03 10:06:26', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20171103115024376807868100508369', null, null, '20171103115024373748595899780124.jpg', 'TB2wRjQXMn85uJjSZFBXXXzZVXa_!!819984768.jpg', null, '641691', null, '0', null, '2017-11-03 11:50:24', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103115024595659060420556200', null, null, '20171103115024588229421099069004.jpg', 'TB2EtbPXG_85uJjSZFlXXXemXXa_!!819984768.jpg', null, '443345', null, '0', null, '2017-11-03 11:50:24', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103142328070336472104001095', null, null, '20171103142328058137476748144332.jpg', 'TB2wRjQXMn85uJjSZFBXXXzZVXa_!!819984768.jpg', null, '641691', null, '0', null, '2017-11-03 14:23:28', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20171103142424495143704864610391', '20171103142436219235878540278453', '2017/', '20171103142424489749216701020821.jpg', 'TB2wRjQXMn85uJjSZFBXXXzZVXa_!!819984768.jpg', null, '641691', null, '1', 'default', '2017-11-03 14:24:24', '2017-11-03 14:24:36', '20171027102652458235566336543814', '20171027102652458235566336543814');
INSERT INTO `sys_attachment` VALUES ('20171103142458264873036828117915', null, null, '20171103142458262996181277870659.jpg', 'TB2wRjQXMn85uJjSZFBXXXzZVXa_!!819984768.jpg', null, '641691', null, '0', null, '2017-11-03 14:24:58', null, '20171027102652458235566336543814', null);
INSERT INTO `sys_attachment` VALUES ('20180122102507198668867008617886', '20180122102526497373284138435453', '2018/', '20180122102507186610725461899083.jpg', 'TB2N3xudBfM8KJjSZFrXXXSdXXa_!!2525247765.jpg', '4', '893621', null, '1', 'default', '2018-01-22 10:25:07', '2018-01-22 10:25:26', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180122102509529691211018994879', '20180122102526497373284138435453', '2018/', '20180122102509522240558009899197.jpg', 'TB2SRmnjxHI8KJjy1zbXXaxdpXa_!!2525247765.jpg', '3', '1081250', null, '1', 'default', '2018-01-22 10:25:09', '2018-01-22 10:25:26', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180122102511123228416441267805', '20180122102526497373284138435453', '2018/', '20180122102511079517659408538504.jpg', 'TB2DQSkjsjI8KJjSsppXXXbyVXa_!!2525247765.jpg', '2', '1424806', null, '1', 'default', '2018-01-22 10:25:11', '2018-01-22 10:25:26', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180122102512006385120003078161', '20180122102526497373284138435453', '2018/', '20180122102511999377638969021780.jpg', 'TB2DrQsddLO8KJjSZPcXXaV0FXa_!!2525247765.jpg', '1', '501568', null, '1', 'default', '2018-01-22 10:25:12', '2018-01-22 10:25:26', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180122102512522799532451314478', '20180122102526497373284138435453', '2018/', '20180122102512510960238590936142.jpg', 'TB2RFmYjrYI8KJjy0FaXXbAiVXa_!!2525247765.jpg', null, '794173', null, '1', 'default', '2018-01-22 10:25:12', '2018-01-22 10:25:26', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180122111227412354927450579958', '20180122111233478527530066356970', '2018/', '20180122111227400220816018136554.jpg', 'TB2DLZqawvD8KJjSsplXXaIEFXa_!!1063738923.jpg', '2', '300173', null, '1', 'default', '2018-01-22 11:12:27', '2018-01-22 11:12:33', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180122111230933767830074476094', '20180122111233478527530066356970', '2018/', '20180122111230924555259359252583.jpg', 'TB21ggmatfJ8KJjy0FeXXXKEXXa_!!1063738923.jpg', '1', '179340', null, '1', 'default', '2018-01-22 11:12:30', '2018-01-22 11:12:33', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180122111231272059955665917757', '20180122111233478527530066356970', '2018/', '20180122111231223211393698418777.jpg', 'TB23IIwav6H8KJjSspmXXb2WXXa_!!1063738923.jpg', null, '403298', null, '1', 'default', '2018-01-22 11:12:31', '2018-01-22 11:12:33', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180122111457498560234891129237', '20180122111459870686175221589973', '2018/', '20180122111457459574775432687331.jpg', 'TB2dTrMiqmgSKJjSsplXXaICpXa_!!2042307543.jpg', '1', '434810', null, '1', 'default', '2018-01-22 11:14:57', '2018-01-22 11:14:59', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180122111457655605012089175357', '20180122111459870686175221589973', '2018/', '20180122111457650437937653121768.jpg', 'TB2kCRTtXXXXXXZXXXXXXXXXXXX_!!2042307543.jpg_q90.jpg', null, '108953', null, '1', 'default', '2018-01-22 11:14:57', '2018-01-22 11:14:59', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180122111705839683005545107445', '20180122111712018249944953366986', '2018/', '20180122111705795874775656526205.jpg', 'TB21lNQc2jM8KJjSZFyXXXdzVXa_!!2263665753.jpg', '1', '368130', null, '1', 'default', '2018-01-22 11:17:05', '2018-01-22 11:17:12', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180122111710108255982396512579', '20180122111712018249944953366986', '2018/', '20180122111710104597312575188761.jpg', 'TB21uX3ihrI8KJjy0FpXXb5hVXa_!!2263665753.jpg', null, '325097', null, '1', 'default', '2018-01-22 11:17:10', '2018-01-22 11:17:12', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180122111857115393536778589590', null, '2018/', '20180122111857112225559103964506.jpg', 'TB281KSjJfJ8KJjy0FeXXXKEXXa_!!842170248.jpg', '2', '168004', null, '2', 'default', '2018-01-22 11:18:57', '2018-01-22 11:19:18', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180122111900273542140745209747', null, '2018/', '20180122111900269168309595462334.jpg', 'TB2_TQOcqLN8KJjSZFvXXXW8VXa_!!842170248.jpg', '1', '170514', null, '2', 'default', '2018-01-22 11:19:00', '2018-01-22 11:19:18', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180122111901139493124797542342', null, '2018/', '20180122111901132375134009779158.jpg', 'TB2WbcOcIic_eJjSZFnXXXVwVXa_!!842170248.jpg', null, '253672', null, '2', 'default', '2018-01-22 11:19:01', '2018-01-22 11:19:18', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180125163751884756612736080410', null, null, '20180125163751882720037115401868.png', 'logo.png', null, '43571', null, '0', null, '2018-01-25 16:37:51', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20180130143706350892940740556192', null, null, '20180130143706346850507424978848.jpg', '500649495.jpg', null, '2235576', null, '0', null, '2018-01-30 14:37:06', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20180203104108912680285790038320', null, '2018/', '20180203104108880667850659066851.png', 'logo.png', null, '43571', null, '2', 'default', '2018-02-03 10:41:08', '2018-02-03 10:41:12', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180208101027445167518945660059', null, null, '20180208101027431795167666511790.jpg', 'TB2.hfOasjI8KJjSsppXXXbyVXa_!!901409638.jpg', null, '59778', null, '0', null, '2018-02-08 10:10:27', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20180304152004955689686944829389', '20170922163541926226083557400245', '2018/', '20180304152004908251998226959204.jpg', '巴拉巴拉banner3.jpg', '13', '183152', null, '1', 'default', '2018-03-04 15:20:04', '2018-03-04 15:20:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180304152005203454209023066897', '20170922163541926226083557400245', '2018/', '20180304152005198238628745333559.jpg', '帛卡袖.jpg', '12', '373552', null, '1', 'default', '2018-03-04 15:20:05', '2018-03-04 15:20:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180304152006237686795362045739', '20170922163541926226083557400245', '2018/', '20180304152006231692552043542836.jpg', '芬腾3.jpg', '11', '430661', null, '1', 'default', '2018-03-04 15:20:06', '2018-03-04 15:20:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180304152006413441688201533555', '20170922163541926226083557400245', '2018/', '20180304152006410376543355755802.jpg', '似水年华.jpg', '10', '164805', null, '1', 'default', '2018-03-04 15:20:06', '2018-03-04 15:20:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180304152006699541761959053525', '20170922163541926226083557400245', '2018/', '20180304152006694195190021894127.jpg', '首页滚动banner.jpg', '9', '308966', null, '1', 'default', '2018-03-04 15:20:06', '2018-03-04 15:20:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180304152007223119665056408858', '20170922163541926226083557400245', '2018/', '20180304152007217388175023754599.jpg', '首页滚动banner2.jpg', '8', '1104579', null, '1', 'default', '2018-03-04 15:20:07', '2018-03-04 15:20:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180304152007483268413917179593', '20170922163541926226083557400245', '2018/', '20180304152007478405387540678406.jpg', '泰和源.jpg', '7', '379644', null, '1', 'default', '2018-03-04 15:20:07', '2018-03-04 15:20:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180304152007673738718325252235', '20170922163541926226083557400245', '2018/', '20180304152007671587248783330101.jpg', '裕燕家居.jpg', '6', '184293', null, '1', 'default', '2018-03-04 15:20:07', '2018-03-04 15:20:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180309095208153077096553908643', '20180309095212238999568509971867', '2018/', '20180309095208150625998571052196.jpg', '芬腾3.jpg', null, '430661', null, '1', 'default', '2018-03-09 09:52:08', '2018-03-09 09:52:12', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180309095259234952368047385104', '20180309095316498958402850972149', '2018/', '20180309095259231030656702430829.jpg', '首页滚动banner.jpg', null, '308966', null, '1', 'default', '2018-03-09 09:52:59', '2018-03-09 09:53:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180309105034097888430954849634', '20180309105036173757940356406536', '2018/', '20180309105034095399725940078396.jpg', 'TB2zNUGXi2mJKJjy0FhXXckoXXa-363607599.jpg', '1', '274124', null, '1', 'default', '2018-03-09 10:50:34', '2018-03-09 10:50:36', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180309105034264131787137273335', '20180309105036173757940356406536', '2018/', '20180309105034262195141178184326.jpg', 'TB2uhAFXi_mJKJjy0FiXXcmzXXa-363607599.jpg', null, '186881', null, '1', 'default', '2018-03-09 10:50:34', '2018-03-09 10:50:36', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180312162433497502771877426518', null, null, '20180312162433494795956057466485.gif', '0B0pdVAl5tI.gif', null, '176990', null, '0', null, '2018-03-12 16:24:33', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20180312162433663908805302949323', null, null, '20180312162433660744524611244129.gif', '1 (1).gif', null, '50585', null, '0', null, '2018-03-12 16:24:33', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20180312162433797943945556218680', null, null, '20180312162433793348969479072482.gif', '1.gif', null, '59034', null, '0', null, '2018-03-12 16:24:33', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20180312162433928854578561605450', null, null, '20180312162433923692239007243041.png', '2017-09-30_142837.png', null, '37977', null, '0', null, '2018-03-12 16:24:33', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20180314173555954778109230651844', '20180310172311004667310961479080', '2018/', '20180314173555949823853342878970.jpg', 'TB2uhAFXi_mJKJjy0FiXXcmzXXa-363607599.jpg', null, '186881', null, '1', 'default', '2018-03-14 17:35:55', '2018-03-14 17:35:58', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314181216538719935025197147', '20180314181359476799647436685746', '2018/', '20180314181216536815547926133919.jpg', 'timg (36).jpg', '11', '82969', null, '1', 'default', '2018-03-14 18:12:16', '2018-03-14 18:13:59', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314181224861112638351874871', '20180314181359476799647436685746', '2018/', '20180314181224856874624128032599.jpg', 'timg (35).jpg', '10', '133769', null, '1', 'default', '2018-03-14 18:12:24', '2018-03-14 18:13:59', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314181225016966233590374723', '20180314181359476799647436685746', '2018/', '20180314181225011812166326750134.jpg', 'timg 1111.jpg', '9', '148654', null, '1', 'default', '2018-03-14 18:12:25', '2018-03-14 18:13:59', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314181225184501102929821788', '20180314181359476799647436685746', '2018/', '20180314181225181597979247899167.jpg', 'timg (34).jpg', '8', '68729', null, '1', 'default', '2018-03-14 18:12:25', '2018-03-14 18:13:59', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314181225389582366038219708', '20180314181359476799647436685746', '2018/', '20180314181225386934903575305341.jpg', 'timg (33).jpg', '7', '71282', null, '1', 'default', '2018-03-14 18:12:25', '2018-03-14 18:13:59', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314181225583206555263383393', '20180314181359476799647436685746', '2018/', '20180314181225580638317748808482.jpg', 'timg (32).jpg', '6', '76200', null, '1', 'default', '2018-03-14 18:12:25', '2018-03-14 18:13:59', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314181225761991277488063208', '20180314181359476799647436685746', '2018/', '20180314181225758750704832327708.jpg', 'timg (31).jpg', '5', '159130', null, '1', 'default', '2018-03-14 18:12:25', '2018-03-14 18:13:59', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314181225920178528290864324', '20180314181359476799647436685746', '2018/', '20180314181225918850022660894598.jpg', 'timg (30).jpg', '4', '51496', null, '1', 'default', '2018-03-14 18:12:25', '2018-03-14 18:13:59', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314181226039026128286039321', '20180314181359476799647436685746', '2018/', '20180314181226038029529981456464.jpg', 'timg (29).jpg', '3', '67242', null, '1', 'default', '2018-03-14 18:12:26', '2018-03-14 18:13:59', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314181226218402538439676895', '20180314181359476799647436685746', '2018/', '20180314181226215111781593898166.jpg', 'timg (28).jpg', '2', '158891', null, '1', 'default', '2018-03-14 18:12:26', '2018-03-14 18:13:59', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314181226403324055400396089', '20180314181359476799647436685746', '2018/', '20180314181226400155877580573565.jpg', 'timg (27).jpg', '1', '149018', null, '1', 'default', '2018-03-14 18:12:26', '2018-03-14 18:13:59', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314181355186731909789809276', '20180314181359476799647436685746', '2018/', '20180314181355184097682874357930.jpg', 'timg (25).jpg', null, '48477', null, '1', 'default', '2018-03-14 18:13:55', '2018-03-14 18:13:59', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314182410971452708579933286', '20180310172311004667310961479080', '2018/', '20180314182410969388350648448358.jpg', 'timg (36).jpg', '10', '82969', null, '1', 'default', '2018-03-14 18:24:10', '2018-03-14 18:24:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314182411243908418514436353', '20180310172311004667310961479080', '2018/', '20180314182411238651001309724992.jpg', 'timg (35).jpg', '9', '133769', null, '1', 'default', '2018-03-14 18:24:11', '2018-03-14 18:24:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314182411635492236295085420', '20180310172311004667310961479080', '2018/', '20180314182411630735918975143878.jpg', 'timg 1111.jpg', '8', '148654', null, '1', 'default', '2018-03-14 18:24:11', '2018-03-14 18:24:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314182411915668937635561811', '20180310172311004667310961479080', '2018/', '20180314182411912711241286626546.jpg', 'timg (34).jpg', '7', '68729', null, '1', 'default', '2018-03-14 18:24:11', '2018-03-14 18:24:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314182412175583917045099867', '20180310172311004667310961479080', '2018/', '20180314182412170437011408762356.jpg', 'timg (33).jpg', '6', '71282', null, '1', 'default', '2018-03-14 18:24:12', '2018-03-14 18:24:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314182412397252165328638417', '20180310172311004667310961479080', '2018/', '20180314182412393939302266518705.jpg', 'timg (32).jpg', '5', '76200', null, '1', 'default', '2018-03-14 18:24:12', '2018-03-14 18:24:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314182412544159403734456813', '20180310172311004667310961479080', '2018/', '20180314182412540069184315596945.jpg', 'timg (31).jpg', '4', '159130', null, '1', 'default', '2018-03-14 18:24:12', '2018-03-14 18:24:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314182412730349254890207585', '20180310172311004667310961479080', '2018/', '20180314182412726942730854927856.jpg', 'timg (30).jpg', '3', '51496', null, '1', 'default', '2018-03-14 18:24:12', '2018-03-14 18:24:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314182412929054424401801207', '20180310172311004667310961479080', '2018/', '20180314182412926421080088093505.jpg', 'timg (29).jpg', '2', '67242', null, '1', 'default', '2018-03-14 18:24:12', '2018-03-14 18:24:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180314182413198911895720682242', '20180310172311004667310961479080', '2018/', '20180314182413194239972753299858.jpg', 'timg (28).jpg', '1', '158891', null, '1', 'default', '2018-03-14 18:24:13', '2018-03-14 18:24:16', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180319164359964955388105293333', null, null, '20180319164359954898845581012230.jpg', 'logo_03.jpg', null, '70797', null, '0', null, '2018-03-19 16:43:59', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20180319164735858612362748813553', null, null, '20180319164735856020983642827273.jpg', 'logo_03.jpg', null, '70797', null, '0', null, '2018-03-19 16:47:35', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20180319165335818528704294683029', '20180319165447188293172216106177', '2018/', '20180319165335808414900418849596.jpg', 'logo_03.jpg', null, '70797', null, '1', 'default', '2018-03-19 16:53:35', '2018-03-19 16:54:47', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180319165620779699039549938668', null, null, '20180319165620777568483873266700.jpg', 'logo_03.jpg', null, '70797', null, '0', null, '2018-03-19 16:56:20', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20180319171222070329736254821300', null, null, '20180319171222060603800929901167.jpg', 'logo_03.jpg', null, '70797', null, '0', null, '2018-03-19 17:12:22', null, '20161222113810681189580305593289', null);
INSERT INTO `sys_attachment` VALUES ('20180319171449789452544788129046', '20180319171500788210574992857106', '2018/', '20180319171449776174224247462325.jpg', 'logo_03.jpg', null, '70797', null, '1', 'default', '2018-03-19 17:14:49', '2018-03-19 17:15:00', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `sys_attachment` VALUES ('20180410180358334451844554293708', '20180410180401864614132692379806', '2018/', '20180410180358287551004090764700.jpg', 'TB2nM4AXm0jpuFjy0FlXXc0bpXa_!!901409638.jpg', null, '217775', null, '1', 'default', '2018-04-10 18:03:58', '2018-04-10 18:04:02', '20161222113810681189580305593289', '20161222113810681189580305593289');

-- ----------------------------
-- Table structure for sys_attachmentconfig
-- ----------------------------
DROP TABLE IF EXISTS `sys_attachmentconfig`;
CREATE TABLE `sys_attachmentconfig` (
  `id` char(32) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `saveDir` varchar(200) DEFAULT NULL,
  `dirLevel` int(11) DEFAULT NULL,
  `fileSize` int(11) DEFAULT NULL,
  `fileCount` int(11) DEFAULT NULL,
  `extension` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `ft` char(19) DEFAULT NULL COMMENT 'first Time',
  `lt` char(19) DEFAULT NULL COMMENT 'last Time',
  `fu` char(32) DEFAULT NULL COMMENT 'First user',
  `lu` char(32) DEFAULT NULL COMMENT 'last user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_attachmentconfig
-- ----------------------------
INSERT INTO `sys_attachmentconfig` VALUES ('20120529172911031725770385248824', 'default', 'G:\\workplace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp5\\wtpwebapps\\platform-tianhe\\platform\\images', '1', '500', '12', 'jpg;png;gif;', '', '2012-05-29 17:29:11', '2015-05-22 11:47:09', '20120507134700000110225236178825', '');
INSERT INTO `sys_attachmentconfig` VALUES ('20120529172911031725770385248825', 'qrcodeImg', 'G:\\workplace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp5\\wtpwebapps\\platform-tianhe\\platform\\qrcode', '1', '5', '1', 'jpg;png;gif;', '', '2012-05-29 17:29:11', '2015-05-22 11:47:09', '20120507134700000110225236178825', '');
INSERT INTO `sys_attachmentconfig` VALUES ('20130413143416257473632078172989', 'sys_ueditor', 'G:\\workplace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp5\\wtpwebapps\\platform-tianhe\\platform\\images', '1', null, null, '', '', '2013-04-13 14:34:16', '', '20120507134700000110225236178825', '');
INSERT INTO `sys_attachmentconfig` VALUES ('20150310164241615718675493153174', 'userPhoto', 'G:\\workplace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp5\\wtpwebapps\\platform-tianhe\\platform\\images', '3', null, '3', '', '用户头像', '2015-03-10 16:42:41', '', '', '');

-- ----------------------------
-- Table structure for sys_attachmentsetting
-- ----------------------------
DROP TABLE IF EXISTS `sys_attachmentsetting`;
CREATE TABLE `sys_attachmentsetting` (
  `id` char(32) NOT NULL,
  `limitFileExtention` varchar(500) DEFAULT NULL,
  `type` char(1) DEFAULT NULL COMMENT '0:本地 1:ftp',
  `ftpAddress` varchar(500) DEFAULT NULL,
  `ftpPort` varchar(20) DEFAULT NULL,
  `ftpPath` varchar(1000) DEFAULT NULL,
  `ftpUserName` varchar(100) DEFAULT NULL,
  `ftpPassword` varchar(100) DEFAULT NULL,
  `ft` char(19) DEFAULT NULL COMMENT 'first Time',
  `lt` char(19) DEFAULT NULL COMMENT 'last Time',
  `fu` char(32) DEFAULT NULL COMMENT 'First user',
  `lu` char(32) DEFAULT NULL COMMENT 'last user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_attachmentsetting
-- ----------------------------
INSERT INTO `sys_attachmentsetting` VALUES ('20120529172911015406605916273091', 'exe;com;dll;ocx;vbx;bat;pif', '', '', '2012-05-29 17:29:11', '20120507134700000110225236178825', '2015-03-10 14:23:24', null, '0', '', '', '');

-- ----------------------------
-- Table structure for th_address
-- ----------------------------
DROP TABLE IF EXISTS `th_address`;
CREATE TABLE `th_address` (
  `id` varchar(32) NOT NULL,
  `customer_id` varchar(32) DEFAULT NULL COMMENT '客户ID',
  `content` text COMMENT '详细地址',
  `isDefault` varchar(5) DEFAULT NULL COMMENT '是否默认(1：是，2：否)',
  `isDelete` varchar(5) DEFAULT NULL COMMENT '是否删除（1：否，2：是）',
  `phone` varchar(15) DEFAULT NULL COMMENT '收货电话',
  `receiver` varchar(50) DEFAULT NULL COMMENT '收货人',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_2` (`customer_id`),
  CONSTRAINT `FK_Reference_2` FOREIGN KEY (`customer_id`) REFERENCES `th_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收货地址';

-- ----------------------------
-- Records of th_address
-- ----------------------------
INSERT INTO `th_address` VALUES ('20170925113510346487136866616830', '20170922194407297172957942397337', '内蒙古包头市-东河区-时候未到伤心处', '1', '1', '15661451612', '经典', '2017-09-25 11:35:10', '2017-09-25 11:35:10', null, null, null);
INSERT INTO `th_address` VALUES ('20170925113902145919686042778053', '20170923163519157870406498515016', '内蒙古包头市-青山区-不大好苏喜欢', '1', '1', '18648250697', '徐昊', '2017-09-25 11:39:02', '2017-09-25 11:39:02', null, null, null);
INSERT INTO `th_address` VALUES ('20171021101508255978469732925530', '20171020161046492169283021443205', '内蒙古包头市-青山区-头目诺特塔塔塔帕苏娜扎起的早到', '2', '2', '13123412341', '测试', '2017-10-21 10:15:08', '2017-10-21 10:15:08', null, '2017-10-24 11:52:57', null);
INSERT INTO `th_address` VALUES ('20171021141734597200166357283086', '20170923163450618324289056610089', '内蒙古包头市-固阳县-sadfasdfasdfasfsdfsdf', '2', '2', '13412345678', 'test', '2017-10-21 14:17:34', '2017-10-21 14:17:34', null, '2017-10-24 14:49:18', null);
INSERT INTO `th_address` VALUES ('20171021164845763310547347814610', '20171021164550227460306945961489', '内蒙古包头市-东河区-维多利', '1', '1', '18647240571', '郝云燕', '2017-10-21 16:48:45', '2017-10-21 16:48:45', null, null, null);
INSERT INTO `th_address` VALUES ('20171024115108108125860164307093', '20171020161046492169283021443205', '内蒙古包头市-白云鄂博矿-bbvghjbbhh桶面有什么东西了吗', '2', '2', '13641239856', 'mark', '2017-10-24 11:51:08', '2017-10-24 11:51:08', null, '2017-10-24 11:52:55', null);
INSERT INTO `th_address` VALUES ('20171024115249566236192893325038', '20171020161046492169283021443205', '内蒙古包头市-九原区-来咯啦咯啦咯啦', '2', '2', '17012345678', '咯哦OK了', '2017-10-24 11:52:49', '2017-10-24 11:52:49', null, '2017-10-24 11:52:53', null);
INSERT INTO `th_address` VALUES ('20171024115920324817950985246529', '20171020161046492169283021443205', '内蒙古包头市-白云鄂博矿-地址KKK吧KKK', '2', '2', '18697409064', '测试', '2017-10-24 11:59:20', '2017-10-24 11:59:20', null, '2017-10-24 14:50:05', null);
INSERT INTO `th_address` VALUES ('20171024115952131679583169477971', '20171020161046492169283021443205', '内蒙古包头市-土默特右旗-某某诺夸呕吐monkKKK', '2', '2', '15584445589', '啦咯啦咯啦咯啦咯', '2017-10-24 11:59:52', '2017-10-24 11:59:52', null, '2017-10-24 14:49:56', null);
INSERT INTO `th_address` VALUES ('20171024163413182528506643729591', '20171020161046492169283021443205', '内蒙古包头市-青山区-包头工商联大厦2101室', '2', '1', '18697409064', '莎莎', '2017-10-24 16:34:13', '2017-10-24 16:34:13', null, null, null);
INSERT INTO `th_address` VALUES ('20171024163931109959778177743462', '20171020161046492169283021443205', '内蒙古包头市-土默特右旗-过来看看家咯楼偷懒18558号楼', '2', '1', '18745612356', '于晓光', '2017-10-24 16:39:31', '2017-10-24 16:39:31', null, null, null);
INSERT INTO `th_address` VALUES ('20171024164241983873172574414027', '20171020161046492169283021443205', '内蒙古包头市-土默特右旗-韩国首尔站东大门484号', '1', '1', '15296524728', '秋瓷炫', '2017-10-24 16:42:41', '2017-10-24 16:42:41', null, null, null);
INSERT INTO `th_address` VALUES ('20171026143427857695400824084434', '20171020161046492169283021443205', '内蒙古包头市-白云鄂博矿-这让我破后默默哦哦哦哦哟哟哟哟43641886哦哦npmpmgm', '2', '1', '18612345678', '地址1', '2017-10-26 14:34:27', '2017-10-26 14:34:27', null, null, null);
INSERT INTO `th_address` VALUES ('20171026143453730935005071304074', '20171020161046492169283021443205', '内蒙古包头市-达尔罕茂明-一名民工住户一下作业的原因主要有94664689', '2', '1', '17043469645', '地址2', '2017-10-26 14:34:53', '2017-10-26 14:34:53', null, null, null);
INSERT INTO `th_address` VALUES ('20171026143633703067325440888376', '20171020161046492169283021443205', '内蒙古包头市-东河区-这是我婆婆婆婆破哦破哦', '2', '1', '17212345678', '地址3月荐婆婆后破哦哦哦哦mpmpgnpmpm', '2017-10-26 14:36:33', '2017-10-26 14:36:33', null, null, null);
INSERT INTO `th_address` VALUES ('20171026143802014955392093001738', '20171020161046492169283021443205', '内蒙古包头市-白云鄂博矿-HdjjdjdxccxvdvdvdBshshsj哦破破破破破哦', '2', '1', '13028832827', '地址4农历基金哦djdjdjdjjdjxjdjx', '2017-10-26 14:38:02', '2017-10-26 14:38:02', null, null, null);
INSERT INTO `th_address` VALUES ('20171026143838138219722723581542', '20171020161046492169283021443205', '内蒙古包头市-固阳县-举目哦哦哦', '2', '1', '13612345678', '地址8', '2017-10-26 14:38:38', '2017-10-26 14:38:38', null, null, null);
INSERT INTO `th_address` VALUES ('20171026143908139122993858373396', '20171020161046492169283021443205', '内蒙古包头市-九原区-哦', '2', '1', '18697046696', '地址9', '2017-10-26 14:39:08', '2017-10-26 14:39:08', null, '2017-10-26 14:39:24', null);
INSERT INTO `th_address` VALUES ('20171026143958700711861308244198', '20171020161046492169283021443205', '内蒙古包头市-昆都仑区-w po go g niu tu', '2', '1', '18712649586', '地址10', '2017-10-26 14:39:58', '2017-10-26 14:39:58', null, null, null);
INSERT INTO `th_address` VALUES ('20171026144058934663395760306288', '20171020161046492169283021443205', '内蒙古包头市-石拐区-你哦婆婆朋友pwwww', '2', '1', '18245183649', '地址11', '2017-10-26 14:40:58', '2017-10-26 14:40:58', null, null, null);
INSERT INTO `th_address` VALUES ('20171026144141843444059917932754', '20171020161046492169283021443205', '内蒙古包头市-九原区-哦哦哦', '2', '1', '13812345768', '地址12', '2017-10-26 14:41:41', '2017-10-26 14:41:41', null, null, null);
INSERT INTO `th_address` VALUES ('20171027114548816136892455305482', '20171021164550227460306945961489', '内蒙古包头市-东河区-123', '2', '1', '18647240571', '郝云燕', '2017-10-27 11:45:48', '2017-10-27 11:45:48', null, null, null);
INSERT INTO `th_address` VALUES ('20171102152507078335469355648932', '20170923163450618324289056610089', '内蒙古包头市-石拐区-g', '1', '1', '15044940362', '测试', '2017-11-02 15:25:07', '2017-11-02 15:25:07', null, null, null);
INSERT INTO `th_address` VALUES ('20180304153154522761276423423598', '20171025092514241801015125166835', '内蒙古包头市-白云鄂博矿-计算机理论课铭12348号楼二单元4548855室收', '1', '1', '19900000001', '乌日娜', '2018-03-04 15:31:54', '2018-03-04 15:31:54', null, null, null);
INSERT INTO `th_address` VALUES ('20180307175614376212359981784643', '20180307095521484289980574167709', '内蒙古包头市-青山区-包头市政府', '2', '1', '16603071755', 'baby', '2018-03-07 17:56:14', '2018-03-07 17:56:14', null, null, null);

-- ----------------------------
-- Table structure for th_allocation
-- ----------------------------
DROP TABLE IF EXISTS `th_allocation`;
CREATE TABLE `th_allocation` (
  `id` varchar(32) NOT NULL,
  `outStorage_id` varchar(32) DEFAULT NULL COMMENT '调出仓库',
  `inStorage_id` varchar(32) DEFAULT NULL COMMENT '调入仓库',
  `store_id` varchar(32) DEFAULT NULL,
  `allocationCode` varchar(16) DEFAULT NULL COMMENT '调拨单号',
  `state` varchar(10) DEFAULT NULL COMMENT '1.完成 2. 新建',
  `remark` text COMMENT '备注',
  `isDelete` varchar(5) DEFAULT NULL COMMENT '是否删除（1：否，2：是）',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_18` (`outStorage_id`),
  KEY `FK_Reference_19` (`inStorage_id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `FK_Reference_18` FOREIGN KEY (`outStorage_id`) REFERENCES `th_storage` (`id`),
  CONSTRAINT `FK_Reference_19` FOREIGN KEY (`inStorage_id`) REFERENCES `th_storage` (`id`),
  CONSTRAINT `th_allocation_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `th_store` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存调拨';

-- ----------------------------
-- Records of th_allocation
-- ----------------------------

-- ----------------------------
-- Table structure for th_allocation_qrcode
-- ----------------------------
DROP TABLE IF EXISTS `th_allocation_qrcode`;
CREATE TABLE `th_allocation_qrcode` (
  `id` varchar(32) NOT NULL,
  `allocation_id` varchar(32) DEFAULT NULL,
  `goods_id` varchar(32) DEFAULT NULL,
  `qrcode_id` varchar(32) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `allocation_id` (`allocation_id`),
  KEY `goods_id` (`goods_id`),
  KEY `qrcode_id` (`qrcode_id`),
  CONSTRAINT `th_allocation_qrcode_ibfk_1` FOREIGN KEY (`allocation_id`) REFERENCES `th_allocation` (`id`),
  CONSTRAINT `th_allocation_qrcode_ibfk_2` FOREIGN KEY (`goods_id`) REFERENCES `th_goods` (`id`),
  CONSTRAINT `th_allocation_qrcode_ibfk_3` FOREIGN KEY (`qrcode_id`) REFERENCES `th_qrcode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of th_allocation_qrcode
-- ----------------------------

-- ----------------------------
-- Table structure for th_area
-- ----------------------------
DROP TABLE IF EXISTS `th_area`;
CREATE TABLE `th_area` (
  `id` varchar(32) NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT NULL,
  `state` varchar(5) DEFAULT NULL COMMENT '当前区域状态（1：正常，2：删除）',
  `patientArea` varchar(32) DEFAULT NULL COMMENT '所属上级地区(没有则不填）',
  `grade` varchar(5) DEFAULT NULL COMMENT '区域等级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='区域';

-- ----------------------------
-- Records of th_area
-- ----------------------------
INSERT INTO `th_area` VALUES ('110000', '北京市', '2016-11-10 14:49:04', '1', null, '1');
INSERT INTO `th_area` VALUES ('110100', '北京市', '2016-11-10 14:49:04', '1', '110000', '2');
INSERT INTO `th_area` VALUES ('110101', '东城区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110102', '西城区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110103', '崇文区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110104', '宣武区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110105', '朝阳区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110106', '丰台区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110107', '石景山区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110108', '海淀区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110109', '门头沟区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110111', '房山区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110112', '通州区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110113', '顺义区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110114', '昌平区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110115', '大兴区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110116', '怀柔区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110117', '平谷区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110228', '密云县', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110229', '延庆县', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('110230', '其它区', '2016-11-10 14:49:04', '1', '110100', '3');
INSERT INTO `th_area` VALUES ('120000', '天津市', '2016-11-10 14:49:04', '1', null, '1');
INSERT INTO `th_area` VALUES ('120100', '天津市', '2016-11-10 14:49:04', '1', '120000', '2');
INSERT INTO `th_area` VALUES ('120101', '和平区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120102', '河东区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120103', '河西区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120104', '南开区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120105', '河北区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120106', '红桥区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120107', '塘沽区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120108', '汉沽区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120109', '大港区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120110', '东丽区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120111', '西青区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120112', '津南区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120113', '北辰区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120114', '武清区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120115', '宝坻区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120116', '滨海新区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120221', '宁河县', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120223', '静海县', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120225', '蓟县', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('120226', '其它区', '2016-11-10 14:49:04', '1', '120100', '3');
INSERT INTO `th_area` VALUES ('130000', '河北省', '2016-11-10 14:49:04', '1', null, '1');
INSERT INTO `th_area` VALUES ('130100', '石家庄市', '2016-11-10 14:49:04', '1', '130000', '2');
INSERT INTO `th_area` VALUES ('130102', '长安区', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130103', '桥东区', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130104', '桥西区', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130105', '新华区', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130107', '井陉矿区', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130108', '裕华区', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130121', '井陉县', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130123', '正定县', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130124', '栾城县', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130125', '行唐县', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130126', '灵寿县', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130127', '高邑县', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130128', '深泽县', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130129', '赞皇县', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130130', '无极县', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130131', '平山县', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130132', '元氏县', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130133', '赵县', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130181', '辛集市', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130182', '藁城市', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130183', '晋州市', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130184', '新乐市', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130185', '鹿泉市', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130186', '其它区', '2016-11-10 14:49:04', '1', '130100', '3');
INSERT INTO `th_area` VALUES ('130200', '唐山市', '2016-11-10 14:49:04', '1', '130000', '2');
INSERT INTO `th_area` VALUES ('130202', '路南区', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130203', '路北区', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130204', '古冶区', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130205', '开平区', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130207', '丰南区', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130208', '丰润区', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130223', '滦县', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130224', '滦南县', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130225', '乐亭县', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130227', '迁西县', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130229', '玉田县', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130230', '唐海县', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130281', '遵化市', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130283', '迁安市', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130284', '其它区', '2016-11-10 14:49:04', '1', '130200', '3');
INSERT INTO `th_area` VALUES ('130300', '秦皇岛市', '2016-11-10 14:49:04', '1', '130000', '2');
INSERT INTO `th_area` VALUES ('130302', '海港区', '2016-11-10 14:49:04', '1', '130300', '3');
INSERT INTO `th_area` VALUES ('130303', '山海关区', '2016-11-10 14:49:04', '1', '130300', '3');
INSERT INTO `th_area` VALUES ('130304', '北戴河区', '2016-11-10 14:49:04', '1', '130300', '3');
INSERT INTO `th_area` VALUES ('130321', '青龙满族自治县', '2016-11-10 14:49:04', '1', '130300', '3');
INSERT INTO `th_area` VALUES ('130322', '昌黎县', '2016-11-10 14:49:04', '1', '130300', '3');
INSERT INTO `th_area` VALUES ('130323', '抚宁县', '2016-11-10 14:49:04', '1', '130300', '3');
INSERT INTO `th_area` VALUES ('130324', '卢龙县', '2016-11-10 14:49:04', '1', '130300', '3');
INSERT INTO `th_area` VALUES ('130398', '其它区', '2016-11-10 14:49:04', '1', '130300', '3');
INSERT INTO `th_area` VALUES ('130399', '经济技术开发区', '2016-11-10 14:49:04', '1', '130300', '3');
INSERT INTO `th_area` VALUES ('130400', '邯郸市', '2016-11-10 14:49:04', '1', '130000', '2');
INSERT INTO `th_area` VALUES ('130402', '邯山区', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130403', '丛台区', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130404', '复兴区', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130406', '峰峰矿区', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130421', '邯郸县', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130423', '临漳县', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130424', '成安县', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130425', '大名县', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130426', '涉县', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130427', '磁县', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130428', '肥乡县', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130429', '永年县', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130430', '邱县', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130431', '鸡泽县', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130432', '广平县', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130433', '馆陶县', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130434', '魏县', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130435', '曲周县', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130481', '武安市', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130482', '其它区', '2016-11-10 14:49:04', '1', '130400', '3');
INSERT INTO `th_area` VALUES ('130500', '邢台市', '2016-11-10 14:49:04', '1', '130000', '2');
INSERT INTO `th_area` VALUES ('130502', '桥东区', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130503', '桥西区', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130521', '邢台县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130522', '临城县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130523', '内丘县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130524', '柏乡县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130525', '隆尧县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130526', '任县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130527', '南和县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130528', '宁晋县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130529', '巨鹿县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130530', '新河县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130531', '广宗县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130532', '平乡县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130533', '威县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130534', '清河县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130535', '临西县', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130581', '南宫市', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130582', '沙河市', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130583', '其它区', '2016-11-10 14:49:04', '1', '130500', '3');
INSERT INTO `th_area` VALUES ('130600', '保定市', '2016-11-10 14:49:04', '1', '130000', '2');
INSERT INTO `th_area` VALUES ('130602', '新市区', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130603', '北市区', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130604', '南市区', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130621', '满城县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130622', '清苑县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130623', '涞水县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130624', '阜平县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130625', '徐水县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130626', '定兴县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130627', '唐县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130628', '高阳县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130629', '容城县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130630', '涞源县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130631', '望都县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130632', '安新县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130633', '易县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130634', '曲阳县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130635', '蠡县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130636', '顺平县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130637', '博野县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130638', '雄县', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130681', '涿州市', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130682', '定州市', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130683', '安国市', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130684', '高碑店市', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130698', '高开区', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130699', '其它区', '2016-11-10 14:49:04', '1', '130600', '3');
INSERT INTO `th_area` VALUES ('130700', '张家口市', '2016-11-10 14:49:04', '1', '130000', '2');
INSERT INTO `th_area` VALUES ('130702', '桥东区', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130703', '桥西区', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130705', '宣化区', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130706', '下花园区', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130721', '宣化县', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130722', '张北县', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130723', '康保县', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130724', '沽源县', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130725', '尚义县', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130726', '蔚县', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130727', '阳原县', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130728', '怀安县', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130729', '万全县', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130730', '怀来县', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130731', '涿鹿县', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130732', '赤城县', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130733', '崇礼县', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130734', '其它区', '2016-11-10 14:49:04', '1', '130700', '3');
INSERT INTO `th_area` VALUES ('130800', '承德市', '2016-11-10 14:49:04', '1', '130000', '2');
INSERT INTO `th_area` VALUES ('130802', '双桥区', '2016-11-10 14:49:04', '1', '130800', '3');
INSERT INTO `th_area` VALUES ('130803', '双滦区', '2016-11-10 14:49:04', '1', '130800', '3');
INSERT INTO `th_area` VALUES ('130804', '鹰手营子矿区', '2016-11-10 14:49:04', '1', '130800', '3');
INSERT INTO `th_area` VALUES ('130821', '承德县', '2016-11-10 14:49:04', '1', '130800', '3');
INSERT INTO `th_area` VALUES ('130822', '兴隆县', '2016-11-10 14:49:04', '1', '130800', '3');
INSERT INTO `th_area` VALUES ('130823', '平泉县', '2016-11-10 14:49:04', '1', '130800', '3');
INSERT INTO `th_area` VALUES ('130824', '滦平县', '2016-11-10 14:49:04', '1', '130800', '3');
INSERT INTO `th_area` VALUES ('130825', '隆化县', '2016-11-10 14:49:04', '1', '130800', '3');
INSERT INTO `th_area` VALUES ('130826', '丰宁满族自治县', '2016-11-10 14:49:04', '1', '130800', '3');
INSERT INTO `th_area` VALUES ('130827', '宽城满族自治县', '2016-11-10 14:49:04', '1', '130800', '3');
INSERT INTO `th_area` VALUES ('130828', '围场满族蒙古族自治县', '2016-11-10 14:49:04', '1', '130800', '3');
INSERT INTO `th_area` VALUES ('130829', '其它区', '2016-11-10 14:49:04', '1', '130800', '3');
INSERT INTO `th_area` VALUES ('130900', '沧州市', '2016-11-10 14:49:04', '1', '130000', '2');
INSERT INTO `th_area` VALUES ('130902', '新华区', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130903', '运河区', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130921', '沧县', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130922', '青县', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130923', '东光县', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130924', '海兴县', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130925', '盐山县', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130926', '肃宁县', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130927', '南皮县', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130928', '吴桥县', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130929', '献县', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130930', '孟村回族自治县', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130981', '泊头市', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130982', '任丘市', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130983', '黄骅市', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130984', '河间市', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('130985', '其它区', '2016-11-10 14:49:04', '1', '130900', '3');
INSERT INTO `th_area` VALUES ('131000', '廊坊市', '2016-11-10 14:49:04', '1', '130000', '2');
INSERT INTO `th_area` VALUES ('131002', '安次区', '2016-11-10 14:49:04', '1', '131000', '3');
INSERT INTO `th_area` VALUES ('131003', '广阳区', '2016-11-10 14:49:04', '1', '131000', '3');
INSERT INTO `th_area` VALUES ('131022', '固安县', '2016-11-10 14:49:04', '1', '131000', '3');
INSERT INTO `th_area` VALUES ('131023', '永清县', '2016-11-10 14:49:04', '1', '131000', '3');
INSERT INTO `th_area` VALUES ('131024', '香河县', '2016-11-10 14:49:04', '1', '131000', '3');
INSERT INTO `th_area` VALUES ('131025', '大城县', '2016-11-10 14:49:04', '1', '131000', '3');
INSERT INTO `th_area` VALUES ('131026', '文安县', '2016-11-10 14:49:04', '1', '131000', '3');
INSERT INTO `th_area` VALUES ('131028', '大厂回族自治县', '2016-11-10 14:49:04', '1', '131000', '3');
INSERT INTO `th_area` VALUES ('131051', '开发区', '2016-11-10 14:49:04', '1', '131000', '3');
INSERT INTO `th_area` VALUES ('131052', '燕郊经济技术开发区', '2016-11-10 14:49:04', '1', '131000', '3');
INSERT INTO `th_area` VALUES ('131081', '霸州市', '2016-11-10 14:49:04', '1', '131000', '3');
INSERT INTO `th_area` VALUES ('131082', '三河市', '2016-11-10 14:49:04', '1', '131000', '3');
INSERT INTO `th_area` VALUES ('131083', '其它区', '2016-11-10 14:49:04', '1', '131000', '3');
INSERT INTO `th_area` VALUES ('131100', '衡水市', '2016-11-10 14:49:04', '1', '130000', '2');
INSERT INTO `th_area` VALUES ('131102', '桃城区', '2016-11-10 14:49:04', '1', '131100', '3');
INSERT INTO `th_area` VALUES ('131121', '枣强县', '2016-11-10 14:49:04', '1', '131100', '3');
INSERT INTO `th_area` VALUES ('131122', '武邑县', '2016-11-10 14:49:04', '1', '131100', '3');
INSERT INTO `th_area` VALUES ('131123', '武强县', '2016-11-10 14:49:04', '1', '131100', '3');
INSERT INTO `th_area` VALUES ('131124', '饶阳县', '2016-11-10 14:49:04', '1', '131100', '3');
INSERT INTO `th_area` VALUES ('131125', '安平县', '2016-11-10 14:49:04', '1', '131100', '3');
INSERT INTO `th_area` VALUES ('131126', '故城县', '2016-11-10 14:49:04', '1', '131100', '3');
INSERT INTO `th_area` VALUES ('131127', '景县', '2016-11-10 14:49:04', '1', '131100', '3');
INSERT INTO `th_area` VALUES ('131128', '阜城县', '2016-11-10 14:49:04', '1', '131100', '3');
INSERT INTO `th_area` VALUES ('131181', '冀州市', '2016-11-10 14:49:04', '1', '131100', '3');
INSERT INTO `th_area` VALUES ('131182', '深州市', '2016-11-10 14:49:04', '1', '131100', '3');
INSERT INTO `th_area` VALUES ('131183', '其它区', '2016-11-10 14:49:04', '1', '131100', '3');
INSERT INTO `th_area` VALUES ('140000', '山西省', '2016-11-10 14:49:04', '1', null, '1');
INSERT INTO `th_area` VALUES ('140100', '太原市', '2016-11-10 14:49:04', '1', '140000', '2');
INSERT INTO `th_area` VALUES ('140105', '小店区', '2016-11-10 14:49:04', '1', '140100', '3');
INSERT INTO `th_area` VALUES ('140106', '迎泽区', '2016-11-10 14:49:04', '1', '140100', '3');
INSERT INTO `th_area` VALUES ('140107', '杏花岭区', '2016-11-10 14:49:04', '1', '140100', '3');
INSERT INTO `th_area` VALUES ('140108', '尖草坪区', '2016-11-10 14:49:04', '1', '140100', '3');
INSERT INTO `th_area` VALUES ('140109', '万柏林区', '2016-11-10 14:49:04', '1', '140100', '3');
INSERT INTO `th_area` VALUES ('140110', '晋源区', '2016-11-10 14:49:04', '1', '140100', '3');
INSERT INTO `th_area` VALUES ('140121', '清徐县', '2016-11-10 14:49:04', '1', '140100', '3');
INSERT INTO `th_area` VALUES ('140122', '阳曲县', '2016-11-10 14:49:04', '1', '140100', '3');
INSERT INTO `th_area` VALUES ('140123', '娄烦县', '2016-11-10 14:49:04', '1', '140100', '3');
INSERT INTO `th_area` VALUES ('140181', '古交市', '2016-11-10 14:49:04', '1', '140100', '3');
INSERT INTO `th_area` VALUES ('140182', '其它区', '2016-11-10 14:49:04', '1', '140100', '3');
INSERT INTO `th_area` VALUES ('140200', '大同市', '2016-11-10 14:49:04', '1', '140000', '2');
INSERT INTO `th_area` VALUES ('140202', '城区', '2016-11-10 14:49:04', '1', '140200', '3');
INSERT INTO `th_area` VALUES ('140203', '矿区', '2016-11-10 14:49:04', '1', '140200', '3');
INSERT INTO `th_area` VALUES ('140211', '南郊区', '2016-11-10 14:49:04', '1', '140200', '3');
INSERT INTO `th_area` VALUES ('140212', '新荣区', '2016-11-10 14:49:04', '1', '140200', '3');
INSERT INTO `th_area` VALUES ('140221', '阳高县', '2016-11-10 14:49:04', '1', '140200', '3');
INSERT INTO `th_area` VALUES ('140222', '天镇县', '2016-11-10 14:49:04', '1', '140200', '3');
INSERT INTO `th_area` VALUES ('140223', '广灵县', '2016-11-10 14:49:04', '1', '140200', '3');
INSERT INTO `th_area` VALUES ('140224', '灵丘县', '2016-11-10 14:49:04', '1', '140200', '3');
INSERT INTO `th_area` VALUES ('140225', '浑源县', '2016-11-10 14:49:04', '1', '140200', '3');
INSERT INTO `th_area` VALUES ('140226', '左云县', '2016-11-10 14:49:04', '1', '140200', '3');
INSERT INTO `th_area` VALUES ('140227', '大同县', '2016-11-10 14:49:04', '1', '140200', '3');
INSERT INTO `th_area` VALUES ('140228', '其它区', '2016-11-10 14:49:04', '1', '140200', '3');
INSERT INTO `th_area` VALUES ('140300', '阳泉市', '2016-11-10 14:49:04', '1', '140000', '2');
INSERT INTO `th_area` VALUES ('140302', '城区', '2016-11-10 14:49:04', '1', '140300', '3');
INSERT INTO `th_area` VALUES ('140303', '矿区', '2016-11-10 14:49:04', '1', '140300', '3');
INSERT INTO `th_area` VALUES ('140311', '郊区', '2016-11-10 14:49:04', '1', '140300', '3');
INSERT INTO `th_area` VALUES ('140321', '平定县', '2016-11-10 14:49:04', '1', '140300', '3');
INSERT INTO `th_area` VALUES ('140322', '盂县', '2016-11-10 14:49:04', '1', '140300', '3');
INSERT INTO `th_area` VALUES ('140323', '其它区', '2016-11-10 14:49:04', '1', '140300', '3');
INSERT INTO `th_area` VALUES ('140400', '长治市', '2016-11-10 14:49:04', '1', '140000', '2');
INSERT INTO `th_area` VALUES ('140421', '长治县', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140423', '襄垣县', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140424', '屯留县', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140425', '平顺县', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140426', '黎城县', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140427', '壶关县', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140428', '长子县', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140429', '武乡县', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140430', '沁县', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140431', '沁源县', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140481', '潞城市', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140482', '城区', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140483', '郊区', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140484', '高新区', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140485', '其它区', '2016-11-10 14:49:04', '1', '140400', '3');
INSERT INTO `th_area` VALUES ('140500', '晋城市', '2016-11-10 14:49:04', '1', '140000', '2');
INSERT INTO `th_area` VALUES ('140502', '城区', '2016-11-10 14:49:04', '1', '140500', '3');
INSERT INTO `th_area` VALUES ('140521', '沁水县', '2016-11-10 14:49:04', '1', '140500', '3');
INSERT INTO `th_area` VALUES ('140522', '阳城县', '2016-11-10 14:49:04', '1', '140500', '3');
INSERT INTO `th_area` VALUES ('140524', '陵川县', '2016-11-10 14:49:04', '1', '140500', '3');
INSERT INTO `th_area` VALUES ('140525', '泽州县', '2016-11-10 14:49:04', '1', '140500', '3');
INSERT INTO `th_area` VALUES ('140581', '高平市', '2016-11-10 14:49:04', '1', '140500', '3');
INSERT INTO `th_area` VALUES ('140582', '其它区', '2016-11-10 14:49:04', '1', '140500', '3');
INSERT INTO `th_area` VALUES ('140600', '朔州市', '2016-11-10 14:49:04', '1', '140000', '2');
INSERT INTO `th_area` VALUES ('140602', '朔城区', '2016-11-10 14:49:04', '1', '140600', '3');
INSERT INTO `th_area` VALUES ('140603', '平鲁区', '2016-11-10 14:49:04', '1', '140600', '3');
INSERT INTO `th_area` VALUES ('140621', '山阴县', '2016-11-10 14:49:04', '1', '140600', '3');
INSERT INTO `th_area` VALUES ('140622', '应县', '2016-11-10 14:49:04', '1', '140600', '3');
INSERT INTO `th_area` VALUES ('140623', '右玉县', '2016-11-10 14:49:04', '1', '140600', '3');
INSERT INTO `th_area` VALUES ('140624', '怀仁县', '2016-11-10 14:49:04', '1', '140600', '3');
INSERT INTO `th_area` VALUES ('140625', '其它区', '2016-11-10 14:49:04', '1', '140600', '3');
INSERT INTO `th_area` VALUES ('140700', '晋中市', '2016-11-10 14:49:04', '1', '140000', '2');
INSERT INTO `th_area` VALUES ('140702', '榆次区', '2016-11-10 14:49:04', '1', '140700', '3');
INSERT INTO `th_area` VALUES ('140721', '榆社县', '2016-11-10 14:49:04', '1', '140700', '3');
INSERT INTO `th_area` VALUES ('140722', '左权县', '2016-11-10 14:49:04', '1', '140700', '3');
INSERT INTO `th_area` VALUES ('140723', '和顺县', '2016-11-10 14:49:04', '1', '140700', '3');
INSERT INTO `th_area` VALUES ('140724', '昔阳县', '2016-11-10 14:49:04', '1', '140700', '3');
INSERT INTO `th_area` VALUES ('140725', '寿阳县', '2016-11-10 14:49:04', '1', '140700', '3');
INSERT INTO `th_area` VALUES ('140726', '太谷县', '2016-11-10 14:49:04', '1', '140700', '3');
INSERT INTO `th_area` VALUES ('140727', '祁县', '2016-11-10 14:49:04', '1', '140700', '3');
INSERT INTO `th_area` VALUES ('140728', '平遥县', '2016-11-10 14:49:04', '1', '140700', '3');
INSERT INTO `th_area` VALUES ('140729', '灵石县', '2016-11-10 14:49:04', '1', '140700', '3');
INSERT INTO `th_area` VALUES ('140781', '介休市', '2016-11-10 14:49:04', '1', '140700', '3');
INSERT INTO `th_area` VALUES ('140782', '其它区', '2016-11-10 14:49:04', '1', '140700', '3');
INSERT INTO `th_area` VALUES ('140800', '运城市', '2016-11-10 14:49:04', '1', '140000', '2');
INSERT INTO `th_area` VALUES ('140802', '盐湖区', '2016-11-10 14:49:04', '1', '140800', '3');
INSERT INTO `th_area` VALUES ('140821', '临猗县', '2016-11-10 14:49:04', '1', '140800', '3');
INSERT INTO `th_area` VALUES ('140822', '万荣县', '2016-11-10 14:49:04', '1', '140800', '3');
INSERT INTO `th_area` VALUES ('140823', '闻喜县', '2016-11-10 14:49:04', '1', '140800', '3');
INSERT INTO `th_area` VALUES ('140824', '稷山县', '2016-11-10 14:49:04', '1', '140800', '3');
INSERT INTO `th_area` VALUES ('140825', '新绛县', '2016-11-10 14:49:04', '1', '140800', '3');
INSERT INTO `th_area` VALUES ('140826', '绛县', '2016-11-10 14:49:04', '1', '140800', '3');
INSERT INTO `th_area` VALUES ('140827', '垣曲县', '2016-11-10 14:49:04', '1', '140800', '3');
INSERT INTO `th_area` VALUES ('140828', '夏县', '2016-11-10 14:49:04', '1', '140800', '3');
INSERT INTO `th_area` VALUES ('140829', '平陆县', '2016-11-10 14:49:04', '1', '140800', '3');
INSERT INTO `th_area` VALUES ('140830', '芮城县', '2016-11-10 14:49:04', '1', '140800', '3');
INSERT INTO `th_area` VALUES ('140881', '永济市', '2016-11-10 14:49:04', '1', '140800', '3');
INSERT INTO `th_area` VALUES ('140882', '河津市', '2016-11-10 14:49:04', '1', '140800', '3');
INSERT INTO `th_area` VALUES ('140883', '其它区', '2016-11-10 14:49:04', '1', '140800', '3');
INSERT INTO `th_area` VALUES ('140900', '忻州市', '2016-11-10 14:49:04', '1', '140000', '2');
INSERT INTO `th_area` VALUES ('140902', '忻府区', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('140921', '定襄县', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('140922', '五台县', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('140923', '代县', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('140924', '繁峙县', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('140925', '宁武县', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('140926', '静乐县', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('140927', '神池县', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('140928', '五寨县', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('140929', '岢岚县', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('140930', '河曲县', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('140931', '保德县', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('140932', '偏关县', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('140981', '原平市', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('140982', '其它区', '2016-11-10 14:49:04', '1', '140900', '3');
INSERT INTO `th_area` VALUES ('141000', '临汾市', '2016-11-10 14:49:04', '1', '140000', '2');
INSERT INTO `th_area` VALUES ('141002', '尧都区', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141021', '曲沃县', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141022', '翼城县', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141023', '襄汾县', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141024', '洪洞县', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141025', '古县', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141026', '安泽县', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141027', '浮山县', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141028', '吉县', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141029', '乡宁县', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141030', '大宁县', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141031', '隰县', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141032', '永和县', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141033', '蒲县', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141034', '汾西县', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141081', '侯马市', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141082', '霍州市', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141083', '其它区', '2016-11-10 14:49:04', '1', '141000', '3');
INSERT INTO `th_area` VALUES ('141100', '吕梁市', '2016-11-10 14:49:04', '1', '140000', '2');
INSERT INTO `th_area` VALUES ('141102', '离石区', '2016-11-10 14:49:04', '1', '141100', '3');
INSERT INTO `th_area` VALUES ('141121', '文水县', '2016-11-10 14:49:04', '1', '141100', '3');
INSERT INTO `th_area` VALUES ('141122', '交城县', '2016-11-10 14:49:04', '1', '141100', '3');
INSERT INTO `th_area` VALUES ('141123', '兴县', '2016-11-10 14:49:04', '1', '141100', '3');
INSERT INTO `th_area` VALUES ('141124', '临县', '2016-11-10 14:49:04', '1', '141100', '3');
INSERT INTO `th_area` VALUES ('141125', '柳林县', '2016-11-10 14:49:04', '1', '141100', '3');
INSERT INTO `th_area` VALUES ('141126', '石楼县', '2016-11-10 14:49:04', '1', '141100', '3');
INSERT INTO `th_area` VALUES ('141127', '岚县', '2016-11-10 14:49:04', '1', '141100', '3');
INSERT INTO `th_area` VALUES ('141128', '方山县', '2016-11-10 14:49:04', '1', '141100', '3');
INSERT INTO `th_area` VALUES ('141129', '中阳县', '2016-11-10 14:49:04', '1', '141100', '3');
INSERT INTO `th_area` VALUES ('141130', '交口县', '2016-11-10 14:49:04', '1', '141100', '3');
INSERT INTO `th_area` VALUES ('141181', '孝义市', '2016-11-10 14:49:04', '1', '141100', '3');
INSERT INTO `th_area` VALUES ('141182', '汾阳市', '2016-11-10 14:49:04', '1', '141100', '3');
INSERT INTO `th_area` VALUES ('141183', '其它区', '2016-11-10 14:49:04', '1', '141100', '3');
INSERT INTO `th_area` VALUES ('150000', '内蒙古', '2016-11-10 14:49:04', '1', null, '1');
INSERT INTO `th_area` VALUES ('150100', '呼和浩特市', '2016-11-10 14:49:04', '1', '150000', '2');
INSERT INTO `th_area` VALUES ('150102', '新城区', '2016-11-10 14:49:04', '1', '150100', '3');
INSERT INTO `th_area` VALUES ('150103', '回民区', '2016-11-10 14:49:04', '1', '150100', '3');
INSERT INTO `th_area` VALUES ('150104', '玉泉区', '2016-11-10 14:49:04', '1', '150100', '3');
INSERT INTO `th_area` VALUES ('150105', '赛罕区', '2016-11-10 14:49:04', '1', '150100', '3');
INSERT INTO `th_area` VALUES ('150121', '土默特左旗', '2016-11-10 14:49:04', '1', '150100', '3');
INSERT INTO `th_area` VALUES ('150122', '托克托县', '2016-11-10 14:49:04', '1', '150100', '3');
INSERT INTO `th_area` VALUES ('150123', '和林格尔县', '2016-11-10 14:49:04', '1', '150100', '3');
INSERT INTO `th_area` VALUES ('150124', '清水河县', '2016-11-10 14:49:04', '1', '150100', '3');
INSERT INTO `th_area` VALUES ('150125', '武川县', '2016-11-10 14:49:04', '1', '150100', '3');
INSERT INTO `th_area` VALUES ('150126', '其它区', '2016-11-10 14:49:04', '1', '150100', '3');
INSERT INTO `th_area` VALUES ('150127', '如意开发区', '2016-11-10 14:49:04', '1', '150100', '3');
INSERT INTO `th_area` VALUES ('150128', '金川开发区', '2016-11-10 14:49:04', '1', '150100', '3');
INSERT INTO `th_area` VALUES ('150200', '包头市', '2016-11-10 14:49:04', '1', '150000', '2');
INSERT INTO `th_area` VALUES ('150202', '东河区', '2016-11-10 14:49:04', '1', '150200', '3');
INSERT INTO `th_area` VALUES ('150203', '昆都仑区', '2016-11-10 14:49:04', '1', '150200', '3');
INSERT INTO `th_area` VALUES ('150204', '青山区', '2016-11-10 14:49:04', '1', '150200', '3');
INSERT INTO `th_area` VALUES ('150205', '石拐区', '2016-11-10 14:49:04', '1', '150200', '3');
INSERT INTO `th_area` VALUES ('150206', '白云矿区', '2016-11-10 14:49:04', '1', '150200', '3');
INSERT INTO `th_area` VALUES ('150207', '九原区', '2016-11-10 14:49:04', '1', '150200', '3');
INSERT INTO `th_area` VALUES ('150221', '土默特右旗', '2016-11-10 14:49:04', '1', '150200', '3');
INSERT INTO `th_area` VALUES ('150222', '固阳县', '2016-11-10 14:49:04', '1', '150200', '3');
INSERT INTO `th_area` VALUES ('150223', '达尔罕茂明安联合旗', '2016-11-10 14:49:04', '1', '150200', '3');
INSERT INTO `th_area` VALUES ('150224', '其它区', '2016-11-10 14:49:04', '1', '150200', '3');
INSERT INTO `th_area` VALUES ('150225', '稀土高新区', '2016-11-10 14:49:04', '1', '150200', '3');
INSERT INTO `th_area` VALUES ('150226', '滨河新区', '2016-11-10 14:49:04', '1', '150200', '3');
INSERT INTO `th_area` VALUES ('150300', '乌海市', '2016-11-10 14:49:04', '1', '150000', '2');
INSERT INTO `th_area` VALUES ('150302', '海勃湾区', '2016-11-10 14:49:04', '1', '150300', '3');
INSERT INTO `th_area` VALUES ('150303', '海南区', '2016-11-10 14:49:04', '1', '150300', '3');
INSERT INTO `th_area` VALUES ('150304', '乌达区', '2016-11-10 14:49:04', '1', '150300', '3');
INSERT INTO `th_area` VALUES ('150305', '其它区', '2016-11-10 14:49:04', '1', '150300', '3');
INSERT INTO `th_area` VALUES ('150400', '赤峰市', '2016-11-10 14:49:04', '1', '150000', '2');
INSERT INTO `th_area` VALUES ('150402', '红山区', '2016-11-10 14:49:04', '1', '150400', '3');
INSERT INTO `th_area` VALUES ('150403', '元宝山区', '2016-11-10 14:49:04', '1', '150400', '3');
INSERT INTO `th_area` VALUES ('150404', '松山区', '2016-11-10 14:49:04', '1', '150400', '3');
INSERT INTO `th_area` VALUES ('150421', '阿鲁科尔沁旗', '2016-11-10 14:49:04', '1', '150400', '3');
INSERT INTO `th_area` VALUES ('150422', '巴林左旗', '2016-11-10 14:49:04', '1', '150400', '3');
INSERT INTO `th_area` VALUES ('150423', '巴林右旗', '2016-11-10 14:49:04', '1', '150400', '3');
INSERT INTO `th_area` VALUES ('150424', '林西县', '2016-11-10 14:49:04', '1', '150400', '3');
INSERT INTO `th_area` VALUES ('150425', '克什克腾旗', '2016-11-10 14:49:04', '1', '150400', '3');
INSERT INTO `th_area` VALUES ('150426', '翁牛特旗', '2016-11-10 14:49:04', '1', '150400', '3');
INSERT INTO `th_area` VALUES ('150428', '喀喇沁旗', '2016-11-10 14:49:04', '1', '150400', '3');
INSERT INTO `th_area` VALUES ('150429', '宁城县', '2016-11-10 14:49:04', '1', '150400', '3');
INSERT INTO `th_area` VALUES ('150430', '敖汉旗', '2016-11-10 14:49:04', '1', '150400', '3');
INSERT INTO `th_area` VALUES ('150431', '其它区', '2016-11-10 14:49:04', '1', '150400', '3');
INSERT INTO `th_area` VALUES ('150500', '通辽市', '2016-11-10 14:49:04', '1', '150000', '2');
INSERT INTO `th_area` VALUES ('150502', '科尔沁区', '2016-11-10 14:49:04', '1', '150500', '3');
INSERT INTO `th_area` VALUES ('150521', '科尔沁左翼中旗', '2016-11-10 14:49:04', '1', '150500', '3');
INSERT INTO `th_area` VALUES ('150522', '科尔沁左翼后旗', '2016-11-10 14:49:04', '1', '150500', '3');
INSERT INTO `th_area` VALUES ('150523', '开鲁县', '2016-11-10 14:49:04', '1', '150500', '3');
INSERT INTO `th_area` VALUES ('150524', '库伦旗', '2016-11-10 14:49:04', '1', '150500', '3');
INSERT INTO `th_area` VALUES ('150525', '奈曼旗', '2016-11-10 14:49:04', '1', '150500', '3');
INSERT INTO `th_area` VALUES ('150526', '扎鲁特旗', '2016-11-10 14:49:04', '1', '150500', '3');
INSERT INTO `th_area` VALUES ('150581', '霍林郭勒市', '2016-11-10 14:49:04', '1', '150500', '3');
INSERT INTO `th_area` VALUES ('150582', '其它区', '2016-11-10 14:49:04', '1', '150500', '3');
INSERT INTO `th_area` VALUES ('150600', '鄂尔多斯市', '2016-11-10 14:49:04', '1', '150000', '2');
INSERT INTO `th_area` VALUES ('150602', '东胜区', '2016-11-10 14:49:04', '1', '150600', '3');
INSERT INTO `th_area` VALUES ('150621', '达拉特旗', '2016-11-10 14:49:04', '1', '150600', '3');
INSERT INTO `th_area` VALUES ('150622', '准格尔旗', '2016-11-10 14:49:04', '1', '150600', '3');
INSERT INTO `th_area` VALUES ('150623', '鄂托克前旗', '2016-11-10 14:49:04', '1', '150600', '3');
INSERT INTO `th_area` VALUES ('150624', '鄂托克旗', '2016-11-10 14:49:04', '1', '150600', '3');
INSERT INTO `th_area` VALUES ('150625', '杭锦旗', '2016-11-10 14:49:04', '1', '150600', '3');
INSERT INTO `th_area` VALUES ('150626', '乌审旗', '2016-11-10 14:49:04', '1', '150600', '3');
INSERT INTO `th_area` VALUES ('150627', '伊金霍洛旗', '2016-11-10 14:49:04', '1', '150600', '3');
INSERT INTO `th_area` VALUES ('150628', '其它区', '2016-11-10 14:49:04', '1', '150600', '3');
INSERT INTO `th_area` VALUES ('150700', '呼伦贝尔市', '2016-11-10 14:49:04', '1', '150000', '2');
INSERT INTO `th_area` VALUES ('150702', '海拉尔区', '2016-11-10 14:49:04', '1', '150700', '3');
INSERT INTO `th_area` VALUES ('150721', '阿荣旗', '2016-11-10 14:49:04', '1', '150700', '3');
INSERT INTO `th_area` VALUES ('150722', '莫力达瓦达斡尔族自治旗', '2016-11-10 14:49:04', '1', '150700', '3');
INSERT INTO `th_area` VALUES ('150723', '鄂伦春自治旗', '2016-11-10 14:49:04', '1', '150700', '3');
INSERT INTO `th_area` VALUES ('150724', '鄂温克族自治旗', '2016-11-10 14:49:04', '1', '150700', '3');
INSERT INTO `th_area` VALUES ('150725', '陈巴尔虎旗', '2016-11-10 14:49:04', '1', '150700', '3');
INSERT INTO `th_area` VALUES ('150726', '新巴尔虎左旗', '2016-11-10 14:49:04', '1', '150700', '3');
INSERT INTO `th_area` VALUES ('150727', '新巴尔虎右旗', '2016-11-10 14:49:04', '1', '150700', '3');
INSERT INTO `th_area` VALUES ('150781', '满洲里市', '2016-11-10 14:49:04', '1', '150700', '3');
INSERT INTO `th_area` VALUES ('150782', '牙克石市', '2016-11-10 14:49:04', '1', '150700', '3');
INSERT INTO `th_area` VALUES ('150783', '扎兰屯市', '2016-11-10 14:49:04', '1', '150700', '3');
INSERT INTO `th_area` VALUES ('150784', '额尔古纳市', '2016-11-10 14:49:04', '1', '150700', '3');
INSERT INTO `th_area` VALUES ('150785', '根河市', '2016-11-10 14:49:04', '1', '150700', '3');
INSERT INTO `th_area` VALUES ('150786', '其它区', '2016-11-10 14:49:04', '1', '150700', '3');
INSERT INTO `th_area` VALUES ('150800', '巴彦淖尔市', '2016-11-10 14:49:04', '1', '150000', '2');
INSERT INTO `th_area` VALUES ('150802', '临河区', '2016-11-10 14:49:04', '1', '150800', '3');
INSERT INTO `th_area` VALUES ('150821', '五原县', '2016-11-10 14:49:04', '1', '150800', '3');
INSERT INTO `th_area` VALUES ('150822', '磴口县', '2016-11-10 14:49:04', '1', '150800', '3');
INSERT INTO `th_area` VALUES ('150823', '乌拉特前旗', '2016-11-10 14:49:04', '1', '150800', '3');
INSERT INTO `th_area` VALUES ('150824', '乌拉特中旗', '2016-11-10 14:49:04', '1', '150800', '3');
INSERT INTO `th_area` VALUES ('150825', '乌拉特后旗', '2016-11-10 14:49:04', '1', '150800', '3');
INSERT INTO `th_area` VALUES ('150826', '杭锦后旗', '2016-11-10 14:49:04', '1', '150800', '3');
INSERT INTO `th_area` VALUES ('150827', '其它区', '2016-11-10 14:49:04', '1', '150800', '3');
INSERT INTO `th_area` VALUES ('150900', '乌兰察布市', '2016-11-10 14:49:04', '1', '150000', '2');
INSERT INTO `th_area` VALUES ('150902', '集宁区', '2016-11-10 14:49:04', '1', '150900', '3');
INSERT INTO `th_area` VALUES ('150921', '卓资县', '2016-11-10 14:49:04', '1', '150900', '3');
INSERT INTO `th_area` VALUES ('150922', '化德县', '2016-11-10 14:49:04', '1', '150900', '3');
INSERT INTO `th_area` VALUES ('150923', '商都县', '2016-11-10 14:49:04', '1', '150900', '3');
INSERT INTO `th_area` VALUES ('150924', '兴和县', '2016-11-10 14:49:04', '1', '150900', '3');
INSERT INTO `th_area` VALUES ('150925', '凉城县', '2016-11-10 14:49:04', '1', '150900', '3');
INSERT INTO `th_area` VALUES ('150926', '察哈尔右翼前旗', '2016-11-10 14:49:04', '1', '150900', '3');
INSERT INTO `th_area` VALUES ('150927', '察哈尔右翼中旗', '2016-11-10 14:49:04', '1', '150900', '3');
INSERT INTO `th_area` VALUES ('150928', '察哈尔右翼后旗', '2016-11-10 14:49:04', '1', '150900', '3');
INSERT INTO `th_area` VALUES ('150929', '四子王旗', '2016-11-10 14:49:04', '1', '150900', '3');
INSERT INTO `th_area` VALUES ('150981', '丰镇市', '2016-11-10 14:49:04', '1', '150900', '3');
INSERT INTO `th_area` VALUES ('150982', '其它区', '2016-11-10 14:49:04', '1', '150900', '3');
INSERT INTO `th_area` VALUES ('152200', '兴安盟', '2016-11-10 14:49:04', '1', '150000', '2');
INSERT INTO `th_area` VALUES ('152201', '乌兰浩特市', '2016-11-10 14:49:04', '1', '152200', '3');
INSERT INTO `th_area` VALUES ('152202', '阿尔山市', '2016-11-10 14:49:04', '1', '152200', '3');
INSERT INTO `th_area` VALUES ('152221', '科尔沁右翼前旗', '2016-11-10 14:49:04', '1', '152200', '3');
INSERT INTO `th_area` VALUES ('152222', '科尔沁右翼中旗', '2016-11-10 14:49:04', '1', '152200', '3');
INSERT INTO `th_area` VALUES ('152223', '扎赉特旗', '2016-11-10 14:49:04', '1', '152200', '3');
INSERT INTO `th_area` VALUES ('152224', '突泉县', '2016-11-10 14:49:04', '1', '152200', '3');
INSERT INTO `th_area` VALUES ('152225', '其它区', '2016-11-10 14:49:04', '1', '152200', '3');
INSERT INTO `th_area` VALUES ('152500', '锡林郭勒盟', '2016-11-10 14:49:04', '1', '150000', '2');
INSERT INTO `th_area` VALUES ('152501', '二连浩特市', '2016-11-10 14:49:04', '1', '152500', '3');
INSERT INTO `th_area` VALUES ('152502', '锡林浩特市', '2016-11-10 14:49:04', '1', '152500', '3');
INSERT INTO `th_area` VALUES ('152522', '阿巴嘎旗', '2016-11-10 14:49:04', '1', '152500', '3');
INSERT INTO `th_area` VALUES ('152523', '苏尼特左旗', '2016-11-10 14:49:04', '1', '152500', '3');
INSERT INTO `th_area` VALUES ('152524', '苏尼特右旗', '2016-11-10 14:49:04', '1', '152500', '3');
INSERT INTO `th_area` VALUES ('152525', '东乌珠穆沁旗', '2016-11-10 14:49:04', '1', '152500', '3');
INSERT INTO `th_area` VALUES ('152526', '西乌珠穆沁旗', '2016-11-10 14:49:04', '1', '152500', '3');
INSERT INTO `th_area` VALUES ('152527', '太仆寺旗', '2016-11-10 14:49:04', '1', '152500', '3');
INSERT INTO `th_area` VALUES ('152528', '镶黄旗', '2016-11-10 14:49:04', '1', '152500', '3');
INSERT INTO `th_area` VALUES ('152529', '正镶白旗', '2016-11-10 14:49:04', '1', '152500', '3');
INSERT INTO `th_area` VALUES ('152530', '正蓝旗', '2016-11-10 14:49:04', '1', '152500', '3');
INSERT INTO `th_area` VALUES ('152531', '多伦县', '2016-11-10 14:49:04', '1', '152500', '3');
INSERT INTO `th_area` VALUES ('152532', '其它区', '2016-11-10 14:49:04', '1', '152500', '3');
INSERT INTO `th_area` VALUES ('152900', '阿拉善盟', '2016-11-10 14:49:04', '1', '150000', '2');
INSERT INTO `th_area` VALUES ('152921', '阿拉善左旗', '2016-11-10 14:49:04', '1', '152900', '3');
INSERT INTO `th_area` VALUES ('152922', '阿拉善右旗', '2016-11-10 14:49:04', '1', '152900', '3');
INSERT INTO `th_area` VALUES ('152923', '额济纳旗', '2016-11-10 14:49:04', '1', '152900', '3');
INSERT INTO `th_area` VALUES ('152924', '其它区', '2016-11-10 14:49:04', '1', '152900', '3');
INSERT INTO `th_area` VALUES ('210000', '辽宁省', '2016-11-10 14:49:04', '1', null, '1');
INSERT INTO `th_area` VALUES ('210100', '沈阳市', '2016-11-10 14:49:05', '1', '210000', '2');
INSERT INTO `th_area` VALUES ('210102', '和平区', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210103', '沈河区', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210104', '大东区', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210105', '皇姑区', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210106', '铁西区', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210111', '苏家屯区', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210112', '东陵区', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210113', '新城子区', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210114', '于洪区', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210122', '辽中县', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210123', '康平县', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210124', '法库县', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210181', '新民市', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210182', '浑南新区', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210183', '张士开发区', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210184', '沈北新区', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210185', '其它区', '2016-11-10 14:49:05', '1', '210100', '3');
INSERT INTO `th_area` VALUES ('210200', '大连市', '2016-11-10 14:49:05', '1', '210000', '2');
INSERT INTO `th_area` VALUES ('210202', '中山区', '2016-11-10 14:49:05', '1', '210200', '3');
INSERT INTO `th_area` VALUES ('210203', '西岗区', '2016-11-10 14:49:05', '1', '210200', '3');
INSERT INTO `th_area` VALUES ('210204', '沙河口区', '2016-11-10 14:49:05', '1', '210200', '3');
INSERT INTO `th_area` VALUES ('210211', '甘井子区', '2016-11-10 14:49:05', '1', '210200', '3');
INSERT INTO `th_area` VALUES ('210212', '旅顺口区', '2016-11-10 14:49:05', '1', '210200', '3');
INSERT INTO `th_area` VALUES ('210213', '金州区', '2016-11-10 14:49:05', '1', '210200', '3');
INSERT INTO `th_area` VALUES ('210224', '长海县', '2016-11-10 14:49:05', '1', '210200', '3');
INSERT INTO `th_area` VALUES ('210251', '开发区', '2016-11-10 14:49:05', '1', '210200', '3');
INSERT INTO `th_area` VALUES ('210281', '瓦房店市', '2016-11-10 14:49:05', '1', '210200', '3');
INSERT INTO `th_area` VALUES ('210282', '普兰店市', '2016-11-10 14:49:05', '1', '210200', '3');
INSERT INTO `th_area` VALUES ('210283', '庄河市', '2016-11-10 14:49:05', '1', '210200', '3');
INSERT INTO `th_area` VALUES ('210297', '岭前区', '2016-11-10 14:49:05', '1', '210200', '3');
INSERT INTO `th_area` VALUES ('210298', '其它区', '2016-11-10 14:49:05', '1', '210200', '3');
INSERT INTO `th_area` VALUES ('210300', '鞍山市', '2016-11-10 14:49:05', '1', '210000', '2');
INSERT INTO `th_area` VALUES ('210302', '铁东区', '2016-11-10 14:49:05', '1', '210300', '3');
INSERT INTO `th_area` VALUES ('210303', '铁西区', '2016-11-10 14:49:05', '1', '210300', '3');
INSERT INTO `th_area` VALUES ('210304', '立山区', '2016-11-10 14:49:05', '1', '210300', '3');
INSERT INTO `th_area` VALUES ('210311', '千山区', '2016-11-10 14:49:05', '1', '210300', '3');
INSERT INTO `th_area` VALUES ('210321', '台安县', '2016-11-10 14:49:05', '1', '210300', '3');
INSERT INTO `th_area` VALUES ('210323', '岫岩满族自治县', '2016-11-10 14:49:05', '1', '210300', '3');
INSERT INTO `th_area` VALUES ('210351', '高新区', '2016-11-10 14:49:05', '1', '210300', '3');
INSERT INTO `th_area` VALUES ('210381', '海城市', '2016-11-10 14:49:05', '1', '210300', '3');
INSERT INTO `th_area` VALUES ('210382', '其它区', '2016-11-10 14:49:05', '1', '210300', '3');
INSERT INTO `th_area` VALUES ('210400', '抚顺市', '2016-11-10 14:49:05', '1', '210000', '2');
INSERT INTO `th_area` VALUES ('210402', '新抚区', '2016-11-10 14:49:05', '1', '210400', '3');
INSERT INTO `th_area` VALUES ('210403', '东洲区', '2016-11-10 14:49:05', '1', '210400', '3');
INSERT INTO `th_area` VALUES ('210404', '望花区', '2016-11-10 14:49:05', '1', '210400', '3');
INSERT INTO `th_area` VALUES ('210411', '顺城区', '2016-11-10 14:49:05', '1', '210400', '3');
INSERT INTO `th_area` VALUES ('210421', '抚顺县', '2016-11-10 14:49:05', '1', '210400', '3');
INSERT INTO `th_area` VALUES ('210422', '新宾满族自治县', '2016-11-10 14:49:05', '1', '210400', '3');
INSERT INTO `th_area` VALUES ('210423', '清原满族自治县', '2016-11-10 14:49:05', '1', '210400', '3');
INSERT INTO `th_area` VALUES ('210424', '其它区', '2016-11-10 14:49:05', '1', '210400', '3');
INSERT INTO `th_area` VALUES ('210500', '本溪市', '2016-11-10 14:49:05', '1', '210000', '2');
INSERT INTO `th_area` VALUES ('210502', '平山区', '2016-11-10 14:49:05', '1', '210500', '3');
INSERT INTO `th_area` VALUES ('210503', '溪湖区', '2016-11-10 14:49:05', '1', '210500', '3');
INSERT INTO `th_area` VALUES ('210504', '明山区', '2016-11-10 14:49:05', '1', '210500', '3');
INSERT INTO `th_area` VALUES ('210505', '南芬区', '2016-11-10 14:49:05', '1', '210500', '3');
INSERT INTO `th_area` VALUES ('210521', '本溪满族自治县', '2016-11-10 14:49:05', '1', '210500', '3');
INSERT INTO `th_area` VALUES ('210522', '桓仁满族自治县', '2016-11-10 14:49:05', '1', '210500', '3');
INSERT INTO `th_area` VALUES ('210523', '其它区', '2016-11-10 14:49:05', '1', '210500', '3');
INSERT INTO `th_area` VALUES ('210600', '丹东市', '2016-11-10 14:49:05', '1', '210000', '2');
INSERT INTO `th_area` VALUES ('210602', '元宝区', '2016-11-10 14:49:05', '1', '210600', '3');
INSERT INTO `th_area` VALUES ('210603', '振兴区', '2016-11-10 14:49:05', '1', '210600', '3');
INSERT INTO `th_area` VALUES ('210604', '振安区', '2016-11-10 14:49:05', '1', '210600', '3');
INSERT INTO `th_area` VALUES ('210624', '宽甸满族自治县', '2016-11-10 14:49:05', '1', '210600', '3');
INSERT INTO `th_area` VALUES ('210681', '东港市', '2016-11-10 14:49:05', '1', '210600', '3');
INSERT INTO `th_area` VALUES ('210682', '凤城市', '2016-11-10 14:49:05', '1', '210600', '3');
INSERT INTO `th_area` VALUES ('210683', '其它区', '2016-11-10 14:49:05', '1', '210600', '3');
INSERT INTO `th_area` VALUES ('210700', '锦州市', '2016-11-10 14:49:05', '1', '210000', '2');
INSERT INTO `th_area` VALUES ('210702', '古塔区', '2016-11-10 14:49:05', '1', '210700', '3');
INSERT INTO `th_area` VALUES ('210703', '凌河区', '2016-11-10 14:49:05', '1', '210700', '3');
INSERT INTO `th_area` VALUES ('210711', '太和区', '2016-11-10 14:49:05', '1', '210700', '3');
INSERT INTO `th_area` VALUES ('210726', '黑山县', '2016-11-10 14:49:05', '1', '210700', '3');
INSERT INTO `th_area` VALUES ('210727', '义县', '2016-11-10 14:49:05', '1', '210700', '3');
INSERT INTO `th_area` VALUES ('210781', '凌海市', '2016-11-10 14:49:05', '1', '210700', '3');
INSERT INTO `th_area` VALUES ('210782', '北镇市', '2016-11-10 14:49:05', '1', '210700', '3');
INSERT INTO `th_area` VALUES ('210783', '其它区', '2016-11-10 14:49:05', '1', '210700', '3');
INSERT INTO `th_area` VALUES ('210800', '营口市', '2016-11-10 14:49:05', '1', '210000', '2');
INSERT INTO `th_area` VALUES ('210802', '站前区', '2016-11-10 14:49:05', '1', '210800', '3');
INSERT INTO `th_area` VALUES ('210803', '西市区', '2016-11-10 14:49:05', '1', '210800', '3');
INSERT INTO `th_area` VALUES ('210804', '鲅鱼圈区', '2016-11-10 14:49:05', '1', '210800', '3');
INSERT INTO `th_area` VALUES ('210811', '老边区', '2016-11-10 14:49:05', '1', '210800', '3');
INSERT INTO `th_area` VALUES ('210881', '盖州市', '2016-11-10 14:49:05', '1', '210800', '3');
INSERT INTO `th_area` VALUES ('210882', '大石桥市', '2016-11-10 14:49:05', '1', '210800', '3');
INSERT INTO `th_area` VALUES ('210883', '其它区', '2016-11-10 14:49:05', '1', '210800', '3');
INSERT INTO `th_area` VALUES ('210900', '阜新市', '2016-11-10 14:49:05', '1', '210000', '2');
INSERT INTO `th_area` VALUES ('210902', '海州区', '2016-11-10 14:49:05', '1', '210900', '3');
INSERT INTO `th_area` VALUES ('210903', '新邱区', '2016-11-10 14:49:05', '1', '210900', '3');
INSERT INTO `th_area` VALUES ('210904', '太平区', '2016-11-10 14:49:05', '1', '210900', '3');
INSERT INTO `th_area` VALUES ('210905', '清河门区', '2016-11-10 14:49:05', '1', '210900', '3');
INSERT INTO `th_area` VALUES ('210911', '细河区', '2016-11-10 14:49:05', '1', '210900', '3');
INSERT INTO `th_area` VALUES ('210921', '阜新蒙古族自治县', '2016-11-10 14:49:05', '1', '210900', '3');
INSERT INTO `th_area` VALUES ('210922', '彰武县', '2016-11-10 14:49:05', '1', '210900', '3');
INSERT INTO `th_area` VALUES ('210923', '其它区', '2016-11-10 14:49:05', '1', '210900', '3');
INSERT INTO `th_area` VALUES ('211000', '辽阳市', '2016-11-10 14:49:05', '1', '210000', '2');
INSERT INTO `th_area` VALUES ('211002', '白塔区', '2016-11-10 14:49:05', '1', '211000', '3');
INSERT INTO `th_area` VALUES ('211003', '文圣区', '2016-11-10 14:49:05', '1', '211000', '3');
INSERT INTO `th_area` VALUES ('211004', '宏伟区', '2016-11-10 14:49:05', '1', '211000', '3');
INSERT INTO `th_area` VALUES ('211005', '弓长岭区', '2016-11-10 14:49:05', '1', '211000', '3');
INSERT INTO `th_area` VALUES ('211011', '太子河区', '2016-11-10 14:49:05', '1', '211000', '3');
INSERT INTO `th_area` VALUES ('211021', '辽阳县', '2016-11-10 14:49:05', '1', '211000', '3');
INSERT INTO `th_area` VALUES ('211081', '灯塔市', '2016-11-10 14:49:05', '1', '211000', '3');
INSERT INTO `th_area` VALUES ('211082', '其它区', '2016-11-10 14:49:05', '1', '211000', '3');
INSERT INTO `th_area` VALUES ('211100', '盘锦市', '2016-11-10 14:49:05', '1', '210000', '2');
INSERT INTO `th_area` VALUES ('211102', '双台子区', '2016-11-10 14:49:05', '1', '211100', '3');
INSERT INTO `th_area` VALUES ('211103', '兴隆台区', '2016-11-10 14:49:05', '1', '211100', '3');
INSERT INTO `th_area` VALUES ('211121', '大洼县', '2016-11-10 14:49:05', '1', '211100', '3');
INSERT INTO `th_area` VALUES ('211122', '盘山县', '2016-11-10 14:49:05', '1', '211100', '3');
INSERT INTO `th_area` VALUES ('211123', '其它区', '2016-11-10 14:49:05', '1', '211100', '3');
INSERT INTO `th_area` VALUES ('211200', '铁岭市', '2016-11-10 14:49:05', '1', '210000', '2');
INSERT INTO `th_area` VALUES ('211202', '银州区', '2016-11-10 14:49:05', '1', '211200', '3');
INSERT INTO `th_area` VALUES ('211204', '清河区', '2016-11-10 14:49:05', '1', '211200', '3');
INSERT INTO `th_area` VALUES ('211221', '铁岭县', '2016-11-10 14:49:05', '1', '211200', '3');
INSERT INTO `th_area` VALUES ('211223', '西丰县', '2016-11-10 14:49:05', '1', '211200', '3');
INSERT INTO `th_area` VALUES ('211224', '昌图县', '2016-11-10 14:49:05', '1', '211200', '3');
INSERT INTO `th_area` VALUES ('211281', '调兵山市', '2016-11-10 14:49:05', '1', '211200', '3');
INSERT INTO `th_area` VALUES ('211282', '开原市', '2016-11-10 14:49:05', '1', '211200', '3');
INSERT INTO `th_area` VALUES ('211283', '其它区', '2016-11-10 14:49:05', '1', '211200', '3');
INSERT INTO `th_area` VALUES ('211300', '朝阳市', '2016-11-10 14:49:05', '1', '210000', '2');
INSERT INTO `th_area` VALUES ('211302', '双塔区', '2016-11-10 14:49:05', '1', '211300', '3');
INSERT INTO `th_area` VALUES ('211303', '龙城区', '2016-11-10 14:49:05', '1', '211300', '3');
INSERT INTO `th_area` VALUES ('211321', '朝阳县', '2016-11-10 14:49:05', '1', '211300', '3');
INSERT INTO `th_area` VALUES ('211322', '建平县', '2016-11-10 14:49:05', '1', '211300', '3');
INSERT INTO `th_area` VALUES ('211324', '喀喇沁左翼蒙古族自治县', '2016-11-10 14:49:05', '1', '211300', '3');
INSERT INTO `th_area` VALUES ('211381', '北票市', '2016-11-10 14:49:05', '1', '211300', '3');
INSERT INTO `th_area` VALUES ('211382', '凌源市', '2016-11-10 14:49:05', '1', '211300', '3');
INSERT INTO `th_area` VALUES ('211383', '其它区', '2016-11-10 14:49:05', '1', '211300', '3');
INSERT INTO `th_area` VALUES ('211400', '葫芦岛市', '2016-11-10 14:49:05', '1', '210000', '2');
INSERT INTO `th_area` VALUES ('211402', '连山区', '2016-11-10 14:49:05', '1', '211400', '3');
INSERT INTO `th_area` VALUES ('211403', '龙港区', '2016-11-10 14:49:05', '1', '211400', '3');
INSERT INTO `th_area` VALUES ('211404', '南票区', '2016-11-10 14:49:05', '1', '211400', '3');
INSERT INTO `th_area` VALUES ('211421', '绥中县', '2016-11-10 14:49:05', '1', '211400', '3');
INSERT INTO `th_area` VALUES ('211422', '建昌县', '2016-11-10 14:49:05', '1', '211400', '3');
INSERT INTO `th_area` VALUES ('211481', '兴城市', '2016-11-10 14:49:05', '1', '211400', '3');
INSERT INTO `th_area` VALUES ('211482', '其它区', '2016-11-10 14:49:05', '1', '211400', '3');
INSERT INTO `th_area` VALUES ('220000', '吉林省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('220100', '长春市', '2016-11-10 14:49:05', '1', '220000', '2');
INSERT INTO `th_area` VALUES ('220102', '南关区', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220103', '宽城区', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220104', '朝阳区', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220105', '二道区', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220106', '绿园区', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220112', '双阳区', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220122', '农安县', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220181', '九台市', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220182', '榆树市', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220183', '德惠市', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220184', '高新技术产业开发区', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220185', '汽车产业开发区', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220186', '经济技术开发区', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220187', '净月旅游开发区', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220188', '其它区', '2016-11-10 14:49:05', '1', '220100', '3');
INSERT INTO `th_area` VALUES ('220200', '吉林市', '2016-11-10 14:49:05', '1', '220000', '2');
INSERT INTO `th_area` VALUES ('220202', '昌邑区', '2016-11-10 14:49:05', '1', '220200', '3');
INSERT INTO `th_area` VALUES ('220203', '龙潭区', '2016-11-10 14:49:05', '1', '220200', '3');
INSERT INTO `th_area` VALUES ('220204', '船营区', '2016-11-10 14:49:05', '1', '220200', '3');
INSERT INTO `th_area` VALUES ('220211', '丰满区', '2016-11-10 14:49:05', '1', '220200', '3');
INSERT INTO `th_area` VALUES ('220221', '永吉县', '2016-11-10 14:49:05', '1', '220200', '3');
INSERT INTO `th_area` VALUES ('220281', '蛟河市', '2016-11-10 14:49:05', '1', '220200', '3');
INSERT INTO `th_area` VALUES ('220282', '桦甸市', '2016-11-10 14:49:05', '1', '220200', '3');
INSERT INTO `th_area` VALUES ('220283', '舒兰市', '2016-11-10 14:49:05', '1', '220200', '3');
INSERT INTO `th_area` VALUES ('220284', '磐石市', '2016-11-10 14:49:05', '1', '220200', '3');
INSERT INTO `th_area` VALUES ('220285', '其它区', '2016-11-10 14:49:05', '1', '220200', '3');
INSERT INTO `th_area` VALUES ('220300', '四平市', '2016-11-10 14:49:05', '1', '220000', '2');
INSERT INTO `th_area` VALUES ('220302', '铁西区', '2016-11-10 14:49:05', '1', '220300', '3');
INSERT INTO `th_area` VALUES ('220303', '铁东区', '2016-11-10 14:49:05', '1', '220300', '3');
INSERT INTO `th_area` VALUES ('220322', '梨树县', '2016-11-10 14:49:05', '1', '220300', '3');
INSERT INTO `th_area` VALUES ('220323', '伊通满族自治县', '2016-11-10 14:49:05', '1', '220300', '3');
INSERT INTO `th_area` VALUES ('220381', '公主岭市', '2016-11-10 14:49:05', '1', '220300', '3');
INSERT INTO `th_area` VALUES ('220382', '双辽市', '2016-11-10 14:49:05', '1', '220300', '3');
INSERT INTO `th_area` VALUES ('220383', '其它区', '2016-11-10 14:49:05', '1', '220300', '3');
INSERT INTO `th_area` VALUES ('220400', '辽源市', '2016-11-10 14:49:05', '1', '220000', '2');
INSERT INTO `th_area` VALUES ('220402', '龙山区', '2016-11-10 14:49:05', '1', '220400', '3');
INSERT INTO `th_area` VALUES ('220403', '西安区', '2016-11-10 14:49:05', '1', '220400', '3');
INSERT INTO `th_area` VALUES ('220421', '东丰县', '2016-11-10 14:49:05', '1', '220400', '3');
INSERT INTO `th_area` VALUES ('220422', '东辽县', '2016-11-10 14:49:05', '1', '220400', '3');
INSERT INTO `th_area` VALUES ('220423', '其它区', '2016-11-10 14:49:05', '1', '220400', '3');
INSERT INTO `th_area` VALUES ('220500', '通化市', '2016-11-10 14:49:05', '1', '220000', '2');
INSERT INTO `th_area` VALUES ('220502', '东昌区', '2016-11-10 14:49:05', '1', '220500', '3');
INSERT INTO `th_area` VALUES ('220503', '二道江区', '2016-11-10 14:49:05', '1', '220500', '3');
INSERT INTO `th_area` VALUES ('220521', '通化县', '2016-11-10 14:49:05', '1', '220500', '3');
INSERT INTO `th_area` VALUES ('220523', '辉南县', '2016-11-10 14:49:05', '1', '220500', '3');
INSERT INTO `th_area` VALUES ('220524', '柳河县', '2016-11-10 14:49:05', '1', '220500', '3');
INSERT INTO `th_area` VALUES ('220581', '梅河口市', '2016-11-10 14:49:05', '1', '220500', '3');
INSERT INTO `th_area` VALUES ('220582', '集安市', '2016-11-10 14:49:05', '1', '220500', '3');
INSERT INTO `th_area` VALUES ('220583', '其它区', '2016-11-10 14:49:05', '1', '220500', '3');
INSERT INTO `th_area` VALUES ('220600', '白山市', '2016-11-10 14:49:05', '1', '220000', '2');
INSERT INTO `th_area` VALUES ('220602', '八道江区', '2016-11-10 14:49:05', '1', '220600', '3');
INSERT INTO `th_area` VALUES ('220621', '抚松县', '2016-11-10 14:49:05', '1', '220600', '3');
INSERT INTO `th_area` VALUES ('220622', '靖宇县', '2016-11-10 14:49:05', '1', '220600', '3');
INSERT INTO `th_area` VALUES ('220623', '长白朝鲜族自治县', '2016-11-10 14:49:05', '1', '220600', '3');
INSERT INTO `th_area` VALUES ('220625', '江源市', '2016-11-10 14:49:05', '1', '220600', '3');
INSERT INTO `th_area` VALUES ('220681', '临江市', '2016-11-10 14:49:05', '1', '220600', '3');
INSERT INTO `th_area` VALUES ('220682', '其它区', '2016-11-10 14:49:05', '1', '220600', '3');
INSERT INTO `th_area` VALUES ('220700', '松原市', '2016-11-10 14:49:05', '1', '220000', '2');
INSERT INTO `th_area` VALUES ('220702', '宁江区', '2016-11-10 14:49:05', '1', '220700', '3');
INSERT INTO `th_area` VALUES ('220721', '前郭尔罗斯蒙古族自治县', '2016-11-10 14:49:05', '1', '220700', '3');
INSERT INTO `th_area` VALUES ('220722', '长岭县', '2016-11-10 14:49:05', '1', '220700', '3');
INSERT INTO `th_area` VALUES ('220723', '乾安县', '2016-11-10 14:49:05', '1', '220700', '3');
INSERT INTO `th_area` VALUES ('220724', '扶余县', '2016-11-10 14:49:05', '1', '220700', '3');
INSERT INTO `th_area` VALUES ('220725', '其它区', '2016-11-10 14:49:05', '1', '220700', '3');
INSERT INTO `th_area` VALUES ('220800', '白城市', '2016-11-10 14:49:05', '1', '220000', '2');
INSERT INTO `th_area` VALUES ('220802', '洮北区', '2016-11-10 14:49:05', '1', '220800', '3');
INSERT INTO `th_area` VALUES ('220821', '镇赉县', '2016-11-10 14:49:05', '1', '220800', '3');
INSERT INTO `th_area` VALUES ('220822', '通榆县', '2016-11-10 14:49:05', '1', '220800', '3');
INSERT INTO `th_area` VALUES ('220881', '洮南市', '2016-11-10 14:49:05', '1', '220800', '3');
INSERT INTO `th_area` VALUES ('220882', '大安市', '2016-11-10 14:49:05', '1', '220800', '3');
INSERT INTO `th_area` VALUES ('220883', '其它区', '2016-11-10 14:49:05', '1', '220800', '3');
INSERT INTO `th_area` VALUES ('222400', '延边朝鲜族自治州', '2016-11-10 14:49:05', '1', '220000', '2');
INSERT INTO `th_area` VALUES ('222401', '延吉市', '2016-11-10 14:49:05', '1', '222400', '3');
INSERT INTO `th_area` VALUES ('222402', '图们市', '2016-11-10 14:49:05', '1', '222400', '3');
INSERT INTO `th_area` VALUES ('222403', '敦化市', '2016-11-10 14:49:05', '1', '222400', '3');
INSERT INTO `th_area` VALUES ('222404', '珲春市', '2016-11-10 14:49:05', '1', '222400', '3');
INSERT INTO `th_area` VALUES ('222405', '龙井市', '2016-11-10 14:49:05', '1', '222400', '3');
INSERT INTO `th_area` VALUES ('222406', '和龙市', '2016-11-10 14:49:05', '1', '222400', '3');
INSERT INTO `th_area` VALUES ('222424', '汪清县', '2016-11-10 14:49:05', '1', '222400', '3');
INSERT INTO `th_area` VALUES ('222426', '安图县', '2016-11-10 14:49:05', '1', '222400', '3');
INSERT INTO `th_area` VALUES ('222427', '其它区', '2016-11-10 14:49:05', '1', '222400', '3');
INSERT INTO `th_area` VALUES ('230000', '黑龙江省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('230100', '哈尔滨市', '2016-11-10 14:49:05', '1', '230000', '2');
INSERT INTO `th_area` VALUES ('230102', '道里区', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230103', '南岗区', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230104', '道外区', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230106', '香坊区', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230107', '动力区', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230108', '平房区', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230109', '松北区', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230111', '呼兰区', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230123', '依兰县', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230124', '方正县', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230125', '宾县', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230126', '巴彦县', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230127', '木兰县', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230128', '通河县', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230129', '延寿县', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230181', '阿城市', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230182', '双城市', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230183', '尚志市', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230184', '五常市', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230185', '阿城市', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230186', '其它区', '2016-11-10 14:49:05', '1', '230100', '3');
INSERT INTO `th_area` VALUES ('230200', '齐齐哈尔市', '2016-11-10 14:49:05', '1', '230000', '2');
INSERT INTO `th_area` VALUES ('230202', '龙沙区', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230203', '建华区', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230204', '铁锋区', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230205', '昂昂溪区', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230206', '富拉尔基区', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230207', '碾子山区', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230208', '梅里斯达斡尔族区', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230221', '龙江县', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230223', '依安县', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230224', '泰来县', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230225', '甘南县', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230227', '富裕县', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230229', '克山县', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230230', '克东县', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230231', '拜泉县', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230281', '讷河市', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230282', '其它区', '2016-11-10 14:49:05', '1', '230200', '3');
INSERT INTO `th_area` VALUES ('230300', '鸡西市', '2016-11-10 14:49:05', '1', '230000', '2');
INSERT INTO `th_area` VALUES ('230302', '鸡冠区', '2016-11-10 14:49:05', '1', '230300', '3');
INSERT INTO `th_area` VALUES ('230303', '恒山区', '2016-11-10 14:49:05', '1', '230300', '3');
INSERT INTO `th_area` VALUES ('230304', '滴道区', '2016-11-10 14:49:05', '1', '230300', '3');
INSERT INTO `th_area` VALUES ('230305', '梨树区', '2016-11-10 14:49:05', '1', '230300', '3');
INSERT INTO `th_area` VALUES ('230306', '城子河区', '2016-11-10 14:49:05', '1', '230300', '3');
INSERT INTO `th_area` VALUES ('230307', '麻山区', '2016-11-10 14:49:05', '1', '230300', '3');
INSERT INTO `th_area` VALUES ('230321', '鸡东县', '2016-11-10 14:49:05', '1', '230300', '3');
INSERT INTO `th_area` VALUES ('230381', '虎林市', '2016-11-10 14:49:05', '1', '230300', '3');
INSERT INTO `th_area` VALUES ('230382', '密山市', '2016-11-10 14:49:05', '1', '230300', '3');
INSERT INTO `th_area` VALUES ('230383', '其它区', '2016-11-10 14:49:05', '1', '230300', '3');
INSERT INTO `th_area` VALUES ('230400', '鹤岗市', '2016-11-10 14:49:05', '1', '230000', '2');
INSERT INTO `th_area` VALUES ('230402', '向阳区', '2016-11-10 14:49:05', '1', '230400', '3');
INSERT INTO `th_area` VALUES ('230403', '工农区', '2016-11-10 14:49:05', '1', '230400', '3');
INSERT INTO `th_area` VALUES ('230404', '南山区', '2016-11-10 14:49:05', '1', '230400', '3');
INSERT INTO `th_area` VALUES ('230405', '兴安区', '2016-11-10 14:49:05', '1', '230400', '3');
INSERT INTO `th_area` VALUES ('230406', '东山区', '2016-11-10 14:49:05', '1', '230400', '3');
INSERT INTO `th_area` VALUES ('230407', '兴山区', '2016-11-10 14:49:05', '1', '230400', '3');
INSERT INTO `th_area` VALUES ('230421', '萝北县', '2016-11-10 14:49:05', '1', '230400', '3');
INSERT INTO `th_area` VALUES ('230422', '绥滨县', '2016-11-10 14:49:05', '1', '230400', '3');
INSERT INTO `th_area` VALUES ('230423', '其它区', '2016-11-10 14:49:05', '1', '230400', '3');
INSERT INTO `th_area` VALUES ('230500', '双鸭山市', '2016-11-10 14:49:05', '1', '230000', '2');
INSERT INTO `th_area` VALUES ('230502', '尖山区', '2016-11-10 14:49:05', '1', '230500', '3');
INSERT INTO `th_area` VALUES ('230503', '岭东区', '2016-11-10 14:49:05', '1', '230500', '3');
INSERT INTO `th_area` VALUES ('230505', '四方台区', '2016-11-10 14:49:05', '1', '230500', '3');
INSERT INTO `th_area` VALUES ('230506', '宝山区', '2016-11-10 14:49:05', '1', '230500', '3');
INSERT INTO `th_area` VALUES ('230521', '集贤县', '2016-11-10 14:49:05', '1', '230500', '3');
INSERT INTO `th_area` VALUES ('230522', '友谊县', '2016-11-10 14:49:05', '1', '230500', '3');
INSERT INTO `th_area` VALUES ('230523', '宝清县', '2016-11-10 14:49:05', '1', '230500', '3');
INSERT INTO `th_area` VALUES ('230524', '饶河县', '2016-11-10 14:49:05', '1', '230500', '3');
INSERT INTO `th_area` VALUES ('230525', '其它区', '2016-11-10 14:49:05', '1', '230500', '3');
INSERT INTO `th_area` VALUES ('230600', '大庆市', '2016-11-10 14:49:05', '1', '230000', '2');
INSERT INTO `th_area` VALUES ('230602', '萨尔图区', '2016-11-10 14:49:05', '1', '230600', '3');
INSERT INTO `th_area` VALUES ('230603', '龙凤区', '2016-11-10 14:49:05', '1', '230600', '3');
INSERT INTO `th_area` VALUES ('230604', '让胡路区', '2016-11-10 14:49:05', '1', '230600', '3');
INSERT INTO `th_area` VALUES ('230605', '红岗区', '2016-11-10 14:49:05', '1', '230600', '3');
INSERT INTO `th_area` VALUES ('230606', '大同区', '2016-11-10 14:49:05', '1', '230600', '3');
INSERT INTO `th_area` VALUES ('230621', '肇州县', '2016-11-10 14:49:05', '1', '230600', '3');
INSERT INTO `th_area` VALUES ('230622', '肇源县', '2016-11-10 14:49:05', '1', '230600', '3');
INSERT INTO `th_area` VALUES ('230623', '林甸县', '2016-11-10 14:49:05', '1', '230600', '3');
INSERT INTO `th_area` VALUES ('230624', '杜尔伯特蒙古族自治县', '2016-11-10 14:49:05', '1', '230600', '3');
INSERT INTO `th_area` VALUES ('230625', '其它区', '2016-11-10 14:49:05', '1', '230600', '3');
INSERT INTO `th_area` VALUES ('230700', '伊春市', '2016-11-10 14:49:05', '1', '230000', '2');
INSERT INTO `th_area` VALUES ('230702', '伊春区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230703', '南岔区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230704', '友好区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230705', '西林区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230706', '翠峦区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230707', '新青区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230708', '美溪区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230709', '金山屯区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230710', '五营区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230711', '乌马河区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230712', '汤旺河区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230713', '带岭区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230714', '乌伊岭区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230715', '红星区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230716', '上甘岭区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230722', '嘉荫县', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230781', '铁力市', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230782', '其它区', '2016-11-10 14:49:05', '1', '230700', '3');
INSERT INTO `th_area` VALUES ('230800', '佳木斯市', '2016-11-10 14:49:05', '1', '230000', '2');
INSERT INTO `th_area` VALUES ('230802', '永红区', '2016-11-10 14:49:05', '1', '230800', '3');
INSERT INTO `th_area` VALUES ('230803', '向阳区', '2016-11-10 14:49:05', '1', '230800', '3');
INSERT INTO `th_area` VALUES ('230804', '前进区', '2016-11-10 14:49:05', '1', '230800', '3');
INSERT INTO `th_area` VALUES ('230805', '东风区', '2016-11-10 14:49:05', '1', '230800', '3');
INSERT INTO `th_area` VALUES ('230811', '郊区', '2016-11-10 14:49:05', '1', '230800', '3');
INSERT INTO `th_area` VALUES ('230822', '桦南县', '2016-11-10 14:49:05', '1', '230800', '3');
INSERT INTO `th_area` VALUES ('230826', '桦川县', '2016-11-10 14:49:05', '1', '230800', '3');
INSERT INTO `th_area` VALUES ('230828', '汤原县', '2016-11-10 14:49:05', '1', '230800', '3');
INSERT INTO `th_area` VALUES ('230833', '抚远县', '2016-11-10 14:49:05', '1', '230800', '3');
INSERT INTO `th_area` VALUES ('230881', '同江市', '2016-11-10 14:49:05', '1', '230800', '3');
INSERT INTO `th_area` VALUES ('230882', '富锦市', '2016-11-10 14:49:05', '1', '230800', '3');
INSERT INTO `th_area` VALUES ('230883', '其它区', '2016-11-10 14:49:05', '1', '230800', '3');
INSERT INTO `th_area` VALUES ('230900', '七台河市', '2016-11-10 14:49:05', '1', '230000', '2');
INSERT INTO `th_area` VALUES ('230902', '新兴区', '2016-11-10 14:49:05', '1', '230900', '3');
INSERT INTO `th_area` VALUES ('230903', '桃山区', '2016-11-10 14:49:05', '1', '230900', '3');
INSERT INTO `th_area` VALUES ('230904', '茄子河区', '2016-11-10 14:49:05', '1', '230900', '3');
INSERT INTO `th_area` VALUES ('230921', '勃利县', '2016-11-10 14:49:05', '1', '230900', '3');
INSERT INTO `th_area` VALUES ('230922', '其它区', '2016-11-10 14:49:05', '1', '230900', '3');
INSERT INTO `th_area` VALUES ('231000', '牡丹江市', '2016-11-10 14:49:05', '1', '230000', '2');
INSERT INTO `th_area` VALUES ('231002', '东安区', '2016-11-10 14:49:05', '1', '231000', '3');
INSERT INTO `th_area` VALUES ('231003', '阳明区', '2016-11-10 14:49:05', '1', '231000', '3');
INSERT INTO `th_area` VALUES ('231004', '爱民区', '2016-11-10 14:49:05', '1', '231000', '3');
INSERT INTO `th_area` VALUES ('231005', '西安区', '2016-11-10 14:49:05', '1', '231000', '3');
INSERT INTO `th_area` VALUES ('231024', '东宁县', '2016-11-10 14:49:05', '1', '231000', '3');
INSERT INTO `th_area` VALUES ('231025', '林口县', '2016-11-10 14:49:05', '1', '231000', '3');
INSERT INTO `th_area` VALUES ('231081', '绥芬河市', '2016-11-10 14:49:05', '1', '231000', '3');
INSERT INTO `th_area` VALUES ('231083', '海林市', '2016-11-10 14:49:05', '1', '231000', '3');
INSERT INTO `th_area` VALUES ('231084', '宁安市', '2016-11-10 14:49:05', '1', '231000', '3');
INSERT INTO `th_area` VALUES ('231085', '穆棱市', '2016-11-10 14:49:05', '1', '231000', '3');
INSERT INTO `th_area` VALUES ('231086', '其它区', '2016-11-10 14:49:05', '1', '231000', '3');
INSERT INTO `th_area` VALUES ('231100', '黑河市', '2016-11-10 14:49:05', '1', '230000', '2');
INSERT INTO `th_area` VALUES ('231102', '爱辉区', '2016-11-10 14:49:05', '1', '231100', '3');
INSERT INTO `th_area` VALUES ('231121', '嫩江县', '2016-11-10 14:49:05', '1', '231100', '3');
INSERT INTO `th_area` VALUES ('231123', '逊克县', '2016-11-10 14:49:05', '1', '231100', '3');
INSERT INTO `th_area` VALUES ('231124', '孙吴县', '2016-11-10 14:49:05', '1', '231100', '3');
INSERT INTO `th_area` VALUES ('231181', '北安市', '2016-11-10 14:49:05', '1', '231100', '3');
INSERT INTO `th_area` VALUES ('231182', '五大连池市', '2016-11-10 14:49:05', '1', '231100', '3');
INSERT INTO `th_area` VALUES ('231183', '其它区', '2016-11-10 14:49:05', '1', '231100', '3');
INSERT INTO `th_area` VALUES ('231200', '绥化市', '2016-11-10 14:49:05', '1', '230000', '2');
INSERT INTO `th_area` VALUES ('231202', '北林区', '2016-11-10 14:49:05', '1', '231200', '3');
INSERT INTO `th_area` VALUES ('231221', '望奎县', '2016-11-10 14:49:05', '1', '231200', '3');
INSERT INTO `th_area` VALUES ('231222', '兰西县', '2016-11-10 14:49:05', '1', '231200', '3');
INSERT INTO `th_area` VALUES ('231223', '青冈县', '2016-11-10 14:49:05', '1', '231200', '3');
INSERT INTO `th_area` VALUES ('231224', '庆安县', '2016-11-10 14:49:05', '1', '231200', '3');
INSERT INTO `th_area` VALUES ('231225', '明水县', '2016-11-10 14:49:05', '1', '231200', '3');
INSERT INTO `th_area` VALUES ('231226', '绥棱县', '2016-11-10 14:49:05', '1', '231200', '3');
INSERT INTO `th_area` VALUES ('231281', '安达市', '2016-11-10 14:49:05', '1', '231200', '3');
INSERT INTO `th_area` VALUES ('231282', '肇东市', '2016-11-10 14:49:05', '1', '231200', '3');
INSERT INTO `th_area` VALUES ('231283', '海伦市', '2016-11-10 14:49:05', '1', '231200', '3');
INSERT INTO `th_area` VALUES ('231284', '其它区', '2016-11-10 14:49:05', '1', '231200', '3');
INSERT INTO `th_area` VALUES ('232700', '大兴安岭地区', '2016-11-10 14:49:05', '1', '230000', '2');
INSERT INTO `th_area` VALUES ('232721', '呼玛县', '2016-11-10 14:49:05', '1', '232700', '3');
INSERT INTO `th_area` VALUES ('232722', '塔河县', '2016-11-10 14:49:05', '1', '232700', '3');
INSERT INTO `th_area` VALUES ('232723', '漠河县', '2016-11-10 14:49:05', '1', '232700', '3');
INSERT INTO `th_area` VALUES ('232724', '加格达奇区', '2016-11-10 14:49:05', '1', '232700', '3');
INSERT INTO `th_area` VALUES ('232725', '其它区', '2016-11-10 14:49:05', '1', '232700', '3');
INSERT INTO `th_area` VALUES ('310000', '上海市', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('310100', '上海市', '2016-11-10 14:49:05', '1', '310000', '2');
INSERT INTO `th_area` VALUES ('310101', '黄浦区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310103', '卢湾区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310104', '徐汇区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310105', '长宁区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310106', '静安区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310107', '普陀区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310108', '闸北区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310109', '虹口区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310110', '杨浦区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310112', '闵行区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310113', '宝山区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310114', '嘉定区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310115', '浦东新区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310116', '金山区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310117', '松江区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310118', '青浦区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310119', '南汇区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310120', '奉贤区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310152', '川沙区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310230', '崇明县', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('310231', '其它区', '2016-11-10 14:49:05', '1', '310100', '3');
INSERT INTO `th_area` VALUES ('320000', '江苏省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('320100', '南京市', '2016-11-10 14:49:05', '1', '320000', '2');
INSERT INTO `th_area` VALUES ('320102', '玄武区', '2016-11-10 14:49:05', '1', '320100', '3');
INSERT INTO `th_area` VALUES ('320103', '白下区', '2016-11-10 14:49:05', '1', '320100', '3');
INSERT INTO `th_area` VALUES ('320104', '秦淮区', '2016-11-10 14:49:05', '1', '320100', '3');
INSERT INTO `th_area` VALUES ('320105', '建邺区', '2016-11-10 14:49:05', '1', '320100', '3');
INSERT INTO `th_area` VALUES ('320106', '鼓楼区', '2016-11-10 14:49:05', '1', '320100', '3');
INSERT INTO `th_area` VALUES ('320107', '下关区', '2016-11-10 14:49:05', '1', '320100', '3');
INSERT INTO `th_area` VALUES ('320111', '浦口区', '2016-11-10 14:49:05', '1', '320100', '3');
INSERT INTO `th_area` VALUES ('320113', '栖霞区', '2016-11-10 14:49:05', '1', '320100', '3');
INSERT INTO `th_area` VALUES ('320114', '雨花台区', '2016-11-10 14:49:05', '1', '320100', '3');
INSERT INTO `th_area` VALUES ('320115', '江宁区', '2016-11-10 14:49:05', '1', '320100', '3');
INSERT INTO `th_area` VALUES ('320116', '六合区', '2016-11-10 14:49:05', '1', '320100', '3');
INSERT INTO `th_area` VALUES ('320124', '溧水县', '2016-11-10 14:49:05', '1', '320100', '3');
INSERT INTO `th_area` VALUES ('320125', '高淳县', '2016-11-10 14:49:05', '1', '320100', '3');
INSERT INTO `th_area` VALUES ('320126', '其它区', '2016-11-10 14:49:05', '1', '320100', '3');
INSERT INTO `th_area` VALUES ('320200', '无锡市', '2016-11-10 14:49:05', '1', '320000', '2');
INSERT INTO `th_area` VALUES ('320202', '崇安区', '2016-11-10 14:49:05', '1', '320200', '3');
INSERT INTO `th_area` VALUES ('320203', '南长区', '2016-11-10 14:49:05', '1', '320200', '3');
INSERT INTO `th_area` VALUES ('320204', '北塘区', '2016-11-10 14:49:05', '1', '320200', '3');
INSERT INTO `th_area` VALUES ('320205', '锡山区', '2016-11-10 14:49:05', '1', '320200', '3');
INSERT INTO `th_area` VALUES ('320206', '惠山区', '2016-11-10 14:49:05', '1', '320200', '3');
INSERT INTO `th_area` VALUES ('320211', '滨湖区', '2016-11-10 14:49:05', '1', '320200', '3');
INSERT INTO `th_area` VALUES ('320281', '江阴市', '2016-11-10 14:49:05', '1', '320200', '3');
INSERT INTO `th_area` VALUES ('320282', '宜兴市', '2016-11-10 14:49:05', '1', '320200', '3');
INSERT INTO `th_area` VALUES ('320296', '新区', '2016-11-10 14:49:05', '1', '320200', '3');
INSERT INTO `th_area` VALUES ('320297', '其它区', '2016-11-10 14:49:05', '1', '320200', '3');
INSERT INTO `th_area` VALUES ('320300', '徐州市', '2016-11-10 14:49:05', '1', '320000', '2');
INSERT INTO `th_area` VALUES ('320302', '鼓楼区', '2016-11-10 14:49:05', '1', '320300', '3');
INSERT INTO `th_area` VALUES ('320303', '云龙区', '2016-11-10 14:49:05', '1', '320300', '3');
INSERT INTO `th_area` VALUES ('320304', '九里区', '2016-11-10 14:49:05', '1', '320300', '3');
INSERT INTO `th_area` VALUES ('320305', '贾汪区', '2016-11-10 14:49:05', '1', '320300', '3');
INSERT INTO `th_area` VALUES ('320311', '泉山区', '2016-11-10 14:49:05', '1', '320300', '3');
INSERT INTO `th_area` VALUES ('320321', '丰县', '2016-11-10 14:49:05', '1', '320300', '3');
INSERT INTO `th_area` VALUES ('320322', '沛县', '2016-11-10 14:49:05', '1', '320300', '3');
INSERT INTO `th_area` VALUES ('320323', '铜山县', '2016-11-10 14:49:05', '1', '320300', '3');
INSERT INTO `th_area` VALUES ('320324', '睢宁县', '2016-11-10 14:49:05', '1', '320300', '3');
INSERT INTO `th_area` VALUES ('320381', '新沂市', '2016-11-10 14:49:05', '1', '320300', '3');
INSERT INTO `th_area` VALUES ('320382', '邳州市', '2016-11-10 14:49:05', '1', '320300', '3');
INSERT INTO `th_area` VALUES ('320383', '其它区', '2016-11-10 14:49:05', '1', '320300', '3');
INSERT INTO `th_area` VALUES ('320400', '常州市', '2016-11-10 14:49:05', '1', '320000', '2');
INSERT INTO `th_area` VALUES ('320402', '天宁区', '2016-11-10 14:49:05', '1', '320400', '3');
INSERT INTO `th_area` VALUES ('320404', '钟楼区', '2016-11-10 14:49:05', '1', '320400', '3');
INSERT INTO `th_area` VALUES ('320405', '戚墅堰区', '2016-11-10 14:49:05', '1', '320400', '3');
INSERT INTO `th_area` VALUES ('320411', '新北区', '2016-11-10 14:49:05', '1', '320400', '3');
INSERT INTO `th_area` VALUES ('320412', '武进区', '2016-11-10 14:49:05', '1', '320400', '3');
INSERT INTO `th_area` VALUES ('320481', '溧阳市', '2016-11-10 14:49:05', '1', '320400', '3');
INSERT INTO `th_area` VALUES ('320482', '金坛市', '2016-11-10 14:49:05', '1', '320400', '3');
INSERT INTO `th_area` VALUES ('320483', '其它区', '2016-11-10 14:49:05', '1', '320400', '3');
INSERT INTO `th_area` VALUES ('320500', '苏州市', '2016-11-10 14:49:05', '1', '320000', '2');
INSERT INTO `th_area` VALUES ('320502', '沧浪区', '2016-11-10 14:49:05', '1', '320500', '3');
INSERT INTO `th_area` VALUES ('320503', '平江区', '2016-11-10 14:49:05', '1', '320500', '3');
INSERT INTO `th_area` VALUES ('320504', '金阊区', '2016-11-10 14:49:05', '1', '320500', '3');
INSERT INTO `th_area` VALUES ('320505', '虎丘区', '2016-11-10 14:49:05', '1', '320500', '3');
INSERT INTO `th_area` VALUES ('320506', '吴中区', '2016-11-10 14:49:05', '1', '320500', '3');
INSERT INTO `th_area` VALUES ('320507', '相城区', '2016-11-10 14:49:05', '1', '320500', '3');
INSERT INTO `th_area` VALUES ('320581', '常熟市', '2016-11-10 14:49:05', '1', '320500', '3');
INSERT INTO `th_area` VALUES ('320582', '张家港市', '2016-11-10 14:49:05', '1', '320500', '3');
INSERT INTO `th_area` VALUES ('320583', '昆山市', '2016-11-10 14:49:05', '1', '320500', '3');
INSERT INTO `th_area` VALUES ('320584', '吴江市', '2016-11-10 14:49:05', '1', '320500', '3');
INSERT INTO `th_area` VALUES ('320585', '太仓市', '2016-11-10 14:49:05', '1', '320500', '3');
INSERT INTO `th_area` VALUES ('320594', '新区', '2016-11-10 14:49:05', '1', '320500', '3');
INSERT INTO `th_area` VALUES ('320595', '园区', '2016-11-10 14:49:05', '1', '320500', '3');
INSERT INTO `th_area` VALUES ('320596', '其它区', '2016-11-10 14:49:05', '1', '320500', '3');
INSERT INTO `th_area` VALUES ('320600', '南通市', '2016-11-10 14:49:05', '1', '320000', '2');
INSERT INTO `th_area` VALUES ('320602', '崇川区', '2016-11-10 14:49:05', '1', '320600', '3');
INSERT INTO `th_area` VALUES ('320611', '港闸区', '2016-11-10 14:49:05', '1', '320600', '3');
INSERT INTO `th_area` VALUES ('320612', '通州区', '2016-11-10 14:49:05', '1', '320600', '3');
INSERT INTO `th_area` VALUES ('320621', '海安县', '2016-11-10 14:49:05', '1', '320600', '3');
INSERT INTO `th_area` VALUES ('320623', '如东县', '2016-11-10 14:49:05', '1', '320600', '3');
INSERT INTO `th_area` VALUES ('320681', '启东市', '2016-11-10 14:49:05', '1', '320600', '3');
INSERT INTO `th_area` VALUES ('320682', '如皋市', '2016-11-10 14:49:05', '1', '320600', '3');
INSERT INTO `th_area` VALUES ('320683', '通州市', '2016-11-10 14:49:05', '1', '320600', '3');
INSERT INTO `th_area` VALUES ('320684', '海门市', '2016-11-10 14:49:05', '1', '320600', '3');
INSERT INTO `th_area` VALUES ('320693', '开发区', '2016-11-10 14:49:05', '1', '320600', '3');
INSERT INTO `th_area` VALUES ('320694', '其它区', '2016-11-10 14:49:05', '1', '320600', '3');
INSERT INTO `th_area` VALUES ('320700', '连云港市', '2016-11-10 14:49:05', '1', '320000', '2');
INSERT INTO `th_area` VALUES ('320703', '连云区', '2016-11-10 14:49:05', '1', '320700', '3');
INSERT INTO `th_area` VALUES ('320705', '新浦区', '2016-11-10 14:49:05', '1', '320700', '3');
INSERT INTO `th_area` VALUES ('320706', '海州区', '2016-11-10 14:49:05', '1', '320700', '3');
INSERT INTO `th_area` VALUES ('320721', '赣榆县', '2016-11-10 14:49:05', '1', '320700', '3');
INSERT INTO `th_area` VALUES ('320722', '东海县', '2016-11-10 14:49:05', '1', '320700', '3');
INSERT INTO `th_area` VALUES ('320723', '灌云县', '2016-11-10 14:49:05', '1', '320700', '3');
INSERT INTO `th_area` VALUES ('320724', '灌南县', '2016-11-10 14:49:05', '1', '320700', '3');
INSERT INTO `th_area` VALUES ('320725', '其它区', '2016-11-10 14:49:05', '1', '320700', '3');
INSERT INTO `th_area` VALUES ('320800', '淮安市', '2016-11-10 14:49:05', '1', '320000', '2');
INSERT INTO `th_area` VALUES ('320802', '清河区', '2016-11-10 14:49:05', '1', '320800', '3');
INSERT INTO `th_area` VALUES ('320803', '楚州区', '2016-11-10 14:49:05', '1', '320800', '3');
INSERT INTO `th_area` VALUES ('320804', '淮阴区', '2016-11-10 14:49:05', '1', '320800', '3');
INSERT INTO `th_area` VALUES ('320811', '清浦区', '2016-11-10 14:49:05', '1', '320800', '3');
INSERT INTO `th_area` VALUES ('320826', '涟水县', '2016-11-10 14:49:05', '1', '320800', '3');
INSERT INTO `th_area` VALUES ('320829', '洪泽县', '2016-11-10 14:49:05', '1', '320800', '3');
INSERT INTO `th_area` VALUES ('320830', '盱眙县', '2016-11-10 14:49:05', '1', '320800', '3');
INSERT INTO `th_area` VALUES ('320831', '金湖县', '2016-11-10 14:49:05', '1', '320800', '3');
INSERT INTO `th_area` VALUES ('320832', '其它区', '2016-11-10 14:49:05', '1', '320800', '3');
INSERT INTO `th_area` VALUES ('320900', '盐城市', '2016-11-10 14:49:05', '1', '320000', '2');
INSERT INTO `th_area` VALUES ('320902', '亭湖区', '2016-11-10 14:49:05', '1', '320900', '3');
INSERT INTO `th_area` VALUES ('320903', '盐都区', '2016-11-10 14:49:05', '1', '320900', '3');
INSERT INTO `th_area` VALUES ('320921', '响水县', '2016-11-10 14:49:05', '1', '320900', '3');
INSERT INTO `th_area` VALUES ('320922', '滨海县', '2016-11-10 14:49:05', '1', '320900', '3');
INSERT INTO `th_area` VALUES ('320923', '阜宁县', '2016-11-10 14:49:05', '1', '320900', '3');
INSERT INTO `th_area` VALUES ('320924', '射阳县', '2016-11-10 14:49:05', '1', '320900', '3');
INSERT INTO `th_area` VALUES ('320925', '建湖县', '2016-11-10 14:49:05', '1', '320900', '3');
INSERT INTO `th_area` VALUES ('320981', '东台市', '2016-11-10 14:49:05', '1', '320900', '3');
INSERT INTO `th_area` VALUES ('320982', '大丰市', '2016-11-10 14:49:05', '1', '320900', '3');
INSERT INTO `th_area` VALUES ('320983', '其它区', '2016-11-10 14:49:05', '1', '320900', '3');
INSERT INTO `th_area` VALUES ('321000', '扬州市', '2016-11-10 14:49:05', '1', '320000', '2');
INSERT INTO `th_area` VALUES ('321002', '广陵区', '2016-11-10 14:49:05', '1', '321000', '3');
INSERT INTO `th_area` VALUES ('321003', '邗江区', '2016-11-10 14:49:05', '1', '321000', '3');
INSERT INTO `th_area` VALUES ('321011', '维扬区', '2016-11-10 14:49:05', '1', '321000', '3');
INSERT INTO `th_area` VALUES ('321023', '宝应县', '2016-11-10 14:49:05', '1', '321000', '3');
INSERT INTO `th_area` VALUES ('321081', '仪征市', '2016-11-10 14:49:05', '1', '321000', '3');
INSERT INTO `th_area` VALUES ('321084', '高邮市', '2016-11-10 14:49:05', '1', '321000', '3');
INSERT INTO `th_area` VALUES ('321088', '江都市', '2016-11-10 14:49:05', '1', '321000', '3');
INSERT INTO `th_area` VALUES ('321092', '经济开发区', '2016-11-10 14:49:05', '1', '321000', '3');
INSERT INTO `th_area` VALUES ('321093', '其它区', '2016-11-10 14:49:05', '1', '321000', '3');
INSERT INTO `th_area` VALUES ('321100', '镇江市', '2016-11-10 14:49:05', '1', '320000', '2');
INSERT INTO `th_area` VALUES ('321102', '京口区', '2016-11-10 14:49:05', '1', '321100', '3');
INSERT INTO `th_area` VALUES ('321111', '润州区', '2016-11-10 14:49:05', '1', '321100', '3');
INSERT INTO `th_area` VALUES ('321112', '丹徒区', '2016-11-10 14:49:05', '1', '321100', '3');
INSERT INTO `th_area` VALUES ('321181', '丹阳市', '2016-11-10 14:49:05', '1', '321100', '3');
INSERT INTO `th_area` VALUES ('321182', '扬中市', '2016-11-10 14:49:05', '1', '321100', '3');
INSERT INTO `th_area` VALUES ('321183', '句容市', '2016-11-10 14:49:05', '1', '321100', '3');
INSERT INTO `th_area` VALUES ('321184', '其它区', '2016-11-10 14:49:05', '1', '321100', '3');
INSERT INTO `th_area` VALUES ('321200', '泰州市', '2016-11-10 14:49:05', '1', '320000', '2');
INSERT INTO `th_area` VALUES ('321202', '海陵区', '2016-11-10 14:49:05', '1', '321200', '3');
INSERT INTO `th_area` VALUES ('321203', '高港区', '2016-11-10 14:49:05', '1', '321200', '3');
INSERT INTO `th_area` VALUES ('321281', '兴化市', '2016-11-10 14:49:05', '1', '321200', '3');
INSERT INTO `th_area` VALUES ('321282', '靖江市', '2016-11-10 14:49:05', '1', '321200', '3');
INSERT INTO `th_area` VALUES ('321283', '泰兴市', '2016-11-10 14:49:05', '1', '321200', '3');
INSERT INTO `th_area` VALUES ('321284', '姜堰市', '2016-11-10 14:49:05', '1', '321200', '3');
INSERT INTO `th_area` VALUES ('321285', '其它区', '2016-11-10 14:49:05', '1', '321200', '3');
INSERT INTO `th_area` VALUES ('321300', '宿迁市', '2016-11-10 14:49:05', '1', '320000', '2');
INSERT INTO `th_area` VALUES ('321302', '宿城区', '2016-11-10 14:49:05', '1', '321300', '3');
INSERT INTO `th_area` VALUES ('321311', '宿豫区', '2016-11-10 14:49:05', '1', '321300', '3');
INSERT INTO `th_area` VALUES ('321322', '沭阳县', '2016-11-10 14:49:05', '1', '321300', '3');
INSERT INTO `th_area` VALUES ('321323', '泗阳县', '2016-11-10 14:49:05', '1', '321300', '3');
INSERT INTO `th_area` VALUES ('321324', '泗洪县', '2016-11-10 14:49:05', '1', '321300', '3');
INSERT INTO `th_area` VALUES ('321325', '其它区', '2016-11-10 14:49:05', '1', '321300', '3');
INSERT INTO `th_area` VALUES ('330000', '浙江省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('330100', '杭州市', '2016-11-10 14:49:05', '1', '330000', '2');
INSERT INTO `th_area` VALUES ('330102', '上城区', '2016-11-10 14:49:05', '1', '330100', '3');
INSERT INTO `th_area` VALUES ('330103', '下城区', '2016-11-10 14:49:05', '1', '330100', '3');
INSERT INTO `th_area` VALUES ('330104', '江干区', '2016-11-10 14:49:05', '1', '330100', '3');
INSERT INTO `th_area` VALUES ('330105', '拱墅区', '2016-11-10 14:49:05', '1', '330100', '3');
INSERT INTO `th_area` VALUES ('330106', '西湖区', '2016-11-10 14:49:05', '1', '330100', '3');
INSERT INTO `th_area` VALUES ('330108', '滨江区', '2016-11-10 14:49:05', '1', '330100', '3');
INSERT INTO `th_area` VALUES ('330109', '萧山区', '2016-11-10 14:49:05', '1', '330100', '3');
INSERT INTO `th_area` VALUES ('330110', '余杭区', '2016-11-10 14:49:05', '1', '330100', '3');
INSERT INTO `th_area` VALUES ('330122', '桐庐县', '2016-11-10 14:49:05', '1', '330100', '3');
INSERT INTO `th_area` VALUES ('330127', '淳安县', '2016-11-10 14:49:05', '1', '330100', '3');
INSERT INTO `th_area` VALUES ('330182', '建德市', '2016-11-10 14:49:05', '1', '330100', '3');
INSERT INTO `th_area` VALUES ('330183', '富阳市', '2016-11-10 14:49:05', '1', '330100', '3');
INSERT INTO `th_area` VALUES ('330185', '临安市', '2016-11-10 14:49:05', '1', '330100', '3');
INSERT INTO `th_area` VALUES ('330186', '其它区', '2016-11-10 14:49:05', '1', '330100', '3');
INSERT INTO `th_area` VALUES ('330200', '宁波市', '2016-11-10 14:49:05', '1', '330000', '2');
INSERT INTO `th_area` VALUES ('330203', '海曙区', '2016-11-10 14:49:05', '1', '330200', '3');
INSERT INTO `th_area` VALUES ('330204', '江东区', '2016-11-10 14:49:05', '1', '330200', '3');
INSERT INTO `th_area` VALUES ('330205', '江北区', '2016-11-10 14:49:05', '1', '330200', '3');
INSERT INTO `th_area` VALUES ('330206', '北仑区', '2016-11-10 14:49:05', '1', '330200', '3');
INSERT INTO `th_area` VALUES ('330211', '镇海区', '2016-11-10 14:49:05', '1', '330200', '3');
INSERT INTO `th_area` VALUES ('330212', '鄞州区', '2016-11-10 14:49:05', '1', '330200', '3');
INSERT INTO `th_area` VALUES ('330225', '象山县', '2016-11-10 14:49:05', '1', '330200', '3');
INSERT INTO `th_area` VALUES ('330226', '宁海县', '2016-11-10 14:49:05', '1', '330200', '3');
INSERT INTO `th_area` VALUES ('330281', '余姚市', '2016-11-10 14:49:05', '1', '330200', '3');
INSERT INTO `th_area` VALUES ('330282', '慈溪市', '2016-11-10 14:49:05', '1', '330200', '3');
INSERT INTO `th_area` VALUES ('330283', '奉化市', '2016-11-10 14:49:05', '1', '330200', '3');
INSERT INTO `th_area` VALUES ('330284', '其它区', '2016-11-10 14:49:05', '1', '330200', '3');
INSERT INTO `th_area` VALUES ('330300', '温州市', '2016-11-10 14:49:05', '1', '330000', '2');
INSERT INTO `th_area` VALUES ('330302', '鹿城区', '2016-11-10 14:49:05', '1', '330300', '3');
INSERT INTO `th_area` VALUES ('330303', '龙湾区', '2016-11-10 14:49:05', '1', '330300', '3');
INSERT INTO `th_area` VALUES ('330304', '瓯海区', '2016-11-10 14:49:05', '1', '330300', '3');
INSERT INTO `th_area` VALUES ('330322', '洞头县', '2016-11-10 14:49:05', '1', '330300', '3');
INSERT INTO `th_area` VALUES ('330324', '永嘉县', '2016-11-10 14:49:05', '1', '330300', '3');
INSERT INTO `th_area` VALUES ('330326', '平阳县', '2016-11-10 14:49:05', '1', '330300', '3');
INSERT INTO `th_area` VALUES ('330327', '苍南县', '2016-11-10 14:49:05', '1', '330300', '3');
INSERT INTO `th_area` VALUES ('330328', '文成县', '2016-11-10 14:49:05', '1', '330300', '3');
INSERT INTO `th_area` VALUES ('330329', '泰顺县', '2016-11-10 14:49:05', '1', '330300', '3');
INSERT INTO `th_area` VALUES ('330381', '瑞安市', '2016-11-10 14:49:05', '1', '330300', '3');
INSERT INTO `th_area` VALUES ('330382', '乐清市', '2016-11-10 14:49:05', '1', '330300', '3');
INSERT INTO `th_area` VALUES ('330383', '其它区', '2016-11-10 14:49:05', '1', '330300', '3');
INSERT INTO `th_area` VALUES ('330400', '嘉兴市', '2016-11-10 14:49:05', '1', '330000', '2');
INSERT INTO `th_area` VALUES ('330402', '南湖区', '2016-11-10 14:49:05', '1', '330400', '3');
INSERT INTO `th_area` VALUES ('330411', '秀洲区', '2016-11-10 14:49:05', '1', '330400', '3');
INSERT INTO `th_area` VALUES ('330421', '嘉善县', '2016-11-10 14:49:05', '1', '330400', '3');
INSERT INTO `th_area` VALUES ('330424', '海盐县', '2016-11-10 14:49:05', '1', '330400', '3');
INSERT INTO `th_area` VALUES ('330481', '海宁市', '2016-11-10 14:49:05', '1', '330400', '3');
INSERT INTO `th_area` VALUES ('330482', '平湖市', '2016-11-10 14:49:05', '1', '330400', '3');
INSERT INTO `th_area` VALUES ('330483', '桐乡市', '2016-11-10 14:49:05', '1', '330400', '3');
INSERT INTO `th_area` VALUES ('330484', '其它区', '2016-11-10 14:49:05', '1', '330400', '3');
INSERT INTO `th_area` VALUES ('330500', '湖州市', '2016-11-10 14:49:05', '1', '330000', '2');
INSERT INTO `th_area` VALUES ('330502', '吴兴区', '2016-11-10 14:49:05', '1', '330500', '3');
INSERT INTO `th_area` VALUES ('330503', '南浔区', '2016-11-10 14:49:05', '1', '330500', '3');
INSERT INTO `th_area` VALUES ('330521', '德清县', '2016-11-10 14:49:05', '1', '330500', '3');
INSERT INTO `th_area` VALUES ('330522', '长兴县', '2016-11-10 14:49:05', '1', '330500', '3');
INSERT INTO `th_area` VALUES ('330523', '安吉县', '2016-11-10 14:49:05', '1', '330500', '3');
INSERT INTO `th_area` VALUES ('330524', '其它区', '2016-11-10 14:49:05', '1', '330500', '3');
INSERT INTO `th_area` VALUES ('330600', '绍兴市', '2016-11-10 14:49:05', '1', '330000', '2');
INSERT INTO `th_area` VALUES ('330602', '越城区', '2016-11-10 14:49:05', '1', '330600', '3');
INSERT INTO `th_area` VALUES ('330621', '柯桥区', '2016-11-10 14:49:05', '1', '330600', '3');
INSERT INTO `th_area` VALUES ('330624', '新昌县', '2016-11-10 14:49:05', '1', '330600', '3');
INSERT INTO `th_area` VALUES ('330681', '诸暨市', '2016-11-10 14:49:05', '1', '330600', '3');
INSERT INTO `th_area` VALUES ('330682', '上虞区', '2016-11-10 14:49:05', '1', '330600', '3');
INSERT INTO `th_area` VALUES ('330683', '嵊州市', '2016-11-10 14:49:05', '1', '330600', '3');
INSERT INTO `th_area` VALUES ('330684', '其它区', '2016-11-10 14:49:05', '1', '330600', '3');
INSERT INTO `th_area` VALUES ('330700', '金华市', '2016-11-10 14:49:05', '1', '330000', '2');
INSERT INTO `th_area` VALUES ('330702', '婺城区', '2016-11-10 14:49:05', '1', '330700', '3');
INSERT INTO `th_area` VALUES ('330703', '金东区', '2016-11-10 14:49:05', '1', '330700', '3');
INSERT INTO `th_area` VALUES ('330723', '武义县', '2016-11-10 14:49:05', '1', '330700', '3');
INSERT INTO `th_area` VALUES ('330726', '浦江县', '2016-11-10 14:49:05', '1', '330700', '3');
INSERT INTO `th_area` VALUES ('330727', '磐安县', '2016-11-10 14:49:05', '1', '330700', '3');
INSERT INTO `th_area` VALUES ('330781', '兰溪市', '2016-11-10 14:49:05', '1', '330700', '3');
INSERT INTO `th_area` VALUES ('330782', '义乌市', '2016-11-10 14:49:05', '1', '330700', '3');
INSERT INTO `th_area` VALUES ('330783', '东阳市', '2016-11-10 14:49:05', '1', '330700', '3');
INSERT INTO `th_area` VALUES ('330784', '永康市', '2016-11-10 14:49:05', '1', '330700', '3');
INSERT INTO `th_area` VALUES ('330785', '其它区', '2016-11-10 14:49:05', '1', '330700', '3');
INSERT INTO `th_area` VALUES ('330800', '衢州市', '2016-11-10 14:49:05', '1', '330000', '2');
INSERT INTO `th_area` VALUES ('330802', '柯城区', '2016-11-10 14:49:05', '1', '330800', '3');
INSERT INTO `th_area` VALUES ('330803', '衢江区', '2016-11-10 14:49:05', '1', '330800', '3');
INSERT INTO `th_area` VALUES ('330822', '常山县', '2016-11-10 14:49:05', '1', '330800', '3');
INSERT INTO `th_area` VALUES ('330824', '开化县', '2016-11-10 14:49:05', '1', '330800', '3');
INSERT INTO `th_area` VALUES ('330825', '龙游县', '2016-11-10 14:49:05', '1', '330800', '3');
INSERT INTO `th_area` VALUES ('330881', '江山市', '2016-11-10 14:49:05', '1', '330800', '3');
INSERT INTO `th_area` VALUES ('330882', '其它区', '2016-11-10 14:49:05', '1', '330800', '3');
INSERT INTO `th_area` VALUES ('330900', '舟山市', '2016-11-10 14:49:05', '1', '330000', '2');
INSERT INTO `th_area` VALUES ('330902', '定海区', '2016-11-10 14:49:05', '1', '330900', '3');
INSERT INTO `th_area` VALUES ('330903', '普陀区', '2016-11-10 14:49:05', '1', '330900', '3');
INSERT INTO `th_area` VALUES ('330921', '岱山县', '2016-11-10 14:49:05', '1', '330900', '3');
INSERT INTO `th_area` VALUES ('330922', '嵊泗县', '2016-11-10 14:49:05', '1', '330900', '3');
INSERT INTO `th_area` VALUES ('330923', '其它区', '2016-11-10 14:49:05', '1', '330900', '3');
INSERT INTO `th_area` VALUES ('331000', '台州市', '2016-11-10 14:49:05', '1', '330000', '2');
INSERT INTO `th_area` VALUES ('331002', '椒江区', '2016-11-10 14:49:05', '1', '331000', '3');
INSERT INTO `th_area` VALUES ('331003', '黄岩区', '2016-11-10 14:49:05', '1', '331000', '3');
INSERT INTO `th_area` VALUES ('331004', '路桥区', '2016-11-10 14:49:05', '1', '331000', '3');
INSERT INTO `th_area` VALUES ('331021', '玉环县', '2016-11-10 14:49:05', '1', '331000', '3');
INSERT INTO `th_area` VALUES ('331022', '三门县', '2016-11-10 14:49:05', '1', '331000', '3');
INSERT INTO `th_area` VALUES ('331023', '天台县', '2016-11-10 14:49:05', '1', '331000', '3');
INSERT INTO `th_area` VALUES ('331024', '仙居县', '2016-11-10 14:49:05', '1', '331000', '3');
INSERT INTO `th_area` VALUES ('331081', '温岭市', '2016-11-10 14:49:05', '1', '331000', '3');
INSERT INTO `th_area` VALUES ('331082', '临海市', '2016-11-10 14:49:05', '1', '331000', '3');
INSERT INTO `th_area` VALUES ('331083', '其它区', '2016-11-10 14:49:05', '1', '331000', '3');
INSERT INTO `th_area` VALUES ('331100', '丽水市', '2016-11-10 14:49:05', '1', '330000', '2');
INSERT INTO `th_area` VALUES ('331102', '莲都区', '2016-11-10 14:49:05', '1', '331100', '3');
INSERT INTO `th_area` VALUES ('331121', '青田县', '2016-11-10 14:49:05', '1', '331100', '3');
INSERT INTO `th_area` VALUES ('331122', '缙云县', '2016-11-10 14:49:05', '1', '331100', '3');
INSERT INTO `th_area` VALUES ('331123', '遂昌县', '2016-11-10 14:49:05', '1', '331100', '3');
INSERT INTO `th_area` VALUES ('331124', '松阳县', '2016-11-10 14:49:05', '1', '331100', '3');
INSERT INTO `th_area` VALUES ('331125', '云和县', '2016-11-10 14:49:05', '1', '331100', '3');
INSERT INTO `th_area` VALUES ('331126', '庆元县', '2016-11-10 14:49:05', '1', '331100', '3');
INSERT INTO `th_area` VALUES ('331127', '景宁畲族自治县', '2016-11-10 14:49:05', '1', '331100', '3');
INSERT INTO `th_area` VALUES ('331181', '龙泉市', '2016-11-10 14:49:05', '1', '331100', '3');
INSERT INTO `th_area` VALUES ('331182', '其它区', '2016-11-10 14:49:05', '1', '331100', '3');
INSERT INTO `th_area` VALUES ('340000', '安徽省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('340100', '合肥市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('340102', '瑶海区', '2016-11-10 14:49:05', '1', '340100', '3');
INSERT INTO `th_area` VALUES ('340103', '庐阳区', '2016-11-10 14:49:05', '1', '340100', '3');
INSERT INTO `th_area` VALUES ('340104', '蜀山区', '2016-11-10 14:49:05', '1', '340100', '3');
INSERT INTO `th_area` VALUES ('340111', '包河区', '2016-11-10 14:49:05', '1', '340100', '3');
INSERT INTO `th_area` VALUES ('340121', '长丰县', '2016-11-10 14:49:05', '1', '340100', '3');
INSERT INTO `th_area` VALUES ('340122', '肥东县', '2016-11-10 14:49:05', '1', '340100', '3');
INSERT INTO `th_area` VALUES ('340123', '肥西县', '2016-11-10 14:49:05', '1', '340100', '3');
INSERT INTO `th_area` VALUES ('340151', '高新区', '2016-11-10 14:49:05', '1', '340100', '3');
INSERT INTO `th_area` VALUES ('340191', '中区', '2016-11-10 14:49:05', '1', '340100', '3');
INSERT INTO `th_area` VALUES ('340192', '其它区', '2016-11-10 14:49:05', '1', '340100', '3');
INSERT INTO `th_area` VALUES ('340200', '芜湖市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('340202', '镜湖区', '2016-11-10 14:49:05', '1', '340200', '3');
INSERT INTO `th_area` VALUES ('340203', '弋江区', '2016-11-10 14:49:05', '1', '340200', '3');
INSERT INTO `th_area` VALUES ('340207', '鸠江区', '2016-11-10 14:49:05', '1', '340200', '3');
INSERT INTO `th_area` VALUES ('340208', '三山区', '2016-11-10 14:49:05', '1', '340200', '3');
INSERT INTO `th_area` VALUES ('340221', '芜湖县', '2016-11-10 14:49:05', '1', '340200', '3');
INSERT INTO `th_area` VALUES ('340222', '繁昌县', '2016-11-10 14:49:05', '1', '340200', '3');
INSERT INTO `th_area` VALUES ('340223', '南陵县', '2016-11-10 14:49:05', '1', '340200', '3');
INSERT INTO `th_area` VALUES ('340224', '其它区', '2016-11-10 14:49:05', '1', '340200', '3');
INSERT INTO `th_area` VALUES ('340300', '蚌埠市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('340302', '龙子湖区', '2016-11-10 14:49:05', '1', '340300', '3');
INSERT INTO `th_area` VALUES ('340303', '蚌山区', '2016-11-10 14:49:05', '1', '340300', '3');
INSERT INTO `th_area` VALUES ('340304', '禹会区', '2016-11-10 14:49:05', '1', '340300', '3');
INSERT INTO `th_area` VALUES ('340311', '淮上区', '2016-11-10 14:49:05', '1', '340300', '3');
INSERT INTO `th_area` VALUES ('340321', '怀远县', '2016-11-10 14:49:05', '1', '340300', '3');
INSERT INTO `th_area` VALUES ('340322', '五河县', '2016-11-10 14:49:05', '1', '340300', '3');
INSERT INTO `th_area` VALUES ('340323', '固镇县', '2016-11-10 14:49:05', '1', '340300', '3');
INSERT INTO `th_area` VALUES ('340324', '其它区', '2016-11-10 14:49:05', '1', '340300', '3');
INSERT INTO `th_area` VALUES ('340400', '淮南市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('340402', '大通区', '2016-11-10 14:49:05', '1', '340400', '3');
INSERT INTO `th_area` VALUES ('340403', '田家庵区', '2016-11-10 14:49:05', '1', '340400', '3');
INSERT INTO `th_area` VALUES ('340404', '谢家集区', '2016-11-10 14:49:05', '1', '340400', '3');
INSERT INTO `th_area` VALUES ('340405', '八公山区', '2016-11-10 14:49:05', '1', '340400', '3');
INSERT INTO `th_area` VALUES ('340406', '潘集区', '2016-11-10 14:49:05', '1', '340400', '3');
INSERT INTO `th_area` VALUES ('340421', '凤台县', '2016-11-10 14:49:05', '1', '340400', '3');
INSERT INTO `th_area` VALUES ('340422', '其它区', '2016-11-10 14:49:05', '1', '340400', '3');
INSERT INTO `th_area` VALUES ('340500', '马鞍山市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('340502', '金家庄区', '2016-11-10 14:49:05', '1', '340500', '3');
INSERT INTO `th_area` VALUES ('340503', '花山区', '2016-11-10 14:49:05', '1', '340500', '3');
INSERT INTO `th_area` VALUES ('340504', '雨山区', '2016-11-10 14:49:05', '1', '340500', '3');
INSERT INTO `th_area` VALUES ('340521', '当涂县', '2016-11-10 14:49:05', '1', '340500', '3');
INSERT INTO `th_area` VALUES ('340522', '其它区', '2016-11-10 14:49:05', '1', '340500', '3');
INSERT INTO `th_area` VALUES ('340600', '淮北市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('340602', '杜集区', '2016-11-10 14:49:05', '1', '340600', '3');
INSERT INTO `th_area` VALUES ('340603', '相山区', '2016-11-10 14:49:05', '1', '340600', '3');
INSERT INTO `th_area` VALUES ('340604', '烈山区', '2016-11-10 14:49:05', '1', '340600', '3');
INSERT INTO `th_area` VALUES ('340621', '濉溪县', '2016-11-10 14:49:05', '1', '340600', '3');
INSERT INTO `th_area` VALUES ('340622', '其它区', '2016-11-10 14:49:05', '1', '340600', '3');
INSERT INTO `th_area` VALUES ('340700', '铜陵市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('340702', '铜官山区', '2016-11-10 14:49:05', '1', '340700', '3');
INSERT INTO `th_area` VALUES ('340703', '狮子山区', '2016-11-10 14:49:05', '1', '340700', '3');
INSERT INTO `th_area` VALUES ('340711', '郊区', '2016-11-10 14:49:05', '1', '340700', '3');
INSERT INTO `th_area` VALUES ('340721', '铜陵县', '2016-11-10 14:49:05', '1', '340700', '3');
INSERT INTO `th_area` VALUES ('340722', '其它区', '2016-11-10 14:49:05', '1', '340700', '3');
INSERT INTO `th_area` VALUES ('340800', '安庆市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('340802', '迎江区', '2016-11-10 14:49:05', '1', '340800', '3');
INSERT INTO `th_area` VALUES ('340803', '大观区', '2016-11-10 14:49:05', '1', '340800', '3');
INSERT INTO `th_area` VALUES ('340811', '宜秀区', '2016-11-10 14:49:05', '1', '340800', '3');
INSERT INTO `th_area` VALUES ('340822', '怀宁县', '2016-11-10 14:49:05', '1', '340800', '3');
INSERT INTO `th_area` VALUES ('340823', '枞阳县', '2016-11-10 14:49:05', '1', '340800', '3');
INSERT INTO `th_area` VALUES ('340824', '潜山县', '2016-11-10 14:49:05', '1', '340800', '3');
INSERT INTO `th_area` VALUES ('340825', '太湖县', '2016-11-10 14:49:05', '1', '340800', '3');
INSERT INTO `th_area` VALUES ('340826', '宿松县', '2016-11-10 14:49:05', '1', '340800', '3');
INSERT INTO `th_area` VALUES ('340827', '望江县', '2016-11-10 14:49:05', '1', '340800', '3');
INSERT INTO `th_area` VALUES ('340828', '岳西县', '2016-11-10 14:49:05', '1', '340800', '3');
INSERT INTO `th_area` VALUES ('340881', '桐城市', '2016-11-10 14:49:05', '1', '340800', '3');
INSERT INTO `th_area` VALUES ('340882', '其它区', '2016-11-10 14:49:05', '1', '340800', '3');
INSERT INTO `th_area` VALUES ('341000', '黄山市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('341002', '屯溪区', '2016-11-10 14:49:05', '1', '341000', '3');
INSERT INTO `th_area` VALUES ('341003', '黄山区', '2016-11-10 14:49:05', '1', '341000', '3');
INSERT INTO `th_area` VALUES ('341004', '徽州区', '2016-11-10 14:49:05', '1', '341000', '3');
INSERT INTO `th_area` VALUES ('341021', '歙县', '2016-11-10 14:49:05', '1', '341000', '3');
INSERT INTO `th_area` VALUES ('341022', '休宁县', '2016-11-10 14:49:05', '1', '341000', '3');
INSERT INTO `th_area` VALUES ('341023', '黟县', '2016-11-10 14:49:05', '1', '341000', '3');
INSERT INTO `th_area` VALUES ('341024', '祁门县', '2016-11-10 14:49:05', '1', '341000', '3');
INSERT INTO `th_area` VALUES ('341025', '其它区', '2016-11-10 14:49:05', '1', '341000', '3');
INSERT INTO `th_area` VALUES ('341100', '滁州市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('341102', '琅琊区', '2016-11-10 14:49:05', '1', '341100', '3');
INSERT INTO `th_area` VALUES ('341103', '南谯区', '2016-11-10 14:49:05', '1', '341100', '3');
INSERT INTO `th_area` VALUES ('341122', '来安县', '2016-11-10 14:49:05', '1', '341100', '3');
INSERT INTO `th_area` VALUES ('341124', '全椒县', '2016-11-10 14:49:05', '1', '341100', '3');
INSERT INTO `th_area` VALUES ('341125', '定远县', '2016-11-10 14:49:05', '1', '341100', '3');
INSERT INTO `th_area` VALUES ('341126', '凤阳县', '2016-11-10 14:49:05', '1', '341100', '3');
INSERT INTO `th_area` VALUES ('341181', '天长市', '2016-11-10 14:49:05', '1', '341100', '3');
INSERT INTO `th_area` VALUES ('341182', '明光市', '2016-11-10 14:49:05', '1', '341100', '3');
INSERT INTO `th_area` VALUES ('341183', '其它区', '2016-11-10 14:49:05', '1', '341100', '3');
INSERT INTO `th_area` VALUES ('341200', '阜阳市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('341202', '颍州区', '2016-11-10 14:49:05', '1', '341200', '3');
INSERT INTO `th_area` VALUES ('341203', '颍东区', '2016-11-10 14:49:05', '1', '341200', '3');
INSERT INTO `th_area` VALUES ('341204', '颍泉区', '2016-11-10 14:49:05', '1', '341200', '3');
INSERT INTO `th_area` VALUES ('341221', '临泉县', '2016-11-10 14:49:05', '1', '341200', '3');
INSERT INTO `th_area` VALUES ('341222', '太和县', '2016-11-10 14:49:05', '1', '341200', '3');
INSERT INTO `th_area` VALUES ('341225', '阜南县', '2016-11-10 14:49:05', '1', '341200', '3');
INSERT INTO `th_area` VALUES ('341226', '颍上县', '2016-11-10 14:49:05', '1', '341200', '3');
INSERT INTO `th_area` VALUES ('341282', '界首市', '2016-11-10 14:49:05', '1', '341200', '3');
INSERT INTO `th_area` VALUES ('341283', '其它区', '2016-11-10 14:49:05', '1', '341200', '3');
INSERT INTO `th_area` VALUES ('341300', '宿州市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('341302', '埇桥区', '2016-11-10 14:49:05', '1', '341300', '3');
INSERT INTO `th_area` VALUES ('341321', '砀山县', '2016-11-10 14:49:05', '1', '341300', '3');
INSERT INTO `th_area` VALUES ('341322', '萧县', '2016-11-10 14:49:05', '1', '341300', '3');
INSERT INTO `th_area` VALUES ('341323', '灵璧县', '2016-11-10 14:49:05', '1', '341300', '3');
INSERT INTO `th_area` VALUES ('341324', '泗县', '2016-11-10 14:49:05', '1', '341300', '3');
INSERT INTO `th_area` VALUES ('341325', '其它区', '2016-11-10 14:49:05', '1', '341300', '3');
INSERT INTO `th_area` VALUES ('341400', '巢湖市', '2016-11-10 14:49:05', '1', '340100', '3');
INSERT INTO `th_area` VALUES ('341402', '居巢区', '2016-11-10 14:49:05', '1', '340100', '3');
INSERT INTO `th_area` VALUES ('341421', '庐江县', '2016-11-10 14:49:05', '1', '340100', '3');
INSERT INTO `th_area` VALUES ('341422', '无为县', '2016-11-10 14:49:05', '1', '340200', '3');
INSERT INTO `th_area` VALUES ('341423', '含山县', '2016-11-10 14:49:05', '1', '340500', '3');
INSERT INTO `th_area` VALUES ('341424', '和县', '2016-11-10 14:49:05', '1', '340500', '3');
INSERT INTO `th_area` VALUES ('341500', '六安市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('341502', '金安区', '2016-11-10 14:49:05', '1', '341500', '3');
INSERT INTO `th_area` VALUES ('341503', '裕安区', '2016-11-10 14:49:05', '1', '341500', '3');
INSERT INTO `th_area` VALUES ('341521', '寿县', '2016-11-10 14:49:05', '1', '341500', '3');
INSERT INTO `th_area` VALUES ('341522', '霍邱县', '2016-11-10 14:49:05', '1', '341500', '3');
INSERT INTO `th_area` VALUES ('341523', '舒城县', '2016-11-10 14:49:05', '1', '341500', '3');
INSERT INTO `th_area` VALUES ('341524', '金寨县', '2016-11-10 14:49:05', '1', '341500', '3');
INSERT INTO `th_area` VALUES ('341525', '霍山县', '2016-11-10 14:49:05', '1', '341500', '3');
INSERT INTO `th_area` VALUES ('341526', '其它区', '2016-11-10 14:49:05', '1', '341500', '3');
INSERT INTO `th_area` VALUES ('341600', '亳州市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('341602', '谯城区', '2016-11-10 14:49:05', '1', '341600', '3');
INSERT INTO `th_area` VALUES ('341621', '涡阳县', '2016-11-10 14:49:05', '1', '341600', '3');
INSERT INTO `th_area` VALUES ('341622', '蒙城县', '2016-11-10 14:49:05', '1', '341600', '3');
INSERT INTO `th_area` VALUES ('341623', '利辛县', '2016-11-10 14:49:05', '1', '341600', '3');
INSERT INTO `th_area` VALUES ('341624', '其它区', '2016-11-10 14:49:05', '1', '341600', '3');
INSERT INTO `th_area` VALUES ('341700', '池州市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('341702', '贵池区', '2016-11-10 14:49:05', '1', '341700', '3');
INSERT INTO `th_area` VALUES ('341721', '东至县', '2016-11-10 14:49:05', '1', '341700', '3');
INSERT INTO `th_area` VALUES ('341722', '石台县', '2016-11-10 14:49:05', '1', '341700', '3');
INSERT INTO `th_area` VALUES ('341723', '青阳县', '2016-11-10 14:49:05', '1', '341700', '3');
INSERT INTO `th_area` VALUES ('341724', '其它区', '2016-11-10 14:49:05', '1', '341700', '3');
INSERT INTO `th_area` VALUES ('341800', '宣城市', '2016-11-10 14:49:05', '1', '340000', '2');
INSERT INTO `th_area` VALUES ('341802', '宣州区', '2016-11-10 14:49:05', '1', '341800', '3');
INSERT INTO `th_area` VALUES ('341821', '郎溪县', '2016-11-10 14:49:05', '1', '341800', '3');
INSERT INTO `th_area` VALUES ('341822', '广德县', '2016-11-10 14:49:05', '1', '341800', '3');
INSERT INTO `th_area` VALUES ('341823', '泾县', '2016-11-10 14:49:05', '1', '341800', '3');
INSERT INTO `th_area` VALUES ('341824', '绩溪县', '2016-11-10 14:49:05', '1', '341800', '3');
INSERT INTO `th_area` VALUES ('341825', '旌德县', '2016-11-10 14:49:05', '1', '341800', '3');
INSERT INTO `th_area` VALUES ('341881', '宁国市', '2016-11-10 14:49:05', '1', '341800', '3');
INSERT INTO `th_area` VALUES ('341882', '其它区', '2016-11-10 14:49:05', '1', '341800', '3');
INSERT INTO `th_area` VALUES ('350000', '福建省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('350100', '福州市', '2016-11-10 14:49:05', '1', '350000', '2');
INSERT INTO `th_area` VALUES ('350102', '鼓楼区', '2016-11-10 14:49:05', '1', '350100', '3');
INSERT INTO `th_area` VALUES ('350103', '台江区', '2016-11-10 14:49:05', '1', '350100', '3');
INSERT INTO `th_area` VALUES ('350104', '仓山区', '2016-11-10 14:49:05', '1', '350100', '3');
INSERT INTO `th_area` VALUES ('350105', '马尾区', '2016-11-10 14:49:05', '1', '350100', '3');
INSERT INTO `th_area` VALUES ('350111', '晋安区', '2016-11-10 14:49:05', '1', '350100', '3');
INSERT INTO `th_area` VALUES ('350121', '闽侯县', '2016-11-10 14:49:05', '1', '350100', '3');
INSERT INTO `th_area` VALUES ('350122', '连江县', '2016-11-10 14:49:05', '1', '350100', '3');
INSERT INTO `th_area` VALUES ('350123', '罗源县', '2016-11-10 14:49:05', '1', '350100', '3');
INSERT INTO `th_area` VALUES ('350124', '闽清县', '2016-11-10 14:49:05', '1', '350100', '3');
INSERT INTO `th_area` VALUES ('350125', '永泰县', '2016-11-10 14:49:05', '1', '350100', '3');
INSERT INTO `th_area` VALUES ('350128', '平潭县', '2016-11-10 14:49:05', '1', '350100', '3');
INSERT INTO `th_area` VALUES ('350181', '福清市', '2016-11-10 14:49:05', '1', '350100', '3');
INSERT INTO `th_area` VALUES ('350182', '长乐市', '2016-11-10 14:49:05', '1', '350100', '3');
INSERT INTO `th_area` VALUES ('350183', '其它区', '2016-11-10 14:49:05', '1', '350100', '3');
INSERT INTO `th_area` VALUES ('350200', '厦门市', '2016-11-10 14:49:05', '1', '350000', '2');
INSERT INTO `th_area` VALUES ('350203', '思明区', '2016-11-10 14:49:05', '1', '350200', '3');
INSERT INTO `th_area` VALUES ('350205', '海沧区', '2016-11-10 14:49:05', '1', '350200', '3');
INSERT INTO `th_area` VALUES ('350206', '湖里区', '2016-11-10 14:49:05', '1', '350200', '3');
INSERT INTO `th_area` VALUES ('350211', '集美区', '2016-11-10 14:49:05', '1', '350200', '3');
INSERT INTO `th_area` VALUES ('350212', '同安区', '2016-11-10 14:49:05', '1', '350200', '3');
INSERT INTO `th_area` VALUES ('350213', '翔安区', '2016-11-10 14:49:05', '1', '350200', '3');
INSERT INTO `th_area` VALUES ('350214', '其它区', '2016-11-10 14:49:05', '1', '350200', '3');
INSERT INTO `th_area` VALUES ('350300', '莆田市', '2016-11-10 14:49:05', '1', '350000', '2');
INSERT INTO `th_area` VALUES ('350302', '城厢区', '2016-11-10 14:49:05', '1', '350300', '3');
INSERT INTO `th_area` VALUES ('350303', '涵江区', '2016-11-10 14:49:05', '1', '350300', '3');
INSERT INTO `th_area` VALUES ('350304', '荔城区', '2016-11-10 14:49:05', '1', '350300', '3');
INSERT INTO `th_area` VALUES ('350305', '秀屿区', '2016-11-10 14:49:05', '1', '350300', '3');
INSERT INTO `th_area` VALUES ('350322', '仙游县', '2016-11-10 14:49:05', '1', '350300', '3');
INSERT INTO `th_area` VALUES ('350323', '其它区', '2016-11-10 14:49:05', '1', '350300', '3');
INSERT INTO `th_area` VALUES ('350400', '三明市', '2016-11-10 14:49:05', '1', '350000', '2');
INSERT INTO `th_area` VALUES ('350402', '梅列区', '2016-11-10 14:49:05', '1', '350400', '3');
INSERT INTO `th_area` VALUES ('350403', '三元区', '2016-11-10 14:49:05', '1', '350400', '3');
INSERT INTO `th_area` VALUES ('350421', '明溪县', '2016-11-10 14:49:05', '1', '350400', '3');
INSERT INTO `th_area` VALUES ('350423', '清流县', '2016-11-10 14:49:05', '1', '350400', '3');
INSERT INTO `th_area` VALUES ('350424', '宁化县', '2016-11-10 14:49:05', '1', '350400', '3');
INSERT INTO `th_area` VALUES ('350425', '大田县', '2016-11-10 14:49:05', '1', '350400', '3');
INSERT INTO `th_area` VALUES ('350426', '尤溪县', '2016-11-10 14:49:05', '1', '350400', '3');
INSERT INTO `th_area` VALUES ('350427', '沙县', '2016-11-10 14:49:05', '1', '350400', '3');
INSERT INTO `th_area` VALUES ('350428', '将乐县', '2016-11-10 14:49:05', '1', '350400', '3');
INSERT INTO `th_area` VALUES ('350429', '泰宁县', '2016-11-10 14:49:05', '1', '350400', '3');
INSERT INTO `th_area` VALUES ('350430', '建宁县', '2016-11-10 14:49:05', '1', '350400', '3');
INSERT INTO `th_area` VALUES ('350481', '永安市', '2016-11-10 14:49:05', '1', '350400', '3');
INSERT INTO `th_area` VALUES ('350482', '其它区', '2016-11-10 14:49:05', '1', '350400', '3');
INSERT INTO `th_area` VALUES ('350500', '泉州市', '2016-11-10 14:49:05', '1', '350000', '2');
INSERT INTO `th_area` VALUES ('350502', '鲤城区', '2016-11-10 14:49:05', '1', '350500', '3');
INSERT INTO `th_area` VALUES ('350503', '丰泽区', '2016-11-10 14:49:05', '1', '350500', '3');
INSERT INTO `th_area` VALUES ('350504', '洛江区', '2016-11-10 14:49:05', '1', '350500', '3');
INSERT INTO `th_area` VALUES ('350505', '泉港区', '2016-11-10 14:49:05', '1', '350500', '3');
INSERT INTO `th_area` VALUES ('350521', '惠安县', '2016-11-10 14:49:05', '1', '350500', '3');
INSERT INTO `th_area` VALUES ('350524', '安溪县', '2016-11-10 14:49:05', '1', '350500', '3');
INSERT INTO `th_area` VALUES ('350525', '永春县', '2016-11-10 14:49:05', '1', '350500', '3');
INSERT INTO `th_area` VALUES ('350526', '德化县', '2016-11-10 14:49:05', '1', '350500', '3');
INSERT INTO `th_area` VALUES ('350527', '金门县', '2016-11-10 14:49:05', '1', '350500', '3');
INSERT INTO `th_area` VALUES ('350581', '石狮市', '2016-11-10 14:49:05', '1', '350500', '3');
INSERT INTO `th_area` VALUES ('350582', '晋江市', '2016-11-10 14:49:05', '1', '350500', '3');
INSERT INTO `th_area` VALUES ('350583', '南安市', '2016-11-10 14:49:05', '1', '350500', '3');
INSERT INTO `th_area` VALUES ('350584', '其它区', '2016-11-10 14:49:05', '1', '350500', '3');
INSERT INTO `th_area` VALUES ('350600', '漳州市', '2016-11-10 14:49:05', '1', '350000', '2');
INSERT INTO `th_area` VALUES ('350602', '芗城区', '2016-11-10 14:49:05', '1', '350600', '3');
INSERT INTO `th_area` VALUES ('350603', '龙文区', '2016-11-10 14:49:05', '1', '350600', '3');
INSERT INTO `th_area` VALUES ('350622', '云霄县', '2016-11-10 14:49:05', '1', '350600', '3');
INSERT INTO `th_area` VALUES ('350623', '漳浦县', '2016-11-10 14:49:05', '1', '350600', '3');
INSERT INTO `th_area` VALUES ('350624', '诏安县', '2016-11-10 14:49:05', '1', '350600', '3');
INSERT INTO `th_area` VALUES ('350625', '长泰县', '2016-11-10 14:49:05', '1', '350600', '3');
INSERT INTO `th_area` VALUES ('350626', '东山县', '2016-11-10 14:49:05', '1', '350600', '3');
INSERT INTO `th_area` VALUES ('350627', '南靖县', '2016-11-10 14:49:05', '1', '350600', '3');
INSERT INTO `th_area` VALUES ('350628', '平和县', '2016-11-10 14:49:05', '1', '350600', '3');
INSERT INTO `th_area` VALUES ('350629', '华安县', '2016-11-10 14:49:05', '1', '350600', '3');
INSERT INTO `th_area` VALUES ('350681', '龙海市', '2016-11-10 14:49:05', '1', '350600', '3');
INSERT INTO `th_area` VALUES ('350682', '其它区', '2016-11-10 14:49:05', '1', '350600', '3');
INSERT INTO `th_area` VALUES ('350700', '南平市', '2016-11-10 14:49:05', '1', '350000', '2');
INSERT INTO `th_area` VALUES ('350702', '延平区', '2016-11-10 14:49:05', '1', '350700', '3');
INSERT INTO `th_area` VALUES ('350721', '顺昌县', '2016-11-10 14:49:05', '1', '350700', '3');
INSERT INTO `th_area` VALUES ('350722', '浦城县', '2016-11-10 14:49:05', '1', '350700', '3');
INSERT INTO `th_area` VALUES ('350723', '光泽县', '2016-11-10 14:49:05', '1', '350700', '3');
INSERT INTO `th_area` VALUES ('350724', '松溪县', '2016-11-10 14:49:05', '1', '350700', '3');
INSERT INTO `th_area` VALUES ('350725', '政和县', '2016-11-10 14:49:05', '1', '350700', '3');
INSERT INTO `th_area` VALUES ('350781', '邵武市', '2016-11-10 14:49:05', '1', '350700', '3');
INSERT INTO `th_area` VALUES ('350782', '武夷山市', '2016-11-10 14:49:05', '1', '350700', '3');
INSERT INTO `th_area` VALUES ('350783', '建瓯市', '2016-11-10 14:49:05', '1', '350700', '3');
INSERT INTO `th_area` VALUES ('350784', '建阳市', '2016-11-10 14:49:05', '1', '350700', '3');
INSERT INTO `th_area` VALUES ('350785', '其它区', '2016-11-10 14:49:05', '1', '350700', '3');
INSERT INTO `th_area` VALUES ('350800', '龙岩市', '2016-11-10 14:49:05', '1', '350000', '2');
INSERT INTO `th_area` VALUES ('350802', '新罗区', '2016-11-10 14:49:05', '1', '350800', '3');
INSERT INTO `th_area` VALUES ('350821', '长汀县', '2016-11-10 14:49:05', '1', '350800', '3');
INSERT INTO `th_area` VALUES ('350822', '永定县', '2016-11-10 14:49:05', '1', '350800', '3');
INSERT INTO `th_area` VALUES ('350823', '上杭县', '2016-11-10 14:49:05', '1', '350800', '3');
INSERT INTO `th_area` VALUES ('350824', '武平县', '2016-11-10 14:49:05', '1', '350800', '3');
INSERT INTO `th_area` VALUES ('350825', '连城县', '2016-11-10 14:49:05', '1', '350800', '3');
INSERT INTO `th_area` VALUES ('350881', '漳平市', '2016-11-10 14:49:05', '1', '350800', '3');
INSERT INTO `th_area` VALUES ('350882', '其它区', '2016-11-10 14:49:05', '1', '350800', '3');
INSERT INTO `th_area` VALUES ('350900', '宁德市', '2016-11-10 14:49:05', '1', '350000', '2');
INSERT INTO `th_area` VALUES ('350902', '蕉城区', '2016-11-10 14:49:05', '1', '350900', '3');
INSERT INTO `th_area` VALUES ('350921', '霞浦县', '2016-11-10 14:49:05', '1', '350900', '3');
INSERT INTO `th_area` VALUES ('350922', '古田县', '2016-11-10 14:49:05', '1', '350900', '3');
INSERT INTO `th_area` VALUES ('350923', '屏南县', '2016-11-10 14:49:05', '1', '350900', '3');
INSERT INTO `th_area` VALUES ('350924', '寿宁县', '2016-11-10 14:49:05', '1', '350900', '3');
INSERT INTO `th_area` VALUES ('350925', '周宁县', '2016-11-10 14:49:05', '1', '350900', '3');
INSERT INTO `th_area` VALUES ('350926', '柘荣县', '2016-11-10 14:49:05', '1', '350900', '3');
INSERT INTO `th_area` VALUES ('350981', '福安市', '2016-11-10 14:49:05', '1', '350900', '3');
INSERT INTO `th_area` VALUES ('350982', '福鼎市', '2016-11-10 14:49:05', '1', '350900', '3');
INSERT INTO `th_area` VALUES ('350983', '其它区', '2016-11-10 14:49:05', '1', '350900', '3');
INSERT INTO `th_area` VALUES ('360000', '江西省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('360100', '南昌市', '2016-11-10 14:49:05', '1', '360000', '2');
INSERT INTO `th_area` VALUES ('360102', '东湖区', '2016-11-10 14:49:05', '1', '360100', '3');
INSERT INTO `th_area` VALUES ('360103', '西湖区', '2016-11-10 14:49:05', '1', '360100', '3');
INSERT INTO `th_area` VALUES ('360104', '青云谱区', '2016-11-10 14:49:05', '1', '360100', '3');
INSERT INTO `th_area` VALUES ('360105', '湾里区', '2016-11-10 14:49:05', '1', '360100', '3');
INSERT INTO `th_area` VALUES ('360111', '青山湖区', '2016-11-10 14:49:05', '1', '360100', '3');
INSERT INTO `th_area` VALUES ('360121', '南昌县', '2016-11-10 14:49:05', '1', '360100', '3');
INSERT INTO `th_area` VALUES ('360122', '新建县', '2016-11-10 14:49:05', '1', '360100', '3');
INSERT INTO `th_area` VALUES ('360123', '安义县', '2016-11-10 14:49:05', '1', '360100', '3');
INSERT INTO `th_area` VALUES ('360124', '进贤县', '2016-11-10 14:49:05', '1', '360100', '3');
INSERT INTO `th_area` VALUES ('360125', '红谷滩新区', '2016-11-10 14:49:05', '1', '360100', '3');
INSERT INTO `th_area` VALUES ('360126', '经济技术开发区', '2016-11-10 14:49:05', '1', '360100', '3');
INSERT INTO `th_area` VALUES ('360127', '昌北区', '2016-11-10 14:49:05', '1', '360100', '3');
INSERT INTO `th_area` VALUES ('360128', '其它区', '2016-11-10 14:49:05', '1', '360100', '3');
INSERT INTO `th_area` VALUES ('360200', '景德镇市', '2016-11-10 14:49:05', '1', '360000', '2');
INSERT INTO `th_area` VALUES ('360202', '昌江区', '2016-11-10 14:49:05', '1', '360200', '3');
INSERT INTO `th_area` VALUES ('360203', '珠山区', '2016-11-10 14:49:05', '1', '360200', '3');
INSERT INTO `th_area` VALUES ('360222', '浮梁县', '2016-11-10 14:49:05', '1', '360200', '3');
INSERT INTO `th_area` VALUES ('360281', '乐平市', '2016-11-10 14:49:05', '1', '360200', '3');
INSERT INTO `th_area` VALUES ('360282', '其它区', '2016-11-10 14:49:05', '1', '360200', '3');
INSERT INTO `th_area` VALUES ('360300', '萍乡市', '2016-11-10 14:49:05', '1', '360000', '2');
INSERT INTO `th_area` VALUES ('360302', '安源区', '2016-11-10 14:49:05', '1', '360300', '3');
INSERT INTO `th_area` VALUES ('360313', '湘东区', '2016-11-10 14:49:05', '1', '360300', '3');
INSERT INTO `th_area` VALUES ('360321', '莲花县', '2016-11-10 14:49:05', '1', '360300', '3');
INSERT INTO `th_area` VALUES ('360322', '上栗县', '2016-11-10 14:49:05', '1', '360300', '3');
INSERT INTO `th_area` VALUES ('360323', '芦溪县', '2016-11-10 14:49:05', '1', '360300', '3');
INSERT INTO `th_area` VALUES ('360324', '其它区', '2016-11-10 14:49:05', '1', '360300', '3');
INSERT INTO `th_area` VALUES ('360400', '九江市', '2016-11-10 14:49:05', '1', '360000', '2');
INSERT INTO `th_area` VALUES ('360402', '庐山区', '2016-11-10 14:49:05', '1', '360400', '3');
INSERT INTO `th_area` VALUES ('360403', '浔阳区', '2016-11-10 14:49:05', '1', '360400', '3');
INSERT INTO `th_area` VALUES ('360421', '九江县', '2016-11-10 14:49:05', '1', '360400', '3');
INSERT INTO `th_area` VALUES ('360423', '武宁县', '2016-11-10 14:49:05', '1', '360400', '3');
INSERT INTO `th_area` VALUES ('360424', '修水县', '2016-11-10 14:49:05', '1', '360400', '3');
INSERT INTO `th_area` VALUES ('360425', '永修县', '2016-11-10 14:49:05', '1', '360400', '3');
INSERT INTO `th_area` VALUES ('360426', '德安县', '2016-11-10 14:49:05', '1', '360400', '3');
INSERT INTO `th_area` VALUES ('360427', '星子县', '2016-11-10 14:49:05', '1', '360400', '3');
INSERT INTO `th_area` VALUES ('360428', '都昌县', '2016-11-10 14:49:05', '1', '360400', '3');
INSERT INTO `th_area` VALUES ('360429', '湖口县', '2016-11-10 14:49:05', '1', '360400', '3');
INSERT INTO `th_area` VALUES ('360430', '彭泽县', '2016-11-10 14:49:05', '1', '360400', '3');
INSERT INTO `th_area` VALUES ('360481', '瑞昌市', '2016-11-10 14:49:05', '1', '360400', '3');
INSERT INTO `th_area` VALUES ('360482', '其它区', '2016-11-10 14:49:05', '1', '360400', '3');
INSERT INTO `th_area` VALUES ('360500', '新余市', '2016-11-10 14:49:05', '1', '360000', '2');
INSERT INTO `th_area` VALUES ('360502', '渝水区', '2016-11-10 14:49:05', '1', '360500', '3');
INSERT INTO `th_area` VALUES ('360521', '分宜县', '2016-11-10 14:49:05', '1', '360500', '3');
INSERT INTO `th_area` VALUES ('360522', '其它区', '2016-11-10 14:49:05', '1', '360500', '3');
INSERT INTO `th_area` VALUES ('360600', '鹰潭市', '2016-11-10 14:49:05', '1', '360000', '2');
INSERT INTO `th_area` VALUES ('360602', '月湖区', '2016-11-10 14:49:05', '1', '360600', '3');
INSERT INTO `th_area` VALUES ('360622', '余江县', '2016-11-10 14:49:05', '1', '360600', '3');
INSERT INTO `th_area` VALUES ('360681', '贵溪市', '2016-11-10 14:49:05', '1', '360600', '3');
INSERT INTO `th_area` VALUES ('360682', '其它区', '2016-11-10 14:49:05', '1', '360600', '3');
INSERT INTO `th_area` VALUES ('360700', '赣州市', '2016-11-10 14:49:05', '1', '360000', '2');
INSERT INTO `th_area` VALUES ('360702', '章贡区', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360721', '赣县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360722', '信丰县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360723', '大余县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360724', '上犹县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360725', '崇义县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360726', '安远县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360727', '龙南县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360728', '定南县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360729', '全南县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360730', '宁都县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360731', '于都县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360732', '兴国县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360733', '会昌县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360734', '寻乌县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360735', '石城县', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360751', '黄金区', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360781', '瑞金市', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360782', '南康市', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360783', '其它区', '2016-11-10 14:49:05', '1', '360700', '3');
INSERT INTO `th_area` VALUES ('360800', '吉安市', '2016-11-10 14:49:05', '1', '360000', '2');
INSERT INTO `th_area` VALUES ('360802', '吉州区', '2016-11-10 14:49:05', '1', '360800', '3');
INSERT INTO `th_area` VALUES ('360803', '青原区', '2016-11-10 14:49:05', '1', '360800', '3');
INSERT INTO `th_area` VALUES ('360821', '吉安县', '2016-11-10 14:49:05', '1', '360800', '3');
INSERT INTO `th_area` VALUES ('360822', '吉水县', '2016-11-10 14:49:05', '1', '360800', '3');
INSERT INTO `th_area` VALUES ('360823', '峡江县', '2016-11-10 14:49:05', '1', '360800', '3');
INSERT INTO `th_area` VALUES ('360824', '新干县', '2016-11-10 14:49:05', '1', '360800', '3');
INSERT INTO `th_area` VALUES ('360825', '永丰县', '2016-11-10 14:49:05', '1', '360800', '3');
INSERT INTO `th_area` VALUES ('360826', '泰和县', '2016-11-10 14:49:05', '1', '360800', '3');
INSERT INTO `th_area` VALUES ('360827', '遂川县', '2016-11-10 14:49:05', '1', '360800', '3');
INSERT INTO `th_area` VALUES ('360828', '万安县', '2016-11-10 14:49:05', '1', '360800', '3');
INSERT INTO `th_area` VALUES ('360829', '安福县', '2016-11-10 14:49:05', '1', '360800', '3');
INSERT INTO `th_area` VALUES ('360830', '永新县', '2016-11-10 14:49:05', '1', '360800', '3');
INSERT INTO `th_area` VALUES ('360881', '井冈山市', '2016-11-10 14:49:05', '1', '360800', '3');
INSERT INTO `th_area` VALUES ('360882', '其它区', '2016-11-10 14:49:05', '1', '360800', '3');
INSERT INTO `th_area` VALUES ('360900', '宜春市', '2016-11-10 14:49:05', '1', '360000', '2');
INSERT INTO `th_area` VALUES ('360902', '袁州区', '2016-11-10 14:49:05', '1', '360900', '3');
INSERT INTO `th_area` VALUES ('360921', '奉新县', '2016-11-10 14:49:05', '1', '360900', '3');
INSERT INTO `th_area` VALUES ('360922', '万载县', '2016-11-10 14:49:05', '1', '360900', '3');
INSERT INTO `th_area` VALUES ('360923', '上高县', '2016-11-10 14:49:05', '1', '360900', '3');
INSERT INTO `th_area` VALUES ('360924', '宜丰县', '2016-11-10 14:49:05', '1', '360900', '3');
INSERT INTO `th_area` VALUES ('360925', '靖安县', '2016-11-10 14:49:05', '1', '360900', '3');
INSERT INTO `th_area` VALUES ('360926', '铜鼓县', '2016-11-10 14:49:05', '1', '360900', '3');
INSERT INTO `th_area` VALUES ('360981', '丰城市', '2016-11-10 14:49:05', '1', '360900', '3');
INSERT INTO `th_area` VALUES ('360982', '樟树市', '2016-11-10 14:49:05', '1', '360900', '3');
INSERT INTO `th_area` VALUES ('360983', '高安市', '2016-11-10 14:49:05', '1', '360900', '3');
INSERT INTO `th_area` VALUES ('360984', '其它区', '2016-11-10 14:49:05', '1', '360900', '3');
INSERT INTO `th_area` VALUES ('361000', '抚州市', '2016-11-10 14:49:05', '1', '360000', '2');
INSERT INTO `th_area` VALUES ('361002', '临川区', '2016-11-10 14:49:05', '1', '361000', '3');
INSERT INTO `th_area` VALUES ('361021', '南城县', '2016-11-10 14:49:05', '1', '361000', '3');
INSERT INTO `th_area` VALUES ('361022', '黎川县', '2016-11-10 14:49:05', '1', '361000', '3');
INSERT INTO `th_area` VALUES ('361023', '南丰县', '2016-11-10 14:49:05', '1', '361000', '3');
INSERT INTO `th_area` VALUES ('361024', '崇仁县', '2016-11-10 14:49:05', '1', '361000', '3');
INSERT INTO `th_area` VALUES ('361025', '乐安县', '2016-11-10 14:49:05', '1', '361000', '3');
INSERT INTO `th_area` VALUES ('361026', '宜黄县', '2016-11-10 14:49:05', '1', '361000', '3');
INSERT INTO `th_area` VALUES ('361027', '金溪县', '2016-11-10 14:49:05', '1', '361000', '3');
INSERT INTO `th_area` VALUES ('361028', '资溪县', '2016-11-10 14:49:05', '1', '361000', '3');
INSERT INTO `th_area` VALUES ('361029', '东乡县', '2016-11-10 14:49:05', '1', '361000', '3');
INSERT INTO `th_area` VALUES ('361030', '广昌县', '2016-11-10 14:49:05', '1', '361000', '3');
INSERT INTO `th_area` VALUES ('361031', '其它区', '2016-11-10 14:49:05', '1', '361000', '3');
INSERT INTO `th_area` VALUES ('361100', '上饶市', '2016-11-10 14:49:05', '1', '360000', '2');
INSERT INTO `th_area` VALUES ('361102', '信州区', '2016-11-10 14:49:05', '1', '361100', '3');
INSERT INTO `th_area` VALUES ('361121', '上饶县', '2016-11-10 14:49:05', '1', '361100', '3');
INSERT INTO `th_area` VALUES ('361122', '广丰县', '2016-11-10 14:49:05', '1', '361100', '3');
INSERT INTO `th_area` VALUES ('361123', '玉山县', '2016-11-10 14:49:05', '1', '361100', '3');
INSERT INTO `th_area` VALUES ('361124', '铅山县', '2016-11-10 14:49:05', '1', '361100', '3');
INSERT INTO `th_area` VALUES ('361125', '横峰县', '2016-11-10 14:49:05', '1', '361100', '3');
INSERT INTO `th_area` VALUES ('361126', '弋阳县', '2016-11-10 14:49:05', '1', '361100', '3');
INSERT INTO `th_area` VALUES ('361127', '余干县', '2016-11-10 14:49:05', '1', '361100', '3');
INSERT INTO `th_area` VALUES ('361128', '鄱阳县', '2016-11-10 14:49:05', '1', '361100', '3');
INSERT INTO `th_area` VALUES ('361129', '万年县', '2016-11-10 14:49:05', '1', '361100', '3');
INSERT INTO `th_area` VALUES ('361130', '婺源县', '2016-11-10 14:49:05', '1', '361100', '3');
INSERT INTO `th_area` VALUES ('361181', '德兴市', '2016-11-10 14:49:05', '1', '361100', '3');
INSERT INTO `th_area` VALUES ('361182', '其它区', '2016-11-10 14:49:05', '1', '361100', '3');
INSERT INTO `th_area` VALUES ('370000', '山东省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('370100', '济南市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('370102', '历下区', '2016-11-10 14:49:05', '1', '370100', '3');
INSERT INTO `th_area` VALUES ('370103', '市中区', '2016-11-10 14:49:05', '1', '370100', '3');
INSERT INTO `th_area` VALUES ('370104', '槐荫区', '2016-11-10 14:49:05', '1', '370100', '3');
INSERT INTO `th_area` VALUES ('370105', '天桥区', '2016-11-10 14:49:05', '1', '370100', '3');
INSERT INTO `th_area` VALUES ('370112', '历城区', '2016-11-10 14:49:05', '1', '370100', '3');
INSERT INTO `th_area` VALUES ('370113', '长清区', '2016-11-10 14:49:05', '1', '370100', '3');
INSERT INTO `th_area` VALUES ('370124', '平阴县', '2016-11-10 14:49:05', '1', '370100', '3');
INSERT INTO `th_area` VALUES ('370125', '济阳县', '2016-11-10 14:49:05', '1', '370100', '3');
INSERT INTO `th_area` VALUES ('370126', '商河县', '2016-11-10 14:49:05', '1', '370100', '3');
INSERT INTO `th_area` VALUES ('370181', '章丘市', '2016-11-10 14:49:05', '1', '370100', '3');
INSERT INTO `th_area` VALUES ('370182', '其它区', '2016-11-10 14:49:05', '1', '370100', '3');
INSERT INTO `th_area` VALUES ('370200', '青岛市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('370202', '市南区', '2016-11-10 14:49:05', '1', '370200', '3');
INSERT INTO `th_area` VALUES ('370203', '市北区', '2016-11-10 14:49:05', '1', '370200', '3');
INSERT INTO `th_area` VALUES ('370205', '四方区', '2016-11-10 14:49:05', '1', '370200', '3');
INSERT INTO `th_area` VALUES ('370211', '黄岛区', '2016-11-10 14:49:05', '1', '370200', '3');
INSERT INTO `th_area` VALUES ('370212', '崂山区', '2016-11-10 14:49:05', '1', '370200', '3');
INSERT INTO `th_area` VALUES ('370213', '李沧区', '2016-11-10 14:49:05', '1', '370200', '3');
INSERT INTO `th_area` VALUES ('370214', '城阳区', '2016-11-10 14:49:05', '1', '370200', '3');
INSERT INTO `th_area` VALUES ('370251', '开发区', '2016-11-10 14:49:05', '1', '370200', '3');
INSERT INTO `th_area` VALUES ('370281', '胶州市', '2016-11-10 14:49:05', '1', '370200', '3');
INSERT INTO `th_area` VALUES ('370282', '即墨市', '2016-11-10 14:49:05', '1', '370200', '3');
INSERT INTO `th_area` VALUES ('370283', '平度市', '2016-11-10 14:49:05', '1', '370200', '3');
INSERT INTO `th_area` VALUES ('370284', '胶南市', '2016-11-10 14:49:05', '1', '370200', '3');
INSERT INTO `th_area` VALUES ('370285', '莱西市', '2016-11-10 14:49:05', '1', '370200', '3');
INSERT INTO `th_area` VALUES ('370286', '其它区', '2016-11-10 14:49:05', '1', '370200', '3');
INSERT INTO `th_area` VALUES ('370300', '淄博市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('370302', '淄川区', '2016-11-10 14:49:05', '1', '370300', '3');
INSERT INTO `th_area` VALUES ('370303', '张店区', '2016-11-10 14:49:05', '1', '370300', '3');
INSERT INTO `th_area` VALUES ('370304', '博山区', '2016-11-10 14:49:05', '1', '370300', '3');
INSERT INTO `th_area` VALUES ('370305', '临淄区', '2016-11-10 14:49:05', '1', '370300', '3');
INSERT INTO `th_area` VALUES ('370306', '周村区', '2016-11-10 14:49:05', '1', '370300', '3');
INSERT INTO `th_area` VALUES ('370321', '桓台县', '2016-11-10 14:49:05', '1', '370300', '3');
INSERT INTO `th_area` VALUES ('370322', '高青县', '2016-11-10 14:49:05', '1', '370300', '3');
INSERT INTO `th_area` VALUES ('370323', '沂源县', '2016-11-10 14:49:05', '1', '370300', '3');
INSERT INTO `th_area` VALUES ('370324', '其它区', '2016-11-10 14:49:05', '1', '370300', '3');
INSERT INTO `th_area` VALUES ('370400', '枣庄市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('370402', '市中区', '2016-11-10 14:49:05', '1', '370400', '3');
INSERT INTO `th_area` VALUES ('370403', '薛城区', '2016-11-10 14:49:05', '1', '370400', '3');
INSERT INTO `th_area` VALUES ('370404', '峄城区', '2016-11-10 14:49:05', '1', '370400', '3');
INSERT INTO `th_area` VALUES ('370405', '台儿庄区', '2016-11-10 14:49:05', '1', '370400', '3');
INSERT INTO `th_area` VALUES ('370406', '山亭区', '2016-11-10 14:49:05', '1', '370400', '3');
INSERT INTO `th_area` VALUES ('370481', '滕州市', '2016-11-10 14:49:05', '1', '370400', '3');
INSERT INTO `th_area` VALUES ('370482', '其它区', '2016-11-10 14:49:05', '1', '370400', '3');
INSERT INTO `th_area` VALUES ('370500', '东营市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('370502', '东营区', '2016-11-10 14:49:05', '1', '370500', '3');
INSERT INTO `th_area` VALUES ('370503', '河口区', '2016-11-10 14:49:05', '1', '370500', '3');
INSERT INTO `th_area` VALUES ('370521', '垦利县', '2016-11-10 14:49:05', '1', '370500', '3');
INSERT INTO `th_area` VALUES ('370522', '利津县', '2016-11-10 14:49:05', '1', '370500', '3');
INSERT INTO `th_area` VALUES ('370523', '广饶县', '2016-11-10 14:49:05', '1', '370500', '3');
INSERT INTO `th_area` VALUES ('370589', '西城区', '2016-11-10 14:49:05', '1', '370500', '3');
INSERT INTO `th_area` VALUES ('370590', '东城区', '2016-11-10 14:49:05', '1', '370500', '3');
INSERT INTO `th_area` VALUES ('370591', '其它区', '2016-11-10 14:49:05', '1', '370500', '3');
INSERT INTO `th_area` VALUES ('370600', '烟台市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('370602', '芝罘区', '2016-11-10 14:49:05', '1', '370600', '3');
INSERT INTO `th_area` VALUES ('370611', '福山区', '2016-11-10 14:49:05', '1', '370600', '3');
INSERT INTO `th_area` VALUES ('370612', '牟平区', '2016-11-10 14:49:05', '1', '370600', '3');
INSERT INTO `th_area` VALUES ('370613', '莱山区', '2016-11-10 14:49:05', '1', '370600', '3');
INSERT INTO `th_area` VALUES ('370634', '长岛县', '2016-11-10 14:49:05', '1', '370600', '3');
INSERT INTO `th_area` VALUES ('370681', '龙口市', '2016-11-10 14:49:05', '1', '370600', '3');
INSERT INTO `th_area` VALUES ('370682', '莱阳市', '2016-11-10 14:49:05', '1', '370600', '3');
INSERT INTO `th_area` VALUES ('370683', '莱州市', '2016-11-10 14:49:05', '1', '370600', '3');
INSERT INTO `th_area` VALUES ('370684', '蓬莱市', '2016-11-10 14:49:05', '1', '370600', '3');
INSERT INTO `th_area` VALUES ('370685', '招远市', '2016-11-10 14:49:05', '1', '370600', '3');
INSERT INTO `th_area` VALUES ('370686', '栖霞市', '2016-11-10 14:49:05', '1', '370600', '3');
INSERT INTO `th_area` VALUES ('370687', '海阳市', '2016-11-10 14:49:05', '1', '370600', '3');
INSERT INTO `th_area` VALUES ('370688', '其它区', '2016-11-10 14:49:05', '1', '370600', '3');
INSERT INTO `th_area` VALUES ('370700', '潍坊市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('370702', '潍城区', '2016-11-10 14:49:05', '1', '370700', '3');
INSERT INTO `th_area` VALUES ('370703', '寒亭区', '2016-11-10 14:49:05', '1', '370700', '3');
INSERT INTO `th_area` VALUES ('370704', '坊子区', '2016-11-10 14:49:05', '1', '370700', '3');
INSERT INTO `th_area` VALUES ('370705', '奎文区', '2016-11-10 14:49:05', '1', '370700', '3');
INSERT INTO `th_area` VALUES ('370724', '临朐县', '2016-11-10 14:49:05', '1', '370700', '3');
INSERT INTO `th_area` VALUES ('370725', '昌乐县', '2016-11-10 14:49:05', '1', '370700', '3');
INSERT INTO `th_area` VALUES ('370751', '开发区', '2016-11-10 14:49:05', '1', '370700', '3');
INSERT INTO `th_area` VALUES ('370781', '青州市', '2016-11-10 14:49:05', '1', '370700', '3');
INSERT INTO `th_area` VALUES ('370782', '诸城市', '2016-11-10 14:49:05', '1', '370700', '3');
INSERT INTO `th_area` VALUES ('370783', '寿光市', '2016-11-10 14:49:05', '1', '370700', '3');
INSERT INTO `th_area` VALUES ('370784', '安丘市', '2016-11-10 14:49:05', '1', '370700', '3');
INSERT INTO `th_area` VALUES ('370785', '高密市', '2016-11-10 14:49:05', '1', '370700', '3');
INSERT INTO `th_area` VALUES ('370786', '昌邑市', '2016-11-10 14:49:05', '1', '370700', '3');
INSERT INTO `th_area` VALUES ('370787', '其它区', '2016-11-10 14:49:05', '1', '370700', '3');
INSERT INTO `th_area` VALUES ('370800', '济宁市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('370802', '市中区', '2016-11-10 14:49:05', '1', '370800', '3');
INSERT INTO `th_area` VALUES ('370811', '任城区', '2016-11-10 14:49:05', '1', '370800', '3');
INSERT INTO `th_area` VALUES ('370826', '微山县', '2016-11-10 14:49:05', '1', '370800', '3');
INSERT INTO `th_area` VALUES ('370827', '鱼台县', '2016-11-10 14:49:05', '1', '370800', '3');
INSERT INTO `th_area` VALUES ('370828', '金乡县', '2016-11-10 14:49:05', '1', '370800', '3');
INSERT INTO `th_area` VALUES ('370829', '嘉祥县', '2016-11-10 14:49:05', '1', '370800', '3');
INSERT INTO `th_area` VALUES ('370830', '汶上县', '2016-11-10 14:49:05', '1', '370800', '3');
INSERT INTO `th_area` VALUES ('370831', '泗水县', '2016-11-10 14:49:05', '1', '370800', '3');
INSERT INTO `th_area` VALUES ('370832', '梁山县', '2016-11-10 14:49:05', '1', '370800', '3');
INSERT INTO `th_area` VALUES ('370881', '曲阜市', '2016-11-10 14:49:05', '1', '370800', '3');
INSERT INTO `th_area` VALUES ('370882', '兖州市', '2016-11-10 14:49:05', '1', '370800', '3');
INSERT INTO `th_area` VALUES ('370883', '邹城市', '2016-11-10 14:49:05', '1', '370800', '3');
INSERT INTO `th_area` VALUES ('370884', '其它区', '2016-11-10 14:49:05', '1', '370800', '3');
INSERT INTO `th_area` VALUES ('370900', '泰安市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('370902', '泰山区', '2016-11-10 14:49:05', '1', '370900', '3');
INSERT INTO `th_area` VALUES ('370903', '岱岳区', '2016-11-10 14:49:05', '1', '370900', '3');
INSERT INTO `th_area` VALUES ('370921', '宁阳县', '2016-11-10 14:49:05', '1', '370900', '3');
INSERT INTO `th_area` VALUES ('370923', '东平县', '2016-11-10 14:49:05', '1', '370900', '3');
INSERT INTO `th_area` VALUES ('370982', '新泰市', '2016-11-10 14:49:05', '1', '370900', '3');
INSERT INTO `th_area` VALUES ('370983', '肥城市', '2016-11-10 14:49:05', '1', '370900', '3');
INSERT INTO `th_area` VALUES ('370984', '其它区', '2016-11-10 14:49:05', '1', '370900', '3');
INSERT INTO `th_area` VALUES ('371000', '威海市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('371002', '环翠区', '2016-11-10 14:49:05', '1', '371000', '3');
INSERT INTO `th_area` VALUES ('371081', '文登市', '2016-11-10 14:49:05', '1', '371000', '3');
INSERT INTO `th_area` VALUES ('371082', '荣成市', '2016-11-10 14:49:05', '1', '371000', '3');
INSERT INTO `th_area` VALUES ('371083', '乳山市', '2016-11-10 14:49:05', '1', '371000', '3');
INSERT INTO `th_area` VALUES ('371084', '其它区', '2016-11-10 14:49:05', '1', '371000', '3');
INSERT INTO `th_area` VALUES ('371100', '日照市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('371102', '东港区', '2016-11-10 14:49:05', '1', '371100', '3');
INSERT INTO `th_area` VALUES ('371103', '岚山区', '2016-11-10 14:49:05', '1', '371100', '3');
INSERT INTO `th_area` VALUES ('371121', '五莲县', '2016-11-10 14:49:05', '1', '371100', '3');
INSERT INTO `th_area` VALUES ('371122', '莒县', '2016-11-10 14:49:05', '1', '371100', '3');
INSERT INTO `th_area` VALUES ('371123', '其它区', '2016-11-10 14:49:05', '1', '371100', '3');
INSERT INTO `th_area` VALUES ('371200', '莱芜市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('371202', '莱城区', '2016-11-10 14:49:05', '1', '371200', '3');
INSERT INTO `th_area` VALUES ('371203', '钢城区', '2016-11-10 14:49:05', '1', '371200', '3');
INSERT INTO `th_area` VALUES ('371204', '其它区', '2016-11-10 14:49:05', '1', '371200', '3');
INSERT INTO `th_area` VALUES ('371300', '临沂市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('371302', '兰山区', '2016-11-10 14:49:05', '1', '371300', '3');
INSERT INTO `th_area` VALUES ('371311', '罗庄区', '2016-11-10 14:49:05', '1', '371300', '3');
INSERT INTO `th_area` VALUES ('371312', '河东区', '2016-11-10 14:49:05', '1', '371300', '3');
INSERT INTO `th_area` VALUES ('371321', '沂南县', '2016-11-10 14:49:05', '1', '371300', '3');
INSERT INTO `th_area` VALUES ('371322', '郯城县', '2016-11-10 14:49:05', '1', '371300', '3');
INSERT INTO `th_area` VALUES ('371323', '沂水县', '2016-11-10 14:49:05', '1', '371300', '3');
INSERT INTO `th_area` VALUES ('371324', '苍山县', '2016-11-10 14:49:05', '1', '371300', '3');
INSERT INTO `th_area` VALUES ('371325', '费县', '2016-11-10 14:49:05', '1', '371300', '3');
INSERT INTO `th_area` VALUES ('371326', '平邑县', '2016-11-10 14:49:05', '1', '371300', '3');
INSERT INTO `th_area` VALUES ('371327', '莒南县', '2016-11-10 14:49:05', '1', '371300', '3');
INSERT INTO `th_area` VALUES ('371328', '蒙阴县', '2016-11-10 14:49:05', '1', '371300', '3');
INSERT INTO `th_area` VALUES ('371329', '临沭县', '2016-11-10 14:49:05', '1', '371300', '3');
INSERT INTO `th_area` VALUES ('371330', '其它区', '2016-11-10 14:49:05', '1', '371300', '3');
INSERT INTO `th_area` VALUES ('371400', '德州市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('371402', '德城区', '2016-11-10 14:49:05', '1', '371400', '3');
INSERT INTO `th_area` VALUES ('371421', '陵县', '2016-11-10 14:49:05', '1', '371400', '3');
INSERT INTO `th_area` VALUES ('371422', '宁津县', '2016-11-10 14:49:05', '1', '371400', '3');
INSERT INTO `th_area` VALUES ('371423', '庆云县', '2016-11-10 14:49:05', '1', '371400', '3');
INSERT INTO `th_area` VALUES ('371424', '临邑县', '2016-11-10 14:49:05', '1', '371400', '3');
INSERT INTO `th_area` VALUES ('371425', '齐河县', '2016-11-10 14:49:05', '1', '371400', '3');
INSERT INTO `th_area` VALUES ('371426', '平原县', '2016-11-10 14:49:05', '1', '371400', '3');
INSERT INTO `th_area` VALUES ('371427', '夏津县', '2016-11-10 14:49:05', '1', '371400', '3');
INSERT INTO `th_area` VALUES ('371428', '武城县', '2016-11-10 14:49:05', '1', '371400', '3');
INSERT INTO `th_area` VALUES ('371451', '开发区', '2016-11-10 14:49:05', '1', '371400', '3');
INSERT INTO `th_area` VALUES ('371481', '乐陵市', '2016-11-10 14:49:05', '1', '371400', '3');
INSERT INTO `th_area` VALUES ('371482', '禹城市', '2016-11-10 14:49:05', '1', '371400', '3');
INSERT INTO `th_area` VALUES ('371483', '其它区', '2016-11-10 14:49:05', '1', '371400', '3');
INSERT INTO `th_area` VALUES ('371500', '聊城市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('371502', '东昌府区', '2016-11-10 14:49:05', '1', '371500', '3');
INSERT INTO `th_area` VALUES ('371521', '阳谷县', '2016-11-10 14:49:05', '1', '371500', '3');
INSERT INTO `th_area` VALUES ('371522', '莘县', '2016-11-10 14:49:05', '1', '371500', '3');
INSERT INTO `th_area` VALUES ('371523', '茌平县', '2016-11-10 14:49:05', '1', '371500', '3');
INSERT INTO `th_area` VALUES ('371524', '东阿县', '2016-11-10 14:49:05', '1', '371500', '3');
INSERT INTO `th_area` VALUES ('371525', '冠县', '2016-11-10 14:49:05', '1', '371500', '3');
INSERT INTO `th_area` VALUES ('371526', '高唐县', '2016-11-10 14:49:05', '1', '371500', '3');
INSERT INTO `th_area` VALUES ('371581', '临清市', '2016-11-10 14:49:05', '1', '371500', '3');
INSERT INTO `th_area` VALUES ('371582', '其它区', '2016-11-10 14:49:05', '1', '371500', '3');
INSERT INTO `th_area` VALUES ('371600', '滨州市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('371602', '滨城区', '2016-11-10 14:49:05', '1', '371600', '3');
INSERT INTO `th_area` VALUES ('371621', '惠民县', '2016-11-10 14:49:05', '1', '371600', '3');
INSERT INTO `th_area` VALUES ('371622', '阳信县', '2016-11-10 14:49:05', '1', '371600', '3');
INSERT INTO `th_area` VALUES ('371623', '无棣县', '2016-11-10 14:49:05', '1', '371600', '3');
INSERT INTO `th_area` VALUES ('371624', '沾化县', '2016-11-10 14:49:05', '1', '371600', '3');
INSERT INTO `th_area` VALUES ('371625', '博兴县', '2016-11-10 14:49:05', '1', '371600', '3');
INSERT INTO `th_area` VALUES ('371626', '邹平县', '2016-11-10 14:49:05', '1', '371600', '3');
INSERT INTO `th_area` VALUES ('371627', '其它区', '2016-11-10 14:49:05', '1', '371600', '3');
INSERT INTO `th_area` VALUES ('371700', '菏泽市', '2016-11-10 14:49:05', '1', '370000', '2');
INSERT INTO `th_area` VALUES ('371702', '牡丹区', '2016-11-10 14:49:05', '1', '371700', '3');
INSERT INTO `th_area` VALUES ('371721', '曹县', '2016-11-10 14:49:05', '1', '371700', '3');
INSERT INTO `th_area` VALUES ('371722', '单县', '2016-11-10 14:49:05', '1', '371700', '3');
INSERT INTO `th_area` VALUES ('371723', '成武县', '2016-11-10 14:49:05', '1', '371700', '3');
INSERT INTO `th_area` VALUES ('371724', '巨野县', '2016-11-10 14:49:05', '1', '371700', '3');
INSERT INTO `th_area` VALUES ('371725', '郓城县', '2016-11-10 14:49:05', '1', '371700', '3');
INSERT INTO `th_area` VALUES ('371726', '鄄城县', '2016-11-10 14:49:05', '1', '371700', '3');
INSERT INTO `th_area` VALUES ('371727', '定陶县', '2016-11-10 14:49:05', '1', '371700', '3');
INSERT INTO `th_area` VALUES ('371728', '东明县', '2016-11-10 14:49:05', '1', '371700', '3');
INSERT INTO `th_area` VALUES ('371729', '其它区', '2016-11-10 14:49:05', '1', '371700', '3');
INSERT INTO `th_area` VALUES ('410000', '河南省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('410100', '郑州市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('410102', '中原区', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410103', '二七区', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410104', '管城回族区', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410105', '金水区', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410106', '上街区', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410108', '惠济区', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410122', '中牟县', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410181', '巩义市', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410182', '荥阳市', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410183', '新密市', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410184', '新郑市', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410185', '登封市', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410186', '郑东新区', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410187', '高新区', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410188', '其它区', '2016-11-10 14:49:05', '1', '410100', '3');
INSERT INTO `th_area` VALUES ('410200', '开封市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('410202', '龙亭区', '2016-11-10 14:49:05', '1', '410200', '3');
INSERT INTO `th_area` VALUES ('410203', '顺河回族区', '2016-11-10 14:49:05', '1', '410200', '3');
INSERT INTO `th_area` VALUES ('410204', '鼓楼区', '2016-11-10 14:49:05', '1', '410200', '3');
INSERT INTO `th_area` VALUES ('410205', '禹王台区', '2016-11-10 14:49:05', '1', '410200', '3');
INSERT INTO `th_area` VALUES ('410211', '金明区', '2016-11-10 14:49:05', '1', '410200', '3');
INSERT INTO `th_area` VALUES ('410221', '杞县', '2016-11-10 14:49:05', '1', '410200', '3');
INSERT INTO `th_area` VALUES ('410222', '通许县', '2016-11-10 14:49:05', '1', '410200', '3');
INSERT INTO `th_area` VALUES ('410223', '尉氏县', '2016-11-10 14:49:05', '1', '410200', '3');
INSERT INTO `th_area` VALUES ('410224', '开封县', '2016-11-10 14:49:05', '1', '410200', '3');
INSERT INTO `th_area` VALUES ('410225', '兰考县', '2016-11-10 14:49:05', '1', '410200', '3');
INSERT INTO `th_area` VALUES ('410226', '其它区', '2016-11-10 14:49:05', '1', '410200', '3');
INSERT INTO `th_area` VALUES ('410300', '洛阳市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('410302', '老城区', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410303', '西工区', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410304', '廛河回族区', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410305', '涧西区', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410306', '吉利区', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410307', '洛龙区', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410322', '孟津县', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410323', '新安县', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410324', '栾川县', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410325', '嵩县', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410326', '汝阳县', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410327', '宜阳县', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410328', '洛宁县', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410329', '伊川县', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410381', '偃师市', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('410400', '平顶山市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('410402', '新华区', '2016-11-10 14:49:05', '1', '410400', '3');
INSERT INTO `th_area` VALUES ('410403', '卫东区', '2016-11-10 14:49:05', '1', '410400', '3');
INSERT INTO `th_area` VALUES ('410404', '石龙区', '2016-11-10 14:49:05', '1', '410400', '3');
INSERT INTO `th_area` VALUES ('410411', '湛河区', '2016-11-10 14:49:05', '1', '410400', '3');
INSERT INTO `th_area` VALUES ('410421', '宝丰县', '2016-11-10 14:49:05', '1', '410400', '3');
INSERT INTO `th_area` VALUES ('410422', '叶县', '2016-11-10 14:49:05', '1', '410400', '3');
INSERT INTO `th_area` VALUES ('410423', '鲁山县', '2016-11-10 14:49:05', '1', '410400', '3');
INSERT INTO `th_area` VALUES ('410425', '郏县', '2016-11-10 14:49:05', '1', '410400', '3');
INSERT INTO `th_area` VALUES ('410481', '舞钢市', '2016-11-10 14:49:05', '1', '410400', '3');
INSERT INTO `th_area` VALUES ('410482', '汝州市', '2016-11-10 14:49:05', '1', '410400', '3');
INSERT INTO `th_area` VALUES ('410483', '其它区', '2016-11-10 14:49:05', '1', '410400', '3');
INSERT INTO `th_area` VALUES ('410500', '安阳市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('410502', '文峰区', '2016-11-10 14:49:05', '1', '410500', '3');
INSERT INTO `th_area` VALUES ('410503', '北关区', '2016-11-10 14:49:05', '1', '410500', '3');
INSERT INTO `th_area` VALUES ('410505', '殷都区', '2016-11-10 14:49:05', '1', '410500', '3');
INSERT INTO `th_area` VALUES ('410506', '龙安区', '2016-11-10 14:49:05', '1', '410500', '3');
INSERT INTO `th_area` VALUES ('410522', '安阳县', '2016-11-10 14:49:05', '1', '410500', '3');
INSERT INTO `th_area` VALUES ('410523', '汤阴县', '2016-11-10 14:49:05', '1', '410500', '3');
INSERT INTO `th_area` VALUES ('410526', '滑县', '2016-11-10 14:49:05', '1', '410500', '3');
INSERT INTO `th_area` VALUES ('410527', '内黄县', '2016-11-10 14:49:05', '1', '410500', '3');
INSERT INTO `th_area` VALUES ('410581', '林州市', '2016-11-10 14:49:05', '1', '410500', '3');
INSERT INTO `th_area` VALUES ('410582', '其它区', '2016-11-10 14:49:05', '1', '410500', '3');
INSERT INTO `th_area` VALUES ('410600', '鹤壁市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('410602', '鹤山区', '2016-11-10 14:49:05', '1', '410600', '3');
INSERT INTO `th_area` VALUES ('410603', '山城区', '2016-11-10 14:49:05', '1', '410600', '3');
INSERT INTO `th_area` VALUES ('410611', '淇滨区', '2016-11-10 14:49:05', '1', '410600', '3');
INSERT INTO `th_area` VALUES ('410621', '浚县', '2016-11-10 14:49:05', '1', '410600', '3');
INSERT INTO `th_area` VALUES ('410622', '淇县', '2016-11-10 14:49:05', '1', '410600', '3');
INSERT INTO `th_area` VALUES ('410623', '其它区', '2016-11-10 14:49:05', '1', '410600', '3');
INSERT INTO `th_area` VALUES ('410700', '新乡市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('410702', '红旗区', '2016-11-10 14:49:05', '1', '410700', '3');
INSERT INTO `th_area` VALUES ('410703', '卫滨区', '2016-11-10 14:49:05', '1', '410700', '3');
INSERT INTO `th_area` VALUES ('410704', '凤泉区', '2016-11-10 14:49:05', '1', '410700', '3');
INSERT INTO `th_area` VALUES ('410711', '牧野区', '2016-11-10 14:49:05', '1', '410700', '3');
INSERT INTO `th_area` VALUES ('410721', '新乡县', '2016-11-10 14:49:05', '1', '410700', '3');
INSERT INTO `th_area` VALUES ('410724', '获嘉县', '2016-11-10 14:49:05', '1', '410700', '3');
INSERT INTO `th_area` VALUES ('410725', '原阳县', '2016-11-10 14:49:05', '1', '410700', '3');
INSERT INTO `th_area` VALUES ('410726', '延津县', '2016-11-10 14:49:05', '1', '410700', '3');
INSERT INTO `th_area` VALUES ('410727', '封丘县', '2016-11-10 14:49:05', '1', '410700', '3');
INSERT INTO `th_area` VALUES ('410728', '长垣县', '2016-11-10 14:49:05', '1', '410700', '3');
INSERT INTO `th_area` VALUES ('410781', '卫辉市', '2016-11-10 14:49:05', '1', '410700', '3');
INSERT INTO `th_area` VALUES ('410782', '辉县市', '2016-11-10 14:49:05', '1', '410700', '3');
INSERT INTO `th_area` VALUES ('410783', '其它区', '2016-11-10 14:49:05', '1', '410700', '3');
INSERT INTO `th_area` VALUES ('410800', '焦作市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('410802', '解放区', '2016-11-10 14:49:05', '1', '410800', '3');
INSERT INTO `th_area` VALUES ('410803', '中站区', '2016-11-10 14:49:05', '1', '410800', '3');
INSERT INTO `th_area` VALUES ('410804', '马村区', '2016-11-10 14:49:05', '1', '410800', '3');
INSERT INTO `th_area` VALUES ('410811', '山阳区', '2016-11-10 14:49:05', '1', '410800', '3');
INSERT INTO `th_area` VALUES ('410821', '修武县', '2016-11-10 14:49:05', '1', '410800', '3');
INSERT INTO `th_area` VALUES ('410822', '博爱县', '2016-11-10 14:49:05', '1', '410800', '3');
INSERT INTO `th_area` VALUES ('410823', '武陟县', '2016-11-10 14:49:05', '1', '410800', '3');
INSERT INTO `th_area` VALUES ('410825', '温县', '2016-11-10 14:49:05', '1', '410800', '3');
INSERT INTO `th_area` VALUES ('410882', '沁阳市', '2016-11-10 14:49:05', '1', '410800', '3');
INSERT INTO `th_area` VALUES ('410883', '孟州市', '2016-11-10 14:49:05', '1', '410800', '3');
INSERT INTO `th_area` VALUES ('410884', '其它区', '2016-11-10 14:49:05', '1', '410800', '3');
INSERT INTO `th_area` VALUES ('410900', '濮阳市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('410902', '华龙区', '2016-11-10 14:49:05', '1', '410900', '3');
INSERT INTO `th_area` VALUES ('410922', '清丰县', '2016-11-10 14:49:05', '1', '410900', '3');
INSERT INTO `th_area` VALUES ('410923', '南乐县', '2016-11-10 14:49:05', '1', '410900', '3');
INSERT INTO `th_area` VALUES ('410926', '范县', '2016-11-10 14:49:05', '1', '410900', '3');
INSERT INTO `th_area` VALUES ('410927', '台前县', '2016-11-10 14:49:05', '1', '410900', '3');
INSERT INTO `th_area` VALUES ('410928', '濮阳县', '2016-11-10 14:49:05', '1', '410900', '3');
INSERT INTO `th_area` VALUES ('410929', '其它区', '2016-11-10 14:49:05', '1', '410900', '3');
INSERT INTO `th_area` VALUES ('411000', '许昌市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('411002', '华龙区', '2016-11-10 14:49:05', '1', '411000', '3');
INSERT INTO `th_area` VALUES ('411022', '清丰县', '2016-11-10 14:49:05', '1', '411000', '3');
INSERT INTO `th_area` VALUES ('411023', '南乐县', '2016-11-10 14:49:05', '1', '411000', '3');
INSERT INTO `th_area` VALUES ('411026', '范县', '2016-11-10 14:49:05', '1', '411000', '3');
INSERT INTO `th_area` VALUES ('411027', '台前县', '2016-11-10 14:49:05', '1', '411000', '3');
INSERT INTO `th_area` VALUES ('411028', '濮阳县', '2016-11-10 14:49:05', '1', '411000', '3');
INSERT INTO `th_area` VALUES ('411029', '其它区', '2016-11-10 14:49:05', '1', '411000', '3');
INSERT INTO `th_area` VALUES ('411100', '漯河市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('411102', '魏都区', '2016-11-10 14:49:05', '1', '411100', '3');
INSERT INTO `th_area` VALUES ('411123', '许昌县', '2016-11-10 14:49:05', '1', '411100', '3');
INSERT INTO `th_area` VALUES ('411124', '鄢陵县', '2016-11-10 14:49:05', '1', '411100', '3');
INSERT INTO `th_area` VALUES ('411125', '襄城县', '2016-11-10 14:49:05', '1', '411100', '3');
INSERT INTO `th_area` VALUES ('411181', '禹州市', '2016-11-10 14:49:05', '1', '411100', '3');
INSERT INTO `th_area` VALUES ('411182', '长葛市', '2016-11-10 14:49:05', '1', '411100', '3');
INSERT INTO `th_area` VALUES ('411183', '其它区', '2016-11-10 14:49:05', '1', '411100', '3');
INSERT INTO `th_area` VALUES ('411200', '三门峡市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('411202', '源汇区', '2016-11-10 14:49:05', '1', '411200', '3');
INSERT INTO `th_area` VALUES ('411203', '郾城区', '2016-11-10 14:49:05', '1', '411200', '3');
INSERT INTO `th_area` VALUES ('411204', '召陵区', '2016-11-10 14:49:05', '1', '411200', '3');
INSERT INTO `th_area` VALUES ('411221', '舞阳县', '2016-11-10 14:49:05', '1', '411200', '3');
INSERT INTO `th_area` VALUES ('411222', '临颍县', '2016-11-10 14:49:05', '1', '411200', '3');
INSERT INTO `th_area` VALUES ('411223', '其它区', '2016-11-10 14:49:05', '1', '411200', '3');
INSERT INTO `th_area` VALUES ('411300', '南阳市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('411302', '湖滨区', '2016-11-10 14:49:05', '1', '411300', '3');
INSERT INTO `th_area` VALUES ('411321', '渑池县', '2016-11-10 14:49:05', '1', '411300', '3');
INSERT INTO `th_area` VALUES ('411322', '陕县', '2016-11-10 14:49:05', '1', '411300', '3');
INSERT INTO `th_area` VALUES ('411324', '卢氏县', '2016-11-10 14:49:05', '1', '411300', '3');
INSERT INTO `th_area` VALUES ('411381', '义马市', '2016-11-10 14:49:05', '1', '411300', '3');
INSERT INTO `th_area` VALUES ('411382', '灵宝市', '2016-11-10 14:49:05', '1', '411300', '3');
INSERT INTO `th_area` VALUES ('411383', '其它区', '2016-11-10 14:49:05', '1', '411300', '3');
INSERT INTO `th_area` VALUES ('411400', '商丘市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('411402', '宛城区', '2016-11-10 14:49:05', '1', '411400', '3');
INSERT INTO `th_area` VALUES ('411403', '卧龙区', '2016-11-10 14:49:05', '1', '411400', '3');
INSERT INTO `th_area` VALUES ('411421', '南召县', '2016-11-10 14:49:05', '1', '411400', '3');
INSERT INTO `th_area` VALUES ('411422', '方城县', '2016-11-10 14:49:05', '1', '411400', '3');
INSERT INTO `th_area` VALUES ('411423', '西峡县', '2016-11-10 14:49:05', '1', '411400', '3');
INSERT INTO `th_area` VALUES ('411424', '镇平县', '2016-11-10 14:49:05', '1', '411400', '3');
INSERT INTO `th_area` VALUES ('411425', '内乡县', '2016-11-10 14:49:05', '1', '411400', '3');
INSERT INTO `th_area` VALUES ('411426', '淅川县', '2016-11-10 14:49:05', '1', '411400', '3');
INSERT INTO `th_area` VALUES ('411427', '社旗县', '2016-11-10 14:49:05', '1', '411400', '3');
INSERT INTO `th_area` VALUES ('411428', '唐河县', '2016-11-10 14:49:05', '1', '411400', '3');
INSERT INTO `th_area` VALUES ('411429', '新野县', '2016-11-10 14:49:05', '1', '411400', '3');
INSERT INTO `th_area` VALUES ('411430', '桐柏县', '2016-11-10 14:49:05', '1', '411400', '3');
INSERT INTO `th_area` VALUES ('411481', '邓州市', '2016-11-10 14:49:05', '1', '411400', '3');
INSERT INTO `th_area` VALUES ('411482', '其它区', '2016-11-10 14:49:05', '1', '411400', '3');
INSERT INTO `th_area` VALUES ('411500', '信阳市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('411502', '梁园区', '2016-11-10 14:49:05', '1', '411500', '3');
INSERT INTO `th_area` VALUES ('411503', '睢阳区', '2016-11-10 14:49:05', '1', '411500', '3');
INSERT INTO `th_area` VALUES ('411521', '民权县', '2016-11-10 14:49:05', '1', '411500', '3');
INSERT INTO `th_area` VALUES ('411522', '睢县', '2016-11-10 14:49:05', '1', '411500', '3');
INSERT INTO `th_area` VALUES ('411523', '宁陵县', '2016-11-10 14:49:05', '1', '411500', '3');
INSERT INTO `th_area` VALUES ('411524', '柘城县', '2016-11-10 14:49:05', '1', '411500', '3');
INSERT INTO `th_area` VALUES ('411526', '夏邑县', '2016-11-10 14:49:05', '1', '411500', '3');
INSERT INTO `th_area` VALUES ('4115425', '虞城县', '2016-11-10 14:49:05', '1', '411500', '3');
INSERT INTO `th_area` VALUES ('411581', '永城市', '2016-11-10 14:49:05', '1', '411500', '3');
INSERT INTO `th_area` VALUES ('411582', '其它区', '2016-11-10 14:49:05', '1', '411500', '3');
INSERT INTO `th_area` VALUES ('411600', '周口市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('411603', '平桥区', '2016-11-10 14:49:05', '1', '411600', '3');
INSERT INTO `th_area` VALUES ('411621', '罗山县', '2016-11-10 14:49:05', '1', '411600', '3');
INSERT INTO `th_area` VALUES ('411622', '光山县', '2016-11-10 14:49:05', '1', '411600', '3');
INSERT INTO `th_area` VALUES ('411623', '新县', '2016-11-10 14:49:05', '1', '411600', '3');
INSERT INTO `th_area` VALUES ('411624', '商城县', '2016-11-10 14:49:05', '1', '411600', '3');
INSERT INTO `th_area` VALUES ('411625', '固始县', '2016-11-10 14:49:05', '1', '411600', '3');
INSERT INTO `th_area` VALUES ('411626', '潢川县', '2016-11-10 14:49:05', '1', '411600', '3');
INSERT INTO `th_area` VALUES ('411627', '淮滨县', '2016-11-10 14:49:05', '1', '411600', '3');
INSERT INTO `th_area` VALUES ('411628', '息县', '2016-11-10 14:49:05', '1', '411600', '3');
INSERT INTO `th_area` VALUES ('411629', '其它区', '2016-11-10 14:49:05', '1', '411600', '3');
INSERT INTO `th_area` VALUES ('4116502', '浉河区', '2016-11-10 14:49:05', '1', '411600', '3');
INSERT INTO `th_area` VALUES ('411700', '驻马店市', '2016-11-10 14:49:05', '1', '410000', '2');
INSERT INTO `th_area` VALUES ('411702', '川汇区', '2016-11-10 14:49:05', '1', '411700', '3');
INSERT INTO `th_area` VALUES ('411721', '扶沟县', '2016-11-10 14:49:05', '1', '411700', '3');
INSERT INTO `th_area` VALUES ('411722', '西华县', '2016-11-10 14:49:05', '1', '411700', '3');
INSERT INTO `th_area` VALUES ('411723', '商水县', '2016-11-10 14:49:05', '1', '411700', '3');
INSERT INTO `th_area` VALUES ('411724', '沈丘县', '2016-11-10 14:49:05', '1', '411700', '3');
INSERT INTO `th_area` VALUES ('411725', '郸城县', '2016-11-10 14:49:05', '1', '411700', '3');
INSERT INTO `th_area` VALUES ('411726', '淮阳县', '2016-11-10 14:49:05', '1', '411700', '3');
INSERT INTO `th_area` VALUES ('411727', '太康县', '2016-11-10 14:49:05', '1', '411700', '3');
INSERT INTO `th_area` VALUES ('411728', '鹿邑县', '2016-11-10 14:49:05', '1', '411700', '3');
INSERT INTO `th_area` VALUES ('411781', '项城市', '2016-11-10 14:49:05', '1', '411700', '3');
INSERT INTO `th_area` VALUES ('411782', '其它区', '2016-11-10 14:49:05', '1', '411700', '3');
INSERT INTO `th_area` VALUES ('420000', '湖北省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('420100', '武汉市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('420102', '江岸区', '2016-11-10 14:49:05', '1', '420100', '3');
INSERT INTO `th_area` VALUES ('420103', '江汉区', '2016-11-10 14:49:05', '1', '420100', '3');
INSERT INTO `th_area` VALUES ('420104', '硚口区', '2016-11-10 14:49:05', '1', '420100', '3');
INSERT INTO `th_area` VALUES ('420105', '汉阳区', '2016-11-10 14:49:05', '1', '420100', '3');
INSERT INTO `th_area` VALUES ('420106', '武昌区', '2016-11-10 14:49:05', '1', '420100', '3');
INSERT INTO `th_area` VALUES ('420107', '青山区', '2016-11-10 14:49:05', '1', '420100', '3');
INSERT INTO `th_area` VALUES ('420111', '洪山区', '2016-11-10 14:49:05', '1', '420100', '3');
INSERT INTO `th_area` VALUES ('420112', '东西湖区', '2016-11-10 14:49:05', '1', '420100', '3');
INSERT INTO `th_area` VALUES ('420113', '汉南区', '2016-11-10 14:49:05', '1', '420100', '3');
INSERT INTO `th_area` VALUES ('420114', '蔡甸区', '2016-11-10 14:49:05', '1', '420100', '3');
INSERT INTO `th_area` VALUES ('420115', '江夏区', '2016-11-10 14:49:05', '1', '420100', '3');
INSERT INTO `th_area` VALUES ('420116', '黄陂区', '2016-11-10 14:49:05', '1', '420100', '3');
INSERT INTO `th_area` VALUES ('420117', '新洲区', '2016-11-10 14:49:05', '1', '420100', '3');
INSERT INTO `th_area` VALUES ('420118', '其它区', '2016-11-10 14:49:05', '1', '420100', '3');
INSERT INTO `th_area` VALUES ('420200', '黄石市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('420202', '黄石港区', '2016-11-10 14:49:05', '1', '420200', '3');
INSERT INTO `th_area` VALUES ('420203', '西塞山区', '2016-11-10 14:49:05', '1', '420200', '3');
INSERT INTO `th_area` VALUES ('420204', '下陆区', '2016-11-10 14:49:05', '1', '420200', '3');
INSERT INTO `th_area` VALUES ('420205', '铁山区', '2016-11-10 14:49:05', '1', '420200', '3');
INSERT INTO `th_area` VALUES ('420222', '阳新县', '2016-11-10 14:49:05', '1', '420200', '3');
INSERT INTO `th_area` VALUES ('420281', '大冶市', '2016-11-10 14:49:05', '1', '420200', '3');
INSERT INTO `th_area` VALUES ('420282', '其它区', '2016-11-10 14:49:05', '1', '420200', '3');
INSERT INTO `th_area` VALUES ('420300', '十堰市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('420302', '茅箭区', '2016-11-10 14:49:05', '1', '420300', '3');
INSERT INTO `th_area` VALUES ('420303', '张湾区', '2016-11-10 14:49:05', '1', '420300', '3');
INSERT INTO `th_area` VALUES ('420321', '郧县', '2016-11-10 14:49:05', '1', '420300', '3');
INSERT INTO `th_area` VALUES ('420322', '郧西县', '2016-11-10 14:49:05', '1', '420300', '3');
INSERT INTO `th_area` VALUES ('420323', '竹山县', '2016-11-10 14:49:05', '1', '420300', '3');
INSERT INTO `th_area` VALUES ('420324', '竹溪县', '2016-11-10 14:49:05', '1', '420300', '3');
INSERT INTO `th_area` VALUES ('420325', '房县', '2016-11-10 14:49:05', '1', '420300', '3');
INSERT INTO `th_area` VALUES ('420381', '丹江口市', '2016-11-10 14:49:05', '1', '420300', '3');
INSERT INTO `th_area` VALUES ('420382', '城区', '2016-11-10 14:49:05', '1', '420300', '3');
INSERT INTO `th_area` VALUES ('420383', '其它区', '2016-11-10 14:49:05', '1', '420300', '3');
INSERT INTO `th_area` VALUES ('420500', '宜昌市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('420502', '西陵区', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420503', '伍家岗区', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420504', '点军区', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420505', '猇亭区', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420506', '夷陵区', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420525', '远安县', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420526', '兴山县', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420527', '秭归县', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420528', '长阳土家族自治县', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420529', '五峰土家族自治县', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420551', '葛洲坝区', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420552', '开发区', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420581', '宜都市', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420582', '当阳市', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420583', '枝江市', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420584', '其它区', '2016-11-10 14:49:05', '1', '420500', '3');
INSERT INTO `th_area` VALUES ('420600', '襄阳市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('420602', '襄城区', '2016-11-10 14:49:05', '1', '420600', '3');
INSERT INTO `th_area` VALUES ('420606', '樊城区', '2016-11-10 14:49:05', '1', '420600', '3');
INSERT INTO `th_area` VALUES ('420607', '襄州区', '2016-11-10 14:49:05', '1', '420600', '3');
INSERT INTO `th_area` VALUES ('420624', '南漳县', '2016-11-10 14:49:05', '1', '420600', '3');
INSERT INTO `th_area` VALUES ('420625', '谷城县', '2016-11-10 14:49:05', '1', '420600', '3');
INSERT INTO `th_area` VALUES ('420626', '保康县', '2016-11-10 14:49:05', '1', '420600', '3');
INSERT INTO `th_area` VALUES ('420682', '老河口市', '2016-11-10 14:49:05', '1', '420600', '3');
INSERT INTO `th_area` VALUES ('420683', '枣阳市', '2016-11-10 14:49:05', '1', '420600', '3');
INSERT INTO `th_area` VALUES ('420684', '宜城市', '2016-11-10 14:49:05', '1', '420600', '3');
INSERT INTO `th_area` VALUES ('420685', '其它区', '2016-11-10 14:49:05', '1', '420600', '3');
INSERT INTO `th_area` VALUES ('420700', '鄂州市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('420702', '梁子湖区', '2016-11-10 14:49:05', '1', '420700', '3');
INSERT INTO `th_area` VALUES ('420703', '华容区', '2016-11-10 14:49:05', '1', '420700', '3');
INSERT INTO `th_area` VALUES ('420704', '鄂城区', '2016-11-10 14:49:05', '1', '420700', '3');
INSERT INTO `th_area` VALUES ('420705', '其它区', '2016-11-10 14:49:05', '1', '420700', '3');
INSERT INTO `th_area` VALUES ('420800', '荆门市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('420802', '东宝区', '2016-11-10 14:49:05', '1', '420800', '3');
INSERT INTO `th_area` VALUES ('420804', '掇刀区', '2016-11-10 14:49:05', '1', '420800', '3');
INSERT INTO `th_area` VALUES ('420821', '京山县', '2016-11-10 14:49:05', '1', '420800', '3');
INSERT INTO `th_area` VALUES ('420822', '沙洋县', '2016-11-10 14:49:05', '1', '420800', '3');
INSERT INTO `th_area` VALUES ('420881', '钟祥市', '2016-11-10 14:49:05', '1', '420800', '3');
INSERT INTO `th_area` VALUES ('420882', '其它区', '2016-11-10 14:49:05', '1', '420800', '3');
INSERT INTO `th_area` VALUES ('420900', '孝感市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('420902', '孝南区', '2016-11-10 14:49:05', '1', '420900', '3');
INSERT INTO `th_area` VALUES ('420921', '孝昌县', '2016-11-10 14:49:05', '1', '420900', '3');
INSERT INTO `th_area` VALUES ('420922', '大悟县', '2016-11-10 14:49:05', '1', '420900', '3');
INSERT INTO `th_area` VALUES ('420923', '云梦县', '2016-11-10 14:49:05', '1', '420900', '3');
INSERT INTO `th_area` VALUES ('420981', '应城市', '2016-11-10 14:49:05', '1', '420900', '3');
INSERT INTO `th_area` VALUES ('420982', '安陆市', '2016-11-10 14:49:05', '1', '420900', '3');
INSERT INTO `th_area` VALUES ('420984', '汉川市', '2016-11-10 14:49:05', '1', '420900', '3');
INSERT INTO `th_area` VALUES ('420985', '其它区', '2016-11-10 14:49:05', '1', '420900', '3');
INSERT INTO `th_area` VALUES ('421000', '荆州市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('421002', '沙市区', '2016-11-10 14:49:05', '1', '421000', '3');
INSERT INTO `th_area` VALUES ('421003', '荆州区', '2016-11-10 14:49:05', '1', '421000', '3');
INSERT INTO `th_area` VALUES ('421022', '公安县', '2016-11-10 14:49:05', '1', '421000', '3');
INSERT INTO `th_area` VALUES ('421023', '监利县', '2016-11-10 14:49:05', '1', '421000', '3');
INSERT INTO `th_area` VALUES ('421024', '江陵县', '2016-11-10 14:49:05', '1', '421000', '3');
INSERT INTO `th_area` VALUES ('421081', '石首市', '2016-11-10 14:49:05', '1', '421000', '3');
INSERT INTO `th_area` VALUES ('421083', '洪湖市', '2016-11-10 14:49:05', '1', '421000', '3');
INSERT INTO `th_area` VALUES ('421087', '松滋市', '2016-11-10 14:49:05', '1', '421000', '3');
INSERT INTO `th_area` VALUES ('421088', '其它区', '2016-11-10 14:49:05', '1', '421000', '3');
INSERT INTO `th_area` VALUES ('421100', '黄冈市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('421102', '黄州区', '2016-11-10 14:49:05', '1', '421100', '3');
INSERT INTO `th_area` VALUES ('421121', '团风县', '2016-11-10 14:49:05', '1', '421100', '3');
INSERT INTO `th_area` VALUES ('421122', '红安县', '2016-11-10 14:49:05', '1', '421100', '3');
INSERT INTO `th_area` VALUES ('421123', '罗田县', '2016-11-10 14:49:05', '1', '421100', '3');
INSERT INTO `th_area` VALUES ('421124', '英山县', '2016-11-10 14:49:05', '1', '421100', '3');
INSERT INTO `th_area` VALUES ('421125', '浠水县', '2016-11-10 14:49:05', '1', '421100', '3');
INSERT INTO `th_area` VALUES ('421126', '蕲春县', '2016-11-10 14:49:05', '1', '421100', '3');
INSERT INTO `th_area` VALUES ('421127', '黄梅县', '2016-11-10 14:49:05', '1', '421100', '3');
INSERT INTO `th_area` VALUES ('421181', '麻城市', '2016-11-10 14:49:05', '1', '421100', '3');
INSERT INTO `th_area` VALUES ('421182', '武穴市', '2016-11-10 14:49:05', '1', '421100', '3');
INSERT INTO `th_area` VALUES ('421183', '其它区', '2016-11-10 14:49:05', '1', '421100', '3');
INSERT INTO `th_area` VALUES ('421200', '咸宁市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('421202', '咸安区', '2016-11-10 14:49:05', '1', '421200', '3');
INSERT INTO `th_area` VALUES ('421221', '嘉鱼县', '2016-11-10 14:49:05', '1', '421200', '3');
INSERT INTO `th_area` VALUES ('421222', '通城县', '2016-11-10 14:49:05', '1', '421200', '3');
INSERT INTO `th_area` VALUES ('421223', '崇阳县', '2016-11-10 14:49:05', '1', '421200', '3');
INSERT INTO `th_area` VALUES ('421224', '通山县', '2016-11-10 14:49:05', '1', '421200', '3');
INSERT INTO `th_area` VALUES ('421281', '赤壁市', '2016-11-10 14:49:05', '1', '421200', '3');
INSERT INTO `th_area` VALUES ('421282', '温泉城区', '2016-11-10 14:49:05', '1', '421200', '3');
INSERT INTO `th_area` VALUES ('421283', '其它区', '2016-11-10 14:49:05', '1', '421200', '3');
INSERT INTO `th_area` VALUES ('421300', '随州市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('421302', '曾都区', '2016-11-10 14:49:05', '1', '421300', '3');
INSERT INTO `th_area` VALUES ('421321', '随县', '2016-11-10 14:49:05', '1', '421300', '3');
INSERT INTO `th_area` VALUES ('421381', '广水市', '2016-11-10 14:49:05', '1', '421300', '3');
INSERT INTO `th_area` VALUES ('421382', '其它区', '2016-11-10 14:49:05', '1', '421300', '3');
INSERT INTO `th_area` VALUES ('422800', '恩施土家族苗族自治州', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('422801', '恩施市', '2016-11-10 14:49:05', '1', '422800', '3');
INSERT INTO `th_area` VALUES ('422802', '利川市', '2016-11-10 14:49:05', '1', '422800', '3');
INSERT INTO `th_area` VALUES ('422822', '建始县', '2016-11-10 14:49:05', '1', '422800', '3');
INSERT INTO `th_area` VALUES ('422823', '巴东县', '2016-11-10 14:49:05', '1', '422800', '3');
INSERT INTO `th_area` VALUES ('422825', '宣恩县', '2016-11-10 14:49:05', '1', '422800', '3');
INSERT INTO `th_area` VALUES ('422826', '咸丰县', '2016-11-10 14:49:05', '1', '422800', '3');
INSERT INTO `th_area` VALUES ('422827', '来凤县', '2016-11-10 14:49:05', '1', '422800', '3');
INSERT INTO `th_area` VALUES ('422828', '鹤峰县', '2016-11-10 14:49:05', '1', '422800', '3');
INSERT INTO `th_area` VALUES ('422829', '其它区', '2016-11-10 14:49:05', '1', '422800', '3');
INSERT INTO `th_area` VALUES ('429004', '仙桃市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('429005', '潜江市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('429006', '天门市', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('429021', '神农架林区', '2016-11-10 14:49:05', '1', '420000', '2');
INSERT INTO `th_area` VALUES ('430000', '湖南省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('430100', '长沙市', '2016-11-10 14:49:05', '1', '430000', '2');
INSERT INTO `th_area` VALUES ('430102', '芙蓉区', '2016-11-10 14:49:05', '1', '430100', '3');
INSERT INTO `th_area` VALUES ('430103', '天心区', '2016-11-10 14:49:05', '1', '430100', '3');
INSERT INTO `th_area` VALUES ('430104', '岳麓区', '2016-11-10 14:49:05', '1', '430100', '3');
INSERT INTO `th_area` VALUES ('430105', '开福区', '2016-11-10 14:49:05', '1', '430100', '3');
INSERT INTO `th_area` VALUES ('430111', '雨花区', '2016-11-10 14:49:05', '1', '430100', '3');
INSERT INTO `th_area` VALUES ('430121', '长沙县', '2016-11-10 14:49:05', '1', '430100', '3');
INSERT INTO `th_area` VALUES ('430122', '望城县', '2016-11-10 14:49:05', '1', '430100', '3');
INSERT INTO `th_area` VALUES ('430124', '宁乡县', '2016-11-10 14:49:05', '1', '430100', '3');
INSERT INTO `th_area` VALUES ('430181', '浏阳市', '2016-11-10 14:49:05', '1', '430100', '3');
INSERT INTO `th_area` VALUES ('430182', '其它区', '2016-11-10 14:49:05', '1', '430100', '3');
INSERT INTO `th_area` VALUES ('430200', '株洲市', '2016-11-10 14:49:05', '1', '430000', '2');
INSERT INTO `th_area` VALUES ('430202', '荷塘区', '2016-11-10 14:49:05', '1', '430200', '3');
INSERT INTO `th_area` VALUES ('430203', '芦淞区', '2016-11-10 14:49:05', '1', '430200', '3');
INSERT INTO `th_area` VALUES ('430204', '石峰区', '2016-11-10 14:49:05', '1', '430200', '3');
INSERT INTO `th_area` VALUES ('430211', '天元区', '2016-11-10 14:49:05', '1', '430200', '3');
INSERT INTO `th_area` VALUES ('430221', '株洲县', '2016-11-10 14:49:05', '1', '430200', '3');
INSERT INTO `th_area` VALUES ('430223', '攸县', '2016-11-10 14:49:05', '1', '430200', '3');
INSERT INTO `th_area` VALUES ('430224', '茶陵县', '2016-11-10 14:49:05', '1', '430200', '3');
INSERT INTO `th_area` VALUES ('430225', '炎陵县', '2016-11-10 14:49:05', '1', '430200', '3');
INSERT INTO `th_area` VALUES ('430281', '醴陵市', '2016-11-10 14:49:05', '1', '430200', '3');
INSERT INTO `th_area` VALUES ('430282', '其它区', '2016-11-10 14:49:05', '1', '430200', '3');
INSERT INTO `th_area` VALUES ('430300', '湘潭市', '2016-11-10 14:49:05', '1', '430000', '2');
INSERT INTO `th_area` VALUES ('430302', '雨湖区', '2016-11-10 14:49:05', '1', '430300', '3');
INSERT INTO `th_area` VALUES ('430304', '岳塘区', '2016-11-10 14:49:05', '1', '430300', '3');
INSERT INTO `th_area` VALUES ('430321', '湘潭县', '2016-11-10 14:49:05', '1', '430300', '3');
INSERT INTO `th_area` VALUES ('430381', '湘乡市', '2016-11-10 14:49:05', '1', '430300', '3');
INSERT INTO `th_area` VALUES ('430382', '韶山市', '2016-11-10 14:49:05', '1', '430300', '3');
INSERT INTO `th_area` VALUES ('430383', '其它区', '2016-11-10 14:49:05', '1', '430300', '3');
INSERT INTO `th_area` VALUES ('430400', '衡阳市', '2016-11-10 14:49:05', '1', '430000', '2');
INSERT INTO `th_area` VALUES ('430405', '珠晖区', '2016-11-10 14:49:05', '1', '430400', '3');
INSERT INTO `th_area` VALUES ('430406', '雁峰区', '2016-11-10 14:49:05', '1', '430400', '3');
INSERT INTO `th_area` VALUES ('430407', '石鼓区', '2016-11-10 14:49:05', '1', '430400', '3');
INSERT INTO `th_area` VALUES ('430408', '蒸湘区', '2016-11-10 14:49:05', '1', '430400', '3');
INSERT INTO `th_area` VALUES ('430412', '南岳区', '2016-11-10 14:49:05', '1', '430400', '3');
INSERT INTO `th_area` VALUES ('430421', '衡阳县', '2016-11-10 14:49:05', '1', '430400', '3');
INSERT INTO `th_area` VALUES ('430422', '衡南县', '2016-11-10 14:49:05', '1', '430400', '3');
INSERT INTO `th_area` VALUES ('430423', '衡山县', '2016-11-10 14:49:05', '1', '430400', '3');
INSERT INTO `th_area` VALUES ('430424', '衡东县', '2016-11-10 14:49:05', '1', '430400', '3');
INSERT INTO `th_area` VALUES ('430426', '祁东县', '2016-11-10 14:49:05', '1', '430400', '3');
INSERT INTO `th_area` VALUES ('430481', '耒阳市', '2016-11-10 14:49:05', '1', '430400', '3');
INSERT INTO `th_area` VALUES ('430482', '常宁市', '2016-11-10 14:49:05', '1', '430400', '3');
INSERT INTO `th_area` VALUES ('430483', '其它区', '2016-11-10 14:49:05', '1', '430400', '3');
INSERT INTO `th_area` VALUES ('430500', '邵阳市', '2016-11-10 14:49:05', '1', '430000', '2');
INSERT INTO `th_area` VALUES ('430502', '双清区', '2016-11-10 14:49:05', '1', '430500', '3');
INSERT INTO `th_area` VALUES ('430503', '大祥区', '2016-11-10 14:49:05', '1', '430500', '3');
INSERT INTO `th_area` VALUES ('430511', '北塔区', '2016-11-10 14:49:05', '1', '430500', '3');
INSERT INTO `th_area` VALUES ('430521', '邵东县', '2016-11-10 14:49:05', '1', '430500', '3');
INSERT INTO `th_area` VALUES ('430522', '新邵县', '2016-11-10 14:49:05', '1', '430500', '3');
INSERT INTO `th_area` VALUES ('430523', '邵阳县', '2016-11-10 14:49:05', '1', '430500', '3');
INSERT INTO `th_area` VALUES ('430524', '隆回县', '2016-11-10 14:49:05', '1', '430500', '3');
INSERT INTO `th_area` VALUES ('430525', '洞口县', '2016-11-10 14:49:05', '1', '430500', '3');
INSERT INTO `th_area` VALUES ('430527', '绥宁县', '2016-11-10 14:49:05', '1', '430500', '3');
INSERT INTO `th_area` VALUES ('430528', '新宁县', '2016-11-10 14:49:05', '1', '430500', '3');
INSERT INTO `th_area` VALUES ('430529', '城步苗族自治县', '2016-11-10 14:49:05', '1', '430500', '3');
INSERT INTO `th_area` VALUES ('430581', '武冈市', '2016-11-10 14:49:05', '1', '430500', '3');
INSERT INTO `th_area` VALUES ('430582', '其它区', '2016-11-10 14:49:05', '1', '430500', '3');
INSERT INTO `th_area` VALUES ('430600', '岳阳市', '2016-11-10 14:49:05', '1', '430000', '2');
INSERT INTO `th_area` VALUES ('430602', '岳阳楼区', '2016-11-10 14:49:05', '1', '430600', '3');
INSERT INTO `th_area` VALUES ('430603', '云溪区', '2016-11-10 14:49:05', '1', '430600', '3');
INSERT INTO `th_area` VALUES ('430611', '君山区', '2016-11-10 14:49:05', '1', '430600', '3');
INSERT INTO `th_area` VALUES ('430621', '岳阳县', '2016-11-10 14:49:05', '1', '430600', '3');
INSERT INTO `th_area` VALUES ('430623', '华容县', '2016-11-10 14:49:05', '1', '430600', '3');
INSERT INTO `th_area` VALUES ('430624', '湘阴县', '2016-11-10 14:49:05', '1', '430600', '3');
INSERT INTO `th_area` VALUES ('430626', '平江县', '2016-11-10 14:49:05', '1', '430600', '3');
INSERT INTO `th_area` VALUES ('430681', '汨罗市', '2016-11-10 14:49:05', '1', '430600', '3');
INSERT INTO `th_area` VALUES ('430682', '临湘市', '2016-11-10 14:49:05', '1', '430600', '3');
INSERT INTO `th_area` VALUES ('430683', '其它区', '2016-11-10 14:49:05', '1', '430600', '3');
INSERT INTO `th_area` VALUES ('430700', '常德市', '2016-11-10 14:49:05', '1', '430000', '2');
INSERT INTO `th_area` VALUES ('430702', '武陵区', '2016-11-10 14:49:05', '1', '430700', '3');
INSERT INTO `th_area` VALUES ('430703', '鼎城区', '2016-11-10 14:49:05', '1', '430700', '3');
INSERT INTO `th_area` VALUES ('430721', '安乡县', '2016-11-10 14:49:05', '1', '430700', '3');
INSERT INTO `th_area` VALUES ('430722', '汉寿县', '2016-11-10 14:49:05', '1', '430700', '3');
INSERT INTO `th_area` VALUES ('430723', '澧县', '2016-11-10 14:49:05', '1', '430700', '3');
INSERT INTO `th_area` VALUES ('430724', '临澧县', '2016-11-10 14:49:05', '1', '430700', '3');
INSERT INTO `th_area` VALUES ('430725', '桃源县', '2016-11-10 14:49:05', '1', '430700', '3');
INSERT INTO `th_area` VALUES ('430726', '石门县', '2016-11-10 14:49:05', '1', '430700', '3');
INSERT INTO `th_area` VALUES ('430781', '津市市', '2016-11-10 14:49:05', '1', '430700', '3');
INSERT INTO `th_area` VALUES ('430782', '其它区', '2016-11-10 14:49:05', '1', '430700', '3');
INSERT INTO `th_area` VALUES ('430800', '张家界市', '2016-11-10 14:49:05', '1', '430000', '2');
INSERT INTO `th_area` VALUES ('430802', '永定区', '2016-11-10 14:49:05', '1', '430800', '3');
INSERT INTO `th_area` VALUES ('430811', '武陵源区', '2016-11-10 14:49:05', '1', '430800', '3');
INSERT INTO `th_area` VALUES ('430821', '慈利县', '2016-11-10 14:49:05', '1', '430800', '3');
INSERT INTO `th_area` VALUES ('430822', '桑植县', '2016-11-10 14:49:05', '1', '430800', '3');
INSERT INTO `th_area` VALUES ('430823', '其它区', '2016-11-10 14:49:05', '1', '430800', '3');
INSERT INTO `th_area` VALUES ('430900', '益阳市', '2016-11-10 14:49:05', '1', '430000', '2');
INSERT INTO `th_area` VALUES ('430902', '资阳区', '2016-11-10 14:49:05', '1', '430900', '3');
INSERT INTO `th_area` VALUES ('430903', '赫山区', '2016-11-10 14:49:05', '1', '430900', '3');
INSERT INTO `th_area` VALUES ('430921', '南县', '2016-11-10 14:49:05', '1', '430900', '3');
INSERT INTO `th_area` VALUES ('430922', '桃江县', '2016-11-10 14:49:05', '1', '430900', '3');
INSERT INTO `th_area` VALUES ('430923', '安化县', '2016-11-10 14:49:05', '1', '430900', '3');
INSERT INTO `th_area` VALUES ('430981', '沅江市', '2016-11-10 14:49:05', '1', '430900', '3');
INSERT INTO `th_area` VALUES ('430982', '其它区', '2016-11-10 14:49:05', '1', '430900', '3');
INSERT INTO `th_area` VALUES ('431000', '郴州市', '2016-11-10 14:49:05', '1', '430000', '2');
INSERT INTO `th_area` VALUES ('431002', '北湖区', '2016-11-10 14:49:05', '1', '431000', '3');
INSERT INTO `th_area` VALUES ('431003', '苏仙区', '2016-11-10 14:49:05', '1', '431000', '3');
INSERT INTO `th_area` VALUES ('431021', '桂阳县', '2016-11-10 14:49:05', '1', '431000', '3');
INSERT INTO `th_area` VALUES ('431022', '宜章县', '2016-11-10 14:49:05', '1', '431000', '3');
INSERT INTO `th_area` VALUES ('431023', '永兴县', '2016-11-10 14:49:05', '1', '431000', '3');
INSERT INTO `th_area` VALUES ('431024', '嘉禾县', '2016-11-10 14:49:05', '1', '431000', '3');
INSERT INTO `th_area` VALUES ('431025', '临武县', '2016-11-10 14:49:05', '1', '431000', '3');
INSERT INTO `th_area` VALUES ('431026', '汝城县', '2016-11-10 14:49:05', '1', '431000', '3');
INSERT INTO `th_area` VALUES ('431027', '桂东县', '2016-11-10 14:49:05', '1', '431000', '3');
INSERT INTO `th_area` VALUES ('431028', '安仁县', '2016-11-10 14:49:05', '1', '431000', '3');
INSERT INTO `th_area` VALUES ('431081', '资兴市', '2016-11-10 14:49:05', '1', '431000', '3');
INSERT INTO `th_area` VALUES ('431082', '其它区', '2016-11-10 14:49:05', '1', '431000', '3');
INSERT INTO `th_area` VALUES ('431100', '永州市', '2016-11-10 14:49:05', '1', '430000', '2');
INSERT INTO `th_area` VALUES ('431102', '零陵区', '2016-11-10 14:49:05', '1', '431100', '3');
INSERT INTO `th_area` VALUES ('431103', '冷水滩区', '2016-11-10 14:49:05', '1', '431100', '3');
INSERT INTO `th_area` VALUES ('431121', '祁阳县', '2016-11-10 14:49:05', '1', '431100', '3');
INSERT INTO `th_area` VALUES ('431122', '东安县', '2016-11-10 14:49:05', '1', '431100', '3');
INSERT INTO `th_area` VALUES ('431123', '双牌县', '2016-11-10 14:49:05', '1', '431100', '3');
INSERT INTO `th_area` VALUES ('431124', '道县', '2016-11-10 14:49:05', '1', '431100', '3');
INSERT INTO `th_area` VALUES ('431125', '江永县', '2016-11-10 14:49:05', '1', '431100', '3');
INSERT INTO `th_area` VALUES ('431126', '宁远县', '2016-11-10 14:49:05', '1', '431100', '3');
INSERT INTO `th_area` VALUES ('431127', '蓝山县', '2016-11-10 14:49:05', '1', '431100', '3');
INSERT INTO `th_area` VALUES ('431128', '新田县', '2016-11-10 14:49:05', '1', '431100', '3');
INSERT INTO `th_area` VALUES ('431129', '江华瑶族自治县', '2016-11-10 14:49:05', '1', '431100', '3');
INSERT INTO `th_area` VALUES ('431130', '其它区', '2016-11-10 14:49:05', '1', '431100', '3');
INSERT INTO `th_area` VALUES ('431200', '怀化市', '2016-11-10 14:49:05', '1', '430000', '2');
INSERT INTO `th_area` VALUES ('431202', '鹤城区', '2016-11-10 14:49:05', '1', '431200', '3');
INSERT INTO `th_area` VALUES ('431221', '中方县', '2016-11-10 14:49:05', '1', '431200', '3');
INSERT INTO `th_area` VALUES ('431222', '沅陵县', '2016-11-10 14:49:05', '1', '431200', '3');
INSERT INTO `th_area` VALUES ('431223', '辰溪县', '2016-11-10 14:49:05', '1', '431200', '3');
INSERT INTO `th_area` VALUES ('431224', '溆浦县', '2016-11-10 14:49:05', '1', '431200', '3');
INSERT INTO `th_area` VALUES ('431225', '会同县', '2016-11-10 14:49:05', '1', '431200', '3');
INSERT INTO `th_area` VALUES ('431226', '麻阳苗族自治县', '2016-11-10 14:49:05', '1', '431200', '3');
INSERT INTO `th_area` VALUES ('431227', '新晃侗族自治县', '2016-11-10 14:49:05', '1', '431200', '3');
INSERT INTO `th_area` VALUES ('431228', '芷江侗族自治县', '2016-11-10 14:49:05', '1', '431200', '3');
INSERT INTO `th_area` VALUES ('431229', '靖州苗族侗族自治县', '2016-11-10 14:49:05', '1', '431200', '3');
INSERT INTO `th_area` VALUES ('431230', '通道侗族自治县', '2016-11-10 14:49:05', '1', '431200', '3');
INSERT INTO `th_area` VALUES ('431281', '洪江市', '2016-11-10 14:49:05', '1', '431200', '3');
INSERT INTO `th_area` VALUES ('431282', '其它区', '2016-11-10 14:49:05', '1', '431200', '3');
INSERT INTO `th_area` VALUES ('431300', '娄底市', '2016-11-10 14:49:05', '1', '430000', '2');
INSERT INTO `th_area` VALUES ('431302', '娄星区', '2016-11-10 14:49:05', '1', '431300', '3');
INSERT INTO `th_area` VALUES ('431321', '双峰县', '2016-11-10 14:49:05', '1', '431300', '3');
INSERT INTO `th_area` VALUES ('431322', '新化县', '2016-11-10 14:49:05', '1', '431300', '3');
INSERT INTO `th_area` VALUES ('431381', '冷水江市', '2016-11-10 14:49:05', '1', '431300', '3');
INSERT INTO `th_area` VALUES ('431382', '涟源市', '2016-11-10 14:49:05', '1', '431300', '3');
INSERT INTO `th_area` VALUES ('431383', '其它区', '2016-11-10 14:49:05', '1', '431300', '3');
INSERT INTO `th_area` VALUES ('433100', '湘西土家族苗族自治州', '2016-11-10 14:49:05', '1', '430000', '2');
INSERT INTO `th_area` VALUES ('433101', '吉首市', '2016-11-10 14:49:05', '1', '433100', '3');
INSERT INTO `th_area` VALUES ('433122', '泸溪县', '2016-11-10 14:49:05', '1', '433100', '3');
INSERT INTO `th_area` VALUES ('433123', '凤凰县', '2016-11-10 14:49:05', '1', '433100', '3');
INSERT INTO `th_area` VALUES ('433124', '花垣县', '2016-11-10 14:49:05', '1', '433100', '3');
INSERT INTO `th_area` VALUES ('433125', '保靖县', '2016-11-10 14:49:05', '1', '433100', '3');
INSERT INTO `th_area` VALUES ('433126', '古丈县', '2016-11-10 14:49:05', '1', '433100', '3');
INSERT INTO `th_area` VALUES ('433127', '永顺县', '2016-11-10 14:49:05', '1', '433100', '3');
INSERT INTO `th_area` VALUES ('433130', '龙山县', '2016-11-10 14:49:05', '1', '433100', '3');
INSERT INTO `th_area` VALUES ('433131', '其它区', '2016-11-10 14:49:05', '1', '433100', '3');
INSERT INTO `th_area` VALUES ('440000', '广东省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('440100', '广州市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('440103', '荔湾区', '2016-11-10 14:49:05', '1', '440100', '3');
INSERT INTO `th_area` VALUES ('440104', '越秀区', '2016-11-10 14:49:05', '1', '440100', '3');
INSERT INTO `th_area` VALUES ('440105', '海珠区', '2016-11-10 14:49:05', '1', '440100', '3');
INSERT INTO `th_area` VALUES ('440106', '天河区', '2016-11-10 14:49:05', '1', '440100', '3');
INSERT INTO `th_area` VALUES ('440111', '白云区', '2016-11-10 14:49:05', '1', '440100', '3');
INSERT INTO `th_area` VALUES ('440112', '黄埔区', '2016-11-10 14:49:05', '1', '440100', '3');
INSERT INTO `th_area` VALUES ('440113', '番禺区', '2016-11-10 14:49:05', '1', '440100', '3');
INSERT INTO `th_area` VALUES ('440114', '花都区', '2016-11-10 14:49:05', '1', '440100', '3');
INSERT INTO `th_area` VALUES ('440115', '南沙区', '2016-11-10 14:49:05', '1', '440100', '3');
INSERT INTO `th_area` VALUES ('440116', '萝岗区', '2016-11-10 14:49:05', '1', '440100', '3');
INSERT INTO `th_area` VALUES ('440183', '增城市', '2016-11-10 14:49:05', '1', '440100', '3');
INSERT INTO `th_area` VALUES ('440184', '从化市', '2016-11-10 14:49:05', '1', '440100', '3');
INSERT INTO `th_area` VALUES ('440188', '东山区', '2016-11-10 14:49:05', '1', '440100', '3');
INSERT INTO `th_area` VALUES ('440189', '其它区', '2016-11-10 14:49:05', '1', '440100', '3');
INSERT INTO `th_area` VALUES ('440200', '韶关市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('440203', '武江区', '2016-11-10 14:49:05', '1', '440200', '3');
INSERT INTO `th_area` VALUES ('440204', '浈江区', '2016-11-10 14:49:05', '1', '440200', '3');
INSERT INTO `th_area` VALUES ('440205', '曲江区', '2016-11-10 14:49:05', '1', '440200', '3');
INSERT INTO `th_area` VALUES ('440222', '始兴县', '2016-11-10 14:49:05', '1', '440200', '3');
INSERT INTO `th_area` VALUES ('440224', '仁化县', '2016-11-10 14:49:05', '1', '440200', '3');
INSERT INTO `th_area` VALUES ('440229', '翁源县', '2016-11-10 14:49:05', '1', '440200', '3');
INSERT INTO `th_area` VALUES ('440232', '乳源瑶族自治县', '2016-11-10 14:49:05', '1', '440200', '3');
INSERT INTO `th_area` VALUES ('440233', '新丰县', '2016-11-10 14:49:05', '1', '440200', '3');
INSERT INTO `th_area` VALUES ('440281', '乐昌市', '2016-11-10 14:49:05', '1', '440200', '3');
INSERT INTO `th_area` VALUES ('440282', '南雄市', '2016-11-10 14:49:05', '1', '440200', '3');
INSERT INTO `th_area` VALUES ('440283', '其它区', '2016-11-10 14:49:05', '1', '440200', '3');
INSERT INTO `th_area` VALUES ('440300', '深圳市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('440303', '罗湖区', '2016-11-10 14:49:05', '1', '440300', '3');
INSERT INTO `th_area` VALUES ('440304', '福田区', '2016-11-10 14:49:05', '1', '440300', '3');
INSERT INTO `th_area` VALUES ('440305', '南山区', '2016-11-10 14:49:05', '1', '440300', '3');
INSERT INTO `th_area` VALUES ('440306', '宝安区', '2016-11-10 14:49:05', '1', '440300', '3');
INSERT INTO `th_area` VALUES ('440307', '龙岗区', '2016-11-10 14:49:05', '1', '440300', '3');
INSERT INTO `th_area` VALUES ('440308', '盐田区', '2016-11-10 14:49:05', '1', '440300', '3');
INSERT INTO `th_area` VALUES ('440309', '其它区', '2016-11-10 14:49:05', '1', '440300', '3');
INSERT INTO `th_area` VALUES ('440400', '珠海市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('440402', '香洲区', '2016-11-10 14:49:05', '1', '440400', '3');
INSERT INTO `th_area` VALUES ('440403', '斗门区', '2016-11-10 14:49:05', '1', '440400', '3');
INSERT INTO `th_area` VALUES ('440404', '金湾区', '2016-11-10 14:49:05', '1', '440400', '3');
INSERT INTO `th_area` VALUES ('440486', '金唐区', '2016-11-10 14:49:05', '1', '440400', '3');
INSERT INTO `th_area` VALUES ('440487', '南湾区', '2016-11-10 14:49:05', '1', '440400', '3');
INSERT INTO `th_area` VALUES ('440488', '其它区', '2016-11-10 14:49:05', '1', '440400', '3');
INSERT INTO `th_area` VALUES ('440500', '汕头市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('440507', '龙湖区', '2016-11-10 14:49:05', '1', '440500', '3');
INSERT INTO `th_area` VALUES ('440511', '金平区', '2016-11-10 14:49:05', '1', '440500', '3');
INSERT INTO `th_area` VALUES ('440512', '濠江区', '2016-11-10 14:49:05', '1', '440500', '3');
INSERT INTO `th_area` VALUES ('440513', '潮阳区', '2016-11-10 14:49:05', '1', '440500', '3');
INSERT INTO `th_area` VALUES ('440514', '潮南区', '2016-11-10 14:49:05', '1', '440500', '3');
INSERT INTO `th_area` VALUES ('440515', '澄海区', '2016-11-10 14:49:05', '1', '440500', '3');
INSERT INTO `th_area` VALUES ('440523', '南澳县', '2016-11-10 14:49:05', '1', '440500', '3');
INSERT INTO `th_area` VALUES ('440524', '其它区', '2016-11-10 14:49:05', '1', '440500', '3');
INSERT INTO `th_area` VALUES ('440600', '佛山市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('440604', '禅城区', '2016-11-10 14:49:05', '1', '440600', '3');
INSERT INTO `th_area` VALUES ('440605', '南海区', '2016-11-10 14:49:05', '1', '440600', '3');
INSERT INTO `th_area` VALUES ('440606', '顺德区', '2016-11-10 14:49:05', '1', '440600', '3');
INSERT INTO `th_area` VALUES ('440607', '三水区', '2016-11-10 14:49:05', '1', '440600', '3');
INSERT INTO `th_area` VALUES ('440608', '高明区', '2016-11-10 14:49:05', '1', '440600', '3');
INSERT INTO `th_area` VALUES ('440609', '其它区', '2016-11-10 14:49:05', '1', '440600', '3');
INSERT INTO `th_area` VALUES ('440700', '江门市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('440703', '蓬江区', '2016-11-10 14:49:05', '1', '440700', '3');
INSERT INTO `th_area` VALUES ('440704', '江海区', '2016-11-10 14:49:05', '1', '440700', '3');
INSERT INTO `th_area` VALUES ('440705', '新会区', '2016-11-10 14:49:05', '1', '440700', '3');
INSERT INTO `th_area` VALUES ('440781', '台山市', '2016-11-10 14:49:05', '1', '440700', '3');
INSERT INTO `th_area` VALUES ('440783', '开平市', '2016-11-10 14:49:05', '1', '440700', '3');
INSERT INTO `th_area` VALUES ('440784', '鹤山市', '2016-11-10 14:49:05', '1', '440700', '3');
INSERT INTO `th_area` VALUES ('440785', '恩平市', '2016-11-10 14:49:05', '1', '440700', '3');
INSERT INTO `th_area` VALUES ('440786', '其它区', '2016-11-10 14:49:05', '1', '440700', '3');
INSERT INTO `th_area` VALUES ('440800', '湛江市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('440802', '赤坎区', '2016-11-10 14:49:05', '1', '440800', '3');
INSERT INTO `th_area` VALUES ('440803', '霞山区', '2016-11-10 14:49:05', '1', '440800', '3');
INSERT INTO `th_area` VALUES ('440804', '坡头区', '2016-11-10 14:49:05', '1', '440800', '3');
INSERT INTO `th_area` VALUES ('440811', '麻章区', '2016-11-10 14:49:05', '1', '440800', '3');
INSERT INTO `th_area` VALUES ('440823', '遂溪县', '2016-11-10 14:49:05', '1', '440800', '3');
INSERT INTO `th_area` VALUES ('440825', '徐闻县', '2016-11-10 14:49:05', '1', '440800', '3');
INSERT INTO `th_area` VALUES ('440881', '廉江市', '2016-11-10 14:49:05', '1', '440800', '3');
INSERT INTO `th_area` VALUES ('440882', '雷州市', '2016-11-10 14:49:05', '1', '440800', '3');
INSERT INTO `th_area` VALUES ('440883', '吴川市', '2016-11-10 14:49:05', '1', '440800', '3');
INSERT INTO `th_area` VALUES ('440884', '其它区', '2016-11-10 14:49:05', '1', '440800', '3');
INSERT INTO `th_area` VALUES ('440900', '茂名市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('440902', '茂南区', '2016-11-10 14:49:05', '1', '440900', '3');
INSERT INTO `th_area` VALUES ('440903', '茂港区', '2016-11-10 14:49:05', '1', '440900', '3');
INSERT INTO `th_area` VALUES ('440923', '电白县', '2016-11-10 14:49:05', '1', '440900', '3');
INSERT INTO `th_area` VALUES ('440981', '高州市', '2016-11-10 14:49:05', '1', '440900', '3');
INSERT INTO `th_area` VALUES ('440982', '化州市', '2016-11-10 14:49:05', '1', '440900', '3');
INSERT INTO `th_area` VALUES ('440983', '信宜市', '2016-11-10 14:49:05', '1', '440900', '3');
INSERT INTO `th_area` VALUES ('440984', '其它区', '2016-11-10 14:49:05', '1', '440900', '3');
INSERT INTO `th_area` VALUES ('441200', '肇庆市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('441202', '端州区', '2016-11-10 14:49:05', '1', '441200', '3');
INSERT INTO `th_area` VALUES ('441203', '鼎湖区', '2016-11-10 14:49:05', '1', '441200', '3');
INSERT INTO `th_area` VALUES ('441223', '广宁县', '2016-11-10 14:49:05', '1', '441200', '3');
INSERT INTO `th_area` VALUES ('441224', '怀集县', '2016-11-10 14:49:05', '1', '441200', '3');
INSERT INTO `th_area` VALUES ('441225', '封开县', '2016-11-10 14:49:05', '1', '441200', '3');
INSERT INTO `th_area` VALUES ('441226', '德庆县', '2016-11-10 14:49:05', '1', '441200', '3');
INSERT INTO `th_area` VALUES ('441283', '高要市', '2016-11-10 14:49:05', '1', '441200', '3');
INSERT INTO `th_area` VALUES ('441284', '四会市', '2016-11-10 14:49:05', '1', '441200', '3');
INSERT INTO `th_area` VALUES ('441285', '其它区', '2016-11-10 14:49:05', '1', '441200', '3');
INSERT INTO `th_area` VALUES ('441300', '惠州市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('441302', '惠城区', '2016-11-10 14:49:05', '1', '441300', '3');
INSERT INTO `th_area` VALUES ('441303', '惠阳区', '2016-11-10 14:49:05', '1', '441300', '3');
INSERT INTO `th_area` VALUES ('441322', '博罗县', '2016-11-10 14:49:05', '1', '441300', '3');
INSERT INTO `th_area` VALUES ('441323', '惠东县', '2016-11-10 14:49:05', '1', '441300', '3');
INSERT INTO `th_area` VALUES ('441324', '龙门县', '2016-11-10 14:49:05', '1', '441300', '3');
INSERT INTO `th_area` VALUES ('441325', '其它区', '2016-11-10 14:49:05', '1', '441300', '3');
INSERT INTO `th_area` VALUES ('441400', '梅州市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('441402', '梅江区', '2016-11-10 14:49:05', '1', '441400', '3');
INSERT INTO `th_area` VALUES ('441421', '梅县', '2016-11-10 14:49:05', '1', '441400', '3');
INSERT INTO `th_area` VALUES ('441422', '大埔县', '2016-11-10 14:49:05', '1', '441400', '3');
INSERT INTO `th_area` VALUES ('441423', '丰顺县', '2016-11-10 14:49:05', '1', '441400', '3');
INSERT INTO `th_area` VALUES ('441424', '五华县', '2016-11-10 14:49:05', '1', '441400', '3');
INSERT INTO `th_area` VALUES ('441426', '平远县', '2016-11-10 14:49:05', '1', '441400', '3');
INSERT INTO `th_area` VALUES ('441427', '蕉岭县', '2016-11-10 14:49:05', '1', '441400', '3');
INSERT INTO `th_area` VALUES ('441481', '兴宁市', '2016-11-10 14:49:05', '1', '441400', '3');
INSERT INTO `th_area` VALUES ('441482', '其它区', '2016-11-10 14:49:05', '1', '441400', '3');
INSERT INTO `th_area` VALUES ('441500', '汕尾市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('441502', '城区', '2016-11-10 14:49:05', '1', '441500', '3');
INSERT INTO `th_area` VALUES ('441521', '海丰县', '2016-11-10 14:49:05', '1', '441500', '3');
INSERT INTO `th_area` VALUES ('441523', '陆河县', '2016-11-10 14:49:05', '1', '441500', '3');
INSERT INTO `th_area` VALUES ('441581', '陆丰市', '2016-11-10 14:49:05', '1', '441500', '3');
INSERT INTO `th_area` VALUES ('441582', '其它区', '2016-11-10 14:49:05', '1', '441500', '3');
INSERT INTO `th_area` VALUES ('441600', '河源市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('441602', '源城区', '2016-11-10 14:49:05', '1', '441600', '3');
INSERT INTO `th_area` VALUES ('441621', '紫金县', '2016-11-10 14:49:05', '1', '441600', '3');
INSERT INTO `th_area` VALUES ('441622', '龙川县', '2016-11-10 14:49:05', '1', '441600', '3');
INSERT INTO `th_area` VALUES ('441623', '连平县', '2016-11-10 14:49:05', '1', '441600', '3');
INSERT INTO `th_area` VALUES ('441624', '和平县', '2016-11-10 14:49:05', '1', '441600', '3');
INSERT INTO `th_area` VALUES ('441625', '东源县', '2016-11-10 14:49:05', '1', '441600', '3');
INSERT INTO `th_area` VALUES ('441626', '其它区', '2016-11-10 14:49:05', '1', '441600', '3');
INSERT INTO `th_area` VALUES ('441700', '阳江市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('441702', '江城区', '2016-11-10 14:49:05', '1', '441700', '3');
INSERT INTO `th_area` VALUES ('441721', '阳西县', '2016-11-10 14:49:05', '1', '441700', '3');
INSERT INTO `th_area` VALUES ('441723', '阳东县', '2016-11-10 14:49:05', '1', '441700', '3');
INSERT INTO `th_area` VALUES ('441781', '阳春市', '2016-11-10 14:49:05', '1', '441700', '3');
INSERT INTO `th_area` VALUES ('441782', '其它区', '2016-11-10 14:49:05', '1', '441700', '3');
INSERT INTO `th_area` VALUES ('441800', '清远市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('441802', '清城区', '2016-11-10 14:49:05', '1', '441800', '3');
INSERT INTO `th_area` VALUES ('441821', '佛冈县', '2016-11-10 14:49:05', '1', '441800', '3');
INSERT INTO `th_area` VALUES ('441823', '阳山县', '2016-11-10 14:49:05', '1', '441800', '3');
INSERT INTO `th_area` VALUES ('441825', '连山壮族瑶族自治县', '2016-11-10 14:49:05', '1', '441800', '3');
INSERT INTO `th_area` VALUES ('441826', '连南瑶族自治县', '2016-11-10 14:49:05', '1', '441800', '3');
INSERT INTO `th_area` VALUES ('441827', '清新县', '2016-11-10 14:49:05', '1', '441800', '3');
INSERT INTO `th_area` VALUES ('441881', '英德市', '2016-11-10 14:49:05', '1', '441800', '3');
INSERT INTO `th_area` VALUES ('441882', '连州市', '2016-11-10 14:49:05', '1', '441800', '3');
INSERT INTO `th_area` VALUES ('441883', '其它区', '2016-11-10 14:49:05', '1', '441800', '3');
INSERT INTO `th_area` VALUES ('441900', '东莞市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('442000', '中山市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('445100', '潮州市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('445102', '湘桥区', '2016-11-10 14:49:05', '1', '445100', '3');
INSERT INTO `th_area` VALUES ('445121', '潮安县', '2016-11-10 14:49:05', '1', '445100', '3');
INSERT INTO `th_area` VALUES ('445122', '饶平县', '2016-11-10 14:49:05', '1', '445100', '3');
INSERT INTO `th_area` VALUES ('445185', '枫溪区', '2016-11-10 14:49:05', '1', '445100', '3');
INSERT INTO `th_area` VALUES ('445186', '其它区', '2016-11-10 14:49:05', '1', '445100', '3');
INSERT INTO `th_area` VALUES ('445200', '揭阳市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('445202', '榕城区', '2016-11-10 14:49:05', '1', '445200', '3');
INSERT INTO `th_area` VALUES ('445221', '揭东县', '2016-11-10 14:49:05', '1', '445200', '3');
INSERT INTO `th_area` VALUES ('445222', '揭西县', '2016-11-10 14:49:05', '1', '445200', '3');
INSERT INTO `th_area` VALUES ('445224', '惠来县', '2016-11-10 14:49:05', '1', '445200', '3');
INSERT INTO `th_area` VALUES ('445281', '普宁市', '2016-11-10 14:49:05', '1', '445200', '3');
INSERT INTO `th_area` VALUES ('445284', '东山区', '2016-11-10 14:49:05', '1', '445200', '3');
INSERT INTO `th_area` VALUES ('445285', '其它区', '2016-11-10 14:49:05', '1', '445200', '3');
INSERT INTO `th_area` VALUES ('445300', '云浮市', '2016-11-10 14:49:05', '1', '440000', '2');
INSERT INTO `th_area` VALUES ('445302', '云城区', '2016-11-10 14:49:05', '1', '445300', '3');
INSERT INTO `th_area` VALUES ('445321', '新兴县', '2016-11-10 14:49:05', '1', '445300', '3');
INSERT INTO `th_area` VALUES ('445322', '郁南县', '2016-11-10 14:49:05', '1', '445300', '3');
INSERT INTO `th_area` VALUES ('445323', '云安县', '2016-11-10 14:49:05', '1', '445300', '3');
INSERT INTO `th_area` VALUES ('445381', '罗定市', '2016-11-10 14:49:05', '1', '445300', '3');
INSERT INTO `th_area` VALUES ('445382', '其它区', '2016-11-10 14:49:05', '1', '445300', '3');
INSERT INTO `th_area` VALUES ('450000', '广西壮族', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('450100', '南宁市', '2016-11-10 14:49:05', '1', '450000', '2');
INSERT INTO `th_area` VALUES ('450102', '兴宁区', '2016-11-10 14:49:05', '1', '450100', '3');
INSERT INTO `th_area` VALUES ('450103', '青秀区', '2016-11-10 14:49:05', '1', '450100', '3');
INSERT INTO `th_area` VALUES ('450105', '江南区', '2016-11-10 14:49:05', '1', '450100', '3');
INSERT INTO `th_area` VALUES ('450107', '西乡塘区', '2016-11-10 14:49:05', '1', '450100', '3');
INSERT INTO `th_area` VALUES ('450108', '良庆区', '2016-11-10 14:49:05', '1', '450100', '3');
INSERT INTO `th_area` VALUES ('450109', '邕宁区', '2016-11-10 14:49:05', '1', '450100', '3');
INSERT INTO `th_area` VALUES ('450122', '武鸣县', '2016-11-10 14:49:05', '1', '450100', '3');
INSERT INTO `th_area` VALUES ('450123', '隆安县', '2016-11-10 14:49:05', '1', '450100', '3');
INSERT INTO `th_area` VALUES ('450124', '马山县', '2016-11-10 14:49:05', '1', '450100', '3');
INSERT INTO `th_area` VALUES ('450125', '上林县', '2016-11-10 14:49:05', '1', '450100', '3');
INSERT INTO `th_area` VALUES ('450126', '宾阳县', '2016-11-10 14:49:05', '1', '450100', '3');
INSERT INTO `th_area` VALUES ('450127', '横县', '2016-11-10 14:49:05', '1', '450100', '3');
INSERT INTO `th_area` VALUES ('450128', '其它区', '2016-11-10 14:49:05', '1', '450100', '3');
INSERT INTO `th_area` VALUES ('450200', '柳州市', '2016-11-10 14:49:05', '1', '450000', '2');
INSERT INTO `th_area` VALUES ('450202', '城中区', '2016-11-10 14:49:05', '1', '450200', '3');
INSERT INTO `th_area` VALUES ('450203', '鱼峰区', '2016-11-10 14:49:05', '1', '450200', '3');
INSERT INTO `th_area` VALUES ('450204', '柳南区', '2016-11-10 14:49:05', '1', '450200', '3');
INSERT INTO `th_area` VALUES ('450205', '柳北区', '2016-11-10 14:49:05', '1', '450200', '3');
INSERT INTO `th_area` VALUES ('450221', '柳江县', '2016-11-10 14:49:05', '1', '450200', '3');
INSERT INTO `th_area` VALUES ('450222', '柳城县', '2016-11-10 14:49:05', '1', '450200', '3');
INSERT INTO `th_area` VALUES ('450223', '鹿寨县', '2016-11-10 14:49:05', '1', '450200', '3');
INSERT INTO `th_area` VALUES ('450224', '融安县', '2016-11-10 14:49:05', '1', '450200', '3');
INSERT INTO `th_area` VALUES ('450225', '融水苗族自治县', '2016-11-10 14:49:05', '1', '450200', '3');
INSERT INTO `th_area` VALUES ('450226', '三江侗族自治县', '2016-11-10 14:49:05', '1', '450200', '3');
INSERT INTO `th_area` VALUES ('450227', '其它区', '2016-11-10 14:49:05', '1', '450200', '3');
INSERT INTO `th_area` VALUES ('450300', '桂林市', '2016-11-10 14:49:05', '1', '450000', '2');
INSERT INTO `th_area` VALUES ('450302', '秀峰区', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450303', '叠彩区', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450304', '象山区', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450305', '七星区', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450311', '雁山区', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450321', '阳朔县', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450322', '临桂县', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450323', '灵川县', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450324', '全州县', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450325', '兴安县', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450326', '永福县', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450327', '灌阳县', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450328', '龙胜各族自治县', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450329', '资源县', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450330', '平乐县', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450331', '荔浦县', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450332', '恭城瑶族自治县', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450333', '其它区', '2016-11-10 14:49:05', '1', '450300', '3');
INSERT INTO `th_area` VALUES ('450400', '梧州市', '2016-11-10 14:49:05', '1', '450000', '2');
INSERT INTO `th_area` VALUES ('450403', '万秀区', '2016-11-10 14:49:05', '1', '450400', '3');
INSERT INTO `th_area` VALUES ('450404', '蝶山区', '2016-11-10 14:49:05', '1', '450400', '3');
INSERT INTO `th_area` VALUES ('450405', '长洲区', '2016-11-10 14:49:05', '1', '450400', '3');
INSERT INTO `th_area` VALUES ('450421', '苍梧县', '2016-11-10 14:49:05', '1', '450400', '3');
INSERT INTO `th_area` VALUES ('450422', '藤县', '2016-11-10 14:49:05', '1', '450400', '3');
INSERT INTO `th_area` VALUES ('450423', '蒙山县', '2016-11-10 14:49:05', '1', '450400', '3');
INSERT INTO `th_area` VALUES ('450481', '岑溪市', '2016-11-10 14:49:05', '1', '450400', '3');
INSERT INTO `th_area` VALUES ('450482', '其它区', '2016-11-10 14:49:05', '1', '450400', '3');
INSERT INTO `th_area` VALUES ('450500', '北海市', '2016-11-10 14:49:05', '1', '450000', '2');
INSERT INTO `th_area` VALUES ('450502', '海城区', '2016-11-10 14:49:05', '1', '450500', '3');
INSERT INTO `th_area` VALUES ('450503', '银海区', '2016-11-10 14:49:05', '1', '450500', '3');
INSERT INTO `th_area` VALUES ('450512', '铁山港区', '2016-11-10 14:49:05', '1', '450500', '3');
INSERT INTO `th_area` VALUES ('450521', '合浦县', '2016-11-10 14:49:05', '1', '450500', '3');
INSERT INTO `th_area` VALUES ('450522', '其它区', '2016-11-10 14:49:05', '1', '450500', '3');
INSERT INTO `th_area` VALUES ('450600', '防城港市', '2016-11-10 14:49:05', '1', '450000', '2');
INSERT INTO `th_area` VALUES ('450602', '港口区', '2016-11-10 14:49:05', '1', '450600', '3');
INSERT INTO `th_area` VALUES ('450603', '防城区', '2016-11-10 14:49:05', '1', '450600', '3');
INSERT INTO `th_area` VALUES ('450621', '上思县', '2016-11-10 14:49:05', '1', '450600', '3');
INSERT INTO `th_area` VALUES ('450681', '东兴市', '2016-11-10 14:49:05', '1', '450600', '3');
INSERT INTO `th_area` VALUES ('450682', '其它区', '2016-11-10 14:49:05', '1', '450600', '3');
INSERT INTO `th_area` VALUES ('450700', '钦州市', '2016-11-10 14:49:05', '1', '450000', '2');
INSERT INTO `th_area` VALUES ('450702', '钦南区', '2016-11-10 14:49:05', '1', '450700', '3');
INSERT INTO `th_area` VALUES ('450703', '钦北区', '2016-11-10 14:49:05', '1', '450700', '3');
INSERT INTO `th_area` VALUES ('450721', '灵山县', '2016-11-10 14:49:05', '1', '450700', '3');
INSERT INTO `th_area` VALUES ('450722', '浦北县', '2016-11-10 14:49:05', '1', '450700', '3');
INSERT INTO `th_area` VALUES ('450723', '其它区', '2016-11-10 14:49:05', '1', '450700', '3');
INSERT INTO `th_area` VALUES ('450800', '贵港市', '2016-11-10 14:49:05', '1', '450000', '2');
INSERT INTO `th_area` VALUES ('450802', '港北区', '2016-11-10 14:49:05', '1', '450800', '3');
INSERT INTO `th_area` VALUES ('450803', '港南区', '2016-11-10 14:49:05', '1', '450800', '3');
INSERT INTO `th_area` VALUES ('450804', '覃塘区', '2016-11-10 14:49:05', '1', '450800', '3');
INSERT INTO `th_area` VALUES ('450821', '平南县', '2016-11-10 14:49:05', '1', '450800', '3');
INSERT INTO `th_area` VALUES ('450881', '桂平市', '2016-11-10 14:49:05', '1', '450800', '3');
INSERT INTO `th_area` VALUES ('450882', '其它区', '2016-11-10 14:49:05', '1', '450800', '3');
INSERT INTO `th_area` VALUES ('450900', '玉林市', '2016-11-10 14:49:05', '1', '450000', '2');
INSERT INTO `th_area` VALUES ('450902', '玉州区', '2016-11-10 14:49:05', '1', '450900', '3');
INSERT INTO `th_area` VALUES ('450921', '容县', '2016-11-10 14:49:05', '1', '450900', '3');
INSERT INTO `th_area` VALUES ('450922', '陆川县', '2016-11-10 14:49:05', '1', '450900', '3');
INSERT INTO `th_area` VALUES ('450923', '博白县', '2016-11-10 14:49:05', '1', '450900', '3');
INSERT INTO `th_area` VALUES ('450924', '兴业县', '2016-11-10 14:49:05', '1', '450900', '3');
INSERT INTO `th_area` VALUES ('450981', '北流市', '2016-11-10 14:49:05', '1', '450900', '3');
INSERT INTO `th_area` VALUES ('450982', '其它区', '2016-11-10 14:49:05', '1', '450900', '3');
INSERT INTO `th_area` VALUES ('451000', '百色市', '2016-11-10 14:49:05', '1', '450000', '2');
INSERT INTO `th_area` VALUES ('451002', '右江区', '2016-11-10 14:49:05', '1', '451000', '3');
INSERT INTO `th_area` VALUES ('451021', '田阳县', '2016-11-10 14:49:05', '1', '451000', '3');
INSERT INTO `th_area` VALUES ('451022', '田东县', '2016-11-10 14:49:05', '1', '451000', '3');
INSERT INTO `th_area` VALUES ('451023', '平果县', '2016-11-10 14:49:05', '1', '451000', '3');
INSERT INTO `th_area` VALUES ('451024', '德保县', '2016-11-10 14:49:05', '1', '451000', '3');
INSERT INTO `th_area` VALUES ('451025', '靖西县', '2016-11-10 14:49:05', '1', '451000', '3');
INSERT INTO `th_area` VALUES ('451026', '那坡县', '2016-11-10 14:49:05', '1', '451000', '3');
INSERT INTO `th_area` VALUES ('451027', '凌云县', '2016-11-10 14:49:05', '1', '451000', '3');
INSERT INTO `th_area` VALUES ('451028', '乐业县', '2016-11-10 14:49:05', '1', '451000', '3');
INSERT INTO `th_area` VALUES ('451029', '田林县', '2016-11-10 14:49:05', '1', '451000', '3');
INSERT INTO `th_area` VALUES ('451030', '西林县', '2016-11-10 14:49:05', '1', '451000', '3');
INSERT INTO `th_area` VALUES ('451031', '隆林各族自治县', '2016-11-10 14:49:05', '1', '451000', '3');
INSERT INTO `th_area` VALUES ('451032', '其它区', '2016-11-10 14:49:05', '1', '451000', '3');
INSERT INTO `th_area` VALUES ('451100', '贺州市', '2016-11-10 14:49:05', '1', '450000', '2');
INSERT INTO `th_area` VALUES ('451102', '八步区', '2016-11-10 14:49:05', '1', '451100', '3');
INSERT INTO `th_area` VALUES ('451121', '昭平县', '2016-11-10 14:49:05', '1', '451100', '3');
INSERT INTO `th_area` VALUES ('451122', '钟山县', '2016-11-10 14:49:05', '1', '451100', '3');
INSERT INTO `th_area` VALUES ('451123', '富川瑶族自治县', '2016-11-10 14:49:05', '1', '451100', '3');
INSERT INTO `th_area` VALUES ('451124', '其它区', '2016-11-10 14:49:05', '1', '451100', '3');
INSERT INTO `th_area` VALUES ('451200', '河池市', '2016-11-10 14:49:05', '1', '450000', '2');
INSERT INTO `th_area` VALUES ('451202', '金城江区', '2016-11-10 14:49:05', '1', '451200', '3');
INSERT INTO `th_area` VALUES ('451221', '南丹县', '2016-11-10 14:49:05', '1', '451200', '3');
INSERT INTO `th_area` VALUES ('451222', '天峨县', '2016-11-10 14:49:05', '1', '451200', '3');
INSERT INTO `th_area` VALUES ('451223', '凤山县', '2016-11-10 14:49:05', '1', '451200', '3');
INSERT INTO `th_area` VALUES ('451224', '东兰县', '2016-11-10 14:49:05', '1', '451200', '3');
INSERT INTO `th_area` VALUES ('451225', '罗城仫佬族自治县', '2016-11-10 14:49:05', '1', '451200', '3');
INSERT INTO `th_area` VALUES ('451226', '环江毛南族自治县', '2016-11-10 14:49:05', '1', '451200', '3');
INSERT INTO `th_area` VALUES ('451227', '巴马瑶族自治县', '2016-11-10 14:49:05', '1', '451200', '3');
INSERT INTO `th_area` VALUES ('451228', '都安瑶族自治县', '2016-11-10 14:49:05', '1', '451200', '3');
INSERT INTO `th_area` VALUES ('451229', '大化瑶族自治县', '2016-11-10 14:49:05', '1', '451200', '3');
INSERT INTO `th_area` VALUES ('451281', '宜州市', '2016-11-10 14:49:05', '1', '451200', '3');
INSERT INTO `th_area` VALUES ('451282', '其它区', '2016-11-10 14:49:05', '1', '451200', '3');
INSERT INTO `th_area` VALUES ('451300', '来宾市', '2016-11-10 14:49:05', '1', '450000', '2');
INSERT INTO `th_area` VALUES ('451302', '兴宾区', '2016-11-10 14:49:05', '1', '451300', '3');
INSERT INTO `th_area` VALUES ('451321', '忻城县', '2016-11-10 14:49:05', '1', '451300', '3');
INSERT INTO `th_area` VALUES ('451322', '象州县', '2016-11-10 14:49:05', '1', '451300', '3');
INSERT INTO `th_area` VALUES ('451323', '武宣县', '2016-11-10 14:49:05', '1', '451300', '3');
INSERT INTO `th_area` VALUES ('451324', '金秀瑶族自治县', '2016-11-10 14:49:05', '1', '451300', '3');
INSERT INTO `th_area` VALUES ('451381', '合山市', '2016-11-10 14:49:05', '1', '451300', '3');
INSERT INTO `th_area` VALUES ('451382', '其它区', '2016-11-10 14:49:05', '1', '451300', '3');
INSERT INTO `th_area` VALUES ('451400', '崇左市', '2016-11-10 14:49:05', '1', '450000', '2');
INSERT INTO `th_area` VALUES ('451402', '江洲区', '2016-11-10 14:49:05', '1', '451400', '3');
INSERT INTO `th_area` VALUES ('451421', '扶绥县', '2016-11-10 14:49:05', '1', '451400', '3');
INSERT INTO `th_area` VALUES ('451422', '宁明县', '2016-11-10 14:49:05', '1', '451400', '3');
INSERT INTO `th_area` VALUES ('451423', '龙州县', '2016-11-10 14:49:05', '1', '451400', '3');
INSERT INTO `th_area` VALUES ('451424', '大新县', '2016-11-10 14:49:05', '1', '451400', '3');
INSERT INTO `th_area` VALUES ('451425', '天等县', '2016-11-10 14:49:05', '1', '451400', '3');
INSERT INTO `th_area` VALUES ('451481', '凭祥市', '2016-11-10 14:49:05', '1', '451400', '3');
INSERT INTO `th_area` VALUES ('451482', '其它区', '2016-11-10 14:49:05', '1', '451400', '3');
INSERT INTO `th_area` VALUES ('460000', '海南省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('460100', '海口市', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('460105', '秀英区', '2016-11-10 14:49:05', '1', '460100', '3');
INSERT INTO `th_area` VALUES ('460106', '龙华区', '2016-11-10 14:49:05', '1', '460100', '3');
INSERT INTO `th_area` VALUES ('460107', '琼山区', '2016-11-10 14:49:05', '1', '460100', '3');
INSERT INTO `th_area` VALUES ('460108', '美兰区', '2016-11-10 14:49:05', '1', '460100', '3');
INSERT INTO `th_area` VALUES ('460109', '其它区', '2016-11-10 14:49:05', '1', '460100', '3');
INSERT INTO `th_area` VALUES ('460200', '三亚市', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469001', '五指山市', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469002', '琼海市', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469003', '儋州市', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469005', '文昌市', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469006', '万宁市', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469007', '东方市', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469025', '定安县', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469026', '屯昌县', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469027', '澄迈县', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469028', '临高县', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469030', '白沙黎族自治县', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469031', '昌江黎族自治县', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469033', '乐东黎族自治县', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469034', '陵水黎族自治县', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469035', '保亭黎族苗族自治县', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469036', '琼中黎族苗族自治县', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469037', '西沙群岛', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469038', '南沙群岛', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('469039', '中沙群岛的岛礁及其海域', '2016-11-10 14:49:05', '1', '460000', '2');
INSERT INTO `th_area` VALUES ('471004', '高新区', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('471005', '其它区', '2016-11-10 14:49:05', '1', '410300', '3');
INSERT INTO `th_area` VALUES ('500000', '重庆', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('5001000', '重庆', '2016-11-10 14:49:05', '1', '500000', '2');
INSERT INTO `th_area` VALUES ('500101', '万州区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500102', '涪陵区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500103', '渝中区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500104', '大渡口区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500105', '江北区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500106', '沙坪坝区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500107', '九龙坡区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500108', '南岸区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500109', '北碚区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500110', '万盛区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500111', '双桥区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500112', '渝北区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500113', '巴南区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500114', '黔江区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500115', '长寿区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500222', '綦江县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500223', '潼南县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500224', '铜梁县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500225', '大足县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500226', '荣昌县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500227', '璧山县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500228', '梁平县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500229', '城口县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500230', '丰都县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500231', '垫江县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500232', '武隆县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500233', '忠县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500234', '开县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500235', '云阳县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500236', '奉节县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500237', '巫山县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500238', '巫溪县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500240', '石柱土家族自治县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500241', '秀山土家族苗族自治县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500242', '酉阳土家族苗族自治县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500243', '彭水苗族土家族自治县', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500381', '江津区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500382', '合川区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500383', '永川区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500384', '南川区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('500385', '其它区', '2016-11-10 14:49:05', '1', '5001000', '3');
INSERT INTO `th_area` VALUES ('510000', '四川省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('510100', '成都市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('510104', '锦江区', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510105', '青羊区', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510106', '金牛区', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510107', '武侯区', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510108', '成华区', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510112', '龙泉驿区', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510113', '青白江区', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510114', '新都区', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510115', '温江区', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510121', '金堂县', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510122', '双流县', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510124', '郫县', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510129', '大邑县', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510131', '蒲江县', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510132', '新津县', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510181', '都江堰市', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510182', '彭州市', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510183', '邛崃市', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510184', '崇州市', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510185', '其它区', '2016-11-10 14:49:05', '1', '510100', '3');
INSERT INTO `th_area` VALUES ('510300', '自贡市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('510302', '自流井区', '2016-11-10 14:49:05', '1', '510300', '3');
INSERT INTO `th_area` VALUES ('510303', '贡井区', '2016-11-10 14:49:05', '1', '510300', '3');
INSERT INTO `th_area` VALUES ('510304', '大安区', '2016-11-10 14:49:05', '1', '510300', '3');
INSERT INTO `th_area` VALUES ('510311', '沿滩区', '2016-11-10 14:49:05', '1', '510300', '3');
INSERT INTO `th_area` VALUES ('510321', '荣县', '2016-11-10 14:49:05', '1', '510300', '3');
INSERT INTO `th_area` VALUES ('510322', '富顺县', '2016-11-10 14:49:05', '1', '510300', '3');
INSERT INTO `th_area` VALUES ('510323', '其它区', '2016-11-10 14:49:05', '1', '510300', '3');
INSERT INTO `th_area` VALUES ('510400', '攀枝花市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('510402', '东区', '2016-11-10 14:49:05', '1', '510400', '3');
INSERT INTO `th_area` VALUES ('510403', '西区', '2016-11-10 14:49:05', '1', '510400', '3');
INSERT INTO `th_area` VALUES ('510411', '仁和区', '2016-11-10 14:49:05', '1', '510400', '3');
INSERT INTO `th_area` VALUES ('510421', '米易县', '2016-11-10 14:49:05', '1', '510400', '3');
INSERT INTO `th_area` VALUES ('510422', '盐边县', '2016-11-10 14:49:05', '1', '510400', '3');
INSERT INTO `th_area` VALUES ('510423', '其它区', '2016-11-10 14:49:05', '1', '510400', '3');
INSERT INTO `th_area` VALUES ('510500', '泸州市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('510502', '江阳区', '2016-11-10 14:49:05', '1', '510500', '3');
INSERT INTO `th_area` VALUES ('510503', '纳溪区', '2016-11-10 14:49:05', '1', '510500', '3');
INSERT INTO `th_area` VALUES ('510504', '龙马潭区', '2016-11-10 14:49:05', '1', '510500', '3');
INSERT INTO `th_area` VALUES ('510521', '泸县', '2016-11-10 14:49:05', '1', '510500', '3');
INSERT INTO `th_area` VALUES ('510522', '合江县', '2016-11-10 14:49:05', '1', '510500', '3');
INSERT INTO `th_area` VALUES ('510524', '叙永县', '2016-11-10 14:49:05', '1', '510500', '3');
INSERT INTO `th_area` VALUES ('510525', '古蔺县', '2016-11-10 14:49:05', '1', '510500', '3');
INSERT INTO `th_area` VALUES ('510526', '其它区', '2016-11-10 14:49:05', '1', '510500', '3');
INSERT INTO `th_area` VALUES ('510600', '德阳市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('510603', '旌阳区', '2016-11-10 14:49:05', '1', '510600', '3');
INSERT INTO `th_area` VALUES ('510623', '中江县', '2016-11-10 14:49:05', '1', '510600', '3');
INSERT INTO `th_area` VALUES ('510626', '罗江县', '2016-11-10 14:49:05', '1', '510600', '3');
INSERT INTO `th_area` VALUES ('510681', '广汉市', '2016-11-10 14:49:05', '1', '510600', '3');
INSERT INTO `th_area` VALUES ('510682', '什邡市', '2016-11-10 14:49:05', '1', '510600', '3');
INSERT INTO `th_area` VALUES ('510683', '绵竹市', '2016-11-10 14:49:05', '1', '510600', '3');
INSERT INTO `th_area` VALUES ('510684', '其它区', '2016-11-10 14:49:05', '1', '510600', '3');
INSERT INTO `th_area` VALUES ('510700', '绵阳市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('510703', '涪城区', '2016-11-10 14:49:05', '1', '510700', '3');
INSERT INTO `th_area` VALUES ('510704', '游仙区', '2016-11-10 14:49:05', '1', '510700', '3');
INSERT INTO `th_area` VALUES ('510722', '三台县', '2016-11-10 14:49:05', '1', '510700', '3');
INSERT INTO `th_area` VALUES ('510723', '盐亭县', '2016-11-10 14:49:05', '1', '510700', '3');
INSERT INTO `th_area` VALUES ('510724', '安县', '2016-11-10 14:49:05', '1', '510700', '3');
INSERT INTO `th_area` VALUES ('510725', '梓潼县', '2016-11-10 14:49:05', '1', '510700', '3');
INSERT INTO `th_area` VALUES ('510726', '北川羌族自治县', '2016-11-10 14:49:05', '1', '510700', '3');
INSERT INTO `th_area` VALUES ('510727', '平武县', '2016-11-10 14:49:05', '1', '510700', '3');
INSERT INTO `th_area` VALUES ('510751', '高新区', '2016-11-10 14:49:05', '1', '510700', '3');
INSERT INTO `th_area` VALUES ('510781', '江油市', '2016-11-10 14:49:05', '1', '510700', '3');
INSERT INTO `th_area` VALUES ('510782', '其它区', '2016-11-10 14:49:05', '1', '510700', '3');
INSERT INTO `th_area` VALUES ('510800', '广元市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('510802', '利州区', '2016-11-10 14:49:05', '1', '510800', '3');
INSERT INTO `th_area` VALUES ('510811', '元坝区', '2016-11-10 14:49:05', '1', '510800', '3');
INSERT INTO `th_area` VALUES ('510812', '朝天区', '2016-11-10 14:49:05', '1', '510800', '3');
INSERT INTO `th_area` VALUES ('510821', '旺苍县', '2016-11-10 14:49:05', '1', '510800', '3');
INSERT INTO `th_area` VALUES ('510822', '青川县', '2016-11-10 14:49:05', '1', '510800', '3');
INSERT INTO `th_area` VALUES ('510823', '剑阁县', '2016-11-10 14:49:05', '1', '510800', '3');
INSERT INTO `th_area` VALUES ('510824', '苍溪县', '2016-11-10 14:49:05', '1', '510800', '3');
INSERT INTO `th_area` VALUES ('510825', '其它区', '2016-11-10 14:49:05', '1', '510800', '3');
INSERT INTO `th_area` VALUES ('510900', '遂宁市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('510903', '船山区', '2016-11-10 14:49:05', '1', '510900', '3');
INSERT INTO `th_area` VALUES ('510904', '安居区', '2016-11-10 14:49:05', '1', '510900', '3');
INSERT INTO `th_area` VALUES ('510921', '蓬溪县', '2016-11-10 14:49:05', '1', '510900', '3');
INSERT INTO `th_area` VALUES ('510922', '射洪县', '2016-11-10 14:49:05', '1', '510900', '3');
INSERT INTO `th_area` VALUES ('510923', '大英县', '2016-11-10 14:49:05', '1', '510900', '3');
INSERT INTO `th_area` VALUES ('510924', '其它区', '2016-11-10 14:49:05', '1', '510900', '3');
INSERT INTO `th_area` VALUES ('511000', '内江市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('511002', '市中区', '2016-11-10 14:49:05', '1', '511000', '3');
INSERT INTO `th_area` VALUES ('511011', '东兴区', '2016-11-10 14:49:05', '1', '511000', '3');
INSERT INTO `th_area` VALUES ('511024', '威远县', '2016-11-10 14:49:05', '1', '511000', '3');
INSERT INTO `th_area` VALUES ('511025', '资中县', '2016-11-10 14:49:05', '1', '511000', '3');
INSERT INTO `th_area` VALUES ('511028', '隆昌县', '2016-11-10 14:49:05', '1', '511000', '3');
INSERT INTO `th_area` VALUES ('511029', '其它区', '2016-11-10 14:49:05', '1', '511000', '3');
INSERT INTO `th_area` VALUES ('511100', '乐山市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('511102', '市中区', '2016-11-10 14:49:05', '1', '511100', '3');
INSERT INTO `th_area` VALUES ('511111', '沙湾区', '2016-11-10 14:49:05', '1', '511100', '3');
INSERT INTO `th_area` VALUES ('511112', '五通桥区', '2016-11-10 14:49:05', '1', '511100', '3');
INSERT INTO `th_area` VALUES ('511113', '金口河区', '2016-11-10 14:49:05', '1', '511100', '3');
INSERT INTO `th_area` VALUES ('511123', '犍为县', '2016-11-10 14:49:05', '1', '511100', '3');
INSERT INTO `th_area` VALUES ('511124', '井研县', '2016-11-10 14:49:05', '1', '511100', '3');
INSERT INTO `th_area` VALUES ('511126', '夹江县', '2016-11-10 14:49:05', '1', '511100', '3');
INSERT INTO `th_area` VALUES ('511129', '沐川县', '2016-11-10 14:49:05', '1', '511100', '3');
INSERT INTO `th_area` VALUES ('511132', '峨边彝族自治县', '2016-11-10 14:49:05', '1', '511100', '3');
INSERT INTO `th_area` VALUES ('511133', '马边彝族自治县', '2016-11-10 14:49:05', '1', '511100', '3');
INSERT INTO `th_area` VALUES ('511181', '峨眉山市', '2016-11-10 14:49:05', '1', '511100', '3');
INSERT INTO `th_area` VALUES ('511182', '其它区', '2016-11-10 14:49:05', '1', '511100', '3');
INSERT INTO `th_area` VALUES ('511300', '南充市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('511302', '顺庆区', '2016-11-10 14:49:05', '1', '511300', '3');
INSERT INTO `th_area` VALUES ('511303', '高坪区', '2016-11-10 14:49:05', '1', '511300', '3');
INSERT INTO `th_area` VALUES ('511304', '嘉陵区', '2016-11-10 14:49:05', '1', '511300', '3');
INSERT INTO `th_area` VALUES ('511321', '南部县', '2016-11-10 14:49:05', '1', '511300', '3');
INSERT INTO `th_area` VALUES ('511322', '营山县', '2016-11-10 14:49:05', '1', '511300', '3');
INSERT INTO `th_area` VALUES ('511323', '蓬安县', '2016-11-10 14:49:05', '1', '511300', '3');
INSERT INTO `th_area` VALUES ('511324', '仪陇县', '2016-11-10 14:49:05', '1', '511300', '3');
INSERT INTO `th_area` VALUES ('511325', '西充县', '2016-11-10 14:49:05', '1', '511300', '3');
INSERT INTO `th_area` VALUES ('511381', '阆中市', '2016-11-10 14:49:05', '1', '511300', '3');
INSERT INTO `th_area` VALUES ('511382', '其它区', '2016-11-10 14:49:05', '1', '511300', '3');
INSERT INTO `th_area` VALUES ('511400', '眉山市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('511402', '东坡区', '2016-11-10 14:49:05', '1', '511400', '3');
INSERT INTO `th_area` VALUES ('511421', '仁寿县', '2016-11-10 14:49:05', '1', '511400', '3');
INSERT INTO `th_area` VALUES ('511422', '彭山县', '2016-11-10 14:49:05', '1', '511400', '3');
INSERT INTO `th_area` VALUES ('511423', '洪雅县', '2016-11-10 14:49:05', '1', '511400', '3');
INSERT INTO `th_area` VALUES ('511424', '丹棱县', '2016-11-10 14:49:05', '1', '511400', '3');
INSERT INTO `th_area` VALUES ('511425', '青神县', '2016-11-10 14:49:05', '1', '511400', '3');
INSERT INTO `th_area` VALUES ('511426', '其它区', '2016-11-10 14:49:05', '1', '511400', '3');
INSERT INTO `th_area` VALUES ('511500', '宜宾市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('511502', '翠屏区', '2016-11-10 14:49:05', '1', '511500', '3');
INSERT INTO `th_area` VALUES ('511521', '宜宾县', '2016-11-10 14:49:05', '1', '511500', '3');
INSERT INTO `th_area` VALUES ('511522', '南溪县', '2016-11-10 14:49:05', '1', '511500', '3');
INSERT INTO `th_area` VALUES ('511523', '江安县', '2016-11-10 14:49:05', '1', '511500', '3');
INSERT INTO `th_area` VALUES ('511524', '长宁县', '2016-11-10 14:49:05', '1', '511500', '3');
INSERT INTO `th_area` VALUES ('511525', '高县', '2016-11-10 14:49:05', '1', '511500', '3');
INSERT INTO `th_area` VALUES ('511526', '珙县', '2016-11-10 14:49:05', '1', '511500', '3');
INSERT INTO `th_area` VALUES ('511527', '筠连县', '2016-11-10 14:49:05', '1', '511500', '3');
INSERT INTO `th_area` VALUES ('511528', '兴文县', '2016-11-10 14:49:05', '1', '511500', '3');
INSERT INTO `th_area` VALUES ('511529', '屏山县', '2016-11-10 14:49:05', '1', '511500', '3');
INSERT INTO `th_area` VALUES ('511530', '其它区', '2016-11-10 14:49:05', '1', '511500', '3');
INSERT INTO `th_area` VALUES ('511600', '广安市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('511602', '广安区', '2016-11-10 14:49:05', '1', '511600', '3');
INSERT INTO `th_area` VALUES ('511621', '岳池县', '2016-11-10 14:49:05', '1', '511600', '3');
INSERT INTO `th_area` VALUES ('511622', '武胜县', '2016-11-10 14:49:05', '1', '511600', '3');
INSERT INTO `th_area` VALUES ('511623', '邻水县', '2016-11-10 14:49:05', '1', '511600', '3');
INSERT INTO `th_area` VALUES ('511681', '华蓥市', '2016-11-10 14:49:05', '1', '511600', '3');
INSERT INTO `th_area` VALUES ('511682', '市辖区', '2016-11-10 14:49:05', '1', '511600', '3');
INSERT INTO `th_area` VALUES ('511683', '其它区', '2016-11-10 14:49:05', '1', '511600', '3');
INSERT INTO `th_area` VALUES ('511700', '达州市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('511702', '通川区', '2016-11-10 14:49:05', '1', '511700', '3');
INSERT INTO `th_area` VALUES ('511721', '达县', '2016-11-10 14:49:05', '1', '511700', '3');
INSERT INTO `th_area` VALUES ('511722', '宣汉县', '2016-11-10 14:49:05', '1', '511700', '3');
INSERT INTO `th_area` VALUES ('511723', '开江县', '2016-11-10 14:49:05', '1', '511700', '3');
INSERT INTO `th_area` VALUES ('511724', '大竹县', '2016-11-10 14:49:05', '1', '511700', '3');
INSERT INTO `th_area` VALUES ('511725', '渠县', '2016-11-10 14:49:05', '1', '511700', '3');
INSERT INTO `th_area` VALUES ('511781', '万源市', '2016-11-10 14:49:05', '1', '511700', '3');
INSERT INTO `th_area` VALUES ('511782', '其它区', '2016-11-10 14:49:05', '1', '511700', '3');
INSERT INTO `th_area` VALUES ('511800', '雅安市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('511802', '雨城区', '2016-11-10 14:49:05', '1', '511800', '3');
INSERT INTO `th_area` VALUES ('511821', '名山县', '2016-11-10 14:49:05', '1', '511800', '3');
INSERT INTO `th_area` VALUES ('511822', '荥经县', '2016-11-10 14:49:05', '1', '511800', '3');
INSERT INTO `th_area` VALUES ('511823', '汉源县', '2016-11-10 14:49:05', '1', '511800', '3');
INSERT INTO `th_area` VALUES ('511824', '石棉县', '2016-11-10 14:49:05', '1', '511800', '3');
INSERT INTO `th_area` VALUES ('511825', '天全县', '2016-11-10 14:49:05', '1', '511800', '3');
INSERT INTO `th_area` VALUES ('511826', '芦山县', '2016-11-10 14:49:05', '1', '511800', '3');
INSERT INTO `th_area` VALUES ('511827', '宝兴县', '2016-11-10 14:49:05', '1', '511800', '3');
INSERT INTO `th_area` VALUES ('511828', '其它区', '2016-11-10 14:49:05', '1', '511800', '3');
INSERT INTO `th_area` VALUES ('511900', '巴中市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('511902', '巴州区', '2016-11-10 14:49:05', '1', '511900', '3');
INSERT INTO `th_area` VALUES ('511921', '通江县', '2016-11-10 14:49:05', '1', '511900', '3');
INSERT INTO `th_area` VALUES ('511922', '南江县', '2016-11-10 14:49:05', '1', '511900', '3');
INSERT INTO `th_area` VALUES ('511923', '平昌县', '2016-11-10 14:49:05', '1', '511900', '3');
INSERT INTO `th_area` VALUES ('511924', '其它区', '2016-11-10 14:49:05', '1', '511900', '3');
INSERT INTO `th_area` VALUES ('512000', '资阳市', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('512002', '雁江区', '2016-11-10 14:49:05', '1', '512000', '3');
INSERT INTO `th_area` VALUES ('512021', '安岳县', '2016-11-10 14:49:05', '1', '512000', '3');
INSERT INTO `th_area` VALUES ('512022', '乐至县', '2016-11-10 14:49:05', '1', '512000', '3');
INSERT INTO `th_area` VALUES ('512081', '简阳市', '2016-11-10 14:49:05', '1', '512000', '3');
INSERT INTO `th_area` VALUES ('512082', '其它区', '2016-11-10 14:49:05', '1', '512000', '3');
INSERT INTO `th_area` VALUES ('513200', '阿坝藏族羌族自治州', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('513221', '汶川县', '2016-11-10 14:49:05', '1', '513200', '3');
INSERT INTO `th_area` VALUES ('513222', '理县', '2016-11-10 14:49:05', '1', '513200', '3');
INSERT INTO `th_area` VALUES ('513223', '茂县', '2016-11-10 14:49:05', '1', '513200', '3');
INSERT INTO `th_area` VALUES ('513224', '松潘县', '2016-11-10 14:49:05', '1', '513200', '3');
INSERT INTO `th_area` VALUES ('513225', '九寨沟县', '2016-11-10 14:49:05', '1', '513200', '3');
INSERT INTO `th_area` VALUES ('513226', '金川县', '2016-11-10 14:49:05', '1', '513200', '3');
INSERT INTO `th_area` VALUES ('513227', '小金县', '2016-11-10 14:49:05', '1', '513200', '3');
INSERT INTO `th_area` VALUES ('513228', '黑水县', '2016-11-10 14:49:05', '1', '513200', '3');
INSERT INTO `th_area` VALUES ('513229', '马尔康县', '2016-11-10 14:49:05', '1', '513200', '3');
INSERT INTO `th_area` VALUES ('513230', '壤塘县', '2016-11-10 14:49:05', '1', '513200', '3');
INSERT INTO `th_area` VALUES ('513231', '阿坝县', '2016-11-10 14:49:05', '1', '513200', '3');
INSERT INTO `th_area` VALUES ('513232', '若尔盖县', '2016-11-10 14:49:05', '1', '513200', '3');
INSERT INTO `th_area` VALUES ('513233', '红原县', '2016-11-10 14:49:05', '1', '513200', '3');
INSERT INTO `th_area` VALUES ('513234', '其它区', '2016-11-10 14:49:05', '1', '513200', '3');
INSERT INTO `th_area` VALUES ('513300', '甘孜藏族自治州', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('513321', '康定县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513322', '泸定县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513323', '丹巴县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513324', '九龙县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513325', '雅江县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513326', '道孚县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513327', '炉霍县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513328', '甘孜县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513329', '新龙县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513330', '德格县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513331', '白玉县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513332', '石渠县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513333', '色达县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513334', '理塘县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513335', '巴塘县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513336', '乡城县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513337', '稻城县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513338', '得荣县', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513339', '其它区', '2016-11-10 14:49:05', '1', '513300', '3');
INSERT INTO `th_area` VALUES ('513400', '凉山彝族自治州', '2016-11-10 14:49:05', '1', '510000', '2');
INSERT INTO `th_area` VALUES ('513401', '西昌市', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513422', '木里藏族自治县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513423', '盐源县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513424', '德昌县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513425', '会理县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513426', '会东县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513427', '宁南县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513428', '普格县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513429', '布拖县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513430', '金阳县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513431', '昭觉县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513432', '喜德县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513433', '冕宁县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513434', '越西县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513435', '甘洛县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513436', '美姑县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513437', '雷波县', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('513438', '其它区', '2016-11-10 14:49:05', '1', '513400', '3');
INSERT INTO `th_area` VALUES ('520000', '贵州省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('520100', '贵阳市', '2016-11-10 14:49:05', '1', '520000', '2');
INSERT INTO `th_area` VALUES ('520102', '南明区', '2016-11-10 14:49:05', '1', '520100', '3');
INSERT INTO `th_area` VALUES ('520103', '云岩区', '2016-11-10 14:49:05', '1', '520100', '3');
INSERT INTO `th_area` VALUES ('520111', '花溪区', '2016-11-10 14:49:05', '1', '520100', '3');
INSERT INTO `th_area` VALUES ('520112', '乌当区', '2016-11-10 14:49:05', '1', '520100', '3');
INSERT INTO `th_area` VALUES ('520113', '白云区', '2016-11-10 14:49:05', '1', '520100', '3');
INSERT INTO `th_area` VALUES ('520114', '小河区', '2016-11-10 14:49:05', '1', '520100', '3');
INSERT INTO `th_area` VALUES ('520121', '开阳县', '2016-11-10 14:49:05', '1', '520100', '3');
INSERT INTO `th_area` VALUES ('520122', '息烽县', '2016-11-10 14:49:05', '1', '520100', '3');
INSERT INTO `th_area` VALUES ('520123', '修文县', '2016-11-10 14:49:05', '1', '520100', '3');
INSERT INTO `th_area` VALUES ('520151', '金阳开发区', '2016-11-10 14:49:05', '1', '520100', '3');
INSERT INTO `th_area` VALUES ('520181', '清镇市', '2016-11-10 14:49:05', '1', '520100', '3');
INSERT INTO `th_area` VALUES ('520182', '其它区', '2016-11-10 14:49:05', '1', '520100', '3');
INSERT INTO `th_area` VALUES ('520200', '六盘水市', '2016-11-10 14:49:05', '1', '520000', '2');
INSERT INTO `th_area` VALUES ('520201', '钟山区', '2016-11-10 14:49:05', '1', '520200', '3');
INSERT INTO `th_area` VALUES ('520203', '六枝特区', '2016-11-10 14:49:05', '1', '520200', '3');
INSERT INTO `th_area` VALUES ('520221', '水城县', '2016-11-10 14:49:05', '1', '520200', '3');
INSERT INTO `th_area` VALUES ('520222', '盘县', '2016-11-10 14:49:05', '1', '520200', '3');
INSERT INTO `th_area` VALUES ('520223', '其它区', '2016-11-10 14:49:05', '1', '520200', '3');
INSERT INTO `th_area` VALUES ('520300', '遵义市', '2016-11-10 14:49:05', '1', '520000', '2');
INSERT INTO `th_area` VALUES ('520302', '红花岗区', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520303', '汇川区', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520321', '遵义县', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520322', '桐梓县', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520323', '绥阳县', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520324', '正安县', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520325', '道真仡佬族苗族自治县', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520326', '务川仡佬族苗族自治县', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520327', '凤冈县', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520328', '湄潭县', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520329', '余庆县', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520330', '习水县', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520381', '赤水市', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520382', '仁怀市', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520383', '其它区', '2016-11-10 14:49:05', '1', '520300', '3');
INSERT INTO `th_area` VALUES ('520400', '安顺市', '2016-11-10 14:49:05', '1', '520000', '2');
INSERT INTO `th_area` VALUES ('520402', '西秀区', '2016-11-10 14:49:05', '1', '520400', '3');
INSERT INTO `th_area` VALUES ('520421', '平坝县', '2016-11-10 14:49:05', '1', '520400', '3');
INSERT INTO `th_area` VALUES ('520422', '普定县', '2016-11-10 14:49:05', '1', '520400', '3');
INSERT INTO `th_area` VALUES ('520423', '镇宁布依族苗族自治县', '2016-11-10 14:49:05', '1', '520400', '3');
INSERT INTO `th_area` VALUES ('520424', '关岭布依族苗族自治县', '2016-11-10 14:49:05', '1', '520400', '3');
INSERT INTO `th_area` VALUES ('520425', '紫云苗族布依族自治县', '2016-11-10 14:49:05', '1', '520400', '3');
INSERT INTO `th_area` VALUES ('520426', '其它区', '2016-11-10 14:49:05', '1', '520400', '3');
INSERT INTO `th_area` VALUES ('522200', '铜仁地区', '2016-11-10 14:49:05', '1', '520000', '2');
INSERT INTO `th_area` VALUES ('522201', '铜仁市', '2016-11-10 14:49:05', '1', '522200', '3');
INSERT INTO `th_area` VALUES ('522222', '江口县', '2016-11-10 14:49:05', '1', '522200', '3');
INSERT INTO `th_area` VALUES ('522223', '玉屏侗族自治县', '2016-11-10 14:49:05', '1', '522200', '3');
INSERT INTO `th_area` VALUES ('522224', '石阡县', '2016-11-10 14:49:05', '1', '522200', '3');
INSERT INTO `th_area` VALUES ('522225', '思南县', '2016-11-10 14:49:05', '1', '522200', '3');
INSERT INTO `th_area` VALUES ('522226', '印江土家族苗族自治县', '2016-11-10 14:49:05', '1', '522200', '3');
INSERT INTO `th_area` VALUES ('522227', '德江县', '2016-11-10 14:49:05', '1', '522200', '3');
INSERT INTO `th_area` VALUES ('522228', '沿河土家族自治县', '2016-11-10 14:49:05', '1', '522200', '3');
INSERT INTO `th_area` VALUES ('522229', '松桃苗族自治县', '2016-11-10 14:49:05', '1', '522200', '3');
INSERT INTO `th_area` VALUES ('522230', '万山特区', '2016-11-10 14:49:05', '1', '522200', '3');
INSERT INTO `th_area` VALUES ('522231', '其它区', '2016-11-10 14:49:05', '1', '522200', '3');
INSERT INTO `th_area` VALUES ('522300', '黔西南布依族苗族自治州', '2016-11-10 14:49:05', '1', '520000', '2');
INSERT INTO `th_area` VALUES ('522301', '兴义市', '2016-11-10 14:49:05', '1', '522300', '3');
INSERT INTO `th_area` VALUES ('522322', '兴仁县', '2016-11-10 14:49:05', '1', '522300', '3');
INSERT INTO `th_area` VALUES ('522323', '普安县', '2016-11-10 14:49:05', '1', '522300', '3');
INSERT INTO `th_area` VALUES ('522324', '晴隆县', '2016-11-10 14:49:05', '1', '522300', '3');
INSERT INTO `th_area` VALUES ('522325', '贞丰县', '2016-11-10 14:49:05', '1', '522300', '3');
INSERT INTO `th_area` VALUES ('522326', '望谟县', '2016-11-10 14:49:05', '1', '522300', '3');
INSERT INTO `th_area` VALUES ('522327', '册亨县', '2016-11-10 14:49:05', '1', '522300', '3');
INSERT INTO `th_area` VALUES ('522328', '安龙县', '2016-11-10 14:49:05', '1', '522300', '3');
INSERT INTO `th_area` VALUES ('522329', '其它区', '2016-11-10 14:49:05', '1', '522300', '3');
INSERT INTO `th_area` VALUES ('522400', '毕节地区', '2016-11-10 14:49:05', '1', '520000', '2');
INSERT INTO `th_area` VALUES ('522401', '毕节市', '2016-11-10 14:49:05', '1', '522400', '3');
INSERT INTO `th_area` VALUES ('522422', '大方县', '2016-11-10 14:49:05', '1', '522400', '3');
INSERT INTO `th_area` VALUES ('522423', '黔西县', '2016-11-10 14:49:05', '1', '522400', '3');
INSERT INTO `th_area` VALUES ('522424', '金沙县', '2016-11-10 14:49:05', '1', '522400', '3');
INSERT INTO `th_area` VALUES ('522425', '织金县', '2016-11-10 14:49:05', '1', '522400', '3');
INSERT INTO `th_area` VALUES ('522426', '纳雍县', '2016-11-10 14:49:05', '1', '522400', '3');
INSERT INTO `th_area` VALUES ('522427', '威宁彝族回族苗族自治县', '2016-11-10 14:49:05', '1', '522400', '3');
INSERT INTO `th_area` VALUES ('522428', '赫章县', '2016-11-10 14:49:05', '1', '522400', '3');
INSERT INTO `th_area` VALUES ('522429', '其它区', '2016-11-10 14:49:05', '1', '522400', '3');
INSERT INTO `th_area` VALUES ('522600', '黔东南苗族侗族自治州', '2016-11-10 14:49:05', '1', '520000', '2');
INSERT INTO `th_area` VALUES ('522601', '凯里市', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522622', '黄平县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522623', '施秉县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522624', '三穗县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522625', '镇远县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522626', '岑巩县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522627', '天柱县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522628', '锦屏县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522629', '剑河县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522630', '台江县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522631', '黎平县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522632', '榕江县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522633', '从江县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522634', '雷山县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522635', '麻江县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522636', '丹寨县', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522637', '其它区', '2016-11-10 14:49:05', '1', '522600', '3');
INSERT INTO `th_area` VALUES ('522700', '黔南布依族苗族自治州', '2016-11-10 14:49:05', '1', '520000', '2');
INSERT INTO `th_area` VALUES ('522701', '都匀市', '2016-11-10 14:49:05', '1', '522700', '3');
INSERT INTO `th_area` VALUES ('522702', '福泉市', '2016-11-10 14:49:05', '1', '522700', '3');
INSERT INTO `th_area` VALUES ('522722', '荔波县', '2016-11-10 14:49:05', '1', '522700', '3');
INSERT INTO `th_area` VALUES ('522723', '贵定县', '2016-11-10 14:49:05', '1', '522700', '3');
INSERT INTO `th_area` VALUES ('522725', '瓮安县', '2016-11-10 14:49:05', '1', '522700', '3');
INSERT INTO `th_area` VALUES ('522726', '独山县', '2016-11-10 14:49:05', '1', '522700', '3');
INSERT INTO `th_area` VALUES ('522727', '平塘县', '2016-11-10 14:49:05', '1', '522700', '3');
INSERT INTO `th_area` VALUES ('522728', '罗甸县', '2016-11-10 14:49:05', '1', '522700', '3');
INSERT INTO `th_area` VALUES ('522729', '长顺县', '2016-11-10 14:49:05', '1', '522700', '3');
INSERT INTO `th_area` VALUES ('522730', '龙里县', '2016-11-10 14:49:05', '1', '522700', '3');
INSERT INTO `th_area` VALUES ('522731', '惠水县', '2016-11-10 14:49:05', '1', '522700', '3');
INSERT INTO `th_area` VALUES ('522732', '三都水族自治县', '2016-11-10 14:49:05', '1', '522700', '3');
INSERT INTO `th_area` VALUES ('522733', '其它区', '2016-11-10 14:49:05', '1', '522700', '3');
INSERT INTO `th_area` VALUES ('530000', '云南省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('530100', '昆明市', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('530102', '五华区', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530103', '盘龙区', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530111', '官渡区', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530112', '西山区', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530113', '东川区', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530121', '呈贡县', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530122', '晋宁县', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530124', '富民县', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530125', '宜良县', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530126', '石林彝族自治县', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530127', '嵩明县', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530128', '禄劝彝族苗族自治县', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530129', '寻甸回族彝族自治县', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530181', '安宁市', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530182', '其它区', '2016-11-10 14:49:05', '1', '530100', '3');
INSERT INTO `th_area` VALUES ('530300', '曲靖市', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('530302', '麒麟区', '2016-11-10 14:49:05', '1', '530300', '3');
INSERT INTO `th_area` VALUES ('530321', '马龙县', '2016-11-10 14:49:05', '1', '530300', '3');
INSERT INTO `th_area` VALUES ('530322', '陆良县', '2016-11-10 14:49:05', '1', '530300', '3');
INSERT INTO `th_area` VALUES ('530323', '师宗县', '2016-11-10 14:49:05', '1', '530300', '3');
INSERT INTO `th_area` VALUES ('530324', '罗平县', '2016-11-10 14:49:05', '1', '530300', '3');
INSERT INTO `th_area` VALUES ('530325', '富源县', '2016-11-10 14:49:05', '1', '530300', '3');
INSERT INTO `th_area` VALUES ('530326', '会泽县', '2016-11-10 14:49:05', '1', '530300', '3');
INSERT INTO `th_area` VALUES ('530328', '沾益县', '2016-11-10 14:49:05', '1', '530300', '3');
INSERT INTO `th_area` VALUES ('530381', '宣威市', '2016-11-10 14:49:05', '1', '530300', '3');
INSERT INTO `th_area` VALUES ('530382', '其它区', '2016-11-10 14:49:05', '1', '530300', '3');
INSERT INTO `th_area` VALUES ('530400', '玉溪市', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('530402', '红塔区', '2016-11-10 14:49:05', '1', '530400', '3');
INSERT INTO `th_area` VALUES ('530421', '江川县', '2016-11-10 14:49:05', '1', '530400', '3');
INSERT INTO `th_area` VALUES ('530422', '澄江县', '2016-11-10 14:49:05', '1', '530400', '3');
INSERT INTO `th_area` VALUES ('530423', '通海县', '2016-11-10 14:49:05', '1', '530400', '3');
INSERT INTO `th_area` VALUES ('530424', '华宁县', '2016-11-10 14:49:05', '1', '530400', '3');
INSERT INTO `th_area` VALUES ('530425', '易门县', '2016-11-10 14:49:05', '1', '530400', '3');
INSERT INTO `th_area` VALUES ('530426', '峨山彝族自治县', '2016-11-10 14:49:05', '1', '530400', '3');
INSERT INTO `th_area` VALUES ('530427', '新平彝族傣族自治县', '2016-11-10 14:49:05', '1', '530400', '3');
INSERT INTO `th_area` VALUES ('530428', '元江哈尼族彝族傣族自治县', '2016-11-10 14:49:05', '1', '530400', '3');
INSERT INTO `th_area` VALUES ('530429', '其它区', '2016-11-10 14:49:05', '1', '530400', '3');
INSERT INTO `th_area` VALUES ('530500', '保山市', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('530502', '隆阳区', '2016-11-10 14:49:05', '1', '530500', '3');
INSERT INTO `th_area` VALUES ('530521', '施甸县', '2016-11-10 14:49:05', '1', '530500', '3');
INSERT INTO `th_area` VALUES ('530522', '腾冲县', '2016-11-10 14:49:05', '1', '530500', '3');
INSERT INTO `th_area` VALUES ('530523', '龙陵县', '2016-11-10 14:49:05', '1', '530500', '3');
INSERT INTO `th_area` VALUES ('530524', '昌宁县', '2016-11-10 14:49:05', '1', '530500', '3');
INSERT INTO `th_area` VALUES ('530525', '其它区', '2016-11-10 14:49:05', '1', '530500', '3');
INSERT INTO `th_area` VALUES ('530600', '昭通市', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('530602', '昭阳区', '2016-11-10 14:49:05', '1', '530600', '3');
INSERT INTO `th_area` VALUES ('530621', '鲁甸县', '2016-11-10 14:49:05', '1', '530600', '3');
INSERT INTO `th_area` VALUES ('530622', '巧家县', '2016-11-10 14:49:05', '1', '530600', '3');
INSERT INTO `th_area` VALUES ('530623', '盐津县', '2016-11-10 14:49:05', '1', '530600', '3');
INSERT INTO `th_area` VALUES ('530624', '大关县', '2016-11-10 14:49:05', '1', '530600', '3');
INSERT INTO `th_area` VALUES ('530625', '永善县', '2016-11-10 14:49:05', '1', '530600', '3');
INSERT INTO `th_area` VALUES ('530626', '绥江县', '2016-11-10 14:49:05', '1', '530600', '3');
INSERT INTO `th_area` VALUES ('530627', '镇雄县', '2016-11-10 14:49:05', '1', '530600', '3');
INSERT INTO `th_area` VALUES ('530628', '彝良县', '2016-11-10 14:49:05', '1', '530600', '3');
INSERT INTO `th_area` VALUES ('530629', '威信县', '2016-11-10 14:49:05', '1', '530600', '3');
INSERT INTO `th_area` VALUES ('530630', '水富县', '2016-11-10 14:49:05', '1', '530600', '3');
INSERT INTO `th_area` VALUES ('530631', '其它区', '2016-11-10 14:49:05', '1', '530600', '3');
INSERT INTO `th_area` VALUES ('530700', '丽江市', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('530702', '古城区', '2016-11-10 14:49:05', '1', '530700', '3');
INSERT INTO `th_area` VALUES ('530721', '玉龙纳西族自治县', '2016-11-10 14:49:05', '1', '530700', '3');
INSERT INTO `th_area` VALUES ('530722', '永胜县', '2016-11-10 14:49:05', '1', '530700', '3');
INSERT INTO `th_area` VALUES ('530723', '华坪县', '2016-11-10 14:49:05', '1', '530700', '3');
INSERT INTO `th_area` VALUES ('530724', '宁蒗彝族自治县', '2016-11-10 14:49:05', '1', '530700', '3');
INSERT INTO `th_area` VALUES ('530725', '其它区', '2016-11-10 14:49:05', '1', '530700', '3');
INSERT INTO `th_area` VALUES ('530800', '普洱市', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('530802', '思茅区', '2016-11-10 14:49:05', '1', '530800', '3');
INSERT INTO `th_area` VALUES ('530821', '宁洱哈尼族彝族自治县', '2016-11-10 14:49:05', '1', '530800', '3');
INSERT INTO `th_area` VALUES ('530822', '墨江哈尼族自治县', '2016-11-10 14:49:05', '1', '530800', '3');
INSERT INTO `th_area` VALUES ('530823', '景东彝族自治县', '2016-11-10 14:49:05', '1', '530800', '3');
INSERT INTO `th_area` VALUES ('530824', '景谷傣族彝族自治县', '2016-11-10 14:49:05', '1', '530800', '3');
INSERT INTO `th_area` VALUES ('530825', '镇沅彝族哈尼族拉祜族自治县', '2016-11-10 14:49:05', '1', '530800', '3');
INSERT INTO `th_area` VALUES ('530826', '江城哈尼族彝族自治县', '2016-11-10 14:49:05', '1', '530800', '3');
INSERT INTO `th_area` VALUES ('530827', '孟连傣族拉祜族佤族自治县', '2016-11-10 14:49:05', '1', '530800', '3');
INSERT INTO `th_area` VALUES ('530828', '澜沧拉祜族自治县', '2016-11-10 14:49:05', '1', '530800', '3');
INSERT INTO `th_area` VALUES ('530829', '西盟佤族自治县', '2016-11-10 14:49:05', '1', '530800', '3');
INSERT INTO `th_area` VALUES ('530830', '其它区', '2016-11-10 14:49:05', '1', '530800', '3');
INSERT INTO `th_area` VALUES ('530900', '临沧市', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('530902', '临翔区', '2016-11-10 14:49:05', '1', '530900', '3');
INSERT INTO `th_area` VALUES ('530921', '凤庆县', '2016-11-10 14:49:05', '1', '530900', '3');
INSERT INTO `th_area` VALUES ('530922', '云县', '2016-11-10 14:49:05', '1', '530900', '3');
INSERT INTO `th_area` VALUES ('530923', '永德县', '2016-11-10 14:49:05', '1', '530900', '3');
INSERT INTO `th_area` VALUES ('530924', '镇康县', '2016-11-10 14:49:05', '1', '530900', '3');
INSERT INTO `th_area` VALUES ('530925', '双江拉祜族佤族布朗族傣族自治县', '2016-11-10 14:49:05', '1', '530900', '3');
INSERT INTO `th_area` VALUES ('530926', '耿马傣族佤族自治县', '2016-11-10 14:49:05', '1', '530900', '3');
INSERT INTO `th_area` VALUES ('530927', '沧源佤族自治县', '2016-11-10 14:49:05', '1', '530900', '3');
INSERT INTO `th_area` VALUES ('530928', '其它区', '2016-11-10 14:49:05', '1', '530900', '3');
INSERT INTO `th_area` VALUES ('532300', '楚雄彝族自治州', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('532301', '楚雄市', '2016-11-10 14:49:05', '1', '532300', '3');
INSERT INTO `th_area` VALUES ('532322', '双柏县', '2016-11-10 14:49:05', '1', '532300', '3');
INSERT INTO `th_area` VALUES ('532323', '牟定县', '2016-11-10 14:49:05', '1', '532300', '3');
INSERT INTO `th_area` VALUES ('532324', '南华县', '2016-11-10 14:49:05', '1', '532300', '3');
INSERT INTO `th_area` VALUES ('532325', '姚安县', '2016-11-10 14:49:05', '1', '532300', '3');
INSERT INTO `th_area` VALUES ('532326', '大姚县', '2016-11-10 14:49:05', '1', '532300', '3');
INSERT INTO `th_area` VALUES ('532327', '永仁县', '2016-11-10 14:49:05', '1', '532300', '3');
INSERT INTO `th_area` VALUES ('532328', '元谋县', '2016-11-10 14:49:05', '1', '532300', '3');
INSERT INTO `th_area` VALUES ('532329', '武定县', '2016-11-10 14:49:05', '1', '532300', '3');
INSERT INTO `th_area` VALUES ('532331', '禄丰县', '2016-11-10 14:49:05', '1', '532300', '3');
INSERT INTO `th_area` VALUES ('532332', '其它区', '2016-11-10 14:49:05', '1', '532300', '3');
INSERT INTO `th_area` VALUES ('532500', '红河哈尼族彝族自治州', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('532501', '个旧市', '2016-11-10 14:49:05', '1', '532500', '3');
INSERT INTO `th_area` VALUES ('532502', '开远市', '2016-11-10 14:49:05', '1', '532500', '3');
INSERT INTO `th_area` VALUES ('532522', '蒙自县', '2016-11-10 14:49:05', '1', '532500', '3');
INSERT INTO `th_area` VALUES ('532523', '屏边苗族自治县', '2016-11-10 14:49:05', '1', '532500', '3');
INSERT INTO `th_area` VALUES ('532524', '建水县', '2016-11-10 14:49:05', '1', '532500', '3');
INSERT INTO `th_area` VALUES ('532525', '石屏县', '2016-11-10 14:49:05', '1', '532500', '3');
INSERT INTO `th_area` VALUES ('532526', '弥勒县', '2016-11-10 14:49:05', '1', '532500', '3');
INSERT INTO `th_area` VALUES ('532527', '泸西县', '2016-11-10 14:49:05', '1', '532500', '3');
INSERT INTO `th_area` VALUES ('532528', '元阳县', '2016-11-10 14:49:05', '1', '532500', '3');
INSERT INTO `th_area` VALUES ('532529', '红河县', '2016-11-10 14:49:05', '1', '532500', '3');
INSERT INTO `th_area` VALUES ('532530', '金平苗族瑶族傣族自治县', '2016-11-10 14:49:05', '1', '532500', '3');
INSERT INTO `th_area` VALUES ('532531', '绿春县', '2016-11-10 14:49:05', '1', '532500', '3');
INSERT INTO `th_area` VALUES ('532532', '河口瑶族自治县', '2016-11-10 14:49:05', '1', '532500', '3');
INSERT INTO `th_area` VALUES ('532533', '其它区', '2016-11-10 14:49:05', '1', '532500', '3');
INSERT INTO `th_area` VALUES ('532600', '文山壮族苗族自治州', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('532621', '文山县', '2016-11-10 14:49:05', '1', '532600', '3');
INSERT INTO `th_area` VALUES ('532622', '砚山县', '2016-11-10 14:49:05', '1', '532600', '3');
INSERT INTO `th_area` VALUES ('532623', '西畴县', '2016-11-10 14:49:05', '1', '532600', '3');
INSERT INTO `th_area` VALUES ('532624', '麻栗坡县', '2016-11-10 14:49:05', '1', '532600', '3');
INSERT INTO `th_area` VALUES ('532625', '马关县', '2016-11-10 14:49:05', '1', '532600', '3');
INSERT INTO `th_area` VALUES ('532626', '丘北县', '2016-11-10 14:49:05', '1', '532600', '3');
INSERT INTO `th_area` VALUES ('532627', '广南县', '2016-11-10 14:49:05', '1', '532600', '3');
INSERT INTO `th_area` VALUES ('532628', '富宁县', '2016-11-10 14:49:05', '1', '532600', '3');
INSERT INTO `th_area` VALUES ('532629', '其它区', '2016-11-10 14:49:05', '1', '532600', '3');
INSERT INTO `th_area` VALUES ('532800', '西双版纳傣族自治州', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('532801', '景洪市', '2016-11-10 14:49:05', '1', '532800', '3');
INSERT INTO `th_area` VALUES ('532822', '勐海县', '2016-11-10 14:49:05', '1', '532800', '3');
INSERT INTO `th_area` VALUES ('532823', '勐腊县', '2016-11-10 14:49:05', '1', '532800', '3');
INSERT INTO `th_area` VALUES ('532824', '其它区', '2016-11-10 14:49:05', '1', '532800', '3');
INSERT INTO `th_area` VALUES ('532900', '大理白族自治州', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('532901', '大理市', '2016-11-10 14:49:05', '1', '532900', '3');
INSERT INTO `th_area` VALUES ('532922', '漾濞彝族自治县', '2016-11-10 14:49:05', '1', '532900', '3');
INSERT INTO `th_area` VALUES ('532923', '祥云县', '2016-11-10 14:49:05', '1', '532900', '3');
INSERT INTO `th_area` VALUES ('532924', '宾川县', '2016-11-10 14:49:05', '1', '532900', '3');
INSERT INTO `th_area` VALUES ('532925', '弥渡县', '2016-11-10 14:49:05', '1', '532900', '3');
INSERT INTO `th_area` VALUES ('532926', '南涧彝族自治县', '2016-11-10 14:49:05', '1', '532900', '3');
INSERT INTO `th_area` VALUES ('532927', '巍山彝族回族自治县', '2016-11-10 14:49:05', '1', '532900', '3');
INSERT INTO `th_area` VALUES ('532928', '永平县', '2016-11-10 14:49:05', '1', '532900', '3');
INSERT INTO `th_area` VALUES ('532929', '云龙县', '2016-11-10 14:49:05', '1', '532900', '3');
INSERT INTO `th_area` VALUES ('532930', '洱源县', '2016-11-10 14:49:05', '1', '532900', '3');
INSERT INTO `th_area` VALUES ('532931', '剑川县', '2016-11-10 14:49:05', '1', '532900', '3');
INSERT INTO `th_area` VALUES ('532932', '鹤庆县', '2016-11-10 14:49:05', '1', '532900', '3');
INSERT INTO `th_area` VALUES ('532933', '其它区', '2016-11-10 14:49:05', '1', '532900', '3');
INSERT INTO `th_area` VALUES ('533100', '德宏傣族景颇族自治州', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('533102', '瑞丽市', '2016-11-10 14:49:05', '1', '533100', '3');
INSERT INTO `th_area` VALUES ('533103', '潞西市', '2016-11-10 14:49:05', '1', '533100', '3');
INSERT INTO `th_area` VALUES ('533122', '梁河县', '2016-11-10 14:49:05', '1', '533100', '3');
INSERT INTO `th_area` VALUES ('533123', '盈江县', '2016-11-10 14:49:05', '1', '533100', '3');
INSERT INTO `th_area` VALUES ('533124', '陇川县', '2016-11-10 14:49:05', '1', '533100', '3');
INSERT INTO `th_area` VALUES ('533125', '其它区', '2016-11-10 14:49:05', '1', '533100', '3');
INSERT INTO `th_area` VALUES ('533300', '怒江傈僳族自治州', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('533321', '泸水县', '2016-11-10 14:49:05', '1', '533300', '3');
INSERT INTO `th_area` VALUES ('533323', '福贡县', '2016-11-10 14:49:05', '1', '533300', '3');
INSERT INTO `th_area` VALUES ('533324', '贡山独龙族怒族自治县', '2016-11-10 14:49:05', '1', '533300', '3');
INSERT INTO `th_area` VALUES ('533325', '兰坪白族普米族自治县', '2016-11-10 14:49:05', '1', '533300', '3');
INSERT INTO `th_area` VALUES ('533326', '其它区', '2016-11-10 14:49:05', '1', '533300', '3');
INSERT INTO `th_area` VALUES ('533400', '迪庆藏族自治州', '2016-11-10 14:49:05', '1', '530000', '2');
INSERT INTO `th_area` VALUES ('533421', '香格里拉县', '2016-11-10 14:49:05', '1', '533400', '3');
INSERT INTO `th_area` VALUES ('533422', '德钦县', '2016-11-10 14:49:05', '1', '533400', '3');
INSERT INTO `th_area` VALUES ('533423', '维西傈僳族自治县', '2016-11-10 14:49:05', '1', '533400', '3');
INSERT INTO `th_area` VALUES ('533424', '其它区', '2016-11-10 14:49:05', '1', '533400', '3');
INSERT INTO `th_area` VALUES ('540000', '西藏', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('540100', '拉萨市', '2016-11-10 14:49:05', '1', '540000', '2');
INSERT INTO `th_area` VALUES ('540102', '城关区', '2016-11-10 14:49:05', '1', '540100', '3');
INSERT INTO `th_area` VALUES ('540121', '林周县', '2016-11-10 14:49:05', '1', '540100', '3');
INSERT INTO `th_area` VALUES ('540122', '当雄县', '2016-11-10 14:49:05', '1', '540100', '3');
INSERT INTO `th_area` VALUES ('540123', '尼木县', '2016-11-10 14:49:05', '1', '540100', '3');
INSERT INTO `th_area` VALUES ('540124', '曲水县', '2016-11-10 14:49:05', '1', '540100', '3');
INSERT INTO `th_area` VALUES ('540125', '堆龙德庆县', '2016-11-10 14:49:05', '1', '540100', '3');
INSERT INTO `th_area` VALUES ('540126', '达孜县', '2016-11-10 14:49:05', '1', '540100', '3');
INSERT INTO `th_area` VALUES ('540127', '墨竹工卡县', '2016-11-10 14:49:05', '1', '540100', '3');
INSERT INTO `th_area` VALUES ('540128', '其它区', '2016-11-10 14:49:05', '1', '540100', '3');
INSERT INTO `th_area` VALUES ('542100', '昌都地区', '2016-11-10 14:49:05', '1', '540000', '2');
INSERT INTO `th_area` VALUES ('542121', '昌都县', '2016-11-10 14:49:05', '1', '542100', '3');
INSERT INTO `th_area` VALUES ('542122', '江达县', '2016-11-10 14:49:05', '1', '542100', '3');
INSERT INTO `th_area` VALUES ('542123', '贡觉县', '2016-11-10 14:49:05', '1', '542100', '3');
INSERT INTO `th_area` VALUES ('542124', '类乌齐县', '2016-11-10 14:49:05', '1', '542100', '3');
INSERT INTO `th_area` VALUES ('542125', '丁青县', '2016-11-10 14:49:05', '1', '542100', '3');
INSERT INTO `th_area` VALUES ('542126', '察雅县', '2016-11-10 14:49:05', '1', '542100', '3');
INSERT INTO `th_area` VALUES ('542127', '八宿县', '2016-11-10 14:49:05', '1', '542100', '3');
INSERT INTO `th_area` VALUES ('542128', '左贡县', '2016-11-10 14:49:05', '1', '542100', '3');
INSERT INTO `th_area` VALUES ('542129', '芒康县', '2016-11-10 14:49:05', '1', '542100', '3');
INSERT INTO `th_area` VALUES ('542132', '洛隆县', '2016-11-10 14:49:05', '1', '542100', '3');
INSERT INTO `th_area` VALUES ('542133', '边坝县', '2016-11-10 14:49:05', '1', '542100', '3');
INSERT INTO `th_area` VALUES ('542134', '其它区', '2016-11-10 14:49:05', '1', '542100', '3');
INSERT INTO `th_area` VALUES ('542200', '山南地区', '2016-11-10 14:49:05', '1', '540000', '2');
INSERT INTO `th_area` VALUES ('542221', '乃东县', '2016-11-10 14:49:05', '1', '542200', '3');
INSERT INTO `th_area` VALUES ('542222', '扎囊县', '2016-11-10 14:49:05', '1', '542200', '3');
INSERT INTO `th_area` VALUES ('542223', '贡嘎县', '2016-11-10 14:49:05', '1', '542200', '3');
INSERT INTO `th_area` VALUES ('542224', '桑日县', '2016-11-10 14:49:05', '1', '542200', '3');
INSERT INTO `th_area` VALUES ('542225', '琼结县', '2016-11-10 14:49:05', '1', '542200', '3');
INSERT INTO `th_area` VALUES ('542226', '曲松县', '2016-11-10 14:49:05', '1', '542200', '3');
INSERT INTO `th_area` VALUES ('542227', '措美县', '2016-11-10 14:49:05', '1', '542200', '3');
INSERT INTO `th_area` VALUES ('542228', '洛扎县', '2016-11-10 14:49:05', '1', '542200', '3');
INSERT INTO `th_area` VALUES ('542229', '加查县', '2016-11-10 14:49:05', '1', '542200', '3');
INSERT INTO `th_area` VALUES ('542231', '隆子县', '2016-11-10 14:49:05', '1', '542200', '3');
INSERT INTO `th_area` VALUES ('542232', '错那县', '2016-11-10 14:49:05', '1', '542200', '3');
INSERT INTO `th_area` VALUES ('542233', '浪卡子县', '2016-11-10 14:49:05', '1', '542200', '3');
INSERT INTO `th_area` VALUES ('542234', '其它区', '2016-11-10 14:49:05', '1', '542200', '3');
INSERT INTO `th_area` VALUES ('542300', '日喀则地区', '2016-11-10 14:49:05', '1', '540000', '2');
INSERT INTO `th_area` VALUES ('542301', '日喀则市', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542322', '南木林县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542323', '江孜县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542324', '定日县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542325', '萨迦县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542326', '拉孜县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542327', '昂仁县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542328', '谢通门县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542329', '白朗县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542330', '仁布县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542331', '康马县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542332', '定结县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542333', '仲巴县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542334', '亚东县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542335', '吉隆县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542336', '聂拉木县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542337', '萨嘎县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542338', '岗巴县', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542339', '其它区', '2016-11-10 14:49:05', '1', '542300', '3');
INSERT INTO `th_area` VALUES ('542400', '那曲地区', '2016-11-10 14:49:05', '1', '540000', '2');
INSERT INTO `th_area` VALUES ('542421', '那曲县', '2016-11-10 14:49:05', '1', '542400', '3');
INSERT INTO `th_area` VALUES ('542422', '嘉黎县', '2016-11-10 14:49:05', '1', '542400', '3');
INSERT INTO `th_area` VALUES ('542423', '比如县', '2016-11-10 14:49:05', '1', '542400', '3');
INSERT INTO `th_area` VALUES ('542424', '聂荣县', '2016-11-10 14:49:05', '1', '542400', '3');
INSERT INTO `th_area` VALUES ('542425', '安多县', '2016-11-10 14:49:05', '1', '542400', '3');
INSERT INTO `th_area` VALUES ('542426', '申扎县', '2016-11-10 14:49:05', '1', '542400', '3');
INSERT INTO `th_area` VALUES ('542427', '索县', '2016-11-10 14:49:05', '1', '542400', '3');
INSERT INTO `th_area` VALUES ('542428', '班戈县', '2016-11-10 14:49:05', '1', '542400', '3');
INSERT INTO `th_area` VALUES ('542429', '巴青县', '2016-11-10 14:49:05', '1', '542400', '3');
INSERT INTO `th_area` VALUES ('542430', '尼玛县', '2016-11-10 14:49:05', '1', '542400', '3');
INSERT INTO `th_area` VALUES ('542431', '其它区', '2016-11-10 14:49:05', '1', '542400', '3');
INSERT INTO `th_area` VALUES ('542500', '阿里地区', '2016-11-10 14:49:05', '1', '540000', '2');
INSERT INTO `th_area` VALUES ('542521', '普兰县', '2016-11-10 14:49:05', '1', '542500', '3');
INSERT INTO `th_area` VALUES ('542522', '札达县', '2016-11-10 14:49:05', '1', '542500', '3');
INSERT INTO `th_area` VALUES ('542523', '噶尔县', '2016-11-10 14:49:05', '1', '542500', '3');
INSERT INTO `th_area` VALUES ('542524', '日土县', '2016-11-10 14:49:05', '1', '542500', '3');
INSERT INTO `th_area` VALUES ('542525', '革吉县', '2016-11-10 14:49:05', '1', '542500', '3');
INSERT INTO `th_area` VALUES ('542526', '改则县', '2016-11-10 14:49:05', '1', '542500', '3');
INSERT INTO `th_area` VALUES ('542527', '措勤县', '2016-11-10 14:49:05', '1', '542500', '3');
INSERT INTO `th_area` VALUES ('542528', '其它区', '2016-11-10 14:49:05', '1', '542500', '3');
INSERT INTO `th_area` VALUES ('542600', '林芝地区', '2016-11-10 14:49:05', '1', '540000', '2');
INSERT INTO `th_area` VALUES ('542621', '林芝县', '2016-11-10 14:49:05', '1', '542600', '3');
INSERT INTO `th_area` VALUES ('542622', '工布江达县', '2016-11-10 14:49:05', '1', '542600', '3');
INSERT INTO `th_area` VALUES ('542623', '米林县', '2016-11-10 14:49:05', '1', '542600', '3');
INSERT INTO `th_area` VALUES ('542624', '墨脱县', '2016-11-10 14:49:05', '1', '542600', '3');
INSERT INTO `th_area` VALUES ('542625', '波密县', '2016-11-10 14:49:05', '1', '542600', '3');
INSERT INTO `th_area` VALUES ('542626', '察隅县', '2016-11-10 14:49:05', '1', '542600', '3');
INSERT INTO `th_area` VALUES ('542627', '朗县', '2016-11-10 14:49:05', '1', '542600', '3');
INSERT INTO `th_area` VALUES ('542628', '其它区', '2016-11-10 14:49:05', '1', '542600', '3');
INSERT INTO `th_area` VALUES ('610000', '陕西省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('610100', '西安市', '2016-11-10 14:49:05', '1', '610000', '2');
INSERT INTO `th_area` VALUES ('610102', '新城区', '2016-11-10 14:49:05', '1', '610100', '3');
INSERT INTO `th_area` VALUES ('610103', '碑林区', '2016-11-10 14:49:05', '1', '610100', '3');
INSERT INTO `th_area` VALUES ('610104', '莲湖区', '2016-11-10 14:49:05', '1', '610100', '3');
INSERT INTO `th_area` VALUES ('610111', '灞桥区', '2016-11-10 14:49:05', '1', '610100', '3');
INSERT INTO `th_area` VALUES ('610112', '未央区', '2016-11-10 14:49:05', '1', '610100', '3');
INSERT INTO `th_area` VALUES ('610113', '雁塔区', '2016-11-10 14:49:05', '1', '610100', '3');
INSERT INTO `th_area` VALUES ('610114', '阎良区', '2016-11-10 14:49:05', '1', '610100', '3');
INSERT INTO `th_area` VALUES ('610115', '临潼区', '2016-11-10 14:49:05', '1', '610100', '3');
INSERT INTO `th_area` VALUES ('610116', '长安区', '2016-11-10 14:49:05', '1', '610100', '3');
INSERT INTO `th_area` VALUES ('610122', '蓝田县', '2016-11-10 14:49:05', '1', '610100', '3');
INSERT INTO `th_area` VALUES ('610124', '周至县', '2016-11-10 14:49:05', '1', '610100', '3');
INSERT INTO `th_area` VALUES ('610125', '户县', '2016-11-10 14:49:05', '1', '610100', '3');
INSERT INTO `th_area` VALUES ('610126', '高陵县', '2016-11-10 14:49:05', '1', '610100', '3');
INSERT INTO `th_area` VALUES ('610127', '其它区', '2016-11-10 14:49:05', '1', '610100', '3');
INSERT INTO `th_area` VALUES ('610200', '铜川市', '2016-11-10 14:49:05', '1', '610000', '2');
INSERT INTO `th_area` VALUES ('610202', '王益区', '2016-11-10 14:49:05', '1', '610200', '3');
INSERT INTO `th_area` VALUES ('610203', '印台区', '2016-11-10 14:49:05', '1', '610200', '3');
INSERT INTO `th_area` VALUES ('610204', '耀州区', '2016-11-10 14:49:05', '1', '610200', '3');
INSERT INTO `th_area` VALUES ('610222', '宜君县', '2016-11-10 14:49:05', '1', '610200', '3');
INSERT INTO `th_area` VALUES ('610223', '其它区', '2016-11-10 14:49:05', '1', '610200', '3');
INSERT INTO `th_area` VALUES ('610300', '宝鸡市', '2016-11-10 14:49:05', '1', '610000', '2');
INSERT INTO `th_area` VALUES ('610302', '渭滨区', '2016-11-10 14:49:05', '1', '610300', '3');
INSERT INTO `th_area` VALUES ('610303', '金台区', '2016-11-10 14:49:05', '1', '610300', '3');
INSERT INTO `th_area` VALUES ('610304', '陈仓区', '2016-11-10 14:49:05', '1', '610300', '3');
INSERT INTO `th_area` VALUES ('610322', '凤翔县', '2016-11-10 14:49:05', '1', '610300', '3');
INSERT INTO `th_area` VALUES ('610323', '岐山县', '2016-11-10 14:49:05', '1', '610300', '3');
INSERT INTO `th_area` VALUES ('610324', '扶风县', '2016-11-10 14:49:05', '1', '610300', '3');
INSERT INTO `th_area` VALUES ('610326', '眉县', '2016-11-10 14:49:05', '1', '610300', '3');
INSERT INTO `th_area` VALUES ('610327', '陇县', '2016-11-10 14:49:05', '1', '610300', '3');
INSERT INTO `th_area` VALUES ('610328', '千阳县', '2016-11-10 14:49:05', '1', '610300', '3');
INSERT INTO `th_area` VALUES ('610329', '麟游县', '2016-11-10 14:49:05', '1', '610300', '3');
INSERT INTO `th_area` VALUES ('610330', '凤县', '2016-11-10 14:49:05', '1', '610300', '3');
INSERT INTO `th_area` VALUES ('610331', '太白县', '2016-11-10 14:49:05', '1', '610300', '3');
INSERT INTO `th_area` VALUES ('610332', '其它区', '2016-11-10 14:49:05', '1', '610300', '3');
INSERT INTO `th_area` VALUES ('610400', '咸阳市', '2016-11-10 14:49:05', '1', '610000', '2');
INSERT INTO `th_area` VALUES ('610402', '秦都区', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610403', '杨陵区', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610404', '渭城区', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610422', '三原县', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610423', '泾阳县', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610424', '乾县', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610425', '礼泉县', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610426', '永寿县', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610427', '彬县', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610428', '长武县', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610429', '旬邑县', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610430', '淳化县', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610431', '武功县', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610481', '兴平市', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610482', '其它区', '2016-11-10 14:49:05', '1', '610400', '3');
INSERT INTO `th_area` VALUES ('610500', '渭南市', '2016-11-10 14:49:05', '1', '610000', '2');
INSERT INTO `th_area` VALUES ('610502', '临渭区', '2016-11-10 14:49:05', '1', '610500', '3');
INSERT INTO `th_area` VALUES ('610521', '华县', '2016-11-10 14:49:05', '1', '610500', '3');
INSERT INTO `th_area` VALUES ('610522', '潼关县', '2016-11-10 14:49:05', '1', '610500', '3');
INSERT INTO `th_area` VALUES ('610523', '大荔县', '2016-11-10 14:49:05', '1', '610500', '3');
INSERT INTO `th_area` VALUES ('610524', '合阳县', '2016-11-10 14:49:05', '1', '610500', '3');
INSERT INTO `th_area` VALUES ('610525', '澄城县', '2016-11-10 14:49:05', '1', '610500', '3');
INSERT INTO `th_area` VALUES ('610526', '蒲城县', '2016-11-10 14:49:05', '1', '610500', '3');
INSERT INTO `th_area` VALUES ('610527', '白水县', '2016-11-10 14:49:05', '1', '610500', '3');
INSERT INTO `th_area` VALUES ('610528', '富平县', '2016-11-10 14:49:05', '1', '610500', '3');
INSERT INTO `th_area` VALUES ('610581', '韩城市', '2016-11-10 14:49:05', '1', '610500', '3');
INSERT INTO `th_area` VALUES ('610582', '华阴市', '2016-11-10 14:49:05', '1', '610500', '3');
INSERT INTO `th_area` VALUES ('610583', '其它区', '2016-11-10 14:49:05', '1', '610500', '3');
INSERT INTO `th_area` VALUES ('610600', '延安市', '2016-11-10 14:49:05', '1', '610000', '2');
INSERT INTO `th_area` VALUES ('610602', '宝塔区', '2016-11-10 14:49:05', '1', '610600', '3');
INSERT INTO `th_area` VALUES ('610621', '延长县', '2016-11-10 14:49:05', '1', '610600', '3');
INSERT INTO `th_area` VALUES ('610622', '延川县', '2016-11-10 14:49:05', '1', '610600', '3');
INSERT INTO `th_area` VALUES ('610623', '子长县', '2016-11-10 14:49:05', '1', '610600', '3');
INSERT INTO `th_area` VALUES ('610624', '安塞县', '2016-11-10 14:49:05', '1', '610600', '3');
INSERT INTO `th_area` VALUES ('610625', '志丹县', '2016-11-10 14:49:05', '1', '610600', '3');
INSERT INTO `th_area` VALUES ('610626', '吴起县', '2016-11-10 14:49:05', '1', '610600', '3');
INSERT INTO `th_area` VALUES ('610627', '甘泉县', '2016-11-10 14:49:05', '1', '610600', '3');
INSERT INTO `th_area` VALUES ('610628', '富县', '2016-11-10 14:49:05', '1', '610600', '3');
INSERT INTO `th_area` VALUES ('610629', '洛川县', '2016-11-10 14:49:05', '1', '610600', '3');
INSERT INTO `th_area` VALUES ('610630', '宜川县', '2016-11-10 14:49:05', '1', '610600', '3');
INSERT INTO `th_area` VALUES ('610631', '黄龙县', '2016-11-10 14:49:05', '1', '610600', '3');
INSERT INTO `th_area` VALUES ('610632', '黄陵县', '2016-11-10 14:49:05', '1', '610600', '3');
INSERT INTO `th_area` VALUES ('610633', '其它区', '2016-11-10 14:49:05', '1', '610600', '3');
INSERT INTO `th_area` VALUES ('610700', '汉中市', '2016-11-10 14:49:05', '1', '610000', '2');
INSERT INTO `th_area` VALUES ('610702', '汉台区', '2016-11-10 14:49:05', '1', '610700', '3');
INSERT INTO `th_area` VALUES ('610721', '南郑县', '2016-11-10 14:49:05', '1', '610700', '3');
INSERT INTO `th_area` VALUES ('610722', '城固县', '2016-11-10 14:49:05', '1', '610700', '3');
INSERT INTO `th_area` VALUES ('610723', '洋县', '2016-11-10 14:49:05', '1', '610700', '3');
INSERT INTO `th_area` VALUES ('610724', '西乡县', '2016-11-10 14:49:05', '1', '610700', '3');
INSERT INTO `th_area` VALUES ('610725', '勉县', '2016-11-10 14:49:05', '1', '610700', '3');
INSERT INTO `th_area` VALUES ('610726', '宁强县', '2016-11-10 14:49:05', '1', '610700', '3');
INSERT INTO `th_area` VALUES ('610727', '略阳县', '2016-11-10 14:49:05', '1', '610700', '3');
INSERT INTO `th_area` VALUES ('610728', '镇巴县', '2016-11-10 14:49:05', '1', '610700', '3');
INSERT INTO `th_area` VALUES ('610729', '留坝县', '2016-11-10 14:49:05', '1', '610700', '3');
INSERT INTO `th_area` VALUES ('610730', '佛坪县', '2016-11-10 14:49:05', '1', '610700', '3');
INSERT INTO `th_area` VALUES ('610731', '其它区', '2016-11-10 14:49:05', '1', '610700', '3');
INSERT INTO `th_area` VALUES ('610800', '榆林市', '2016-11-10 14:49:05', '1', '610000', '2');
INSERT INTO `th_area` VALUES ('610802', '榆阳区', '2016-11-10 14:49:05', '1', '610800', '3');
INSERT INTO `th_area` VALUES ('610821', '神木县', '2016-11-10 14:49:05', '1', '610800', '3');
INSERT INTO `th_area` VALUES ('610822', '府谷县', '2016-11-10 14:49:05', '1', '610800', '3');
INSERT INTO `th_area` VALUES ('610823', '横山县', '2016-11-10 14:49:05', '1', '610800', '3');
INSERT INTO `th_area` VALUES ('610824', '靖边县', '2016-11-10 14:49:05', '1', '610800', '3');
INSERT INTO `th_area` VALUES ('610825', '定边县', '2016-11-10 14:49:05', '1', '610800', '3');
INSERT INTO `th_area` VALUES ('610826', '绥德县', '2016-11-10 14:49:05', '1', '610800', '3');
INSERT INTO `th_area` VALUES ('610827', '米脂县', '2016-11-10 14:49:05', '1', '610800', '3');
INSERT INTO `th_area` VALUES ('610828', '佳县', '2016-11-10 14:49:05', '1', '610800', '3');
INSERT INTO `th_area` VALUES ('610829', '吴堡县', '2016-11-10 14:49:05', '1', '610800', '3');
INSERT INTO `th_area` VALUES ('610830', '清涧县', '2016-11-10 14:49:05', '1', '610800', '3');
INSERT INTO `th_area` VALUES ('610831', '子洲县', '2016-11-10 14:49:05', '1', '610800', '3');
INSERT INTO `th_area` VALUES ('610832', '其它区', '2016-11-10 14:49:05', '1', '610800', '3');
INSERT INTO `th_area` VALUES ('610900', '安康市', '2016-11-10 14:49:05', '1', '610000', '2');
INSERT INTO `th_area` VALUES ('610902', '汉滨区', '2016-11-10 14:49:05', '1', '610900', '3');
INSERT INTO `th_area` VALUES ('610921', '汉阴县', '2016-11-10 14:49:05', '1', '610900', '3');
INSERT INTO `th_area` VALUES ('610922', '石泉县', '2016-11-10 14:49:05', '1', '610900', '3');
INSERT INTO `th_area` VALUES ('610923', '宁陕县', '2016-11-10 14:49:05', '1', '610900', '3');
INSERT INTO `th_area` VALUES ('610924', '紫阳县', '2016-11-10 14:49:05', '1', '610900', '3');
INSERT INTO `th_area` VALUES ('610925', '岚皋县', '2016-11-10 14:49:05', '1', '610900', '3');
INSERT INTO `th_area` VALUES ('610926', '平利县', '2016-11-10 14:49:05', '1', '610900', '3');
INSERT INTO `th_area` VALUES ('610927', '镇坪县', '2016-11-10 14:49:05', '1', '610900', '3');
INSERT INTO `th_area` VALUES ('610928', '旬阳县', '2016-11-10 14:49:05', '1', '610900', '3');
INSERT INTO `th_area` VALUES ('610929', '白河县', '2016-11-10 14:49:05', '1', '610900', '3');
INSERT INTO `th_area` VALUES ('610930', '其它区', '2016-11-10 14:49:05', '1', '610900', '3');
INSERT INTO `th_area` VALUES ('611000', '商洛市', '2016-11-10 14:49:05', '1', '610000', '2');
INSERT INTO `th_area` VALUES ('611002', '商州区', '2016-11-10 14:49:05', '1', '611000', '3');
INSERT INTO `th_area` VALUES ('611021', '洛南县', '2016-11-10 14:49:05', '1', '611000', '3');
INSERT INTO `th_area` VALUES ('611022', '丹凤县', '2016-11-10 14:49:05', '1', '611000', '3');
INSERT INTO `th_area` VALUES ('611023', '商南县', '2016-11-10 14:49:05', '1', '611000', '3');
INSERT INTO `th_area` VALUES ('611024', '山阳县', '2016-11-10 14:49:05', '1', '611000', '3');
INSERT INTO `th_area` VALUES ('611025', '镇安县', '2016-11-10 14:49:05', '1', '611000', '3');
INSERT INTO `th_area` VALUES ('611026', '柞水县', '2016-11-10 14:49:05', '1', '611000', '3');
INSERT INTO `th_area` VALUES ('611027', '其它区', '2016-11-10 14:49:05', '1', '611000', '3');
INSERT INTO `th_area` VALUES ('620000', '甘肃省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('620100', '兰州市', '2016-11-10 14:49:05', '1', '620000', '2');
INSERT INTO `th_area` VALUES ('620102', '城关区', '2016-11-10 14:49:05', '1', '620100', '3');
INSERT INTO `th_area` VALUES ('620103', '七里河区', '2016-11-10 14:49:05', '1', '620100', '3');
INSERT INTO `th_area` VALUES ('620104', '西固区', '2016-11-10 14:49:05', '1', '620100', '3');
INSERT INTO `th_area` VALUES ('620105', '安宁区', '2016-11-10 14:49:05', '1', '620100', '3');
INSERT INTO `th_area` VALUES ('620111', '红古区', '2016-11-10 14:49:05', '1', '620100', '3');
INSERT INTO `th_area` VALUES ('620121', '永登县', '2016-11-10 14:49:05', '1', '620100', '3');
INSERT INTO `th_area` VALUES ('620122', '皋兰县', '2016-11-10 14:49:05', '1', '620100', '3');
INSERT INTO `th_area` VALUES ('620123', '榆中县', '2016-11-10 14:49:05', '1', '620100', '3');
INSERT INTO `th_area` VALUES ('620124', '其它区', '2016-11-10 14:49:05', '1', '620100', '3');
INSERT INTO `th_area` VALUES ('620200', '嘉峪关市', '2016-11-10 14:49:05', '1', '620000', '2');
INSERT INTO `th_area` VALUES ('620202', '金川区', '2016-11-10 14:49:05', '1', '620200', '3');
INSERT INTO `th_area` VALUES ('620221', '永昌县', '2016-11-10 14:49:05', '1', '620200', '3');
INSERT INTO `th_area` VALUES ('620222', '其它区', '2016-11-10 14:49:05', '1', '620200', '3');
INSERT INTO `th_area` VALUES ('620300', '金昌市', '2016-11-10 14:49:05', '1', '620000', '2');
INSERT INTO `th_area` VALUES ('620302', '金川区', '2016-11-10 14:49:05', '1', '620300', '3');
INSERT INTO `th_area` VALUES ('620321', '永昌县', '2016-11-10 14:49:05', '1', '620300', '3');
INSERT INTO `th_area` VALUES ('620322', '其它区', '2016-11-10 14:49:05', '1', '620300', '3');
INSERT INTO `th_area` VALUES ('620400', '白银市', '2016-11-10 14:49:05', '1', '620000', '2');
INSERT INTO `th_area` VALUES ('620402', '白银区', '2016-11-10 14:49:05', '1', '620400', '3');
INSERT INTO `th_area` VALUES ('620403', '平川区', '2016-11-10 14:49:05', '1', '620400', '3');
INSERT INTO `th_area` VALUES ('620421', '靖远县', '2016-11-10 14:49:05', '1', '620400', '3');
INSERT INTO `th_area` VALUES ('620422', '会宁县', '2016-11-10 14:49:05', '1', '620400', '3');
INSERT INTO `th_area` VALUES ('620423', '景泰县', '2016-11-10 14:49:05', '1', '620400', '3');
INSERT INTO `th_area` VALUES ('620424', '其它区', '2016-11-10 14:49:05', '1', '620400', '3');
INSERT INTO `th_area` VALUES ('620500', '天水市', '2016-11-10 14:49:05', '1', '620000', '2');
INSERT INTO `th_area` VALUES ('620502', '秦州区', '2016-11-10 14:49:05', '1', '620500', '3');
INSERT INTO `th_area` VALUES ('620503', '麦积区', '2016-11-10 14:49:05', '1', '620500', '3');
INSERT INTO `th_area` VALUES ('620521', '清水县', '2016-11-10 14:49:05', '1', '620500', '3');
INSERT INTO `th_area` VALUES ('620522', '秦安县', '2016-11-10 14:49:05', '1', '620500', '3');
INSERT INTO `th_area` VALUES ('620523', '甘谷县', '2016-11-10 14:49:05', '1', '620500', '3');
INSERT INTO `th_area` VALUES ('620524', '武山县', '2016-11-10 14:49:05', '1', '620500', '3');
INSERT INTO `th_area` VALUES ('620525', '张家川回族自治县', '2016-11-10 14:49:05', '1', '620500', '3');
INSERT INTO `th_area` VALUES ('620526', '其它区', '2016-11-10 14:49:05', '1', '620500', '3');
INSERT INTO `th_area` VALUES ('620600', '武威市', '2016-11-10 14:49:05', '1', '620000', '2');
INSERT INTO `th_area` VALUES ('620602', '凉州区', '2016-11-10 14:49:05', '1', '620600', '3');
INSERT INTO `th_area` VALUES ('620621', '民勤县', '2016-11-10 14:49:05', '1', '620600', '3');
INSERT INTO `th_area` VALUES ('620622', '古浪县', '2016-11-10 14:49:05', '1', '620600', '3');
INSERT INTO `th_area` VALUES ('620623', '天祝藏族自治县', '2016-11-10 14:49:05', '1', '620600', '3');
INSERT INTO `th_area` VALUES ('620624', '其它区', '2016-11-10 14:49:05', '1', '620600', '3');
INSERT INTO `th_area` VALUES ('620700', '张掖市', '2016-11-10 14:49:05', '1', '620000', '2');
INSERT INTO `th_area` VALUES ('620702', '甘州区', '2016-11-10 14:49:05', '1', '620700', '3');
INSERT INTO `th_area` VALUES ('620721', '肃南裕固族自治县', '2016-11-10 14:49:05', '1', '620700', '3');
INSERT INTO `th_area` VALUES ('620722', '民乐县', '2016-11-10 14:49:05', '1', '620700', '3');
INSERT INTO `th_area` VALUES ('620723', '临泽县', '2016-11-10 14:49:05', '1', '620700', '3');
INSERT INTO `th_area` VALUES ('620724', '高台县', '2016-11-10 14:49:05', '1', '620700', '3');
INSERT INTO `th_area` VALUES ('620725', '山丹县', '2016-11-10 14:49:05', '1', '620700', '3');
INSERT INTO `th_area` VALUES ('620726', '其它区', '2016-11-10 14:49:05', '1', '620700', '3');
INSERT INTO `th_area` VALUES ('620800', '平凉市', '2016-11-10 14:49:05', '1', '620000', '2');
INSERT INTO `th_area` VALUES ('620802', '崆峒区', '2016-11-10 14:49:05', '1', '620800', '3');
INSERT INTO `th_area` VALUES ('620821', '泾川县', '2016-11-10 14:49:05', '1', '620800', '3');
INSERT INTO `th_area` VALUES ('620822', '灵台县', '2016-11-10 14:49:05', '1', '620800', '3');
INSERT INTO `th_area` VALUES ('620823', '崇信县', '2016-11-10 14:49:05', '1', '620800', '3');
INSERT INTO `th_area` VALUES ('620824', '华亭县', '2016-11-10 14:49:05', '1', '620800', '3');
INSERT INTO `th_area` VALUES ('620825', '庄浪县', '2016-11-10 14:49:05', '1', '620800', '3');
INSERT INTO `th_area` VALUES ('620826', '静宁县', '2016-11-10 14:49:05', '1', '620800', '3');
INSERT INTO `th_area` VALUES ('620827', '其它区', '2016-11-10 14:49:05', '1', '620800', '3');
INSERT INTO `th_area` VALUES ('620900', '酒泉市', '2016-11-10 14:49:05', '1', '620000', '2');
INSERT INTO `th_area` VALUES ('620902', '肃州区', '2016-11-10 14:49:05', '1', '620900', '3');
INSERT INTO `th_area` VALUES ('620921', '金塔县', '2016-11-10 14:49:05', '1', '620900', '3');
INSERT INTO `th_area` VALUES ('620922', '安西县', '2016-11-10 14:49:05', '1', '620900', '3');
INSERT INTO `th_area` VALUES ('620923', '肃北蒙古族自治县', '2016-11-10 14:49:05', '1', '620900', '3');
INSERT INTO `th_area` VALUES ('620924', '阿克塞哈萨克族自治县', '2016-11-10 14:49:05', '1', '620900', '3');
INSERT INTO `th_area` VALUES ('620981', '玉门市', '2016-11-10 14:49:05', '1', '620900', '3');
INSERT INTO `th_area` VALUES ('620982', '敦煌市', '2016-11-10 14:49:05', '1', '620900', '3');
INSERT INTO `th_area` VALUES ('620983', '其它区', '2016-11-10 14:49:05', '1', '620900', '3');
INSERT INTO `th_area` VALUES ('621000', '庆阳市', '2016-11-10 14:49:05', '1', '620000', '2');
INSERT INTO `th_area` VALUES ('621002', '西峰区', '2016-11-10 14:49:05', '1', '621000', '3');
INSERT INTO `th_area` VALUES ('621021', '庆城县', '2016-11-10 14:49:05', '1', '621000', '3');
INSERT INTO `th_area` VALUES ('621022', '环县', '2016-11-10 14:49:05', '1', '621000', '3');
INSERT INTO `th_area` VALUES ('621023', '华池县', '2016-11-10 14:49:05', '1', '621000', '3');
INSERT INTO `th_area` VALUES ('621024', '合水县', '2016-11-10 14:49:05', '1', '621000', '3');
INSERT INTO `th_area` VALUES ('621025', '正宁县', '2016-11-10 14:49:05', '1', '621000', '3');
INSERT INTO `th_area` VALUES ('621026', '宁县', '2016-11-10 14:49:05', '1', '621000', '3');
INSERT INTO `th_area` VALUES ('621027', '镇原县', '2016-11-10 14:49:05', '1', '621000', '3');
INSERT INTO `th_area` VALUES ('621028', '其它区', '2016-11-10 14:49:05', '1', '621000', '3');
INSERT INTO `th_area` VALUES ('621100', '定西市', '2016-11-10 14:49:05', '1', '620000', '2');
INSERT INTO `th_area` VALUES ('621102', '安定区', '2016-11-10 14:49:05', '1', '621100', '3');
INSERT INTO `th_area` VALUES ('621121', '通渭县', '2016-11-10 14:49:05', '1', '621100', '3');
INSERT INTO `th_area` VALUES ('621122', '陇西县', '2016-11-10 14:49:05', '1', '621100', '3');
INSERT INTO `th_area` VALUES ('621123', '渭源县', '2016-11-10 14:49:05', '1', '621100', '3');
INSERT INTO `th_area` VALUES ('621124', '临洮县', '2016-11-10 14:49:05', '1', '621100', '3');
INSERT INTO `th_area` VALUES ('621125', '漳县', '2016-11-10 14:49:05', '1', '621100', '3');
INSERT INTO `th_area` VALUES ('621126', '岷县', '2016-11-10 14:49:05', '1', '621100', '3');
INSERT INTO `th_area` VALUES ('621127', '其它区', '2016-11-10 14:49:05', '1', '621100', '3');
INSERT INTO `th_area` VALUES ('621200', '陇南市', '2016-11-10 14:49:05', '1', '620000', '2');
INSERT INTO `th_area` VALUES ('621202', '武都区', '2016-11-10 14:49:05', '1', '621200', '3');
INSERT INTO `th_area` VALUES ('621221', '成县', '2016-11-10 14:49:05', '1', '621200', '3');
INSERT INTO `th_area` VALUES ('621222', '文县', '2016-11-10 14:49:05', '1', '621200', '3');
INSERT INTO `th_area` VALUES ('621223', '宕昌县', '2016-11-10 14:49:05', '1', '621200', '3');
INSERT INTO `th_area` VALUES ('621224', '康县', '2016-11-10 14:49:05', '1', '621200', '3');
INSERT INTO `th_area` VALUES ('621225', '西和县', '2016-11-10 14:49:05', '1', '621200', '3');
INSERT INTO `th_area` VALUES ('621226', '礼县', '2016-11-10 14:49:05', '1', '621200', '3');
INSERT INTO `th_area` VALUES ('621227', '徽县', '2016-11-10 14:49:05', '1', '621200', '3');
INSERT INTO `th_area` VALUES ('621228', '两当县', '2016-11-10 14:49:05', '1', '621200', '3');
INSERT INTO `th_area` VALUES ('621229', '其它区', '2016-11-10 14:49:05', '1', '621200', '3');
INSERT INTO `th_area` VALUES ('622900', '临夏回族自治州', '2016-11-10 14:49:05', '1', '620000', '2');
INSERT INTO `th_area` VALUES ('622901', '临夏市', '2016-11-10 14:49:05', '1', '622900', '3');
INSERT INTO `th_area` VALUES ('622921', '临夏县', '2016-11-10 14:49:05', '1', '622900', '3');
INSERT INTO `th_area` VALUES ('622922', '康乐县', '2016-11-10 14:49:05', '1', '622900', '3');
INSERT INTO `th_area` VALUES ('622923', '永靖县', '2016-11-10 14:49:05', '1', '622900', '3');
INSERT INTO `th_area` VALUES ('622924', '广河县', '2016-11-10 14:49:05', '1', '622900', '3');
INSERT INTO `th_area` VALUES ('622925', '和政县', '2016-11-10 14:49:05', '1', '622900', '3');
INSERT INTO `th_area` VALUES ('622926', '东乡族自治县', '2016-11-10 14:49:05', '1', '622900', '3');
INSERT INTO `th_area` VALUES ('622927', '积石山保安族东乡族撒拉族自治县', '2016-11-10 14:49:05', '1', '622900', '3');
INSERT INTO `th_area` VALUES ('622928', '其它区', '2016-11-10 14:49:05', '1', '622900', '3');
INSERT INTO `th_area` VALUES ('623000', '甘南藏族自治州', '2016-11-10 14:49:05', '1', '620000', '2');
INSERT INTO `th_area` VALUES ('623001', '合作市', '2016-11-10 14:49:05', '1', '623000', '3');
INSERT INTO `th_area` VALUES ('623021', '临潭县', '2016-11-10 14:49:05', '1', '623000', '3');
INSERT INTO `th_area` VALUES ('623022', '卓尼县', '2016-11-10 14:49:05', '1', '623000', '3');
INSERT INTO `th_area` VALUES ('623023', '舟曲县', '2016-11-10 14:49:05', '1', '623000', '3');
INSERT INTO `th_area` VALUES ('623024', '迭部县', '2016-11-10 14:49:05', '1', '623000', '3');
INSERT INTO `th_area` VALUES ('623025', '玛曲县', '2016-11-10 14:49:05', '1', '623000', '3');
INSERT INTO `th_area` VALUES ('623026', '碌曲县', '2016-11-10 14:49:05', '1', '623000', '3');
INSERT INTO `th_area` VALUES ('623027', '夏河县', '2016-11-10 14:49:05', '1', '623000', '3');
INSERT INTO `th_area` VALUES ('623028', '其它区', '2016-11-10 14:49:05', '1', '623000', '3');
INSERT INTO `th_area` VALUES ('630000', '青海省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('630100', '西宁市', '2016-11-10 14:49:05', '1', '630000', '2');
INSERT INTO `th_area` VALUES ('630102', '城东区', '2016-11-10 14:49:05', '1', '630100', '3');
INSERT INTO `th_area` VALUES ('630103', '城中区', '2016-11-10 14:49:05', '1', '630100', '3');
INSERT INTO `th_area` VALUES ('630104', '城西区', '2016-11-10 14:49:05', '1', '630100', '3');
INSERT INTO `th_area` VALUES ('630105', '城北区', '2016-11-10 14:49:05', '1', '630100', '3');
INSERT INTO `th_area` VALUES ('630121', '大通回族土族自治县', '2016-11-10 14:49:05', '1', '630100', '3');
INSERT INTO `th_area` VALUES ('630122', '湟中县', '2016-11-10 14:49:05', '1', '630100', '3');
INSERT INTO `th_area` VALUES ('630123', '湟源县', '2016-11-10 14:49:05', '1', '630100', '3');
INSERT INTO `th_area` VALUES ('630124', '其它区', '2016-11-10 14:49:05', '1', '630100', '3');
INSERT INTO `th_area` VALUES ('632100', '海东地区', '2016-11-10 14:49:05', '1', '630000', '2');
INSERT INTO `th_area` VALUES ('632121', '平安县', '2016-11-10 14:49:05', '1', '632100', '3');
INSERT INTO `th_area` VALUES ('632122', '民和回族土族自治县', '2016-11-10 14:49:05', '1', '632100', '3');
INSERT INTO `th_area` VALUES ('632123', '乐都县', '2016-11-10 14:49:05', '1', '632100', '3');
INSERT INTO `th_area` VALUES ('632126', '互助土族自治县', '2016-11-10 14:49:05', '1', '632100', '3');
INSERT INTO `th_area` VALUES ('632127', '化隆回族自治县', '2016-11-10 14:49:05', '1', '632100', '3');
INSERT INTO `th_area` VALUES ('632128', '循化撒拉族自治县', '2016-11-10 14:49:05', '1', '632100', '3');
INSERT INTO `th_area` VALUES ('632129', '其它区', '2016-11-10 14:49:05', '1', '632100', '3');
INSERT INTO `th_area` VALUES ('632200', '海北藏族自治州', '2016-11-10 14:49:05', '1', '630000', '2');
INSERT INTO `th_area` VALUES ('632221', '门源回族自治县', '2016-11-10 14:49:05', '1', '632200', '3');
INSERT INTO `th_area` VALUES ('632222', '祁连县', '2016-11-10 14:49:05', '1', '632200', '3');
INSERT INTO `th_area` VALUES ('632223', '海晏县', '2016-11-10 14:49:05', '1', '632200', '3');
INSERT INTO `th_area` VALUES ('632224', '刚察县', '2016-11-10 14:49:05', '1', '632200', '3');
INSERT INTO `th_area` VALUES ('632225', '其它区', '2016-11-10 14:49:05', '1', '632200', '3');
INSERT INTO `th_area` VALUES ('632300', '黄南藏族自治州', '2016-11-10 14:49:05', '1', '630000', '2');
INSERT INTO `th_area` VALUES ('632321', '同仁县', '2016-11-10 14:49:05', '1', '632300', '3');
INSERT INTO `th_area` VALUES ('632322', '尖扎县', '2016-11-10 14:49:05', '1', '632300', '3');
INSERT INTO `th_area` VALUES ('632323', '泽库县', '2016-11-10 14:49:05', '1', '632300', '3');
INSERT INTO `th_area` VALUES ('632324', '河南蒙古族自治县', '2016-11-10 14:49:05', '1', '632300', '3');
INSERT INTO `th_area` VALUES ('632325', '其它区', '2016-11-10 14:49:05', '1', '632300', '3');
INSERT INTO `th_area` VALUES ('632500', '海南藏族自治州', '2016-11-10 14:49:05', '1', '630000', '2');
INSERT INTO `th_area` VALUES ('632521', '共和县', '2016-11-10 14:49:05', '1', '632500', '3');
INSERT INTO `th_area` VALUES ('632522', '同德县', '2016-11-10 14:49:05', '1', '632500', '3');
INSERT INTO `th_area` VALUES ('632523', '贵德县', '2016-11-10 14:49:05', '1', '632500', '3');
INSERT INTO `th_area` VALUES ('632524', '兴海县', '2016-11-10 14:49:05', '1', '632500', '3');
INSERT INTO `th_area` VALUES ('632525', '贵南县', '2016-11-10 14:49:05', '1', '632500', '3');
INSERT INTO `th_area` VALUES ('632526', '其它区', '2016-11-10 14:49:05', '1', '632500', '3');
INSERT INTO `th_area` VALUES ('632600', '果洛藏族自治州', '2016-11-10 14:49:05', '1', '630000', '2');
INSERT INTO `th_area` VALUES ('632621', '玛沁县', '2016-11-10 14:49:05', '1', '632600', '3');
INSERT INTO `th_area` VALUES ('632622', '班玛县', '2016-11-10 14:49:05', '1', '632600', '3');
INSERT INTO `th_area` VALUES ('632623', '甘德县', '2016-11-10 14:49:05', '1', '632600', '3');
INSERT INTO `th_area` VALUES ('632624', '达日县', '2016-11-10 14:49:05', '1', '632600', '3');
INSERT INTO `th_area` VALUES ('632625', '久治县', '2016-11-10 14:49:05', '1', '632600', '3');
INSERT INTO `th_area` VALUES ('632626', '玛多县', '2016-11-10 14:49:05', '1', '632600', '3');
INSERT INTO `th_area` VALUES ('632627', '其它区', '2016-11-10 14:49:05', '1', '632600', '3');
INSERT INTO `th_area` VALUES ('632700', '玉树藏族自治州', '2016-11-10 14:49:05', '1', '630000', '2');
INSERT INTO `th_area` VALUES ('632721', '玉树县', '2016-11-10 14:49:05', '1', '632700', '3');
INSERT INTO `th_area` VALUES ('632722', '杂多县', '2016-11-10 14:49:05', '1', '632700', '3');
INSERT INTO `th_area` VALUES ('632723', '称多县', '2016-11-10 14:49:05', '1', '632700', '3');
INSERT INTO `th_area` VALUES ('632724', '治多县', '2016-11-10 14:49:05', '1', '632700', '3');
INSERT INTO `th_area` VALUES ('632725', '囊谦县', '2016-11-10 14:49:05', '1', '632700', '3');
INSERT INTO `th_area` VALUES ('632726', '曲麻莱县', '2016-11-10 14:49:05', '1', '632700', '3');
INSERT INTO `th_area` VALUES ('632727', '其它区', '2016-11-10 14:49:05', '1', '632700', '3');
INSERT INTO `th_area` VALUES ('632800', '海西蒙古族藏族自治州', '2016-11-10 14:49:05', '1', '630000', '2');
INSERT INTO `th_area` VALUES ('632801', '格尔木市', '2016-11-10 14:49:05', '1', '632800', '3');
INSERT INTO `th_area` VALUES ('632802', '德令哈市', '2016-11-10 14:49:05', '1', '632800', '3');
INSERT INTO `th_area` VALUES ('632821', '乌兰县', '2016-11-10 14:49:05', '1', '632800', '3');
INSERT INTO `th_area` VALUES ('632822', '都兰县', '2016-11-10 14:49:05', '1', '632800', '3');
INSERT INTO `th_area` VALUES ('632823', '天峻县', '2016-11-10 14:49:05', '1', '632800', '3');
INSERT INTO `th_area` VALUES ('632824', '其它区', '2016-11-10 14:49:05', '1', '632800', '3');
INSERT INTO `th_area` VALUES ('640000', '宁夏', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('640100', '银川市', '2016-11-10 14:49:05', '1', '640000', '2');
INSERT INTO `th_area` VALUES ('640104', '兴庆区', '2016-11-10 14:49:05', '1', '640100', '3');
INSERT INTO `th_area` VALUES ('640105', '西夏区', '2016-11-10 14:49:05', '1', '640100', '3');
INSERT INTO `th_area` VALUES ('640106', '金凤区', '2016-11-10 14:49:05', '1', '640100', '3');
INSERT INTO `th_area` VALUES ('640121', '永宁县', '2016-11-10 14:49:05', '1', '640100', '3');
INSERT INTO `th_area` VALUES ('640122', '贺兰县', '2016-11-10 14:49:05', '1', '640100', '3');
INSERT INTO `th_area` VALUES ('640181', '灵武市', '2016-11-10 14:49:05', '1', '640100', '3');
INSERT INTO `th_area` VALUES ('640182', '其它区', '2016-11-10 14:49:05', '1', '640100', '3');
INSERT INTO `th_area` VALUES ('640200', '石嘴山市', '2016-11-10 14:49:05', '1', '640000', '2');
INSERT INTO `th_area` VALUES ('640202', '大武口区', '2016-11-10 14:49:05', '1', '640200', '3');
INSERT INTO `th_area` VALUES ('640205', '惠农区', '2016-11-10 14:49:05', '1', '640200', '3');
INSERT INTO `th_area` VALUES ('640221', '平罗县', '2016-11-10 14:49:05', '1', '640200', '3');
INSERT INTO `th_area` VALUES ('640222', '其它区', '2016-11-10 14:49:05', '1', '640200', '3');
INSERT INTO `th_area` VALUES ('640300', '吴忠市', '2016-11-10 14:49:05', '1', '640000', '2');
INSERT INTO `th_area` VALUES ('640302', '利通区', '2016-11-10 14:49:05', '1', '640300', '3');
INSERT INTO `th_area` VALUES ('640303', '红寺堡区', '2016-11-10 14:49:05', '1', '640300', '3');
INSERT INTO `th_area` VALUES ('640323', '盐池县', '2016-11-10 14:49:05', '1', '640300', '3');
INSERT INTO `th_area` VALUES ('640324', '同心县', '2016-11-10 14:49:05', '1', '640300', '3');
INSERT INTO `th_area` VALUES ('640381', '青铜峡市', '2016-11-10 14:49:05', '1', '640300', '3');
INSERT INTO `th_area` VALUES ('640382', '其它区', '2016-11-10 14:49:05', '1', '640300', '3');
INSERT INTO `th_area` VALUES ('640400', '固原市', '2016-11-10 14:49:05', '1', '640000', '2');
INSERT INTO `th_area` VALUES ('640402', '原州区', '2016-11-10 14:49:05', '1', '640400', '3');
INSERT INTO `th_area` VALUES ('640422', '西吉县', '2016-11-10 14:49:05', '1', '640400', '3');
INSERT INTO `th_area` VALUES ('640423', '隆德县', '2016-11-10 14:49:05', '1', '640400', '3');
INSERT INTO `th_area` VALUES ('640424', '泾源县', '2016-11-10 14:49:05', '1', '640400', '3');
INSERT INTO `th_area` VALUES ('640425', '彭阳县', '2016-11-10 14:49:05', '1', '640400', '3');
INSERT INTO `th_area` VALUES ('640426', '其它区', '2016-11-10 14:49:05', '1', '640400', '3');
INSERT INTO `th_area` VALUES ('640500', '中卫市', '2016-11-10 14:49:05', '1', '640000', '2');
INSERT INTO `th_area` VALUES ('640502', '沙坡头区', '2016-11-10 14:49:05', '1', '640500', '3');
INSERT INTO `th_area` VALUES ('640521', '中宁县', '2016-11-10 14:49:05', '1', '640500', '3');
INSERT INTO `th_area` VALUES ('640522', '海原县', '2016-11-10 14:49:05', '1', '640500', '3');
INSERT INTO `th_area` VALUES ('640523', '其它区', '2016-11-10 14:49:05', '1', '640500', '3');
INSERT INTO `th_area` VALUES ('650000', '新疆', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('650100', '乌鲁木齐市', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('650102', '天山区', '2016-11-10 14:49:05', '1', '650100', '3');
INSERT INTO `th_area` VALUES ('650103', '沙依巴克区', '2016-11-10 14:49:05', '1', '650100', '3');
INSERT INTO `th_area` VALUES ('650104', '新市区', '2016-11-10 14:49:05', '1', '650100', '3');
INSERT INTO `th_area` VALUES ('650105', '水磨沟区', '2016-11-10 14:49:05', '1', '650100', '3');
INSERT INTO `th_area` VALUES ('650106', '头屯河区', '2016-11-10 14:49:05', '1', '650100', '3');
INSERT INTO `th_area` VALUES ('650107', '达坂城区', '2016-11-10 14:49:05', '1', '650100', '3');
INSERT INTO `th_area` VALUES ('650108', '东山区', '2016-11-10 14:49:05', '1', '650100', '3');
INSERT INTO `th_area` VALUES ('650109', '米东区', '2016-11-10 14:49:05', '1', '650100', '3');
INSERT INTO `th_area` VALUES ('650121', '乌鲁木齐县', '2016-11-10 14:49:05', '1', '650100', '3');
INSERT INTO `th_area` VALUES ('650122', '其它区', '2016-11-10 14:49:05', '1', '650100', '3');
INSERT INTO `th_area` VALUES ('650200', '克拉玛依市', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('650202', '独山子区', '2016-11-10 14:49:05', '1', '650200', '3');
INSERT INTO `th_area` VALUES ('650203', '克拉玛依区', '2016-11-10 14:49:05', '1', '650200', '3');
INSERT INTO `th_area` VALUES ('650204', '白碱滩区', '2016-11-10 14:49:05', '1', '650200', '3');
INSERT INTO `th_area` VALUES ('650205', '乌尔禾区', '2016-11-10 14:49:05', '1', '650200', '3');
INSERT INTO `th_area` VALUES ('650206', '其它区', '2016-11-10 14:49:05', '1', '650200', '3');
INSERT INTO `th_area` VALUES ('652100', '吐鲁番地区', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('652101', '吐鲁番市', '2016-11-10 14:49:05', '1', '652100', '3');
INSERT INTO `th_area` VALUES ('652122', '鄯善县', '2016-11-10 14:49:05', '1', '652100', '3');
INSERT INTO `th_area` VALUES ('652123', '托克逊县', '2016-11-10 14:49:05', '1', '652100', '3');
INSERT INTO `th_area` VALUES ('652124', '其它区', '2016-11-10 14:49:05', '1', '652100', '3');
INSERT INTO `th_area` VALUES ('652200', '哈密地区', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('652201', '哈密市', '2016-11-10 14:49:05', '1', '652200', '3');
INSERT INTO `th_area` VALUES ('652222', '巴里坤哈萨克自治县', '2016-11-10 14:49:05', '1', '652200', '3');
INSERT INTO `th_area` VALUES ('652223', '伊吾县', '2016-11-10 14:49:05', '1', '652200', '3');
INSERT INTO `th_area` VALUES ('652224', '其它区', '2016-11-10 14:49:05', '1', '652200', '3');
INSERT INTO `th_area` VALUES ('652300', '昌吉回族自治州', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('652301', '昌吉市', '2016-11-10 14:49:05', '1', '652300', '3');
INSERT INTO `th_area` VALUES ('652302', '阜康市', '2016-11-10 14:49:05', '1', '652300', '3');
INSERT INTO `th_area` VALUES ('652303', '米泉市', '2016-11-10 14:49:05', '1', '652300', '3');
INSERT INTO `th_area` VALUES ('652323', '呼图壁县', '2016-11-10 14:49:05', '1', '652300', '3');
INSERT INTO `th_area` VALUES ('652324', '玛纳斯县', '2016-11-10 14:49:05', '1', '652300', '3');
INSERT INTO `th_area` VALUES ('652325', '奇台县', '2016-11-10 14:49:05', '1', '652300', '3');
INSERT INTO `th_area` VALUES ('652327', '吉木萨尔县', '2016-11-10 14:49:05', '1', '652300', '3');
INSERT INTO `th_area` VALUES ('652328', '木垒哈萨克自治县', '2016-11-10 14:49:05', '1', '652300', '3');
INSERT INTO `th_area` VALUES ('652329', '其它区', '2016-11-10 14:49:05', '1', '652300', '3');
INSERT INTO `th_area` VALUES ('652700', '博尔塔拉蒙古自治州', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('652701', '博乐市', '2016-11-10 14:49:05', '1', '652700', '3');
INSERT INTO `th_area` VALUES ('652722', '精河县', '2016-11-10 14:49:05', '1', '652700', '3');
INSERT INTO `th_area` VALUES ('652723', '温泉县', '2016-11-10 14:49:05', '1', '652700', '3');
INSERT INTO `th_area` VALUES ('652724', '其它区', '2016-11-10 14:49:05', '1', '652700', '3');
INSERT INTO `th_area` VALUES ('652800', '巴音郭楞蒙古自治州', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('652801', '库尔勒市', '2016-11-10 14:49:05', '1', '652800', '3');
INSERT INTO `th_area` VALUES ('652822', '轮台县', '2016-11-10 14:49:05', '1', '652800', '3');
INSERT INTO `th_area` VALUES ('652823', '尉犁县', '2016-11-10 14:49:05', '1', '652800', '3');
INSERT INTO `th_area` VALUES ('652824', '若羌县', '2016-11-10 14:49:05', '1', '652800', '3');
INSERT INTO `th_area` VALUES ('652825', '且末县', '2016-11-10 14:49:05', '1', '652800', '3');
INSERT INTO `th_area` VALUES ('652826', '焉耆回族自治县', '2016-11-10 14:49:05', '1', '652800', '3');
INSERT INTO `th_area` VALUES ('652827', '和静县', '2016-11-10 14:49:05', '1', '652800', '3');
INSERT INTO `th_area` VALUES ('652828', '和硕县', '2016-11-10 14:49:05', '1', '652800', '3');
INSERT INTO `th_area` VALUES ('652829', '博湖县', '2016-11-10 14:49:05', '1', '652800', '3');
INSERT INTO `th_area` VALUES ('652830', '其它区', '2016-11-10 14:49:05', '1', '652800', '3');
INSERT INTO `th_area` VALUES ('652900', '阿克苏地区', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('652901', '阿克苏市', '2016-11-10 14:49:05', '1', '652900', '3');
INSERT INTO `th_area` VALUES ('652922', '温宿县', '2016-11-10 14:49:05', '1', '652900', '3');
INSERT INTO `th_area` VALUES ('652923', '库车县', '2016-11-10 14:49:05', '1', '652900', '3');
INSERT INTO `th_area` VALUES ('652924', '沙雅县', '2016-11-10 14:49:05', '1', '652900', '3');
INSERT INTO `th_area` VALUES ('652925', '新和县', '2016-11-10 14:49:05', '1', '652900', '3');
INSERT INTO `th_area` VALUES ('652926', '拜城县', '2016-11-10 14:49:05', '1', '652900', '3');
INSERT INTO `th_area` VALUES ('652927', '乌什县', '2016-11-10 14:49:05', '1', '652900', '3');
INSERT INTO `th_area` VALUES ('652928', '阿瓦提县', '2016-11-10 14:49:05', '1', '652900', '3');
INSERT INTO `th_area` VALUES ('652929', '柯坪县', '2016-11-10 14:49:05', '1', '652900', '3');
INSERT INTO `th_area` VALUES ('652930', '其它区', '2016-11-10 14:49:05', '1', '652900', '3');
INSERT INTO `th_area` VALUES ('653000', '克孜勒苏柯尔克孜自治州', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('653001', '阿图什市', '2016-11-10 14:49:05', '1', '653000', '3');
INSERT INTO `th_area` VALUES ('653022', '阿克陶县', '2016-11-10 14:49:05', '1', '653000', '3');
INSERT INTO `th_area` VALUES ('653023', '阿合奇县', '2016-11-10 14:49:05', '1', '653000', '3');
INSERT INTO `th_area` VALUES ('653024', '乌恰县', '2016-11-10 14:49:05', '1', '653000', '3');
INSERT INTO `th_area` VALUES ('653025', '其它区', '2016-11-10 14:49:05', '1', '653000', '3');
INSERT INTO `th_area` VALUES ('653100', '喀什地区', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('653101', '喀什市', '2016-11-10 14:49:05', '1', '653100', '3');
INSERT INTO `th_area` VALUES ('653121', '疏附县', '2016-11-10 14:49:05', '1', '653100', '3');
INSERT INTO `th_area` VALUES ('653122', '疏勒县', '2016-11-10 14:49:05', '1', '653100', '3');
INSERT INTO `th_area` VALUES ('653123', '英吉沙县', '2016-11-10 14:49:05', '1', '653100', '3');
INSERT INTO `th_area` VALUES ('653124', '泽普县', '2016-11-10 14:49:05', '1', '653100', '3');
INSERT INTO `th_area` VALUES ('653125', '莎车县', '2016-11-10 14:49:05', '1', '653100', '3');
INSERT INTO `th_area` VALUES ('653126', '叶城县', '2016-11-10 14:49:05', '1', '653100', '3');
INSERT INTO `th_area` VALUES ('653127', '麦盖提县', '2016-11-10 14:49:05', '1', '653100', '3');
INSERT INTO `th_area` VALUES ('653128', '岳普湖县', '2016-11-10 14:49:05', '1', '653100', '3');
INSERT INTO `th_area` VALUES ('653129', '伽师县', '2016-11-10 14:49:05', '1', '653100', '3');
INSERT INTO `th_area` VALUES ('653130', '巴楚县', '2016-11-10 14:49:05', '1', '653100', '3');
INSERT INTO `th_area` VALUES ('653131', '塔什库尔干塔吉克自治县', '2016-11-10 14:49:05', '1', '653100', '3');
INSERT INTO `th_area` VALUES ('653132', '其它区', '2016-11-10 14:49:05', '1', '653100', '3');
INSERT INTO `th_area` VALUES ('653200', '和田地区', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('653201', '和田市', '2016-11-10 14:49:05', '1', '653200', '3');
INSERT INTO `th_area` VALUES ('653221', '和田县', '2016-11-10 14:49:05', '1', '653200', '3');
INSERT INTO `th_area` VALUES ('653222', '墨玉县', '2016-11-10 14:49:05', '1', '653200', '3');
INSERT INTO `th_area` VALUES ('653223', '皮山县', '2016-11-10 14:49:05', '1', '653200', '3');
INSERT INTO `th_area` VALUES ('653224', '洛浦县', '2016-11-10 14:49:05', '1', '653200', '3');
INSERT INTO `th_area` VALUES ('653225', '策勒县', '2016-11-10 14:49:05', '1', '653200', '3');
INSERT INTO `th_area` VALUES ('653226', '于田县', '2016-11-10 14:49:05', '1', '653200', '3');
INSERT INTO `th_area` VALUES ('653227', '民丰县', '2016-11-10 14:49:05', '1', '653200', '3');
INSERT INTO `th_area` VALUES ('653228', '其它区', '2016-11-10 14:49:05', '1', '653200', '3');
INSERT INTO `th_area` VALUES ('654000', '伊犁哈萨克自治州', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('654002', '伊宁市', '2016-11-10 14:49:05', '1', '654000', '3');
INSERT INTO `th_area` VALUES ('654003', '奎屯市', '2016-11-10 14:49:05', '1', '654000', '3');
INSERT INTO `th_area` VALUES ('654021', '伊宁县', '2016-11-10 14:49:05', '1', '654000', '3');
INSERT INTO `th_area` VALUES ('654022', '察布查尔锡伯自治县', '2016-11-10 14:49:05', '1', '654000', '3');
INSERT INTO `th_area` VALUES ('654023', '霍城县', '2016-11-10 14:49:05', '1', '654000', '3');
INSERT INTO `th_area` VALUES ('654024', '巩留县', '2016-11-10 14:49:05', '1', '654000', '3');
INSERT INTO `th_area` VALUES ('654025', '新源县', '2016-11-10 14:49:05', '1', '654000', '3');
INSERT INTO `th_area` VALUES ('654026', '昭苏县', '2016-11-10 14:49:05', '1', '654000', '3');
INSERT INTO `th_area` VALUES ('654027', '特克斯县', '2016-11-10 14:49:05', '1', '654000', '3');
INSERT INTO `th_area` VALUES ('654028', '尼勒克县', '2016-11-10 14:49:05', '1', '654000', '3');
INSERT INTO `th_area` VALUES ('654029', '其它区', '2016-11-10 14:49:05', '1', '654000', '3');
INSERT INTO `th_area` VALUES ('654200', '塔城地区', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('654201', '塔城市', '2016-11-10 14:49:05', '1', '654200', '3');
INSERT INTO `th_area` VALUES ('654202', '乌苏市', '2016-11-10 14:49:05', '1', '654200', '3');
INSERT INTO `th_area` VALUES ('654221', '额敏县', '2016-11-10 14:49:05', '1', '654200', '3');
INSERT INTO `th_area` VALUES ('654223', '沙湾县', '2016-11-10 14:49:05', '1', '654200', '3');
INSERT INTO `th_area` VALUES ('654224', '托里县', '2016-11-10 14:49:05', '1', '654200', '3');
INSERT INTO `th_area` VALUES ('654225', '裕民县', '2016-11-10 14:49:05', '1', '654200', '3');
INSERT INTO `th_area` VALUES ('654226', '和布克赛尔蒙古自治县', '2016-11-10 14:49:05', '1', '654200', '3');
INSERT INTO `th_area` VALUES ('654227', '其它区', '2016-11-10 14:49:05', '1', '654200', '3');
INSERT INTO `th_area` VALUES ('654300', '阿勒泰地区', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('654301', '阿勒泰市', '2016-11-10 14:49:05', '1', '654300', '3');
INSERT INTO `th_area` VALUES ('654321', '布尔津县', '2016-11-10 14:49:05', '1', '654300', '3');
INSERT INTO `th_area` VALUES ('654322', '富蕴县', '2016-11-10 14:49:05', '1', '654300', '3');
INSERT INTO `th_area` VALUES ('654323', '福海县', '2016-11-10 14:49:05', '1', '654300', '3');
INSERT INTO `th_area` VALUES ('654324', '哈巴河县', '2016-11-10 14:49:05', '1', '654300', '3');
INSERT INTO `th_area` VALUES ('654325', '青河县', '2016-11-10 14:49:05', '1', '654300', '3');
INSERT INTO `th_area` VALUES ('654326', '吉木乃县', '2016-11-10 14:49:05', '1', '654300', '3');
INSERT INTO `th_area` VALUES ('654327', '其它区', '2016-11-10 14:49:05', '1', '654300', '3');
INSERT INTO `th_area` VALUES ('659001', '石河子市', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('659002', '阿拉尔市', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('659003', '图木舒克市', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('659004', '五家渠市', '2016-11-10 14:49:05', '1', '650000', '2');
INSERT INTO `th_area` VALUES ('710000', '台湾省', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('710100', '台北市', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('710101', '中正区', '2016-11-10 14:49:05', '1', '710100', '3');
INSERT INTO `th_area` VALUES ('710102', '大同区', '2016-11-10 14:49:05', '1', '710100', '3');
INSERT INTO `th_area` VALUES ('710103', '中山区', '2016-11-10 14:49:05', '1', '710100', '3');
INSERT INTO `th_area` VALUES ('710104', '松山区', '2016-11-10 14:49:05', '1', '710100', '3');
INSERT INTO `th_area` VALUES ('710105', '大安区', '2016-11-10 14:49:05', '1', '710100', '3');
INSERT INTO `th_area` VALUES ('710106', '万华区', '2016-11-10 14:49:05', '1', '710100', '3');
INSERT INTO `th_area` VALUES ('710107', '信义区', '2016-11-10 14:49:05', '1', '710100', '3');
INSERT INTO `th_area` VALUES ('710108', '士林区', '2016-11-10 14:49:05', '1', '710100', '3');
INSERT INTO `th_area` VALUES ('710109', '北投区', '2016-11-10 14:49:05', '1', '710100', '3');
INSERT INTO `th_area` VALUES ('710110', '内湖区', '2016-11-10 14:49:05', '1', '710100', '3');
INSERT INTO `th_area` VALUES ('710111', '南港区', '2016-11-10 14:49:05', '1', '710100', '3');
INSERT INTO `th_area` VALUES ('710112', '文山区', '2016-11-10 14:49:05', '1', '710100', '3');
INSERT INTO `th_area` VALUES ('710113', '其它区', '2016-11-10 14:49:05', '1', '710100', '3');
INSERT INTO `th_area` VALUES ('710200', '高雄市', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('710201', '新兴区', '2016-11-10 14:49:05', '1', '710200', '3');
INSERT INTO `th_area` VALUES ('710202', '前金区', '2016-11-10 14:49:05', '1', '710200', '3');
INSERT INTO `th_area` VALUES ('710203', '芩雅区', '2016-11-10 14:49:05', '1', '710200', '3');
INSERT INTO `th_area` VALUES ('710204', '盐埕区', '2016-11-10 14:49:05', '1', '710200', '3');
INSERT INTO `th_area` VALUES ('710205', '鼓山区', '2016-11-10 14:49:05', '1', '710200', '3');
INSERT INTO `th_area` VALUES ('710206', '旗津区', '2016-11-10 14:49:05', '1', '710200', '3');
INSERT INTO `th_area` VALUES ('710207', '前镇区', '2016-11-10 14:49:05', '1', '710200', '3');
INSERT INTO `th_area` VALUES ('710208', '三民区', '2016-11-10 14:49:05', '1', '710200', '3');
INSERT INTO `th_area` VALUES ('710209', '左营区', '2016-11-10 14:49:05', '1', '710200', '3');
INSERT INTO `th_area` VALUES ('710210', '楠梓区', '2016-11-10 14:49:05', '1', '710200', '3');
INSERT INTO `th_area` VALUES ('710211', '小港区', '2016-11-10 14:49:05', '1', '710200', '3');
INSERT INTO `th_area` VALUES ('710212', '其它区', '2016-11-10 14:49:05', '1', '710200', '3');
INSERT INTO `th_area` VALUES ('710300', '台南市', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('710301', '中西区', '2016-11-10 14:49:05', '1', '710300', '3');
INSERT INTO `th_area` VALUES ('710302', '东区', '2016-11-10 14:49:05', '1', '710300', '3');
INSERT INTO `th_area` VALUES ('710303', '南区', '2016-11-10 14:49:05', '1', '710300', '3');
INSERT INTO `th_area` VALUES ('710304', '北区', '2016-11-10 14:49:05', '1', '710300', '3');
INSERT INTO `th_area` VALUES ('710305', '安平区', '2016-11-10 14:49:05', '1', '710300', '3');
INSERT INTO `th_area` VALUES ('710306', '安南区', '2016-11-10 14:49:05', '1', '710300', '3');
INSERT INTO `th_area` VALUES ('710307', '其它区', '2016-11-10 14:49:05', '1', '710300', '3');
INSERT INTO `th_area` VALUES ('710400', '台中市', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('710401', '中区', '2016-11-10 14:49:05', '1', '710400', '3');
INSERT INTO `th_area` VALUES ('710402', '东区', '2016-11-10 14:49:05', '1', '710400', '3');
INSERT INTO `th_area` VALUES ('710403', '南区', '2016-11-10 14:49:05', '1', '710400', '3');
INSERT INTO `th_area` VALUES ('710404', '西区', '2016-11-10 14:49:05', '1', '710400', '3');
INSERT INTO `th_area` VALUES ('710405', '北区', '2016-11-10 14:49:05', '1', '710400', '3');
INSERT INTO `th_area` VALUES ('710406', '北屯区', '2016-11-10 14:49:05', '1', '710400', '3');
INSERT INTO `th_area` VALUES ('710407', '西屯区', '2016-11-10 14:49:05', '1', '710400', '3');
INSERT INTO `th_area` VALUES ('710408', '南屯区', '2016-11-10 14:49:05', '1', '710400', '3');
INSERT INTO `th_area` VALUES ('710409', '其它区', '2016-11-10 14:49:05', '1', '710400', '3');
INSERT INTO `th_area` VALUES ('710500', '金门县', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('710600', '南投县', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('710700', '基隆市', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('710701', '仁爱区', '2016-11-10 14:49:05', '1', '710700', '3');
INSERT INTO `th_area` VALUES ('710702', '信义区', '2016-11-10 14:49:05', '1', '710700', '3');
INSERT INTO `th_area` VALUES ('710703', '中正区', '2016-11-10 14:49:05', '1', '710700', '3');
INSERT INTO `th_area` VALUES ('710704', '中山区', '2016-11-10 14:49:05', '1', '710700', '3');
INSERT INTO `th_area` VALUES ('710705', '安乐区', '2016-11-10 14:49:05', '1', '710700', '3');
INSERT INTO `th_area` VALUES ('710706', '暖暖区', '2016-11-10 14:49:05', '1', '710700', '3');
INSERT INTO `th_area` VALUES ('710707', '七堵区', '2016-11-10 14:49:05', '1', '710700', '3');
INSERT INTO `th_area` VALUES ('710708', '其它区', '2016-11-10 14:49:05', '1', '710700', '3');
INSERT INTO `th_area` VALUES ('710800', '新竹市', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('710801', '东区', '2016-11-10 14:49:05', '1', '710800', '3');
INSERT INTO `th_area` VALUES ('710802', '北区', '2016-11-10 14:49:05', '1', '710800', '3');
INSERT INTO `th_area` VALUES ('710803', '香山区', '2016-11-10 14:49:05', '1', '710800', '3');
INSERT INTO `th_area` VALUES ('710804', '其它区', '2016-11-10 14:49:05', '1', '710800', '3');
INSERT INTO `th_area` VALUES ('710900', '嘉义市', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('710901', '东区', '2016-11-10 14:49:05', '1', '710900', '3');
INSERT INTO `th_area` VALUES ('710902', '西区', '2016-11-10 14:49:05', '1', '710900', '3');
INSERT INTO `th_area` VALUES ('710903', '其它区', '2016-11-10 14:49:05', '1', '710900', '3');
INSERT INTO `th_area` VALUES ('711100', '新北市', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('711200', '宜兰县', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('711300', '新竹县', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('711400', '桃园县', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('711500', '苗栗县', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('711700', '彰化县', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('711900', '嘉义县', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('712100', '云林县', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('712400', '屏东县', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('712500', '台东县', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('712600', '花莲县', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('712700', '澎湖县', '2016-11-10 14:49:05', '1', '710000', '2');
INSERT INTO `th_area` VALUES ('810000', '香港', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('810100', '香港岛', '2016-11-10 14:49:05', '1', '810000', '2');
INSERT INTO `th_area` VALUES ('810101', '中西区', '2016-11-10 14:49:05', '1', '810100', '3');
INSERT INTO `th_area` VALUES ('810102', '湾仔', '2016-11-10 14:49:05', '1', '810100', '3');
INSERT INTO `th_area` VALUES ('810103', '东区', '2016-11-10 14:49:05', '1', '810100', '3');
INSERT INTO `th_area` VALUES ('810104', '南区', '2016-11-10 14:49:05', '1', '810100', '3');
INSERT INTO `th_area` VALUES ('810200', '九龙', '2016-11-10 14:49:05', '1', '810000', '2');
INSERT INTO `th_area` VALUES ('810201', '九龙城区', '2016-11-10 14:49:05', '1', '810200', '3');
INSERT INTO `th_area` VALUES ('810202', '油尖旺区', '2016-11-10 14:49:05', '1', '810200', '3');
INSERT INTO `th_area` VALUES ('810203', '深水埗区', '2016-11-10 14:49:05', '1', '810200', '3');
INSERT INTO `th_area` VALUES ('810204', '黄大仙区', '2016-11-10 14:49:05', '1', '810200', '3');
INSERT INTO `th_area` VALUES ('810205', '观塘区', '2016-11-10 14:49:05', '1', '810200', '3');
INSERT INTO `th_area` VALUES ('810300', '新界', '2016-11-10 14:49:05', '1', '810000', '2');
INSERT INTO `th_area` VALUES ('810301', '北区', '2016-11-10 14:49:05', '1', '810300', '3');
INSERT INTO `th_area` VALUES ('810302', '大埔区', '2016-11-10 14:49:05', '1', '810300', '3');
INSERT INTO `th_area` VALUES ('810303', '沙田区', '2016-11-10 14:49:05', '1', '810300', '3');
INSERT INTO `th_area` VALUES ('810304', '西贡区', '2016-11-10 14:49:05', '1', '810300', '3');
INSERT INTO `th_area` VALUES ('810305', '元朗区', '2016-11-10 14:49:05', '1', '810300', '3');
INSERT INTO `th_area` VALUES ('810306', '屯门区', '2016-11-10 14:49:05', '1', '810300', '3');
INSERT INTO `th_area` VALUES ('810307', '荃湾区', '2016-11-10 14:49:05', '1', '810300', '3');
INSERT INTO `th_area` VALUES ('810308', '葵青区', '2016-11-10 14:49:05', '1', '810300', '3');
INSERT INTO `th_area` VALUES ('810309', '离岛区', '2016-11-10 14:49:05', '1', '810300', '3');
INSERT INTO `th_area` VALUES ('820000', '澳门', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('820100', '澳门半岛', '2016-11-10 14:49:05', '1', '820000', '2');
INSERT INTO `th_area` VALUES ('820200', '离岛', '2016-11-10 14:49:05', '1', '820000', '2');
INSERT INTO `th_area` VALUES ('990000', '海外', '2016-11-10 14:49:05', '1', null, '1');
INSERT INTO `th_area` VALUES ('990100', '海外', '2016-11-10 14:49:05', '1', '990000', '2');

-- ----------------------------
-- Table structure for th_back_cash
-- ----------------------------
DROP TABLE IF EXISTS `th_back_cash`;
CREATE TABLE `th_back_cash` (
  `id` varchar(32) NOT NULL,
  `startMoney` varchar(50) DEFAULT NULL COMMENT '返现档位',
  `proportion` varchar(20) DEFAULT NULL COMMENT '返现比例',
  `remark` text COMMENT '备注',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值返现';

-- ----------------------------
-- Records of th_back_cash
-- ----------------------------
INSERT INTO `th_back_cash` VALUES ('20180307180840253198394678373342', '100', '100', null, '2018-03-07 18:08:40', '2018-03-07 18:08:40', null, '20161222113810681189580305593289', null);
INSERT INTO `th_back_cash` VALUES ('20180314150755974990200457720805', '50', '50', null, '2018-03-14 15:07:55', '2018-03-14 15:07:55', null, '20161222113810681189580305593289', null);
INSERT INTO `th_back_cash` VALUES ('20180314150805865033628359084142', '10', '10', null, '2018-03-14 15:08:05', '2018-03-14 15:08:05', null, '20161222113810681189580305593289', null);

-- ----------------------------
-- Table structure for th_banner
-- ----------------------------
DROP TABLE IF EXISTS `th_banner`;
CREATE TABLE `th_banner` (
  `id` varchar(32) NOT NULL,
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信首页轮播';

-- ----------------------------
-- Records of th_banner
-- ----------------------------
INSERT INTO `th_banner` VALUES ('20180314181359476799647436685746', '2018-03-14 18:13:59', '2018-03-14 18:13:59', '20161222113810681189580305593289', null, null);

-- ----------------------------
-- Table structure for th_bonus
-- ----------------------------
DROP TABLE IF EXISTS `th_bonus`;
CREATE TABLE `th_bonus` (
  `id` varchar(32) NOT NULL,
  `startMoney` varchar(50) DEFAULT NULL COMMENT '提成档位',
  `proportion` varchar(20) DEFAULT NULL COMMENT '提成比例',
  `remark` text COMMENT '备注',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='导购提成比例设置表';

-- ----------------------------
-- Records of th_bonus
-- ----------------------------
INSERT INTO `th_bonus` VALUES ('20180314150720086884036929535734', '100', '10', null, null, '2018-03-14 15:07:20', null, '20161222113810681189580305593289', null);

-- ----------------------------
-- Table structure for th_bonus_detail
-- ----------------------------
DROP TABLE IF EXISTS `th_bonus_detail`;
CREATE TABLE `th_bonus_detail` (
  `id` varchar(32) NOT NULL,
  `guideUser_id` varchar(32) DEFAULT NULL COMMENT '导购（ps：auth_user表里的）',
  `targetMoney` varchar(50) DEFAULT NULL COMMENT '销售额',
  `money` varchar(50) DEFAULT NULL COMMENT '提成金额',
  `month` varchar(50) DEFAULT NULL COMMENT '提成月份',
  `isPayMoney` varchar(5) DEFAULT NULL COMMENT '是否发放(1:是,2:否)',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='导购提成记录';

-- ----------------------------
-- Records of th_bonus_detail
-- ----------------------------

-- ----------------------------
-- Table structure for th_brand
-- ----------------------------
DROP TABLE IF EXISTS `th_brand`;
CREATE TABLE `th_brand` (
  `id` varchar(32) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `brandHttpURI` text COMMENT '官网网址',
  `content` text COMMENT '描述',
  `remark` text COMMENT '备注',
  `isDelete` varchar(5) DEFAULT NULL COMMENT '是否删除（1：否，2：是）',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='品牌信息';

-- ----------------------------
-- Records of th_brand
-- ----------------------------
INSERT INTO `th_brand` VALUES ('20170922155623033757857866122344', '似水年华', 'www.baidu.com', '女装中的战斗机', '椅', '1', '2017-09-22 15:56:23', '2017-09-22 15:56:23', '20161222113810681189580305593289', null, null);
INSERT INTO `th_brand` VALUES ('20170922155649207495063299482529', '帛卡袖', 'www.baidu.com', '从来没有听说过', '', '1', '2017-09-22 15:56:49', '2017-09-22 15:56:49', '20161222113810681189580305593289', null, null);
INSERT INTO `th_brand` VALUES ('20170922170008418500507169281039', '女鞋店品牌', 'www.baidu.com', 'sfdsfsfsdfsd', '', '1', '2017-09-22 17:00:08', '2017-09-22 17:00:08', '20161222113810681189580305593289', null, null);
INSERT INTO `th_brand` VALUES ('20170922170542478009503390176485', '小商品品牌', 'www.baidu.com', 'dsfgsfs', '', '1', '2017-09-22 17:05:42', '2017-09-22 17:05:42', '20161222113810681189580305593289', null, null);
INSERT INTO `th_brand` VALUES ('20171020141858078532445550340340', '测试品牌', '', '测试品牌', '测试品牌', '1', '2017-10-20 14:18:58', '2017-10-20 14:18:58', '20161222113810681189580305593289', null, null);
INSERT INTO `th_brand` VALUES ('20180310172916868887773200359534', '11', '11', '1', '1', '1', '2018-03-10 17:29:16', '2018-03-10 17:29:16', '20161222113810681189580305593289', null, null);
INSERT INTO `th_brand` VALUES ('20180310172921458444792841448108', '22', '22', '22', '22', '1', '2018-03-10 17:29:21', '2018-03-10 17:29:21', '20161222113810681189580305593289', null, null);
INSERT INTO `th_brand` VALUES ('20180310172926660012357346877331', '33', '33', '33', '33', '1', '2018-03-10 17:29:26', '2018-03-10 17:29:26', '20161222113810681189580305593289', null, null);

-- ----------------------------
-- Table structure for th_cashieruserloginandlogout
-- ----------------------------
DROP TABLE IF EXISTS `th_cashieruserloginandlogout`;
CREATE TABLE `th_cashieruserloginandlogout` (
  `id` varchar(32) NOT NULL,
  `cashierUser_id` varchar(32) DEFAULT NULL COMMENT '收银用户ID',
  `cashierCode` varchar(20) DEFAULT NULL COMMENT '款台号',
  `loginTime` timestamp NULL DEFAULT NULL COMMENT '登录时间',
  `logoutTime` timestamp NULL DEFAULT NULL COMMENT '退出时间',
  `state` varchar(5) DEFAULT NULL COMMENT '1：未交班，2：未结算，3：完成',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收银台交接班';

-- ----------------------------
-- Records of th_cashieruserloginandlogout
-- ----------------------------
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180306170452953752810502098600', '20170922195030757264333921841291', '001', '2018-03-06 17:04:52', '2018-03-06 17:04:56', '2', '2018-03-06 17:04:52', '2018-03-06 17:04:52', null, '2018-03-06 17:04:56', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180306170519437221344602589029', '20170922195030757264333921841291', '001', '2018-03-06 17:05:19', '2018-03-06 17:20:15', '2', '2018-03-06 17:05:19', '2018-03-06 17:05:19', null, '2018-03-06 17:20:15', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180306172042587296843106023992', '20170922195030757264333921841291', '001', '2018-03-06 17:20:42', '2018-03-06 17:23:43', '2', '2018-03-06 17:20:42', '2018-03-06 17:20:42', null, '2018-03-06 17:23:43', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180306172653001029497693886442', '20170922195030757264333921841291', '001', '2018-03-06 17:26:53', '2018-03-06 18:02:35', '2', '2018-03-06 17:26:53', '2018-03-06 17:26:53', null, '2018-03-06 18:02:35', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180306180306976161349800048085', '20170922195030757264333921841291', '001', '2018-03-06 18:03:06', '2018-03-07 14:54:47', '2', '2018-03-06 18:03:06', '2018-03-06 18:03:06', null, '2018-03-07 14:54:47', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180307145514477493600541787642', '20170922195030757264333921841291', '001', '2018-03-07 14:55:14', '2018-03-08 09:21:23', '2', '2018-03-07 14:55:14', '2018-03-07 14:55:14', null, '2018-03-08 09:21:23', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180308092136746340093135788313', '20170922195030757264333921841291', '001', '2018-03-08 09:21:36', '2018-03-09 09:48:48', '2', '2018-03-08 09:21:36', '2018-03-08 09:21:36', null, '2018-03-09 09:48:48', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180309094914041274084634348055', '20170922195030757264333921841291', '001', '2018-03-09 09:49:14', '2018-03-10 09:32:34', '2', '2018-03-09 09:49:14', '2018-03-09 09:49:14', null, '2018-03-10 09:32:35', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180310093249466728667600533753', '20170922195030757264333921841291', '001', '2018-03-10 09:32:49', '2018-03-12 09:45:42', '2', '2018-03-10 09:32:49', '2018-03-10 09:32:49', null, '2018-03-12 09:45:43', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180312094615078010140643155928', '20170922195030757264333921841291', '001', '2018-03-12 09:46:15', '2018-03-12 09:53:13', '2', '2018-03-12 09:46:15', '2018-03-12 09:46:15', null, '2018-03-12 09:53:13', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180312095325138909874845105389', '20170923163938680812505983823051', '001', '2018-03-12 09:53:25', '2018-03-12 09:53:48', '2', '2018-03-12 09:53:25', '2018-03-12 09:53:25', null, '2018-03-12 09:53:48', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180312095400741827589754644764', '20170922195030757264333921841291', '001', '2018-03-12 09:54:00', '2018-03-12 10:02:19', '2', '2018-03-12 09:54:00', '2018-03-12 09:54:00', null, '2018-03-12 10:02:19', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180312100241116930285739109382', '20170923163938680812505983823051', '001', '2018-03-12 10:02:41', '2018-03-12 10:02:52', '2', '2018-03-12 10:02:41', '2018-03-12 10:02:41', null, '2018-03-12 10:02:52', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180312100320914048246553872467', '20170922195030757264333921841291', '001', '2018-03-12 10:03:20', '2018-03-13 09:13:11', '2', '2018-03-12 10:03:20', '2018-03-12 10:03:20', null, '2018-03-13 09:13:11', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180313091336554087066699504798', '20170922195030757264333921841291', '001', '2018-03-13 09:13:36', '2018-03-14 14:04:56', '2', '2018-03-13 09:13:36', '2018-03-13 09:13:36', null, '2018-03-14 14:04:56', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180320150621407460583510149918', '20170922195030757264333921841291', '001', '2018-03-20 15:06:21', '2018-03-20 15:06:32', '2', '2018-03-20 15:06:21', '2018-03-20 15:06:21', null, '2018-03-20 15:06:32', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180410180651786996761503246906', '20170922195030757264333921841291', '001', '2018-04-10 18:06:51', '2018-04-10 18:10:10', '2', '2018-04-10 18:06:51', '2018-04-10 18:06:51', null, '2018-04-10 18:10:10', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180410181207718095096368338845', '20170922195030757264333921841291', '001', '2018-04-10 18:12:07', '2018-04-10 18:28:39', '2', '2018-04-10 18:12:07', '2018-04-10 18:12:07', null, '2018-04-10 18:28:39', null);
INSERT INTO `th_cashieruserloginandlogout` VALUES ('20180510145807246653947974054895', '20170922195030757264333921841291', '001', '2018-05-10 14:58:07', null, '1', '2018-05-10 14:58:07', '2018-05-10 14:58:07', null, null, null);

-- ----------------------------
-- Table structure for th_checkstorage
-- ----------------------------
DROP TABLE IF EXISTS `th_checkstorage`;
CREATE TABLE `th_checkstorage` (
  `id` varchar(32) NOT NULL,
  `store_id` varchar(32) DEFAULT NULL COMMENT '门店ID',
  `code` varchar(50) DEFAULT NULL COMMENT '盘点单号（ps:16位长订单号生成模式）',
  `storage_id` varchar(32) DEFAULT NULL COMMENT '仓库ID',
  `checkDate` timestamp NULL DEFAULT NULL COMMENT '盘点日期(结束)',
  `state` varchar(5) DEFAULT NULL COMMENT '状态（1：完成，2：新建，3：已审批）',
  `remark` text,
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间（盘点时间）',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL COMMENT '盘点人',
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_23` (`storage_id`),
  KEY `FK_Reference_24` (`store_id`),
  CONSTRAINT `FK_Reference_23` FOREIGN KEY (`storage_id`) REFERENCES `th_storage` (`id`),
  CONSTRAINT `FK_Reference_24` FOREIGN KEY (`store_id`) REFERENCES `th_store` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存盘点';

-- ----------------------------
-- Records of th_checkstorage
-- ----------------------------
INSERT INTO `th_checkstorage` VALUES ('20180307111735914821159143449229', '20171020141842757704681968303771', '2018030711170000', '20171020143623644909530581599768', '2018-03-07 11:17:47', '1', '', '2018-03-07 11:17:35', '2018-03-07 11:17:35', '20161222113810681189580305593289', '2018-03-07 11:17:47', '20161222113810681189580305593289');
INSERT INTO `th_checkstorage` VALUES ('20180319181348132167830128340125', '20171020141842757704681968303771', '2018031918130001', '20180314141637307619473967715931', null, '2', '', '2018-03-19 18:13:48', '2018-03-19 18:13:48', '20161222113810681189580305593289', null, null);

-- ----------------------------
-- Table structure for th_checkstorage_goods
-- ----------------------------
DROP TABLE IF EXISTS `th_checkstorage_goods`;
CREATE TABLE `th_checkstorage_goods` (
  `id` varchar(32) NOT NULL,
  `checkstorage_id` varchar(32) DEFAULT NULL COMMENT '所属盘点单',
  `checkNumber` varchar(50) DEFAULT NULL COMMENT '盘点数量',
  `inventoryNumber` varchar(50) DEFAULT NULL COMMENT '盘点前数量',
  `profitNumber` varchar(50) DEFAULT NULL COMMENT '盈亏数量',
  `profitMoney` varchar(50) DEFAULT NULL COMMENT '盈亏金额',
  `goods_id` varchar(32) DEFAULT NULL COMMENT '盘点产品',
  `state` varchar(10) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_25` (`checkstorage_id`),
  KEY `FK_Reference_26` (`goods_id`),
  CONSTRAINT `FK_Reference_25` FOREIGN KEY (`checkstorage_id`) REFERENCES `th_checkstorage` (`id`),
  CONSTRAINT `FK_Reference_26` FOREIGN KEY (`goods_id`) REFERENCES `th_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='盘点明细';

-- ----------------------------
-- Records of th_checkstorage_goods
-- ----------------------------
INSERT INTO `th_checkstorage_goods` VALUES ('20180307111740739198201702172177', '20180307111735914821159143449229', '5', '5', '0', null, '20170922173129684003478306409198', '1', '2018-03-07 11:17:40', '2018-03-07 11:17:40', '20161222113810681189580305593289', '2018-03-07 11:17:44', '20161222113810681189580305593289');

-- ----------------------------
-- Table structure for th_classification
-- ----------------------------
DROP TABLE IF EXISTS `th_classification`;
CREATE TABLE `th_classification` (
  `id` varchar(32) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '分类名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `seq` varchar(11) DEFAULT NULL COMMENT '顺序',
  `isVisible` varchar(5) DEFAULT NULL COMMENT '是否可见',
  `state` varchar(5) DEFAULT NULL COMMENT '状态',
  `level` varchar(12) DEFAULT NULL COMMENT '分类级别',
  `parentId` varchar(32) DEFAULT NULL COMMENT '所属上级分类',
  `otherAttrJson` text COMMENT '自定义属性(使用json方式定义产品自定义属性，eg: {''price'',''价格''}，key为产品属性json的对应key，value为属性名称)',
  `remark` text COMMENT '备注',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_6` (`parentId`),
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`parentId`) REFERENCES `th_classification` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品分类';

-- ----------------------------
-- Records of th_classification
-- ----------------------------
INSERT INTO `th_classification` VALUES ('20170922155839727831157664240076', '女装', '', '1', '1', '1', '0', null, null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20170922155851476375275990068257', '裙装', '', '1', '1', '1', '1', '20170922155839727831157664240076', null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20170922155900143994816435732693', '连衣裙', '', '1', '1', '1', '2', '20170922155851476375275990068257', '[{\"attrCode\":\"20170922155924342749177782192624\",\"attr\":\"颜色\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"红色,黑色,白色\"},{\"attrCode\":\"20170922155953666134633180007523\",\"attr\":\"尺码\",\"inputType\":\"2\",\"isRequired\":\"2\",\"childAttr\":\"均码\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20170922160016873516064921871997', '女鞋', '', '1', '1', '1', '0', null, null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20170922160027076865093045747050', '高跟', '', '1', '1', '1', '1', '20170922160016873516064921871997', null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20170922160040124948343465745025', '圆头', '', '2', '1', '1', '2', '20170922160027076865093045747050', '[{\"attrCode\":\"20170922173002913652458738082960\",\"attr\":\"颜色\",\"inputType\":\"1\",\"isRequired\":\"1\"},{\"attrCode\":\"20170922173022025813064987775377\",\"attr\":\"尺码\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"34,35\"},{\"attrCode\":\"20171027172345112274130482409009\",\"attr\":\"产地\",\"inputType\":\"1\",\"isRequired\":\"1\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20170922160103963740147356256807', '修身裙', '', '1', '1', '1', '2', '20170922155851476375275990068257', '[{\"attrCode\":\"20170922160132846304364678755434\",\"attr\":\"颜色\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"红色,黑色\"},{\"attrCode\":\"20170922160148893812645375812372\",\"attr\":\"尺码\",\"inputType\":\"1\",\"isRequired\":\"1\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20170922170108727175841486008638', '小商品', '', '1', '1', '1', '0', null, null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20170922170142581069964048743031', '小吃', '', '1', '1', '1', '1', '20170922170108727175841486008638', null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20170922170201154241355993238220', '袋装', '', '1', '1', '1', '2', '20170922170142581069964048743031', '[{\"attrCode\":\"20170922170251728913442656434091\",\"attr\":\"重量\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"100g\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20171014165212744335482368671109', '短裙', '', '3', '1', '1', '2', '20170922155851476375275990068257', null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20171014171004400438494734263118', '虚拟商品', '', '31', '1', '1', '0', null, null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20171020142147751081585708164854', '毛呢外套', '冬季新品', '1', '1', '1', '1', '20170922155839727831157664240076', null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20171020142219809531291123190087', '毛呢大衣', '', '1', '1', '1', '2', '20171020142147751081585708164854', '[{\"attrCode\":\"20171020143322817884242768847206\",\"attr\":\"材质\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"羊毛,聚酯,腈纶,仿呢料\"},{\"attrCode\":\"20171020143406382915136199687762\",\"attr\":\"衣长\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"短款,中长款,长款\"},{\"attrCode\":\"20171020143422886414718355564340\",\"attr\":\"材质\",\"inputType\":\"1\",\"isRequired\":\"1\"},{\"attrCode\":\"20171020144326583553060000549540\",\"attr\":\"尺码\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"S,M,L,XL\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20171020142230076132054547768887', '其他分类', '', '8', '1', '1', '2', '20171020142147751081585708164854', null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20171020143954779765302788020463', '童装', '', '5', '1', '1', '0', null, null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20171025100050543557026983149412', '羊毛大衣', '', '2', '1', '1', '2', '20171020142147751081585708164854', '[{\"attrCode\":\"20171025100135068183321767662316\",\"attr\":\"颜色\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"白色,红色,黑色\"},{\"attrCode\":\"20171025100154429890901622623364\",\"attr\":\"尺码\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"均码\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20171025100219058384794993959413', '单排扣大衣', '', '3', '1', '1', '2', '20171020142147751081585708164854', '[{\"attrCode\":\"20171025100431101252923441634114\",\"attr\":\"颜色\",\"inputType\":\"1\",\"isRequired\":\"1\"},{\"attrCode\":\"20171025100439479010449811937262\",\"attr\":\"尺码\",\"inputType\":\"1\",\"isRequired\":\"1\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20171025100247945364463578492952', '中长款大衣', '', '5', '1', '1', '2', '20171020142147751081585708164854', '[{\"attrCode\":\"20171025100337836565202417451529\",\"attr\":\"颜色\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"黑色\"},{\"attrCode\":\"20171025100355804900886186100446\",\"attr\":\"尺码\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"S,M,L\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20171025100314946187546799578446', '双排扣大衣', '', '6', '1', '1', '2', '20171020142147751081585708164854', '[{\"attrCode\":\"20171025100448381843033759752103\",\"attr\":\"颜色\",\"inputType\":\"1\",\"isRequired\":\"1\"},{\"attrCode\":\"20171025100453947388393162965405\",\"attr\":\"尺码\",\"inputType\":\"1\",\"isRequired\":\"1\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20171025100511318078727310556556', '加长款大', '', '6', '1', '2', '0', null, null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20171025100542411099882323542658', '加长款大衣', '', '6', '1', '1', '2', '20171020142147751081585708164854', '[{\"attrCode\":\"20171025100549055254983000473616\",\"attr\":\"颜色\",\"inputType\":\"1\",\"isRequired\":\"1\"},{\"attrCode\":\"20171025100556271839152900005018\",\"attr\":\"尺码\",\"inputType\":\"1\",\"isRequired\":\"1\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20171102104527275475985285767093', '购物卡', '', '1', '1', '1', '1', '20171014171004400438494734263118', '[{\"attrCode\":\"20180122115050693733972373240219\",\"attr\":\"价值\",\"inputType\":\"5\",\"isRequired\":\"1\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20180122100218657507660198357018', '平底', '', '2', '1', '1', '1', '20170922160016873516064921871997', null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20180122100301811509596267554940', '单鞋', '', '1', '1', '1', '2', '20180122100218657507660198357018', '[{\"attrCode\":\"20180122100436008649042718091562\",\"attr\":\"颜色\",\"inputType\":\"1\",\"isRequired\":\"1\"},{\"attrCode\":\"20180122100444587897254187452794\",\"attr\":\"尺码\",\"inputType\":\"1\",\"isRequired\":\"1\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20180122100319009251535488252250', '棉鞋', '', '2', '1', '1', '2', '20180122100218657507660198357018', '[{\"attrCode\":\"20180122100455711105647543867205\",\"attr\":\"颜色\",\"inputType\":\"1\",\"isRequired\":\"1\"},{\"attrCode\":\"20180122100505207201825552522648\",\"attr\":\"尺码\",\"inputType\":\"1\",\"isRequired\":\"1\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20180122100349748252824599094773', '凉鞋/拖鞋', '', '3', '1', '1', '2', '20180122100218657507660198357018', '[{\"attrCode\":\"20180122100514144850564683229776\",\"attr\":\"颜色\",\"inputType\":\"1\",\"isRequired\":\"1\"},{\"attrCode\":\"20180122100527825214931131094809\",\"attr\":\"尺码\",\"inputType\":\"1\",\"isRequired\":\"1\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20180122115017406870057700904947', '充值卡', '', '2', '1', '1', '1', '20171014171004400438494734263118', '[{\"attrCode\":\"20180122115144054202527884485760\",\"attr\":\"面值\",\"inputType\":\"5\",\"isRequired\":\"1\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20180122115119806857145256753318', '面值', '', '1', '1', '2', '2', '20180122115017406870057700904947', null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20180310162143839845394427651591', '运动鞋', '', '3', '1', '2', '1', '20170922160016873516064921871997', '[]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20180310162329752540375910465845', '运动鞋', '', '4', '1', '1', '1', '20170922160016873516064921871997', null, null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20180310162403909567135096701689', '跑鞋', '', '1', '1', '1', '2', '20180310162329752540375910465845', '[{\"attrCode\":\"20180310163707815223112858806830\",\"attr\":\"尺码\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"36,37,38,39,40\"},{\"attrCode\":\"20180310163832377866466338104780\",\"attr\":\"颜色\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"黑色,白色,灰色\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20180310162416249644766691497434', '休闲鞋', '', '2', '1', '1', '2', '20180310162329752540375910465845', '[{\"attrCode\":\"20180310163731166953665849092637\",\"attr\":\"尺码\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"36,37,38,39,40\"}]', null, null, null, null, null, null);
INSERT INTO `th_classification` VALUES ('20180310162428058490800791116828', '登山鞋', '', '3', '1', '1', '2', '20180310162329752540375910465845', '[{\"attrCode\":\"20180310163803626774964163494454\",\"attr\":\"尺码\",\"inputType\":\"2\",\"isRequired\":\"1\",\"childAttr\":\"36,37,38,39,40\"}]', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for th_client_shoppingcart
-- ----------------------------
DROP TABLE IF EXISTS `th_client_shoppingcart`;
CREATE TABLE `th_client_shoppingcart` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL COMMENT '收银员ID(用户ID）',
  `goods_id` varchar(32) DEFAULT NULL COMMENT '产品ID',
  `qrcode_id` varchar(32) DEFAULT NULL,
  `type` varchar(5) DEFAULT NULL COMMENT '类型（1：卖出，2：退回）',
  `count` varchar(50) DEFAULT NULL COMMENT '购买数量',
  `salesPrice` varchar(50) DEFAULT NULL COMMENT '商品售价，由导购开具',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`),
  KEY `qrcode_id` (`qrcode_id`),
  CONSTRAINT `th_client_shoppingcart_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `th_goods` (`id`),
  CONSTRAINT `th_client_shoppingcart_ibfk_2` FOREIGN KEY (`qrcode_id`) REFERENCES `th_qrcode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收银购物车';

-- ----------------------------
-- Records of th_client_shoppingcart
-- ----------------------------

-- ----------------------------
-- Table structure for th_consume
-- ----------------------------
DROP TABLE IF EXISTS `th_consume`;
CREATE TABLE `th_consume` (
  `id` varchar(32) NOT NULL,
  `customer_id` varchar(32) DEFAULT NULL COMMENT '客户ID',
  `guideUser_id` varchar(32) DEFAULT NULL COMMENT '导购（ps：auth_user表里的）',
  `consumeCode` varchar(16) DEFAULT NULL COMMENT '流水单号(有订单用订单)',
  `type` varchar(5) DEFAULT NULL COMMENT '类型（1：充值， 2：充值 (线下)，3：充值返现 4：消费返现 5：消费(线上) 6：消费(线下) 7:退款 ）',
  `money` varchar(50) DEFAULT NULL COMMENT '金额',
  `remark` varchar(100) DEFAULT NULL COMMENT '充值备注其返现金额',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间（消费/充值/返现日期）',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `th_consume_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `th_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户钱包余额流水记录';

-- ----------------------------
-- Records of th_consume
-- ----------------------------
INSERT INTO `th_consume` VALUES ('20180306163129622411031756433399', '20171025092514241801015125166835', null, null, '6', '1.0', '线下消费1.0元', '2018-03-06 16:31:29', '2018-03-06 16:31:29', null, null, null);
INSERT INTO `th_consume` VALUES ('20180306163239867412720155950422', '20171025092514241801015125166835', null, null, '5', '1.0', '线上消费1.0元', '2018-03-06 16:32:39', '2018-03-06 16:32:39', null, null, null);
INSERT INTO `th_consume` VALUES ('20180306163719774337965208530544', '20171025092514241801015125166835', null, null, '7', '1.0', '订单退款到账1.0元', '2018-03-06 16:37:19', '2018-03-06 16:37:19', null, null, null);
INSERT INTO `th_consume` VALUES ('20180306165239575907415182764946', '20171025092514241801015125166835', null, null, '6', '0.1', '线下消费0.1元', '2018-03-06 16:52:39', '2018-03-06 16:52:39', null, null, null);
INSERT INTO `th_consume` VALUES ('20180306165415775673977492722531', '20171025092514241801015125166835', null, null, '7', '0.1', '订单退款到账0.1元', '2018-03-06 16:54:15', '2018-03-06 16:54:15', null, null, null);
INSERT INTO `th_consume` VALUES ('20180306165813895781169094907845', '20171025092514241801015125166835', null, null, '6', '0.1', '线下消费0.1元', '2018-03-06 16:58:13', '2018-03-06 16:58:13', null, null, null);
INSERT INTO `th_consume` VALUES ('20180306170233115564856252709279', '20171025092514241801015125166835', null, null, '7', '0.1', '订单退款到账0.1元', '2018-03-06 17:02:33', '2018-03-06 17:02:33', null, null, null);
INSERT INTO `th_consume` VALUES ('20180306170825001421143648727985', '20171025092514241801015125166835', null, null, '6', '0.1', '线下消费0.1元', '2018-03-06 17:08:25', '2018-03-06 17:08:25', null, null, null);
INSERT INTO `th_consume` VALUES ('20180307093842913844422447095629', '20171025092514241801015125166835', null, null, '5', '10.0', '线上消费10.0元', '2018-03-07 09:38:42', '2018-03-07 09:38:42', null, null, null);
INSERT INTO `th_consume` VALUES ('20180307100101625263254862238274', '20180307095521484289980574167709', null, null, '2', '1000', '线下充值1000元', '2018-03-07 10:01:01', '2018-03-07 10:01:01', null, null, null);
INSERT INTO `th_consume` VALUES ('20180307112939462634744421733147', '20180307095521484289980574167709', null, null, '6', '6.0', '线下消费6.0元', '2018-03-07 11:29:39', '2018-03-07 11:29:39', null, null, null);
INSERT INTO `th_consume` VALUES ('20180307180620221753091340084804', '20180307095521484289980574167709', null, null, '6', '10.0', '线下消费10.0元', '2018-03-07 18:06:20', '2018-03-07 18:06:20', null, null, null);
INSERT INTO `th_consume` VALUES ('20180307180620340125215147927523', '20180307095521484289980574167709', null, null, '4', '30', '消费返现30元', '2018-03-07 18:06:20', '2018-03-07 18:06:20', null, null, null);
INSERT INTO `th_consume` VALUES ('20180307180914934779859637584917', '20180307095521484289980574167709', null, null, '3', '100.0', '线下返现100.0元', '2018-03-07 18:09:14', '2018-03-07 18:09:14', null, null, null);
INSERT INTO `th_consume` VALUES ('20180307180914934824920545335952', '20180307095521484289980574167709', null, null, '2', '100', '线下充值100元', '2018-03-07 18:09:14', '2018-03-07 18:09:14', null, null, null);
INSERT INTO `th_consume` VALUES ('20180307181134636283843980682697', '20180307095521484289980574167709', null, null, '6', '10.0', '线下消费10.0元', '2018-03-07 18:11:34', '2018-03-07 18:11:34', null, null, null);
INSERT INTO `th_consume` VALUES ('20180307181134760001574773850178', '20180307095521484289980574167709', null, null, '4', '30', '消费返现30元', '2018-03-07 18:11:34', '2018-03-07 18:11:34', null, null, null);
INSERT INTO `th_consume` VALUES ('20180308092706509878788163265562', '20180307095521484289980574167709', null, null, '6', '10.0', '线下消费10.0元', '2018-03-08 09:27:06', '2018-03-08 09:27:06', null, null, null);
INSERT INTO `th_consume` VALUES ('20180308093215401539189078490059', '20180307095521484289980574167709', null, null, '7', '9.9', '订单退款到账9.9元', '2018-03-08 09:32:15', '2018-03-08 09:32:15', null, null, null);
INSERT INTO `th_consume` VALUES ('20180308142347826339784803014975', '20171020161046492169283021443205', null, null, '2', '0.1', '线下充值0.1元', '2018-03-08 14:23:47', '2018-03-08 14:23:47', null, null, null);
INSERT INTO `th_consume` VALUES ('20180308142412289275655756323756', '20171020161046492169283021443205', null, null, '2', '0.9', '线下充值0.9元', '2018-03-08 14:24:12', '2018-03-08 14:24:12', null, null, null);
INSERT INTO `th_consume` VALUES ('20180308142630807229174076267422', '20171020161046492169283021443205', null, null, '2', '0.1', '线下充值0.1元', '2018-03-08 14:26:30', '2018-03-08 14:26:30', null, null, null);
INSERT INTO `th_consume` VALUES ('20180308143435759920743953501792', '20171020161046492169283021443205', null, null, '2', '0.1', '线下充值0.1元', '2018-03-08 14:34:35', '2018-03-08 14:34:35', null, null, null);
INSERT INTO `th_consume` VALUES ('20180308182403952073588981341354', '20180307095521484289980574167709', null, null, '6', '1.0', '线下消费1.0元', '2018-03-08 18:24:03', '2018-03-08 18:24:03', null, null, null);
INSERT INTO `th_consume` VALUES ('20180309112138683983884340269735', '20180307095521484289980574167709', null, null, '6', '0.1', '线下消费0.1元', '2018-03-09 11:21:38', '2018-03-09 11:21:38', null, null, null);
INSERT INTO `th_consume` VALUES ('20180313172014463628221576994829', '20180307095521484289980574167709', null, null, '6', '5.0', '线下消费5.0元', '2018-03-13 17:20:14', '2018-03-13 17:20:14', null, null, null);
INSERT INTO `th_consume` VALUES ('20180313172223572565309367014547', '20180307095521484289980574167709', null, null, '7', '5.0', '订单退款到账5.0元', '2018-03-13 17:22:23', '2018-03-13 17:22:23', null, null, null);
INSERT INTO `th_consume` VALUES ('20180314155811621665426814001664', '20180307095521484289980574167709', null, null, '5', '422.95', '线上消费422.95元', '2018-03-14 15:58:11', '2018-03-14 15:58:11', null, null, null);
INSERT INTO `th_consume` VALUES ('20180314165359433947036794726025', '20180307095521484289980574167709', null, null, '5', '499.14', '线上消费499.14元', '2018-03-14 16:53:59', '2018-03-14 16:53:59', null, null, null);

-- ----------------------------
-- Table structure for th_consume_bonus
-- ----------------------------
DROP TABLE IF EXISTS `th_consume_bonus`;
CREATE TABLE `th_consume_bonus` (
  `id` varchar(32) NOT NULL,
  `startMoney` varchar(50) DEFAULT NULL COMMENT '提成档位',
  `proportion` varchar(20) DEFAULT NULL COMMENT '提成比例',
  `remark` text COMMENT '备注',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值提成档位';

-- ----------------------------
-- Records of th_consume_bonus
-- ----------------------------
INSERT INTO `th_consume_bonus` VALUES ('20180314150741485867711151757164', '0.1', '100', null, '2018-03-14 15:07:41', '2018-03-14 15:07:41', null, '20161222113810681189580305593289', null);

-- ----------------------------
-- Table structure for th_consume_bonus_detail
-- ----------------------------
DROP TABLE IF EXISTS `th_consume_bonus_detail`;
CREATE TABLE `th_consume_bonus_detail` (
  `id` varchar(32) NOT NULL,
  `guideUser_id` varchar(32) DEFAULT NULL COMMENT '导购（ps：auth_user表里的）',
  `targetMoney` varchar(50) DEFAULT NULL COMMENT '充值的目标金额',
  `money` varchar(50) DEFAULT NULL COMMENT '提成金额',
  `month` varchar(50) DEFAULT NULL COMMENT '提成月份',
  `isPayMoney` varchar(5) DEFAULT NULL COMMENT '是否发放(1:是,2:否)',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值提成记录';

-- ----------------------------
-- Records of th_consume_bonus_detail
-- ----------------------------

-- ----------------------------
-- Table structure for th_customer
-- ----------------------------
DROP TABLE IF EXISTS `th_customer`;
CREATE TABLE `th_customer` (
  `id` varchar(32) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `birthday` timestamp NULL DEFAULT NULL COMMENT '出生年月',
  `phone` varchar(15) DEFAULT NULL COMMENT '手机号',
  `loginPassword` varchar(30) DEFAULT NULL COMMENT '登录密码',
  `money` varchar(255) DEFAULT NULL COMMENT '钱包余额',
  `payPassword` varchar(30) DEFAULT NULL COMMENT '支付密码',
  `isBlank` varchar(5) DEFAULT NULL COMMENT '是否拉黑（1：否，2：是）',
  `registerBonusMoney` varchar(10) DEFAULT NULL COMMENT '注册奖励金(给guideUser)',
  `employee_id` varchar(32) DEFAULT NULL COMMENT '微信用户ID',
  `guideUser_id` varchar(32) DEFAULT NULL COMMENT '导购',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  `payCode` varchar(20) DEFAULT NULL COMMENT ' 天河余额支付动态密码 ',
  `payCodeCreateTime` timestamp NULL DEFAULT NULL,
  `kefuStartDate` timestamp NULL DEFAULT NULL COMMENT '客服开始时间',
  `kefuState` varchar(5) DEFAULT NULL COMMENT '1:开始2:结束',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_1` (`employee_id`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`employee_id`) REFERENCES `th_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员信息';

-- ----------------------------
-- Records of th_customer
-- ----------------------------
INSERT INTO `th_customer` VALUES ('20170922194407297172957942397337', '郝佩琳（云图网络）', '2002-09-22 00:00:00', '15661451612', 'qwerty', '9797.21', '123456', '1', null, '20170922150215790602282531380838', '20170922171947376165547181122780', '2017-09-22 19:44:07', '2017-09-22 19:44:07', null, '2017-09-25 19:32:35', null, '8360', '2017-11-21 09:40:40', null, null);
INSERT INTO `th_customer` VALUES ('20170923163450618324289056610089', '枫', '2017-09-23 00:00:00', '15044940362', '123456', '10000', null, '1', null, '20170922170038799212551927004046', '', '2017-09-23 16:34:50', '2017-09-23 16:34:50', null, '2017-11-02 15:21:34', null, '4636', '2017-09-23 19:39:06', null, null);
INSERT INTO `th_customer` VALUES ('20170923163519157870406498515016', '昊', '2012-09-23 00:00:00', '18648250697', '123456', '9504.47', '123456', '2', null, '20170922171005299036579267692145', '20170922171947376165547181122780', '2017-09-23 16:35:19', '2017-09-23 16:35:19', null, '2017-10-26 17:20:32', '20161222113810681189580305593289', '6101', '2017-10-20 15:51:49', null, null);
INSERT INTO `th_customer` VALUES ('20171020155712273121866188928881', '莎莎', '1996-10-20 00:00:00', '16600000001', '123456', '30.00', null, '2', null, '20171020155345721288922232573559', '20171020155533327011935951200187', '2017-10-20 15:57:12', '2017-10-20 15:57:12', null, '2018-03-08 10:12:03', '20161222113810681189580305593289', '7697', '2017-10-20 16:05:45', null, null);
INSERT INTO `th_customer` VALUES ('20171020161046492169283021443205', '莎莎', '1997-10-20 00:00:00', '18697409064', '123456', '371.94', '654321', '1', null, null, '20171020155533327011935951200187', '2017-10-20 16:10:46', '2017-10-20 16:10:46', null, '2018-03-08 14:23:18', null, '0467', '2018-03-08 14:33:56', null, null);
INSERT INTO `th_customer` VALUES ('20171021164550227460306945961489', '乐在其中', '1993-10-21 00:00:00', '18647240571', '123456', null, null, '1', null, null, '', '2017-10-21 16:45:50', '2017-10-21 16:45:50', null, null, null, null, null, null, null);
INSERT INTO `th_customer` VALUES ('20171025092514241801015125166835', '莎莎', '2017-10-25 00:00:00', '19900000001', '123456', '2099.28', '123456', '1', null, null, '20171020155533327011935951200187', '2017-10-25 09:25:14', '2017-10-25 09:25:14', null, '2018-03-05 15:47:56', null, null, null, null, null);
INSERT INTO `th_customer` VALUES ('20180307095521484289980574167709', '莎莎', '2018-03-07 00:00:00', '19800000001', '123456', '310.71', '123456', '1', null, '20171020155345721288922232573559', '20171020155533327011935951200187', '2018-03-07 09:55:21', '2018-03-07 09:55:21', null, '2018-03-14 15:50:47', null, null, null, null, null);

-- ----------------------------
-- Table structure for th_employee
-- ----------------------------
DROP TABLE IF EXISTS `th_employee`;
CREATE TABLE `th_employee` (
  `id` varchar(32) NOT NULL,
  `openid` varchar(255) DEFAULT NULL COMMENT '微信openid',
  `name` varchar(255) DEFAULT NULL COMMENT '微信昵称',
  `headimgurl` varchar(255) DEFAULT NULL COMMENT '微信头像',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  `kefuStartDate` timestamp NULL DEFAULT NULL COMMENT '客服开始时间',
  `kefuState` varchar(5) DEFAULT NULL COMMENT '1:开始2:结束',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信用户信息表';

-- ----------------------------
-- Records of th_employee
-- ----------------------------
INSERT INTO `th_employee` VALUES ('20170922150215790602282531380838', 'oo58PxLtbx101HJemUDgj4CenAME', '燕＠云图网络', 'http://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqqG7YoGUvNTCNBEpibAia3NnK0vz2ia85ibSdda5zIOkMaJCa7zXDLTHUQHD36I9d7NpR5Yc3ysVj12Q/0', null, '2017-09-22 15:02:15', '2017-11-21 10:50:22', null, null, null, '2');
INSERT INTO `th_employee` VALUES ('20170922151232188646652555657222', 'oo58PxPWDF-TzjRJgkukw92bVhuE', '乐在其中', 'http://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erUN2gWl3HFksQhGW9m4HcksGYTcwwCib8oop9OCB7iaLQOVqcL55khqQcjDJA8k4QAdj0Eod9ouCzw/0', null, '2017-09-22 15:12:32', '2017-11-03 17:21:30', null, null, null, '2');
INSERT INTO `th_employee` VALUES ('20170922160117982872584008462036', 'oo58PxNhpFvGUULRXmQ4rd0TBQT0', 'Jolie Cuddle', 'http://wx.qlogo.cn/mmopen/vi_32/hGkGnLnAxjQnA1XIpgE0CPiczgjclucAqGNfvUMpRk5icQESzroplqiagibib07cSJMFiaQiaibfSwtIr4dJMWgXC0Y58g/0', null, '2017-09-22 16:01:17', null, null, null, null, '2');
INSERT INTO `th_employee` VALUES ('20170922165555112992667235019688', 'oo58PxI7y_D4vt0AmHjslAhU19cg', '郝佩琳（云图网络）', 'http://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqfnbRHW1PibTWFp1KXf4BWdibVvLyqxI4ibsFvibFJU1uGOf90n2t9hSskD4wMIWrIH6p7DCnFCCgUEQ/0', null, '2017-09-22 16:55:55', '2017-09-25 16:45:05', null, null, '2017-09-25 16:58:17', '2');
INSERT INTO `th_employee` VALUES ('20170922170038799212551927004046', 'oo58PxIrr2TvypVn8tLFRH3JC354', '枫', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKlPWz6sE2Iic2fx8kR2EQpjiaSG8eGKibYcd7nvWeV2HicbHZay9lcrqrBvWf7Pjiabic1bBcu8qhdk2Yw/132', null, '2017-09-22 17:00:38', '2018-03-12 16:32:48', null, null, '2017-09-25 11:35:59', '2');
INSERT INTO `th_employee` VALUES ('20170922171005299036579267692145', 'oo58PxH0iE_mX8MGU2p8UyK5JdpY', '昊', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLH6bicWSDcWibICKrjmQo9qs9qiag4yYicVgaDYNvN9Fs2sYkxoMiaHOAmbGEcmgcAqZSqAX1EBia0C9Rg/132', null, '2017-09-22 17:10:05', '2018-03-04 14:56:15', null, null, null, '2');
INSERT INTO `th_employee` VALUES ('20170922171009209031023828003772', 'oo58PxE7ShTHjIgkHOc7jRyg2_0I', '*', 'http://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erryIKWOe9iadz5LRn0aVeT9tq6hhsNlGZJibA6MKNlsQvwYhRZwY4TohABB3ssW7B9sYTx16D1e85w/0', null, '2017-09-22 17:10:09', null, null, null, '2017-09-22 17:17:07', '2');
INSERT INTO `th_employee` VALUES ('20170925192834186772481244845723', 'oo58PxKsY1K84oeK_eUJbCPXYNR8', '郝佩琳(麦洛科技)', 'http://wx.qlogo.cn/mmopen/vi_32/ZOGZzUVe5WI0er8HIkTEWGv9fdUn2cicZzlXEaIEldFPBTEp7IicdRicmyHAeLC8xVdC5BuhxHH5tXqIniaGhVLibhg/0', null, '2017-09-25 19:28:34', null, null, null, null, '2');
INSERT INTO `th_employee` VALUES ('20171020155345721288922232573559', 'oo58PxDMsAz0tZ9XJ76W5C83jn5M', '莎莎', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqNKGqOqXlibicQ1Auia63icduVsNRnEVqMXsU9qAoJaJkZyUNI9WBq0sFazN0ia8KvKwtEJEfqibwz0T8Q/132', null, '2017-10-20 15:53:45', '2018-03-14 14:48:03', null, null, '2017-11-06 11:34:44', '2');
INSERT INTO `th_employee` VALUES ('20171021112315270920603946338559', 'oo58PxHn4wzPEMp60iSgE42WFsQ0', '怡红公子', 'http://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKc1JQ3ibH5Xib4lmmxf8DGMX6VYQZr7jXQyoLribOWFVYfXaEpaUyJrhNYayqQpKvKXX2uf752IhjZA/0', null, '2017-10-21 11:23:15', null, null, null, null, '2');
INSERT INTO `th_employee` VALUES ('20171024185504500592224864155700', 'oo58PxG_1cfVHVcGsh4Nz49k2iJQ', '头像不代表实际', 'http://wx.qlogo.cn/mmopen/vi_32/wPlZ1VDnXPjjfS1Np2OgbT4ZuXjlhAG1SeFurjBVq2ppv6zLA036d4ic4QbeZWx8UtQo5FZBYwjBfAFgkdVCXbA/0', null, '2017-10-24 18:55:04', '2017-10-25 09:32:59', null, null, null, '2');
INSERT INTO `th_employee` VALUES ('20171026091922266062718031729632', 'oo58PxPa6rAt3Nlg9vJl5m2CbTdM', '李小梦', 'http://wx.qlogo.cn/mmhead/JRicrayPGR3OgOoJzRdysrPtF7GSKy4YQxMuyBxmoyI1IoecJOsFicQA/0', null, '2017-10-26 09:19:22', null, null, null, null, '2');
INSERT INTO `th_employee` VALUES ('20171101170029924695070661647040', 'oo58PxCxyZ_JsQRsWXBcQQ-Yl6UI', '且听风吟', 'http://wx.qlogo.cn/mmopen/vi_32/ajNVdqHZLLARcOy402vzpBOufbJJCmkCSwM9F2EnRXglOV09Wo9c3aJhmG8S1zIicNGRT4StIQMnSmSq9uWa95w/0', null, '2017-11-01 17:00:29', null, null, null, '2017-11-01 17:01:10', '2');
INSERT INTO `th_employee` VALUES ('20180305154103329318389982103365', 'oo58PxK_ztSVKAmG8utMPAnljrx0', '我叫好高兴', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJfOvffiawjS8fEXPj77exDRFkLOKfjJibzZov7pFJb3em8pDoowbpqfRZhFqzExypiapWiaicEfwhQMFg/132', null, '2018-03-05 15:41:03', null, null, null, null, '2');

-- ----------------------------
-- Table structure for th_eticket
-- ----------------------------
DROP TABLE IF EXISTS `th_eticket`;
CREATE TABLE `th_eticket` (
  `id` varchar(32) NOT NULL,
  `name` varchar(20) DEFAULT NULL COMMENT '名称',
  `type` varchar(5) DEFAULT NULL COMMENT '类型（1：专用，2：通用）',
  `outType` varchar(5) DEFAULT NULL COMMENT '发放类型(1：手动发放，2：自动发放-交易，3：自动发放-微信注册，4：自动发放-微信充值，5：自动发放-生日当月)',
  `dateLimit` varchar(20) DEFAULT NULL COMMENT '电子券有效期（天）',
  `price` varchar(20) DEFAULT NULL COMMENT '电子券金额',
  `outStore_id` varchar(32) DEFAULT NULL COMMENT '发放门店（指定在哪个门店购买商品发放本电子券,全场发 本字段为空）',
  `useStore_id` varchar(32) DEFAULT NULL COMMENT '可使用的门店ID（专属卷有值，通用卷忽略）',
  `outLimit` varchar(20) DEFAULT NULL COMMENT '发放阀值',
  `useLimit` varchar(20) DEFAULT NULL COMMENT '使用阀值',
  `isDelete` varchar(5) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  `stopSendTime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `outStore_id` (`outStore_id`),
  KEY `useStore_id` (`useStore_id`),
  CONSTRAINT `th_eticket_ibfk_1` FOREIGN KEY (`outStore_id`) REFERENCES `th_store` (`id`),
  CONSTRAINT `th_eticket_ibfk_2` FOREIGN KEY (`useStore_id`) REFERENCES `th_store` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of th_eticket
-- ----------------------------
INSERT INTO `th_eticket` VALUES ('20180306181519902840978898945756', '10元通用', '2', '1', '15', '11', null, null, null, '0.01', '1', '2018-03-06 18:15:19', '2018-03-06 18:15:19', '20161222113810681189580305593289', '2018-03-17 14:38:32', '20161222113810681189580305593289', '2018-03-17 23:59:00');
INSERT INTO `th_eticket` VALUES ('20180307095327530060072730364886', '新人通用券10', '2', '3', '30', '10', null, null, null, '0.01', '1', '2018-03-07 09:53:27', '2018-03-07 09:53:27', '20161222113810681189580305593289', '2018-03-07 09:53:35', '20161222113810681189580305593289', '2018-12-31 23:59:00');
INSERT INTO `th_eticket` VALUES ('20180307183407348130129293612839', '消费送券5', '1', '2', '2', '5', null, '20171020141842757704681968303771', '0.01', '0.01', '2', '2018-03-07 18:34:07', '2018-03-07 18:34:07', '20161222113810681189580305593289', '2018-03-08 09:14:35', '20161222113810681189580305593289', '2018-03-10 23:59:00');
INSERT INTO `th_eticket` VALUES ('20180308155813868966246087773827', '1元通用', '2', '2', '1', '1', null, null, '0.01', '1', '1', '2018-03-08 15:58:13', '2018-03-08 15:58:13', '20161222113810681189580305593289', null, null, '2018-03-08 23:59:00');
INSERT INTO `th_eticket` VALUES ('20180308155906644170172255673640', '4', '2', '2', '2', '1', null, null, '0.01', '4', '1', '2018-03-08 15:59:06', '2018-03-08 15:59:06', '20161222113810681189580305593289', '2018-03-08 17:06:47', '20161222113810681189580305593289', '2018-03-08 23:59:00');
INSERT INTO `th_eticket` VALUES ('20180308161424331881752206630853', '专用1', '1', '2', '15', '1', '20171020141842757704681968303771', '20171020141842757704681968303771', '0.01', '0.01', '2', '2018-03-08 16:14:24', '2018-03-08 16:14:24', '20161222113810681189580305593289', null, null, '2018-03-08 23:59:00');
INSERT INTO `th_eticket` VALUES ('20180313181714540407742599947417', '专用1', '1', '1', '2', '1', null, '20180122101904528474410614949352', null, '0.1', '1', '2018-03-13 18:17:14', '2018-03-13 18:17:14', '20161222113810681189580305593289', null, null, '2018-03-17 23:59:00');
INSERT INTO `th_eticket` VALUES ('20180314154854890530282965297353', '5元券', '2', '1', '365', '5', null, null, null, '0.1', '1', '2018-03-14 15:48:54', '2018-03-14 15:48:54', '20161222113810681189580305593289', null, null, '2018-03-17 23:59:00');
INSERT INTO `th_eticket` VALUES ('20180510172856914378322388981793', '自动发放无限制', '2', '2', '3', '10', null, null, '0.01', '100', '1', '2018-05-10 17:28:56', '2018-05-10 17:28:56', '20161222113810681189580305593289', null, null, '2018-05-12 17:00:00');

-- ----------------------------
-- Table structure for th_eticket_outrecord
-- ----------------------------
DROP TABLE IF EXISTS `th_eticket_outrecord`;
CREATE TABLE `th_eticket_outrecord` (
  `id` varchar(32) NOT NULL,
  `code` varchar(32) DEFAULT NULL,
  `state` varchar(5) DEFAULT NULL COMMENT '使用状态',
  `remark` varchar(255) DEFAULT NULL,
  `eticket_id` varchar(32) DEFAULT NULL,
  `isHide` varchar(5) DEFAULT NULL COMMENT '是否隐藏 1:隐藏 2:显示 ',
  `customer_id` varchar(32) DEFAULT NULL,
  `createDate` timestamp NULL DEFAULT NULL COMMENT '发放时间（创建时间）',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `eticket_id` (`eticket_id`) USING BTREE,
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `th_eticket_outrecord_ibfk_1` FOREIGN KEY (`eticket_id`) REFERENCES `th_eticket` (`id`),
  CONSTRAINT `th_eticket_outrecord_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `th_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='电子券发放记录';

-- ----------------------------
-- Records of th_eticket_outrecord
-- ----------------------------
INSERT INTO `th_eticket_outrecord` VALUES ('20180510172948596926760731249060', '201805101729480000', '1', '购买成功自动发送', '20180510172856914378322388981793', '2', '20170923163450618324289056610089', '2018-05-10 17:29:48', '2018-05-10 17:29:48', null, null, null);
INSERT INTO `th_eticket_outrecord` VALUES ('20180510173340935949641526524108', '201805101733400000', '1', '购买成功自动发送', '20180510172856914378322388981793', '2', '20170923163450618324289056610089', '2018-05-10 17:33:40', '2018-05-10 17:33:40', null, null, null);

-- ----------------------------
-- Table structure for th_eticket_userecord
-- ----------------------------
DROP TABLE IF EXISTS `th_eticket_userecord`;
CREATE TABLE `th_eticket_userecord` (
  `id` varchar(32) NOT NULL,
  `order_id` varchar(32) DEFAULT NULL,
  `eticket_out_record_id` varchar(32) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `eticket_out_record_id` (`eticket_out_record_id`),
  CONSTRAINT `th_eticket_userecord_ibfk_2` FOREIGN KEY (`eticket_out_record_id`) REFERENCES `th_eticket_outrecord` (`id`),
  CONSTRAINT `th_eticket_userecord_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `th_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of th_eticket_userecord
-- ----------------------------

-- ----------------------------
-- Table structure for th_evaluation
-- ----------------------------
DROP TABLE IF EXISTS `th_evaluation`;
CREATE TABLE `th_evaluation` (
  `id` char(32) NOT NULL,
  `goods_id` char(32) DEFAULT NULL,
  `customer_id` char(32) DEFAULT NULL,
  `content` text,
  `createTime` timestamp NULL DEFAULT NULL,
  `imgName` text,
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `th_evaluation_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `th_goods` (`id`),
  CONSTRAINT `th_evaluation_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `th_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评价';

-- ----------------------------
-- Records of th_evaluation
-- ----------------------------
INSERT INTO `th_evaluation` VALUES ('20180306163547258523973472457149', '20171020143937478702840762092955', '20171025092514241801015125166835', '好评', '2018-03-06 16:35:47', '20180306163539671285552911432824.jpg,20180306163546767847714065314954.jpg', '2018-03-06 16:35:47', null, null, null);
INSERT INTO `th_evaluation` VALUES ('20180307094832883838722815770833', '20171020170557715117684770670802', '20171025092514241801015125166835', '好评你明哦哦，你就不要把你jgqjjHwh[]_\\{|~}#<>%^€£*¥+=.,?!’', '2018-03-07 09:48:32', null, '2018-03-07 09:48:32', null, null, null);
INSERT INTO `th_evaluation` VALUES ('20180314172639969569550157486355', '20180310172311004667310961479080', '20180307095521484289980574167709', '质量很好', '2018-03-14 17:26:39', '20180314172600306673001869681722.jpg,20180314172624692507573719783308.jpg', '2018-03-14 17:26:39', null, null, null);

-- ----------------------------
-- Table structure for th_goods
-- ----------------------------
DROP TABLE IF EXISTS `th_goods`;
CREATE TABLE `th_goods` (
  `id` varchar(32) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `specification_id` varchar(32) DEFAULT NULL COMMENT '产品规格',
  `goods_id` varchar(32) DEFAULT NULL COMMENT '所属上级产品',
  `store_id` varchar(32) DEFAULT NULL COMMENT '所属门店',
  `brand_id` varchar(32) DEFAULT NULL COMMENT '所属品牌',
  `classification_id` varchar(32) DEFAULT NULL COMMENT '所属分类',
  `marketTime` varchar(50) DEFAULT NULL COMMENT '上市时间',
  `goodsCode` varchar(100) DEFAULT NULL,
  `price` varchar(20) DEFAULT NULL,
  `salesPrice` varchar(20) DEFAULT NULL,
  `warningUp` varchar(20) DEFAULT NULL COMMENT '库存预警上线',
  `warningDown` varchar(20) DEFAULT NULL COMMENT '库存预警下线',
  `goodsColor` varchar(20) DEFAULT NULL COMMENT '颜色',
  `goodsSize` varchar(20) DEFAULT NULL COMMENT '尺码',
  `otherAttr` text COMMENT '个性化参数（格式由分类表决定，数据放在这里）',
  `remark` varchar(255) DEFAULT NULL,
  `isRecommed` varchar(10) DEFAULT NULL COMMENT '是否推荐 1：是，2：否',
  `isAbnormal` varchar(10) DEFAULT NULL,
  `isVisible` varchar(10) DEFAULT NULL COMMENT '上下架, 1：上架，2：下架',
  `isDelete` varchar(5) DEFAULT NULL COMMENT '是否删除（1：否，2：是）',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_4` (`store_id`),
  KEY `FK_Reference_5` (`brand_id`),
  KEY `FK_Reference_7` (`classification_id`),
  KEY `FK_Reference_8` (`goods_id`),
  KEY `specification_id` (`specification_id`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`store_id`) REFERENCES `th_store` (`id`),
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`brand_id`) REFERENCES `th_brand` (`id`),
  CONSTRAINT `FK_Reference_7` FOREIGN KEY (`classification_id`) REFERENCES `th_classification` (`id`),
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`goods_id`) REFERENCES `th_goods` (`id`),
  CONSTRAINT `th_goods_ibfk_1` FOREIGN KEY (`specification_id`) REFERENCES `th_specification` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品';

-- ----------------------------
-- Records of th_goods
-- ----------------------------
INSERT INTO `th_goods` VALUES ('20170922164348366833637124707254', '2017春夏印花连衣裙V领裹身裙开叉性感长裙修身度假沙滩裙', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20170922155623033757857866122344', '20170922155900143994816435732693', '2017', '0001', '4560.7', '0.56', '5', '2', null, null, null, '', '2', '2', '1', '1', '2017-09-22 16:43:48', '2017-09-22 16:43:48', '20161222113810681189580305593289', '2018-03-10 17:40:14', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922164440302889210003523496', null, '20170922160206729295103754527856', '20170922164348366833637124707254', '20180122101904528474410614949352', '20170922155623033757857866122344', '20170922155900143994816435732693', null, null, '4560.7', '0.56', null, null, null, null, '{\"20170922155924342749177782192624\":\"红色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-09-22 16:44:40', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922164440304791894654717187', null, '20170922160206729295103754527856', '20170922164348366833637124707254', '20180122101904528474410614949352', '20170922155623033757857866122344', '20170922155900143994816435732693', null, null, '4560.7', '0.56', null, null, null, null, '{\"20170922155924342749177782192624\":\"黑色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-09-22 16:44:40', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922164440361477844917723603', null, '20170922160206729295103754527856', '20170922164348366833637124707254', '20180122101904528474410614949352', '20170922155623033757857866122344', '20170922155900143994816435732693', null, null, '4560.7', '0.56', null, null, null, null, '{\"20170922155924342749177782192624\":\"白色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-09-22 16:44:40', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922164753384264999000703592', '马尔代夫红色森女不规则大摆荷叶边仙女裙度假海边沙滩雪纺连衣裙', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20170922155623033757857866122344', '20170922155900143994816435732693', '2017', '0002', '0.5', '0.43', '5', '3', null, null, null, '', '2', '2', '1', '1', '2017-09-22 16:47:53', '2017-09-22 16:47:53', '20161222113810681189580305593289', '2018-03-10 17:43:51', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922164753385277306649785468', null, '20170922160206729295103754527856', '20170922164753384264999000703592', '20180122101904528474410614949352', '20170922155623033757857866122344', '20170922155900143994816435732693', null, null, '0.5', '0.43', null, null, null, null, '{\"20170922155924342749177782192624\":\"红色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-09-22 16:47:53', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922164753386996847830327438', null, '20170922160206729295103754527856', '20170922164753384264999000703592', '20180122101904528474410614949352', '20170922155623033757857866122344', '20170922155900143994816435732693', null, null, '0.5', '0.43', null, null, null, null, '{\"20170922155924342749177782192624\":\"黑色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-09-22 16:47:53', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922164753454668307317790511', null, '20170922160206729295103754527856', '20170922164753384264999000703592', '20180122101904528474410614949352', '20170922155623033757857866122344', '20170922155900143994816435732693', null, null, '0.5', '0.43', null, null, null, null, '{\"20170922155924342749177782192624\":\"白色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-09-22 16:47:53', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922165036441147383554204347', null, '20170922160206729295103754527856', '20170922165036441661166265911438', '20170922155207290634168580342140', '20170922155649207495063299482529', '20170922160103963740147356256807', null, null, '210', '20', null, null, null, null, '{\"20170922160132846304364678755434\":\"红色\",\"20170922160148893812645375812372\":\"L\"}', null, null, null, null, '1', null, '2017-09-22 16:50:36', '20161222113810681189580305593289', '2017-10-26 10:20:56', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922165036441661166265911438', '天天特价女装真丝雪纺喇叭袖收腰大裙摆仙女度假连衣裙仙女长裙', '20170922160206729295103754527856', null, '20170922155207290634168580342140', '20170922155649207495063299482529', '20170922160103963740147356256807', '2017', '0003', '210', '20', '5', '5', null, null, null, '', '2', '2', '1', '1', '2017-09-22 16:50:36', '2017-09-22 16:50:36', '20161222113810681189580305593289', '2018-03-05 11:15:10', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922165036442497838073910712', null, '20170922160206729295103754527856', '20170922165036441661166265911438', '20170922155207290634168580342140', '20170922155649207495063299482529', '20170922160103963740147356256807', null, null, '210', '20', null, null, null, null, '{\"20170922160132846304364678755434\":\"黑色\",\"20170922160148893812645375812372\":\"M\"}', null, null, null, null, '1', null, '2017-09-22 16:50:36', '20161222113810681189580305593289', '2017-10-26 10:20:56', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922165751042747443964724774', '春季新款连衣裙秋装长袖打底裙修身中长款印花钉珠大码时尚a字裙', '20170922160206729295103754527856', null, '20170922155207290634168580342140', '20170922155649207495063299482529', '20170922160103963740147356256807', '2017', '0004', '580', '16', '5', '3', null, null, null, '', '2', '2', '1', '1', '2017-09-22 16:57:51', '2017-09-22 16:57:51', '20161222113810681189580305593289', '2018-03-05 11:15:05', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922165751044282370764271841', null, '20170922160206729295103754527856', '20170922165751042747443964724774', '20170922155207290634168580342140', '20170922155649207495063299482529', '20170922160103963740147356256807', null, null, '580', '16', null, null, null, null, '{\"20170922160132846304364678755434\":\"红色\",\"20170922160148893812645375812372\":\"XL\"}', null, null, null, null, '1', null, '2017-09-22 16:57:51', '20161222113810681189580305593289', '2017-10-26 10:21:04', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922165751044670932756283815', null, '20170922160206729295103754527856', '20170922165751042747443964724774', '20170922155207290634168580342140', '20170922155649207495063299482529', '20170922160103963740147356256807', null, null, '580', '16', null, null, null, null, '{\"20170922160132846304364678755434\":\"黑色\",\"20170922160148893812645375812372\":\"M\"}', null, null, null, null, '1', null, '2017-09-22 16:57:51', '20161222113810681189580305593289', '2017-10-26 10:21:04', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922165751045445339597122875', null, '20170922160206729295103754527856', '20170922165751042747443964724774', '20170922155207290634168580342140', '20170922155649207495063299482529', '20170922160103963740147356256807', null, null, '580', '16', null, null, null, null, '{\"20170922160132846304364678755434\":\"红色\",\"20170922160148893812645375812372\":\"M\"}', null, null, null, null, '1', null, '2017-09-22 16:57:51', '20161222113810681189580305593289', '2017-10-26 10:21:04', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922165751136019703879289424', null, '20170922160206729295103754527856', '20170922165751042747443964724774', '20170922155207290634168580342140', '20170922155649207495063299482529', '20170922160103963740147356256807', null, null, '580', '16', null, null, null, null, '{\"20170922160132846304364678755434\":\"黑色\",\"20170922160148893812645375812372\":\"XL\"}', null, null, null, null, '1', null, '2017-09-22 16:57:51', '20161222113810681189580305593289', '2017-10-26 10:21:04', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922165937277224378358837932', '高跟鞋女鞋2017春新款细跟职业尖头单鞋中跟女士皮鞋', '20170922160219718260550566573824', null, '20170922155758751662910860438310', '20170922170008418500507169281039', '20170922160040124948343465745025', '2017', '0005', '1', '0.40', '5', '4', null, null, null, '', '2', '2', '1', '1', '2017-09-22 16:59:37', '2017-09-22 16:59:37', '20161222113810681189580305593289', '2018-03-14 14:15:09', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922170523551944134261972825', '良品干果', '20170922160206729295103754527856', null, '20170922155512650796375955980227', '20170922170542478009503390176485', '20170922170201154241355993238220', '2017', '0006', '0.5', '0.40', '2', '2', null, null, null, '', '2', '2', '1', '1', '2017-09-22 17:05:23', '2017-09-22 17:05:23', '20161222113810681189580305593289', '2017-09-22 18:54:22', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922170523552054457950010851', null, '20170922160206729295103754527856', '20170922170523551944134261972825', '20170922155512650796375955980227', '20170922170542478009503390176485', '20170922170201154241355993238220', null, null, '0.5', '0.40', null, null, null, null, '{\"20170922170251728913442656434091\":\"100g\"}', null, null, null, null, '1', null, '2017-09-22 17:05:23', '20161222113810681189580305593289', '2017-09-22 17:06:27', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922171744928951383856667403', '欧美111头高跟鞋女秋细跟中跟浅口性感黑色漆皮工作鞋单鞋', '20170922160219718260550566573824', null, '20170922155758751662910860438310', '20170922170008418500507169281039', '20170922160040124948343465745025', '2017', '0007', '50', '10.99', '3', '2', null, null, null, '', '1', '2', '1', '1', '2017-09-22 17:17:44', '2017-09-22 17:17:44', '20161222113810681189580305593289', '2018-03-14 14:14:53', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922173129684003478306409198', null, '20170922160219718260550566573824', '20170922171744928951383856667403', '20170922155758751662910860438310', '20170922170008418500507169281039', '20170922160040124948343465745025', null, null, '50', '10.99', null, null, null, null, '{\"20170922173002913652458738082960\":\"红色\",\"20170922173022025813064987775377\":\"34\",\"20171027172345112274130482409009\":\"广州\"}', null, null, '1', null, '1', null, '2017-09-22 17:31:29', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922173129684921855528678042', null, '20170922160219718260550566573824', '20170922171744928951383856667403', '20170922155758751662910860438310', '20170922170008418500507169281039', '20170922160040124948343465745025', null, null, '50', '10.99', null, null, null, null, '{\"20170922173002913652458738082960\":\"红色\",\"20170922173022025813064987775377\":\"35\",\"20171027172345112274130482409009\":\"广州\"}', null, null, '1', null, '1', null, '2017-09-22 17:31:29', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922173129789593368539100635', null, '20170922160219718260550566573824', '20170922171744928951383856667403', '20170922155758751662910860438310', '20170922170008418500507169281039', '20170922160040124948343465745025', null, null, '50', '10.99', null, null, null, null, '{\"20170922173002913652458738082960\":\"黑色\",\"20170922173022025813064987775377\":\"34\",\"20171027172345112274130482409009\":\"广州\"}', null, null, '1', null, '1', null, '2017-09-22 17:31:29', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922173129791742628482877468', null, '20170922160219718260550566573824', '20170922171744928951383856667403', '20170922155758751662910860438310', '20170922170008418500507169281039', '20170922160040124948343465745025', null, null, '50', '10.99', null, null, null, null, '{\"20170922173002913652458738082960\":\"黑色\",\"20170922173022025813064987775377\":\"35\",\"20171027172345112274130482409009\":\"广州\"}', null, null, '1', null, '1', null, '2017-09-22 17:31:29', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922173157232869154187665661', null, '20170922160219718260550566573824', '20170922165937277224378358837932', '20170922155758751662910860438310', '20170922170008418500507169281039', '20170922160040124948343465745025', null, null, '1', '0.40', null, null, null, null, '{\"20170922173002913652458738082960\":\"红色\",\"20170922173022025813064987775377\":\"34\",\"20171027172345112274130482409009\":\"sad\"}', null, null, '1', null, '1', null, '2017-09-22 17:31:57', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922173157232953462119171816', null, '20170922160219718260550566573824', '20170922165937277224378358837932', '20170922155758751662910860438310', '20170922170008418500507169281039', '20170922160040124948343465745025', null, null, '1', '0.40', null, null, null, null, '{\"20170922173002913652458738082960\":\"红色\",\"20170922173022025813064987775377\":\"35\",\"20171027172345112274130482409009\":\"asd\"}', null, null, '1', null, '1', null, '2017-09-22 17:31:57', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922173157320896988500436809', null, '20170922160219718260550566573824', '20170922165937277224378358837932', '20170922155758751662910860438310', '20170922170008418500507169281039', '20170922160040124948343465745025', null, null, '1', '0.40', null, null, null, null, '{\"20170922173002913652458738082960\":\"黑色\",\"20170922173022025813064987775377\":\"34\",\"20171027172345112274130482409009\":\"asd\"}', null, null, '1', null, '1', null, '2017-09-22 17:31:57', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170922173157321921086198377291', null, '20170922160219718260550566573824', '20170922165937277224378358837932', '20170922155758751662910860438310', '20170922170008418500507169281039', '20170922160040124948343465745025', null, null, '1', '0.40', null, null, null, null, '{\"20170922173002913652458738082960\":\"黑色\",\"20170922173022025813064987775377\":\"35\",\"20171027172345112274130482409009\":\"ad\"}', null, null, '1', null, '1', null, '2017-09-22 17:31:57', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20170926103923003853017209983477', '零食', '20170922160206729295103754527856', null, '20170922155512650796375955980227', '20170922170542478009503390176485', '20170922170201154241355993238220', '2014', '111111111', '0.6', '0.48', '2', '2', null, null, null, '', '2', '2', '1', '1', '2017-09-26 10:39:23', '2017-09-26 10:39:23', '20170923171444523929901468294484', '2017-09-26 10:40:05', '20170923171444523929901468294484');
INSERT INTO `th_goods` VALUES ('20170926103923013173037375331770', null, '20170922160206729295103754527856', '20170926103923003853017209983477', '20170922155512650796375955980227', '20170922170542478009503390176485', '20170922170201154241355993238220', null, null, '0.6', '0.48', null, null, null, null, '{\"20170922170251728913442656434091\":\"100g\"}', null, null, null, null, '1', null, '2017-09-26 10:39:23', '20170923171444523929901468294484', '2017-09-26 10:40:05', '20170923171444523929901468294484');
INSERT INTO `th_goods` VALUES ('20171014165251008459951743489247', '第三种服装', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20170922155623033757857866122344', '20170922155900143994816435732693', 'wqe', 'wwq', '123', '0.72', '1', '1', null, null, null, '', '2', '2', '1', '1', '2017-10-14 16:52:51', '2017-10-14 16:52:51', '20161222113810681189580305593289', '2018-03-10 17:39:43', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171016094309465163388680954678', '礼品卡1', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20170922170008418500507169281039', '20171102104527275475985285767093', '0304', '0304', '1', '0.3', '10', '1', null, null, null, '', '2', '2', '1', '1', '2017-10-16 09:43:09', '2017-10-16 09:43:09', '20161222113810681189580305593289', '2018-05-10 18:11:31', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171016094309470202065024630645', null, '20170922160206729295103754527856', '20171016094309465163388680954678', '20170922155512650796375955980227', '20170922170542478009503390176485', '20170922170201154241355993238220', null, null, '1', '0.3', null, null, null, null, '{\"20170922170251728913442656434091\":\"100g\"}', null, null, null, null, '2', null, '2017-10-16 09:43:09', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20171016095421291400352421533005', null, '20170922160206729295103754527856', '20171016094309465163388680954678', '20180122101904528474410614949352', '20170922170008418500507169281039', '20171102104527275475985285767093', null, null, '1', '0.3', null, null, null, null, '{\"20180122115050693733972373240219\":\"10\"}', null, null, '1', null, '1', null, '2017-10-16 09:54:21', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20171020143937478702840762092955', '测试韩国2017新款秋冬双面呢焦糖色矮个外套', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', '2017年10月20日', 'csbh01', '1.78', '1', '5', '1', null, null, null, 'sdf', '2', '2', '1', '1', '2017-10-20 14:39:37', '2017-10-20 14:39:37', '20161222113810681189580305593289', '2018-03-09 17:05:01', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171020143937479575128993734718', null, '20170922160206729295103754527856', '20171020143937478702840762092955', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '1.78', '1', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"短款\",\"20171020143422886414718355564340\":\"sdf\",\"20171020144326583553060000549540\":\"S\"}', null, null, '1', null, '1', null, '2017-10-20 14:39:37', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171020144710371134027497052566', null, '20170922160206729295103754527856', '20171020143937478702840762092955', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '1.78', '1', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"短款\",\"20171020143422886414718355564340\":\"sdf\",\"20171020144326583553060000549540\":\"S\"}', null, null, '1', null, '1', null, '2017-10-20 14:47:10', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171020144710372918583430481077', null, '20170922160206729295103754527856', '20171020143937478702840762092955', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '1.78', '1', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"短款\",\"20171020143422886414718355564340\":\"sdf\",\"20171020144326583553060000549540\":\"L\"}', null, null, '1', null, '1', null, '2017-10-20 14:47:10', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171020144710372983881697334208', null, '20170922160206729295103754527856', '20171020143937478702840762092955', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '1.78', '1', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"短款\",\"20171020143422886414718355564340\":\"sdf\",\"20171020144326583553060000549540\":\"M\"}', null, null, '1', null, '1', null, '2017-10-20 14:47:10', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171020170557715117684770670802', '秋冬季韩版矮个子中长款韩国原宿风呢子大衣', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', '2017', 'csbh02', '100', '10', '5', '2', null, null, null, '', '1', '2', '1', '1', '2017-10-20 17:05:57', '2017-10-20 17:05:57', '20161222113810681189580305593289', '2018-03-14 14:14:37', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171020170557727164476982899392', null, '20170922160206729295103754527856', '20171020170557715117684770670802', '20171020141842757704681968303771', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '100', '10', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"短款\",\"20171020143422886414718355564340\":\"羊毛\",\"20171020144326583553060000549540\":\"S\"}', null, null, '1', null, '2', null, '2017-10-20 17:05:57', '20161222113810681189580305593289', '2017-10-20 17:29:01', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171020170557756507593467572518', null, '20170922160206729295103754527856', '20171020170557715117684770670802', '20171020141842757704681968303771', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '100', '10', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"短款\",\"20171020143422886414718355564340\":\"羊毛\",\"20171020144326583553060000549540\":\"M\"}', null, null, '1', null, '2', null, '2017-10-20 17:05:57', '20161222113810681189580305593289', '2017-10-20 17:29:01', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171020170557757600622580338243', null, '20170922160206729295103754527856', '20171020170557715117684770670802', '20171020141842757704681968303771', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '100', '10', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"短款\",\"20171020143422886414718355564340\":\"羊毛\",\"20171020144326583553060000549540\":\"L\"}', null, null, '1', null, '2', null, '2017-10-20 17:05:57', '20161222113810681189580305593289', '2017-10-20 17:29:01', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171020172901013115921608791032', null, '20170922160206729295103754527856', '20171020170557715117684770670802', '20171020141842757704681968303771', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '100', '10', null, null, null, null, '{\"20171020143322817884242768847206\":\"\",\"20171020143406382915136199687762\":\"\",\"20171020143422886414718355564340\":\"\",\"20171020144326583553060000549540\":\"S\"}', null, null, '1', null, '2', null, '2017-10-20 17:29:01', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20171020173028530949970098129978', null, '20170922160206729295103754527856', '20171020170557715117684770670802', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '100', '10', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"短款\",\"20171020143422886414718355564340\":\"羊毛\",\"20171020144326583553060000549540\":\"S\"}', null, null, '1', null, '1', null, '2017-10-20 17:30:28', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171020173028534640540981875063', null, '20170922160206729295103754527856', '20171020170557715117684770670802', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '100', '10', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"短款\",\"20171020143422886414718355564340\":\"羊毛\",\"20171020144326583553060000549540\":\"M\"}', null, null, '1', null, '1', null, '2017-10-20 17:30:28', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171020173028536157044145363172', null, '20170922160206729295103754527856', '20171020170557715117684770670802', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '100', '10', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"短款\",\"20171020143422886414718355564340\":\"羊毛\",\"20171020144326583553060000549540\":\"L\"}', null, null, '1', null, '1', null, '2017-10-20 17:30:28', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171021112547457754669361423602', null, '20170922160206729295103754527856', '20171020170557715117684770670802', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '100', '10', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"短款\",\"20171020143422886414718355564340\":\"羊毛\",\"20171020144326583553060000549540\":\"L\"}', null, null, null, null, '1', null, '2017-10-21 11:25:47', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024152040666846121282909024', 'FivePlus格子西装领羊毛呢大衣2HL1340200', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', '20171024', 'csbh03', '3390', '100', '3', '2', null, null, null, '', '2', '2', '1', '1', '2017-10-24 15:20:40', '2017-10-24 15:20:40', '20161222113810681189580305593289', '2018-03-04 15:27:42', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024152040729464623304267490', null, '20170922160206729295103754527856', '20171024152040666846121282909024', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '3390', '100', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"中长款\",\"20171020143422886414718355564340\":\"里料：聚酯纤维\",\"20171020144326583553060000549540\":\"S\"}', null, null, null, null, '1', null, '2017-10-24 15:20:40', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024152040731567337858370954', null, '20170922160206729295103754527856', '20171024152040666846121282909024', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '3390', '100', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"中长款\",\"20171020143422886414718355564340\":\"里料：聚酯纤维\",\"20171020144326583553060000549540\":\"M\"}', null, null, null, null, '1', null, '2017-10-24 15:20:40', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024152040733845619666123495', null, '20170922160206729295103754527856', '20171024152040666846121282909024', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '3390', '100', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"中长款\",\"20171020143422886414718355564340\":\"里料：聚酯纤维\",\"20171020144326583553060000549540\":\"L\"}', null, null, null, null, '1', null, '2017-10-24 15:20:40', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024152040735435503125294763', null, '20170922160206729295103754527856', '20171024152040666846121282909024', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171020142219809531291123190087', null, null, '3390', '100', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"中长款\",\"20171020143422886414718355564340\":\"里料：聚酯纤维\",\"20171020144326583553060000549540\":\"XL\"}', null, null, null, null, '1', null, '2017-10-24 15:20:40', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024172548067546195026358174', 'miuco2017秋冬新款女装蕾丝拼接荷叶边喇叭袖连衣裙', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', '2017', 'csbh04', '0.5', '0.2', '2', '1', null, null, null, '', '2', '2', '1', '1', '2017-10-24 17:25:48', '2017-10-24 17:25:48', '20161222113810681189580305593289', '2018-03-04 15:27:36', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024172548096443358805664103', null, '20170922160206729295103754527856', '20171024172548067546195026358174', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', null, null, '0.5', '0.2', null, null, null, null, '{\"20170922155924342749177782192624\":\"黑色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-10-24 17:25:48', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20171024172548097248568981818616', null, '20170922160206729295103754527856', '20171024172548067546195026358174', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', null, null, '0.5', '0.2', null, null, null, null, '{\"20170922155924342749177782192624\":\"白色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-10-24 17:25:48', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20171024172852789370734026677867', '菲梦伊2017秋冬新款通勤韩版刺绣连衣裙女大码宽松a字裙', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', '2017', 'csbh05', '1', '0.16', '5', '1', null, null, null, '', '2', '2', '1', '1', '2017-10-24 17:28:52', '2017-10-24 17:28:52', '20161222113810681189580305593289', '2018-03-09 15:09:56', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024172852789913173493246725', null, '20170922160206729295103754527856', '20171024172852789370734026677867', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', null, null, '1', '0.16', null, null, null, null, '{\"20170922155924342749177782192624\":\"红色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-10-24 17:28:52', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024172852790206024765914081', null, '20170922160206729295103754527856', '20171024172852789370734026677867', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', null, null, '1', '0.16', null, null, null, null, '{\"20170922155924342749177782192624\":\"黑色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-10-24 17:28:52', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024172852790915796270251169', null, '20170922160206729295103754527856', '20171024172852789370734026677867', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', null, null, '1', '0.16', null, null, null, null, '{\"20170922155924342749177782192624\":\"白色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-10-24 17:28:52', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024173129164418909766552237', '圣哥弟娅2017秋冬中长裙印花包臀波纹打底连衣裙', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922160103963740147356256807', '2017', 'csbh06', '1', '0.14', '5', '1', null, null, null, '', '2', '2', '1', '1', '2017-10-24 17:31:29', '2017-10-24 17:31:29', '20161222113810681189580305593289', '2018-03-09 15:09:46', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024173129187201031419711933', null, '20170922160206729295103754527856', '20171024173129164418909766552237', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922160103963740147356256807', null, null, '1', '0.14', null, null, null, null, '{\"20170922160132846304364678755434\":\"红色\",\"20170922160148893812645375812372\":\"S\"}', null, null, null, null, '1', null, '2017-10-24 17:31:29', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024173129188114723615945993', null, '20170922160206729295103754527856', '20171024173129164418909766552237', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922160103963740147356256807', null, null, '1', '0.14', null, null, null, null, '{\"20170922160132846304364678755434\":\"黑色\",\"20170922160148893812645375812372\":\"M\"}', null, null, null, null, '1', null, '2017-10-24 17:31:29', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024173129188613222788166475', null, '20170922160206729295103754527856', '20171024173129164418909766552237', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922160103963740147356256807', null, null, '1', '0.14', null, null, null, null, '{\"20170922160132846304364678755434\":\"红色\",\"20170922160148893812645375812372\":\"L\"}', null, null, null, null, '1', null, '2017-10-24 17:31:29', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024173129270732293656640543', null, '20170922160206729295103754527856', '20171024173129164418909766552237', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922160103963740147356256807', null, null, '1', '0.14', null, null, null, null, '{\"20170922160132846304364678755434\":\"黑色\",\"20170922160148893812645375812372\":\"S\"}', null, null, null, null, '1', null, '2017-10-24 17:31:29', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024173323063359142148168544', '罗衣原创冬装新款优雅酒红色气质中长裙修身弹力针织连衣裙', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', '2017', 'csbh07', '0.39', '0.4', '3', '2', null, null, null, '', '2', '2', '1', '1', '2017-10-24 17:33:23', '2017-10-24 17:33:23', '20161222113810681189580305593289', '2018-03-05 11:08:57', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024173323083575956801401152', null, '20170922160206729295103754527856', '20171024173323063359142148168544', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', null, null, '0.39', '0.4', null, null, null, null, '{\"20170922155924342749177782192624\":\"黑色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-10-24 17:33:23', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024173323084131804226484500', null, '20170922160206729295103754527856', '20171024173323063359142148168544', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', null, null, '0.39', '0.4', null, null, null, null, '{\"20170922155924342749177782192624\":\"红色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-10-24 17:33:23', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024173746518084596390323875', '海青蓝2017秋装新款纯色简约长袖立领一步裙通勤气质连衣裙', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', '2019', 'csbh08', '123', '0.1', '2', '1', null, null, null, '', '2', '2', '1', '1', '2017-10-24 17:37:46', '2017-10-24 17:37:46', '20161222113810681189580305593289', '2018-03-05 11:08:52', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024173746519381324249408155', null, '20170922160206729295103754527856', '20171024173746518084596390323875', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', null, null, '123', '0.1', null, null, null, null, '{\"20170922155924342749177782192624\":\"黑色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-10-24 17:37:46', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024174001040202280272054699', '小红帽法式系带蝴蝶结衬衫裙秋装女长袖修身收腰红色连衣裙', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', '2016', 'csbh09', '45', '10', '12', '1', null, null, null, '', '2', '2', '1', '1', '2017-10-24 17:40:01', '2017-10-24 17:40:01', '20161222113810681189580305593289', '2018-03-09 15:08:45', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024174001062066068059043941', null, '20170922160206729295103754527856', '20171024174001040202280272054699', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', null, null, '45', '10', null, null, null, null, '{\"20170922155924342749177782192624\":\"红色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-10-24 17:40:01', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024174201734162792776406068', '星诺2017秋装新款复古文艺范小清新森女系长袖连衣裙', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', 'gdfg', 'csbh10', '12', '50.11', '2', '2', null, null, null, '', '2', '2', '1', '1', '2017-10-24 17:42:01', '2017-10-24 17:42:01', '20161222113810681189580305593289', '2018-03-05 11:08:48', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024174201735722489382748556', null, '20170922160206729295103754527856', '20171024174201734162792776406068', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', null, null, '12', '50.11', null, null, null, null, '{\"20170922155924342749177782192624\":\"白色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2017-10-24 17:42:01', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024174410113198261330319674', 'VeroModa大翻领双排扣蝙蝠袖长款毛呢大衣', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20171025100314946187546799578446', '212', 'csbh11', '23', '10', '3', '2', null, null, null, '', '2', '2', '1', '1', '2017-10-24 17:44:10', '2017-10-24 17:44:10', '20161222113810681189580305593289', '2018-03-10 17:38:33', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024174410114904989882035151', null, '20170922160206729295103754527856', '20171024174410113198261330319674', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171025100314946187546799578446', null, null, '23', '10', null, null, null, null, '{\"20171025100448381843033759752103\":\"灰色\",\"20171025100453947388393162965405\":\"均码\"}', null, null, null, null, '1', null, '2017-10-24 17:44:10', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171024174410114979180590471505', null, '20170922160206729295103754527856', '20171024174410113198261330319674', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171025100314946187546799578446', null, null, '23', '10', null, null, null, null, '{\"20171025100448381843033759752103\":\"黄色\",\"20171025100453947388393162965405\":\"均码\"}', null, null, null, null, '1', null, '2017-10-24 17:44:10', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171025101520527958678340708111', null, '20170922160206729295103754527856', '20171024174410113198261330319674', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171025100314946187546799578446', null, null, '23', '10', null, null, null, null, '{\"20171025100448381843033759752103\":\"粉色\",\"20171025100453947388393162965405\":\"均码\"}', null, null, null, null, '1', null, '2017-10-25 10:15:20', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20171025102953587208765305615398', 'MECITY女装2017冬季新品羊毛长款系带大衣外套', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20171025100050543557026983149412', '2017', 'csbh12', '1999', '199.99', '3', '2', null, null, null, '', '2', '2', '1', '1', '2017-10-25 10:29:53', '2017-10-25 10:29:53', '20161222113810681189580305593289', '2018-03-04 15:26:09', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171025102953588438857271574470', null, '20170922160206729295103754527856', '20171025102953587208765305615398', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171025100050543557026983149412', null, null, '1999', '199.99', null, null, null, null, '{\"20171025100135068183321767662316\":\"白色\",\"20171025100154429890901622623364\":\"均码\"}', null, null, null, null, '1', null, '2017-10-25 10:29:53', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20171025102953589966097163292157', null, '20170922160206729295103754527856', '20171025102953587208765305615398', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171025100050543557026983149412', null, null, '1999', '199.99', null, null, null, null, '{\"20171025100135068183321767662316\":\"红色\",\"20171025100154429890901622623364\":\"均码\"}', null, null, null, null, '1', null, '2017-10-25 10:29:53', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20171025103239036293356146737021', 'Edition10羊毛呢大衣女冬中长袍式腰带束腰翻领', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20171025100542411099882323542658', '2017', 'csbh13', '300', '32.89', '3', '2', null, null, null, '', '2', '2', '1', '1', '2017-10-25 10:32:39', '2017-10-25 10:32:39', '20161222113810681189580305593289', '2018-03-04 15:26:00', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171025103239037994571698040619', null, '20170922160206729295103754527856', '20171025103239036293356146737021', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171025100542411099882323542658', null, null, '300', '32.89', null, null, null, null, '{\"20171025100549055254983000473616\":\"黄色\",\"20171025100556271839152900005018\":\"均码\"}', null, null, null, null, '1', null, '2017-10-25 10:32:39', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171025103239038648146930466232', null, '20170922160206729295103754527856', '20171025103239036293356146737021', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171025100542411099882323542658', null, null, '300', '32.89', null, null, null, null, '{\"20171025100549055254983000473616\":\"黑色\",\"20171025100556271839152900005018\":\"均码\"}', null, null, null, null, '1', null, '2017-10-25 10:32:39', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171025143541496658690956288136', '测试加长款大衣', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20171025100219058384794993959413', '2017', 'csbh14', '100', '29.99', '4', '3', null, null, null, '', '2', '2', '1', '1', '2017-10-25 14:35:41', '2017-10-25 14:35:41', '20161222113810681189580305593289', '2018-03-04 15:25:51', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171025143541526608618235876276', null, '20170922160206729295103754527856', '20171025143541496658690956288136', '20180122101904528474410614949352', '20171020141858078532445550340340', '20171025100219058384794993959413', null, null, '100', '29.99', null, null, null, null, '{\"20171025100431101252923441634114\":\"黄色\",\"20171025100439479010449811937262\":\"均码\"}', null, null, null, null, '1', null, '2017-10-25 14:35:41', '20161222113810681189580305593289', null, '20170925103713874175976363098240');
INSERT INTO `th_goods` VALUES ('20171027113724031641949791734239', 'dzzit地素翻领夹克式毛边提花羊毛大衣', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20170922155623033757857866122344', '20171020142219809531291123190087', '2017', 'csbh15', '1890', '199.99', '5', '3', null, null, null, '', '2', '2', '1', '1', '2017-10-27 11:37:24', '2017-10-27 11:37:24', '20170925103713874175976363098240', '2018-03-05 11:24:57', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20171027113724051302031623513066', null, '20170922160206729295103754527856', '20171027113724031641949791734239', '20180122101904528474410614949352', '20170922155623033757857866122344', '20171020142219809531291123190087', null, null, '1890', '199.99', null, null, null, null, '{\"20171020143322817884242768847206\":\"羊毛\",\"20171020143406382915136199687762\":\"短款\",\"20171020143422886414718355564340\":\"100\",\"20171020144326583553060000549540\":\"S\"}', null, null, null, null, '1', null, '2017-10-27 11:37:24', '20170925103713874175976363098240', null, null);
INSERT INTO `th_goods` VALUES ('20171027113806681368093564402901', null, '20170922160206729295103754527856', '20171025143541496658690956288136', '20171020141842757704681968303771', '20171020141858078532445550340340', '20171025100219058384794993959413', null, null, '100', '29.99', null, null, null, null, '{\"20171025100431101252923441634114\":\"黑色东方斯黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234\",\"20171025100439479010449811937262\":\"黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234黑色东方斯卡拉大风那算了大风上了对方水电费水电费水电费水电费水电费水电费答复24234234234234234234234234234234244234234234\"}', null, null, null, null, '2', null, '2017-10-27 11:38:06', '20170925103713874175976363098240', null, null);
INSERT INTO `th_goods` VALUES ('20180122102526497373284138435453', '2018新款豆豆鞋女冬外穿加绒一脚蹬女鞋平底鞋单鞋瓢鞋', '20170922160219718260550566573824', null, '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', '20180122', '01', '690', '10', '10', '1', null, null, null, '', '2', '2', '1', '1', '2018-01-22 10:25:26', '2018-01-22 10:25:26', '20161222113810681189580305593289', '2018-03-04 11:14:21', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122102526513870863183723240', null, '20170922160219718260550566573824', '20180122102526497373284138435453', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '690', '10', null, null, null, null, '{\"20180122100455711105647543867205\":\"黑色\",\"20180122100505207201825552522648\":\"36\"}', null, null, null, null, '1', null, '2018-01-22 10:25:26', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122102526542595633171445140', null, '20170922160219718260550566573824', '20180122102526497373284138435453', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '690', '10', null, null, null, null, '{\"20180122100455711105647543867205\":\"黑色\",\"20180122100505207201825552522648\":\"37\"}', null, null, null, null, '1', null, '2018-01-22 10:25:26', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122102526543417855861392524', null, '20170922160219718260550566573824', '20180122102526497373284138435453', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '690', '10', null, null, null, null, '{\"20180122100455711105647543867205\":\"黑色\",\"20180122100505207201825552522648\":\"38\"}', null, null, null, null, '1', null, '2018-01-22 10:25:26', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122102526543600456291851153', null, '20170922160219718260550566573824', '20180122102526497373284138435453', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '690', '10', null, null, null, null, '{\"20180122100455711105647543867205\":\"黑色\",\"20180122100505207201825552522648\":\"39\"}', null, null, null, null, '1', null, '2018-01-22 10:25:26', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122102526544190079845200693', null, '20170922160219718260550566573824', '20180122102526497373284138435453', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '690', '10', null, null, null, null, '{\"20180122100455711105647543867205\":\"灰色\",\"20180122100505207201825552522648\":\"36\"}', null, null, null, null, '1', null, '2018-01-22 10:25:26', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122102526544989953911941764', null, '20170922160219718260550566573824', '20180122102526497373284138435453', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '690', '10', null, null, null, null, '{\"20180122100455711105647543867205\":\"黑色\",\"20180122100505207201825552522648\":\"40\"}', null, null, null, null, '1', null, '2018-01-22 10:25:26', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122102526545499399131152437', null, '20170922160219718260550566573824', '20180122102526497373284138435453', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '690', '10', null, null, null, null, '{\"20180122100455711105647543867205\":\"灰色\",\"20180122100505207201825552522648\":\"38\"}', null, null, null, null, '1', null, '2018-01-22 10:25:26', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122102526545915648132991945', null, '20170922160219718260550566573824', '20180122102526497373284138435453', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '690', '10', null, null, null, null, '{\"20180122100455711105647543867205\":\"灰色\",\"20180122100505207201825552522648\":\"37\"}', null, null, null, null, '1', null, '2018-01-22 10:25:26', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122102526546351323008350143', null, '20170922160219718260550566573824', '20180122102526497373284138435453', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '690', '10', null, null, null, null, '{\"20180122100455711105647543867205\":\"灰色\",\"20180122100505207201825552522648\":\"40\"}', null, null, null, null, '1', null, '2018-01-22 10:25:26', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122102526546658620372508043', null, '20170922160219718260550566573824', '20180122102526497373284138435453', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '690', '10', null, null, null, null, '{\"20180122100455711105647543867205\":\"灰色\",\"20180122100505207201825552522648\":\"39\"}', null, null, null, null, '1', null, '2018-01-22 10:25:26', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111233478527530066356970', 'AUSTRUGG兔毛豆豆鞋瓢鞋秋冬平底大码女鞋', '20170922160219718260550566573824', null, '20170922155758751662910860438310', '20170922170008418500507169281039', '20180122100319009251535488252250', '20180122', '02', '300', '31', '10', '1', null, null, null, '', '2', '2', '1', '1', '2018-01-22 11:12:33', '2018-01-22 11:12:33', '20161222113810681189580305593289', '2018-03-14 14:14:19', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111233479652994631295342', null, '20170922160219718260550566573824', '20180122111233478527530066356970', '20170922155758751662910860438310', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '300', '31', null, null, null, null, '{\"20180122100455711105647543867205\":\"黑色\",\"20180122100505207201825552522648\":\"37\"}', null, null, null, null, '1', null, '2018-01-22 11:12:33', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111233480406319577417218', null, '20170922160219718260550566573824', '20180122111233478527530066356970', '20170922155758751662910860438310', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '300', '31', null, null, null, null, '{\"20180122100455711105647543867205\":\"黑色\",\"20180122100505207201825552522648\":\"38\"}', null, null, null, null, '1', null, '2018-01-22 11:12:33', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111233480798765671645460', null, '20170922160219718260550566573824', '20180122111233478527530066356970', '20170922155758751662910860438310', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '300', '31', null, null, null, null, '{\"20180122100455711105647543867205\":\"棕色\",\"20180122100505207201825552522648\":\"37\"}', null, null, null, null, '1', null, '2018-01-22 11:12:33', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111233481378666470693866', null, '20170922160219718260550566573824', '20180122111233478527530066356970', '20170922155758751662910860438310', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '300', '31', null, null, null, null, '{\"20180122100455711105647543867205\":\"棕色\",\"20180122100505207201825552522648\":\"38\"}', null, null, null, null, '1', null, '2018-01-22 11:12:33', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111459870686175221589973', '婚鞋女平底新娘鞋子2017新款冬季红色婚礼中式结婚鞋', '20170922160219718260550566573824', null, '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', '20180122', '03', '186', '50.11', '10', '1', null, null, null, '', '2', '2', '1', '1', '2018-01-22 11:14:59', '2018-01-22 11:14:59', '20161222113810681189580305593289', '2018-03-04 11:14:40', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111459871538122943908738', null, '20170922160219718260550566573824', '20180122111459870686175221589973', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '186', '50.11', null, null, null, null, '{\"20180122100455711105647543867205\":\"红色\",\"20180122100505207201825552522648\":\"37\"}', null, null, null, null, '1', null, '2018-01-22 11:14:59', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111459871882511161428299', null, '20170922160219718260550566573824', '20180122111459870686175221589973', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '186', '50.11', null, null, null, null, '{\"20180122100455711105647543867205\":\"红色\",\"20180122100505207201825552522648\":\"36\"}', null, null, null, null, '1', null, '2018-01-22 11:14:59', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111459872345027716373992', null, '20170922160219718260550566573824', '20180122111459870686175221589973', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '186', '50.11', null, null, null, null, '{\"20180122100455711105647543867205\":\"红色\",\"20180122100505207201825552522648\":\"39\"}', null, null, null, null, '1', null, '2018-01-22 11:14:59', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111459872759273094909453', null, '20170922160219718260550566573824', '20180122111459870686175221589973', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '186', '50.11', null, null, null, null, '{\"20180122100455711105647543867205\":\"红色\",\"20180122100505207201825552522648\":\"38\"}', null, null, null, null, '1', null, '2018-01-22 11:14:59', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111459873117398847433749', null, '20170922160219718260550566573824', '20180122111459870686175221589973', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '186', '50.11', null, null, null, null, '{\"20180122100455711105647543867205\":\"红色\",\"20180122100505207201825552522648\":\"40\"}', null, null, null, null, '1', null, '2018-01-22 11:14:59', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111712018249944953366986', '短靴高跟2017版水貂毛系带休闲鞋', '20170922160219718260550566573824', null, '20170922155758751662910860438310', '20170922170008418500507169281039', '20180122100319009251535488252250', '20180110', '04', '588', '10', '10', '1', null, null, null, '', '2', '2', '1', '1', '2018-01-22 11:17:12', '2018-01-22 11:17:12', '20161222113810681189580305593289', '2018-03-14 14:14:11', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111712019014128900881941', null, '20170922160219718260550566573824', '20180122111712018249944953366986', '20170922155758751662910860438310', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '588', '10', null, null, null, null, '{\"20180122100455711105647543867205\":\"深卡其色\",\"20180122100505207201825552522648\":\"36\"}', null, null, null, null, '1', null, '2018-01-22 11:17:12', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111712020763036421783175', null, '20170922160219718260550566573824', '20180122111712018249944953366986', '20170922155758751662910860438310', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '588', '10', null, null, null, null, '{\"20180122100455711105647543867205\":\"黑色\",\"20180122100505207201825552522648\":\"36\"}', null, null, null, null, '1', null, '2018-01-22 11:17:12', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111712091670403329579951', null, '20170922160219718260550566573824', '20180122111712018249944953366986', '20170922155758751662910860438310', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '588', '10', null, null, null, null, '{\"20180122100455711105647543867205\":\"深卡其色\",\"20180122100505207201825552522648\":\"37\"}', null, null, null, null, '1', null, '2018-01-22 11:17:12', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111712093574287720239587', null, '20170922160219718260550566573824', '20180122111712018249944953366986', '20170922155758751662910860438310', '20170922170008418500507169281039', '20180122100319009251535488252250', null, null, '588', '10', null, null, null, null, '{\"20180122100455711105647543867205\":\"黑色\",\"20180122100505207201825552522648\":\"37\"}', null, null, null, null, '1', null, '2018-01-22 11:17:12', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111918337388157036901911', '韩版女冬毛球豆豆鞋可爱学生加绒保暖平底单鞋外穿懒人棉鞋', '20170922160219718260550566573824', null, '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100301811509596267554940', '20180111', '05', '168', '20.1', '10', '1', null, null, null, '', '2', '2', '1', '1', '2018-01-22 11:19:18', '2018-01-22 11:19:18', '20161222113810681189580305593289', '2018-03-04 14:19:55', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111918338805214988143657', null, '20170922160219718260550566573824', '20180122111918337388157036901911', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100301811509596267554940', null, null, '168', '20.1', null, null, null, null, '{\"20180122100436008649042718091562\":\"红\",\"20180122100444587897254187452794\":\"36\"}', null, null, null, null, '1', null, '2018-01-22 11:19:18', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111918338987539221560704', null, '20170922160219718260550566573824', '20180122111918337388157036901911', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100301811509596267554940', null, null, '168', '20.1', null, null, null, null, '{\"20180122100436008649042718091562\":\"黑\",\"20180122100444587897254187452794\":\"36\"}', null, null, null, null, '1', null, '2018-01-22 11:19:18', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111918339375366075677461', null, '20170922160219718260550566573824', '20180122111918337388157036901911', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100301811509596267554940', null, null, '168', '20.1', null, null, null, null, '{\"20180122100436008649042718091562\":\"红\",\"20180122100444587897254187452794\":\"37\"}', null, null, null, null, '1', null, '2018-01-22 11:19:18', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122111918339932058735988724', null, '20170922160219718260550566573824', '20180122111918337388157036901911', '20180122101904528474410614949352', '20170922170008418500507169281039', '20180122100301811509596267554940', null, null, '168', '20.1', null, null, null, null, '{\"20180122100436008649042718091562\":\"黑\",\"20180122100444587897254187452794\":\"37\"}', null, null, null, null, '1', null, '2018-01-22 11:19:18', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122115306634026996232910217', '换购商品', '20180122115318931820660508991547', null, '20170922155512650796375955980227', '20170922170008418500507169281039', '20170922155900143994816435732693', '20180110', 'A1', '50', '10', '1000', '1', null, null, null, '', '2', '2', '2', '1', '2018-01-22 11:53:06', '2018-01-22 11:53:06', '20161222113810681189580305593289', '2018-03-07 15:39:15', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122115306635512118794541513', null, '20180122115318931820660508991547', '20180122115306634026996232910217', '20170922155512650796375955980227', '20170922170008418500507169281039', '20170922155900143994816435732693', null, null, '50', '10', null, null, null, null, '{\"20170922155924342749177782192624\":\"红色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, '1', null, '1', null, '2018-01-22 11:53:06', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180122115306635929089266491870', null, '20180122115318931820660508991547', '20180122115306634026996232910217', '20170922155512650796375955980227', '20170922170008418500507169281039', '20170922155900143994816435732693', null, null, '50', '10', null, null, null, null, '{\"20170922155924342749177782192624\":\"黑色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, '1', null, '1', null, '2018-01-22 11:53:06', '20161222113810681189580305593289', null, '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180208140943733620443495230063', '圆头鞋', '20170922160219718260550566573824', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922160040124948343465745025', '201802081408', '20180208', '100', '10', '10', '1', null, null, null, '', '2', '2', '1', '1', '2018-02-08 14:09:43', '2018-02-08 14:09:43', '20161222113810681189580305593289', '2018-03-05 11:08:42', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180208140943734092860624269649', null, '20170922160219718260550566573824', '20180208140943733620443495230063', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922160040124948343465745025', null, null, '100', '10', null, null, null, null, '{\"20170922173002913652458738082960\":\"黑色ggsdfsdfsd\",\"20170922173022025813064987775377\":\"34\",\"20171027172345112274130482409009\":\"广州\"}', null, null, null, null, '1', null, '2018-02-08 14:09:43', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180305101632539543262286132950', '高跟鞋女鞋2017', '20170922160219718260550566573824', null, '20171020141842757704681968303771', '20170922170008418500507169281039', '20180122100301811509596267554940', '0305', '20180305101601', '1500000', '0.4', '10', '1', null, null, null, '', '2', '2', '1', '1', '2018-03-05 10:16:32', '2018-03-05 10:16:32', '20161222113810681189580305593289', '2018-04-03 10:23:09', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180305101632540354835519511063', null, '20170922160219718260550566573824', '20180305101632539543262286132950', '20171020141842757704681968303771', '20170922170008418500507169281039', '20180122100301811509596267554940', null, null, '1500000', '0.4', null, null, null, null, '{\"20180122100436008649042718091562\":\"黑色\",\"20180122100444587897254187452794\":\"36\"}', null, null, null, null, '1', null, '2018-03-05 10:16:32', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180305101632540548318115370803', null, '20170922160219718260550566573824', '20180305101632539543262286132950', '20171020141842757704681968303771', '20170922170008418500507169281039', '20180122100301811509596267554940', null, null, '1500000', '0.4', null, null, null, null, '{\"20180122100436008649042718091562\":\"黑色\",\"20180122100444587897254187452794\":\"37\"}', null, null, null, null, '1', null, '2018-03-05 10:16:32', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180305165627979487208421838261', null, '20180122115318931820660508991547', '20180122115306634026996232910217', '20170922155512650796375955980227', '20170922170008418500507169281039', '20170922155900143994816435732693', null, null, '50', '10', null, null, null, null, '{\"20170922155924342749177782192624\":\"白色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2018-03-05 16:56:27', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180309105036173757940356406536', '运动鞋春季黑色跑鞋361度透气跑步鞋女轻便粉色鞋子', '20170922160219718260550566573824', null, '20171020141842757704681968303771', '20170922170008418500507169281039', '20180122100301811509596267554940', '0309', '0309', '249', '300', '10', '1', null, null, null, '', '1', '2', '1', '1', '2018-03-09 10:50:36', '2018-03-09 10:50:36', '20161222113810681189580305593289', '2018-03-14 14:12:34', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180309105036174528202992898075', null, '20170922160219718260550566573824', '20180309105036173757940356406536', '20171020141842757704681968303771', '20170922170008418500507169281039', '20180122100301811509596267554940', null, null, '249', '300', null, null, null, null, '{\"20180122100436008649042718091562\":\"黑色\",\"20180122100444587897254187452794\":\"36\"}', null, null, null, null, '1', null, '2018-03-09 10:50:36', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180309105036175532035028608670', null, '20170922160219718260550566573824', '20180309105036173757940356406536', '20171020141842757704681968303771', '20170922170008418500507169281039', '20180122100301811509596267554940', null, null, '249', '300', null, null, null, null, '{\"20180122100436008649042718091562\":\"黑色\",\"20180122100444587897254187452794\":\"37\"}', null, null, null, null, '1', null, '2018-03-09 10:50:36', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180309105036175732518352898229', null, '20170922160219718260550566573824', '20180309105036173757940356406536', '20171020141842757704681968303771', '20170922170008418500507169281039', '20180122100301811509596267554940', null, null, '249', '300', null, null, null, null, '{\"20180122100436008649042718091562\":\"黑色\",\"20180122100444587897254187452794\":\"38\"}', null, null, null, null, '1', null, '2018-03-09 10:50:36', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180309105036176040397662251278', null, '20170922160219718260550566573824', '20180309105036173757940356406536', '20171020141842757704681968303771', '20170922170008418500507169281039', '20180122100301811509596267554940', null, null, '249', '300', null, null, null, null, '{\"20180122100436008649042718091562\":\"白色\",\"20180122100444587897254187452794\":\"36\"}', null, null, null, null, '1', null, '2018-03-09 10:50:36', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180309105036176480903498696913', null, '20170922160219718260550566573824', '20180309105036173757940356406536', '20171020141842757704681968303771', '20170922170008418500507169281039', '20180122100301811509596267554940', null, null, '249', '300', null, null, null, null, '{\"20180122100436008649042718091562\":\"黑色\",\"20180122100444587897254187452794\":\"39\"}', null, null, null, null, '1', null, '2018-03-09 10:50:36', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180309105036177454954643991675', null, '20170922160219718260550566573824', '20180309105036173757940356406536', '20171020141842757704681968303771', '20170922170008418500507169281039', '20180122100301811509596267554940', null, null, '249', '300', null, null, null, null, '{\"20180122100436008649042718091562\":\"白色\",\"20180122100444587897254187452794\":\"37\"}', null, null, null, null, '1', null, '2018-03-09 10:50:36', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180309105036177820995622756563', null, '20170922160219718260550566573824', '20180309105036173757940356406536', '20171020141842757704681968303771', '20170922170008418500507169281039', '20180122100301811509596267554940', null, null, '249', '300', null, null, null, null, '{\"20180122100436008649042718091562\":\"白色\",\"20180122100444587897254187452794\":\"38\"}', null, null, null, null, '1', null, '2018-03-09 10:50:36', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180309105036178506091525057612', null, '20170922160219718260550566573824', '20180309105036173757940356406536', '20171020141842757704681968303771', '20170922170008418500507169281039', '20180122100301811509596267554940', null, null, '249', '300', null, null, null, null, '{\"20180122100436008649042718091562\":\"白色\",\"20180122100444587897254187452794\":\"39\"}', null, null, null, null, '1', null, '2018-03-09 10:50:36', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311004667310961479080', 'Adidas', '20170922160219718260550566573824', null, '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', '0310', '0310', '1000', '500', '10', '1', null, null, null, '是打发斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬是打发斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬', '2', '2', '1', '1', '2018-03-10 17:23:11', '2018-03-10 17:23:11', '20161222113810681189580305593289', '2018-03-14 18:25:18', '20161222113810681189580305593289');
INSERT INTO `th_goods` VALUES ('20180310172311005052072388073622', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"36\",\"20180310163832377866466338104780\":\"黑色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311005255530180703231', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"37\",\"20180310163832377866466338104780\":\"黑色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311006690411428684918', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"38\",\"20180310163832377866466338104780\":\"黑色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311007501959929735384', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"40\",\"20180310163832377866466338104780\":\"黑色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311007545134910576639', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"39\",\"20180310163832377866466338104780\":\"黑色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311008512846402263829', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"37\",\"20180310163832377866466338104780\":\"白色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311008788820543713098', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"36\",\"20180310163832377866466338104780\":\"白色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311008800488991808016', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"38\",\"20180310163832377866466338104780\":\"白色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311009441455249383698', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"39\",\"20180310163832377866466338104780\":\"白色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311009676649320845761', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"40\",\"20180310163832377866466338104780\":\"白色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311010077450520071911', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"38\",\"20180310163832377866466338104780\":\"灰色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311010626854694787073', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"37\",\"20180310163832377866466338104780\":\"灰色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311010710660614568318', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"36\",\"20180310163832377866466338104780\":\"灰色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311011472513878925692', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"40\",\"20180310163832377866466338104780\":\"灰色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310172311011622604823489423', null, '20170922160219718260550566573824', '20180310172311004667310961479080', '20171020141842757704681968303771', '20171020141858078532445550340340', '20180310162403909567135096701689', null, null, '1000', '500', null, null, null, null, '{\"20180310163707815223112858806830\":\"39\",\"20180310163832377866466338104780\":\"灰色\"}', null, null, null, null, '1', null, '2018-03-10 17:23:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180310173943037961334434981896', null, '20170922160206729295103754527856', '20171014165251008459951743489247', '20180122101904528474410614949352', '20170922155623033757857866122344', '20170922155900143994816435732693', null, null, '123', '0.72', null, null, null, null, '{\"20170922155924342749177782192624\":\"红色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2018-03-10 17:39:43', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180410180401864614132692379806', '商品1', '20170922160206729295103754527856', null, '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', '20180110', '201804101803', '10', '10', '10', '1', null, null, null, '', '2', '2', '1', '1', '2018-04-10 18:04:01', '2018-04-10 18:04:01', '20161222113810681189580305593289', null, null);
INSERT INTO `th_goods` VALUES ('20180410180401891463008854035951', null, '20170922160206729295103754527856', '20180410180401864614132692379806', '20180122101904528474410614949352', '20171020141858078532445550340340', '20170922155900143994816435732693', null, null, '10', '10', null, null, null, null, '{\"20170922155924342749177782192624\":\"红色\",\"20170922155953666134633180007523\":\"均码\"}', null, null, null, null, '1', null, '2018-04-10 18:04:01', '20161222113810681189580305593289', null, null);

-- ----------------------------
-- Table structure for th_inventory
-- ----------------------------
DROP TABLE IF EXISTS `th_inventory`;
CREATE TABLE `th_inventory` (
  `id` varchar(32) NOT NULL,
  `goods_id` varchar(32) DEFAULT NULL COMMENT '产品ID',
  `count` varchar(50) DEFAULT NULL COMMENT '当前库存',
  `money` varchar(50) DEFAULT NULL COMMENT '库存金额',
  `storage_id` varchar(32) DEFAULT NULL COMMENT '仓库ID',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_21` (`storage_id`),
  KEY `FK_Reference_22` (`goods_id`),
  CONSTRAINT `FK_Reference_21` FOREIGN KEY (`storage_id`) REFERENCES `th_storage` (`id`),
  CONSTRAINT `FK_Reference_22` FOREIGN KEY (`goods_id`) REFERENCES `th_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存';

-- ----------------------------
-- Records of th_inventory
-- ----------------------------
INSERT INTO `th_inventory` VALUES ('20180306114542769882042353554905', '20171020143937479575128993734718', '3', '0.54', '20170922162328008365745515797496', '2018-03-06 11:45:42', '2018-03-06 11:45:42', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180306120041764199135562445617', '20171024174001062066068059043941', '1', '4.5', '20170922162328008365745515797496', '2018-03-06 12:00:41', '2018-03-06 12:00:41', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180306165012664331070349228818', '20171024172852789913173493246725', '1', '0.10000000000000003', '20170922162328008365745515797496', '2018-03-06 16:50:12', '2018-03-06 16:50:12', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180306165020348313914838697845', '20171024173129187201031419711933', '0', '0', '20170922162328008365745515797496', '2018-03-06 16:50:20', '2018-03-06 16:50:20', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180306172201967415978608714306', '20180305101632540354835519511063', '2', '300', '20170922162328008365745515797496', '2018-03-06 17:22:01', '2018-03-06 17:22:01', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180306181301325385867277045917', '20180208140943734092860624269649', '1', '1', '20170922162411079613911762625402', '2018-03-06 18:13:01', '2018-03-06 18:13:01', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180307093558240535097568307375', '20171020173028530949970098129978', '0', '0', '20171020143623644909530581599768', '2018-03-07 09:35:58', '2018-03-07 09:35:58', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180307101719272780808157759689', '20170922173129684003478306409198', '0', '0', '20171020143623644909530581599768', '2018-03-07 10:17:19', '2018-03-07 10:17:19', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180307154111756640533829002945', '20180122115306635512118794541513', '2', '10', '20171020143623644909530581599768', '2018-03-07 15:41:11', '2018-03-07 15:41:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180309150732468258055692757718', '20180208140943734092860624269649', '1', '10', '20170922162328008365745515797496', '2018-03-09 15:07:32', '2018-03-09 15:07:32', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180309173529976586764301948263', '20171020144710372918583430481077', '0', '5.551115123125783e-17', '20170922162328008365745515797496', '2018-03-09 17:35:29', '2018-03-09 17:35:29', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180310104544404216544867725589', '20171020143937479575128993734718', '1', '0.18000000000000005', '20171020143623644909530581599768', '2018-03-10 10:45:44', '2018-03-10 10:45:44', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180310115022312084513387288262', '20180309105036174528202992898075', '0', '-0.00000000000003552713678800501', '20170922162328008365745515797496', '2018-03-10 11:50:22', '2018-03-10 11:50:22', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180314144103687743195394110495', '20180309105036174528202992898075', '19', '517.9200000000001', '20180314141637307619473967715931', '2018-03-14 14:41:03', '2018-03-14 14:41:03', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180314144117141916080412379074', '20180310172311005052072388073622', '10', '1000', '20180314141637307619473967715931', '2018-03-14 14:41:17', '2018-03-14 14:41:17', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180314151259628352250052436256', '20170922173157232869154187665661', '0', '0', '20171020143623644909530581599768', '2018-03-14 15:12:59', '2018-03-14 15:12:59', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180314151307468815554529424646', '20180122111233479652994631295342', '0', '0', '20171020143623644909530581599768', '2018-03-14 15:13:07', '2018-03-14 15:13:07', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180314151315250599526728300927', '20180122111712019014128900881941', '0', '0', '20171020143623644909530581599768', '2018-03-14 15:13:15', '2018-03-14 15:13:15', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180314163515474481909758987744', '20171024173323083575956801401152', '0', '0', '20170922162328008365745515797496', '2018-03-14 16:35:15', '2018-03-14 16:35:15', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180314163528359114786815344056', '20171024173746519381324249408155', '0', '0', '20170922162328008365745515797496', '2018-03-14 16:35:28', '2018-03-14 16:35:28', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180314174131214349052567110517', '20170922173157232869154187665661', '0', '0', '20170922162328008365745515797496', '2018-03-14 17:41:31', '2018-03-14 17:41:31', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180320144959615284623808980729', '20171024174410114904989882035151', '1', '2.3', '20170922162328008365745515797496', '2018-03-20 14:49:59', '2018-03-20 14:49:59', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180403101515287138047212090521', '20170922173157232869154187665661', '1', '0.1', '20180314141637307619473967715931', '2018-04-03 10:15:15', '2018-04-03 10:15:15', '20170922182244405544128921993049', null, null);
INSERT INTO `th_inventory` VALUES ('20180403103021151913932217363572', '20180305101632540548318115370803', '1', '0.1', '20170922162328008365745515797496', '2018-04-03 10:30:21', '2018-04-03 10:30:21', '20180403102452843217051878132227', null, null);
INSERT INTO `th_inventory` VALUES ('20180410180447071532563504894291', '20180410180401891463008854035951', '9', '9', '20170922162328008365745515797496', '2018-04-10 18:04:47', '2018-04-10 18:04:47', '20161222113810681189580305593289', null, null);
INSERT INTO `th_inventory` VALUES ('20180510150029511574104610615048', '20180305101632540354835519511063', '2', '60000.0', '20180314141637307619473967715931', '2018-05-10 15:00:29', '2018-05-10 15:00:29', '20161222113810681189580305593289', null, null);

-- ----------------------------
-- Table structure for th_log
-- ----------------------------
DROP TABLE IF EXISTS `th_log`;
CREATE TABLE `th_log` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `operatorName` varchar(255) DEFAULT NULL COMMENT '操作人',
  `content` varchar(5000) DEFAULT NULL COMMENT '操作记录',
  `isAdmin` varchar(20) DEFAULT NULL COMMENT '是否是管理员',
  `operatorId` varchar(32) DEFAULT NULL COMMENT '操作人ID',
  `logType` varchar(255) DEFAULT NULL COMMENT '类型',
  `objectId` varchar(32) DEFAULT NULL COMMENT '对象id',
  `operate` int(11) DEFAULT NULL COMMENT '动作',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '操作时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of th_log
-- ----------------------------

-- ----------------------------
-- Table structure for th_notice
-- ----------------------------
DROP TABLE IF EXISTS `th_notice`;
CREATE TABLE `th_notice` (
  `id` varchar(32) NOT NULL,
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `remark` text COMMENT '备注',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统公告';

-- ----------------------------
-- Records of th_notice
-- ----------------------------
INSERT INTO `th_notice` VALUES ('20170922172339204631599119334792', '切尔西官宣科斯塔回马竞达协议 5300万1月加盟', '北京时间9月21日消息，切尔西和马竞在官方网站宣布，双方就迭戈-科斯塔重返马竞已经达成协议，科斯塔将在未来几天完成体检和签约。根据英格兰媒体的最新报道，科斯塔的转会费为5300万英镑（折合约6000万欧元）北京时间9月21日消息，切尔西和马竞在官方网站宣布，双方就迭戈-科斯塔重返马竞已经达成协议，科斯塔将在未来几天完成体检和签约。根据英格兰媒体的最新报道，科斯塔的转会费为5300万英镑（折合约6000万欧元）北京时间9月21日消息，切尔西和马竞在官方网站宣布，双方就迭戈-科斯塔重返马竞已经达成协议，科斯塔将在未来几天完成体检和签约。根据英格兰媒体的最新报道，科斯塔的转会费为5300万英镑（折合约6000万欧元）北京时间9月21日消息，切尔西和马竞在官方网站宣布，双方就迭戈-科斯塔重返马竞已经达成协议，科斯塔将在未来几天完成体检和签约。根据英格兰媒体的最新报道，科斯塔的转会费为5300万英镑（折合约6000万欧元）北京时间9月21日消息，切尔西和马竞在官方网站宣布，双方就迭戈-科斯塔重返马竞已经达成协议，科斯塔将在未来几天完成体检和签约。根据英格兰媒体的最新报道，科斯塔的转会费为5300万英镑（折合约6000万欧元）北京时间9月21日消息，切尔西和马竞在官方网站宣布，双方就迭戈-科斯塔重返马竞已经达成协议，科斯塔将在未来几天完成体检和签约。根据英格兰媒体的最新报道，科斯塔的转会费为5300万英镑（折合约6000万欧元）北京时间9月21日消息，切尔西和马竞在官方网站宣布，双方就迭戈-科斯塔重返马竞已经达成协议，科斯塔将在未来几天完成体检和签约。根据英格兰媒体的最新报道，科斯塔的转会费为5300万英镑（折合约6000万欧元）北京时间9月21日消息，切尔西和马竞在官方网站宣布，双方就迭戈-科斯塔重返马竞已经达成协议，科斯塔将在未来几天完成体检和签约。根据英格兰媒体的最新报道，科斯塔的转会费为5300万英镑（折合约6000万欧元）', null, '2017-09-22 17:23:39', '2017-09-22 17:23:39', '20161222113810681189580305593289', null, null);
INSERT INTO `th_notice` VALUES ('20180306092458901618072290273655', 'Caparol驻马店体验中心盛大开业', '2018年3月3日，元宵佳节刚刚过去，在一片鼓乐齐鸣之中，Caparol的又一家线下体验中心在驻马店市开业了。在去年获得了全国文明城市称号的驻马店向来被誉为华夏文明的发祥地，这里是中华民族的始祖盘古创世纪活动的核心区域，也是红色革命根据地之一。\r\n1\r\nCaparol的线下体验中心位于驿城区铜山大道与文化路路口附近的南美庐元D3栋1单元的临街店铺，店面面积约150平，秉持着一贯的“德国范”。\r\n2\r\n3\r\n4\r\n开业当天，驻马店首次Caparol会员经销商招募大会也在天龙大酒店召开。会议主要就Caparol品牌、发展历史以及产品作了相关介绍，并对“线上销售+线下体验”的涂料行业全新模式作了详细讲解。\r\n5\r\n6\r\nCaparol隶属于德国DAW SE集团，诞生于1895年。百年来Caoarol秉持以质取胜的理念，这不仅仅意味着生产和推广革新优质的产品，更重要的是坚持环保而低原料消耗的生产原则，以保证每桶标有Caparol标志的产品成为高品质的象征。\r\n作为涂料行业全新销售模式的领跑者，Caparol的“新零售”也引起了在场每一位会员经销商极大的兴趣，迎合互联网时代的浪潮，直击传统销售模式痛点，Caparol将携手每一位会员经销商，颠覆涂料行业。', null, '2018-03-06 09:24:58', '2018-03-06 09:24:58', '20161222113810681189580305593289', null, null);
INSERT INTO `th_notice` VALUES ('20180306092655354540201520030347', '包头好去处—九曲花街 1月28日盛大开业', '九曲花街业态规划为花鸟宠物、古玩玉器、家居饰品、工艺礼品、特色餐饮、字画拍卖等。由专业运营团队全程跟踪，同时引入“互联网+”物流销售平台.以科学完善的管理制度；现代新型商业模式；专业运营策划团队全力打造西北地区规模较大、业态全、专业化程度高、市场竞争力强的文化产业综合性九曲花街。\r\n\r\n\r\n项目占地面积35亩，建筑面积2.5万平方米，具有观赏旅游示范休闲、购物品质的九曲花街。花街建筑外观新颖别致、古朴典雅；业态布局科学合理；购物环境优良舒适；文化特色鲜明；配套设施齐全；每栋楼均配置客梯及货梯，同时规划停车位200余个。\r\n\r\n这是一个以花鸟鱼虫，书画奇石艺术文化交流的基地；一个展示、参与、体验中华书画艺术的文化窗口。一个全城市民共享的特色休闲娱乐消费中心。\r\n九曲花街实景展示\r\n花卉绿植\r\n\r\n奇石、老物件\r\n\r\n\r\n\r\n文玩珠宝\r\n\r\n\r\n水族\r\n\r\n开街时间：2018年1月28日\r\n项目地址：包头市东河区红星环岛北100米处\r\n交通路线：可乘坐10路、35路、38路、36路、7路、30路、16路等公交线路到红星环岛下车。\r\n联系电话：400-6174-717', null, '2018-03-06 09:26:55', '2018-03-06 09:26:55', '20161222113810681189580305593289', null, null);
INSERT INTO `th_notice` VALUES ('20180306092757536015073537230523', '3月10日开业！小米之家要开机场店了', '2017年小米不仅在出货量上创新高，小米之家在全国各地陆续开业，几乎每周我们都能看到小米之家开业，小米CEO雷军对此表示：“我们不是在开店，就是在开店的路上”。\r\n小米之家首家机场店来了：3月10日开业\r\n小米之家首家机场店来了：3月10日开业\r\n3月5日，小米官方宣布，小米之家首家机场店——深圳宝安机场店3月10日正式开业。详细地址是深圳宝安机场T3航站楼F4国内出发厅（值机岛E后方）。\r\n与此同时，长沙、焦作、锦州、禹州等四家新店将同步开业，它们分别是长沙万家丽店、焦作万达广场店、锦州锦绣前程店、禹州一峰城市广场店等。\r\n此前小米总裁林斌透露，小米之家的运营方式是能够支撑收费模式的，最主要是因为销售额很高，而租金是固定的，结果就是坪效很不错，达到了26万元。在整个行业内，这仅次于苹果的40万左右。', null, '2018-03-06 09:27:57', '2018-03-06 09:27:57', '20161222113810681189580305593289', null, null);
INSERT INTO `th_notice` VALUES ('20180306092847591789643027399799', '1保定新零售店盛大开业 联想新零售店在地级市加速扩张', '1原标题：保定新零售店盛大开业 联想新零售店在地级市加速扩张\r\n2月11日，联想又一家新零售店在保定市万博广场盛大开业。在2018年初CES大展上，联想集团执行副总裁兼中国区总裁刘军，就透露：联想成立了旗下首家新零售公司——天禧传奇科技有限公司，剑指新零售界的独角兽！此前，联想旗下天禧传奇CEO周铭曾表示，2018年联想将在全国范围内以直营+加盟的方式开设150家智生活门店，并不断迭代变换。这是继1月28日，联想全球首家智生活直营店在北京金源燕莎开业后，首间在地级市开业的新零售店，标志着联想新零售已经拉开在地级市加速扩张的帷幕。\r\n\r\n联想以客户为中心4S是核心竞争力\r\n首家联想4S店面于2017年6月上线，目前已经覆盖全国60多个核心城市，传统IT零售门店需要8个月甚至更长时间实现开业后盈利，但是联想4S店创造了最快当月开业、当月盈利的记录，反映出市场对该模式的认可。\r\n4S的概念源自汽车行业，最大的特点是整合产品销售、体验和售后服务于一体，实现消费者价值和品牌价值的最大化。以此为基础，联想提出的IT零售界4S模式指的是：\r\nSales，打破传统线上线下隔阂，实行线上线下同价的全网营销策略；\r\nService，提供最亲民、最个性化的IT服务，从专业的数据恢复服务、电脑保养服务到家庭网路组件服务无所不包，你的一切IT服务问题，我们都力争迎刃而解；\r\nShow，不仅售卖产品，更会展示各种黑科技产品，你只要进店，就可随时体验；\r\nSocial，我们将打造全新的社群化营销模式，并定期开展“疯狂低价”会员福利活动。\r\n联想新零售店不只销售联想品牌的产品，零售店里除了联想旗下全线产品，还有品种繁多的各类智能设备，如Kindle电子书，万魔耳机，Bose音箱等，一次性满足顾客对智能设备的选购需求。服务的集成，让联想新零售店为客户提供的服务也更为多元和个性化，从专业的数据恢复服务、电脑保养到家庭网路组件等亲民IT服务。\r\n此次万博广场店盛大开业，热销机型酬宾价，直降1100元，心动配件低至九块九、现场更有现金红包派送和抽奖机会。进店参与产品体验可以领取蛋糕并获得AR游戏畅玩的机会。该店是保定当地3家联想新零售店中促销力度最大的一家，SKU转化率近200。\r\n\r\n新零售新在哪里\r\n传统零售主要是以线下实体店为主体。近十年电商经过快速发展，基本达到了线上、线下市场各分天下的状态，线下的比例更高一些。但是，随着线上获客成本的提升，它的成长性也面临问题。随着产业升级，线上、线下亟待融合，线上的电商往线下发展，线下做实体店的往线上拓展。\r\n新零售给消费者带来了更大的便利。以往消费者在购买一件产品的时候，有70%会首先到线上进行查询、比较，获得相关信息。有30%会选择首先到线下店体验，圈定他需要的产品。在最后的交易环节，线上、线下的比例各占一半。\r\n而新零售出现后，给消费者带来了交易效率及体验的全面提升。首先是交易效率，因为用户行为发生了变化，给他们提供便利的选择、体验、购买的全过程。二是体验的提升。在新零售店里有丰富的产品品类。细致来看，每一个产品都是场景化展示的，体验非常好。在交易的过程中，都是电子价签。通过电子价签实现全网同价，线上是什么价格，实体店也是什么价格，这对用户来讲也是体验的提升。以前同样一个厂家的产品，线上、线下的价格不一样，作为消费者来讲，刚买到一个产品后一旦看到不同甚至更低的价格，这种体验是非常不好的。新零售给用户带来效率的提升，体验也在提升。\r\n\r\n联想新零售布局\r\n与京东和小米这种纯线上企业去做线下门店来说，联想的巨大优势就是其在国内已经拥有超过10000家线下门店渠道。同时经过20多年的积累，联想建立了国内最完善的IT售后服务体系，拥有2400多家线下的服务站，超过1万名的专业联想客服人员，并引入了AI技术，机器人7×24小时在线服务。在开设新零售门店时，联想累积的大量的后备门店和人力资源，将为其搭建和完善线下零售渠道体系提供充裕的人力物力。更不要忽视，联想在这些线下资产背后还拥有20多年零售管理、运维经验。这些都是难能可贵的势能积累。\r\n联想新零售体系整体设计已初步搭建完成，此前，宣布正式成立联想控股新零售公司天禧传奇，由曾经联想最大的经销商周铭担任CEO，天禧传奇所承载的是联想新零售布局排头兵的重担。\r\n据周铭介绍，联想智生活门店计划于2018年新开150家左右，但未来三年将采用直营+加盟的方式开1000家，在1000家店面中，有50家左右是直营店面，剩下900多家是跟优秀合作伙伴合作的店面，这50家自营店里有5家顶级概念店，未来还可能会出现5000家左右的店中店模式。\r\n这是一个庞大的商业目标，也显示了联想在新零售业务上的目标和决心。\r\n联想集团执行副总裁、联想中国区总裁刘军在2018CES上接受媒体采访时曾表示：新零售领域势必会冒出独角兽公司，如果天禧传奇业务进展顺利，联想或将很快孵化出新零售界的独角兽公司。\r\n新零售很重要的是零售阵地的管理，这是很核心的能力需求。新零售不仅能使联想现有业务获得增量，还将促使联想整体向智能化和数据化转型，领跑智能时代。', null, '2018-03-06 09:28:47', '2018-03-06 09:28:47', '20161222113810681189580305593289', '2018-03-08 09:53:32', '20161222113810681189580305593289');

-- ----------------------------
-- Table structure for th_order
-- ----------------------------
DROP TABLE IF EXISTS `th_order`;
CREATE TABLE `th_order` (
  `id` varchar(32) NOT NULL,
  `customer_id` varchar(32) DEFAULT NULL COMMENT '会员ID',
  `store_id` varchar(32) DEFAULT NULL COMMENT '所属门店',
  `cashierUser_id` varchar(32) DEFAULT NULL COMMENT '收银员（ps：auth_user表里的）',
  `guideUser_id` varchar(32) DEFAULT NULL COMMENT '导购（ps：auth_user表里的）',
  `order_id` varchar(32) DEFAULT NULL COMMENT '上级订单',
  `code` varchar(30) DEFAULT NULL COMMENT '订单ID（订单Util生成的16位长订单）',
  `type` varchar(5) DEFAULT NULL COMMENT '类型（1：线上，2：线下，z3：换购，4：预约，5：退货，6：换货,7:同商品换货）',
  `payTime` timestamp NULL DEFAULT NULL COMMENT '下单日期（线上），线下和换够：成交日期，预约：完成日期',
  `payType` varchar(5) DEFAULT NULL COMMENT '支付方式（1：现金支付，2：银行pos刷卡支付，3：微信支付，4：支付宝支付，5：天和会员余额）',
  `reserveName` varchar(50) DEFAULT NULL COMMENT '预约人(预约类订单必填，其他不需要填写)',
  `reservePhone` varchar(20) DEFAULT NULL COMMENT '预约人手机号码(预约类订单必填，其他不需要填写)',
  `reserveTime` timestamp NULL DEFAULT NULL COMMENT '预约时间(预约类订单必填，其他不需要填写)',
  `reserveMoney` varchar(50) DEFAULT NULL COMMENT '定金(预约类订单必填，其他不需要填写)',
  `lestMoney` varchar(50) DEFAULT NULL COMMENT '尾款',
  `state` varchar(5) DEFAULT NULL COMMENT '状态(1：未支付，2：未发货，3：已出库，4：已发货，5：待评价，6：已完成，7：放弃)（ps：放弃的状态在预约类的订单会出现，状态2、3、4、5 只有线上出现其他状态都出现）',
  `sumMoney` varchar(50) DEFAULT NULL COMMENT '订单总金额',
  `sumNumber` varchar(50) DEFAULT NULL COMMENT '订单总数',
  `inLinePayMoney` varchar(50) DEFAULT NULL,
  `payMoney` varchar(50) DEFAULT NULL COMMENT '支付金额',
  `eticketMoney` varchar(50) DEFAULT NULL,
  `subMoney` varchar(50) DEFAULT NULL COMMENT '订单总优惠金额',
  `subUserType` varchar(5) DEFAULT NULL COMMENT '优惠级别（1：导购，2：主管，3：经理）',
  `cashierCode` varchar(20) DEFAULT NULL COMMENT '款台号',
  `leaveMessage` text COMMENT '订单留言（仅线上订单有）',
  `receiverName` varchar(50) DEFAULT NULL COMMENT '收货人（仅线上订单有）',
  `receiverAddress` text COMMENT '收货地址（仅线上订单有）',
  `receiverPhone` varchar(20) DEFAULT NULL COMMENT '收货人手机号（仅线上订单有）',
  `expressName` varchar(50) DEFAULT NULL COMMENT '快递姓名',
  `expressPhone` varchar(20) DEFAULT NULL COMMENT '快递电话',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  `proType` varchar(50) DEFAULT NULL COMMENT 'goodsOrder对应产品级活动子订单，storeOrder对应门店级活动子订单，tianheOrder对应天河级活动子订单，otherOrder代表无活动子订单产品， nullOrder 代表讲价优惠订单(不参与任何活动订单)',
  `onePayMoney` varchar(255) DEFAULT NULL COMMENT '订单首次支付金额',
  `onePayType` varchar(5) DEFAULT NULL COMMENT '第一次支付方式',
  `onePayCode` varchar(50) DEFAULT NULL COMMENT '第一次支付交易单号（微信或支付宝支付会有）',
  `oneReturnMoney` varchar(50) DEFAULT NULL COMMENT '订单首次支付未退款金额',
  `twoPayMoney` varchar(50) DEFAULT NULL COMMENT '订单第二次支付金额',
  `twoPayType` varchar(5) DEFAULT NULL COMMENT '第二次支付方式',
  `twoPayCode` varchar(50) DEFAULT NULL COMMENT '第二次支付交易单号（微信或支付宝支付会有）',
  `twoPayTime` timestamp NULL DEFAULT NULL COMMENT '第二次支付时间 ',
  `twoCashierUser_id` varchar(32) DEFAULT NULL COMMENT '第二次支付收银员',
  `twoCashierCode` varchar(20) DEFAULT NULL COMMENT '第二次支付款台号',
  `twoReturnMoney` varchar(50) DEFAULT NULL COMMENT '订单第二次支付未退金额',
  `remark` text COMMENT '备注',
  `returnMoney` varchar(50) DEFAULT NULL COMMENT '现金退款额度',
  `returnWeChatPay` varchar(50) DEFAULT NULL COMMENT '微信支付退款额度',
  `returnAliPay` varchar(50) DEFAULT NULL COMMENT '支付宝支付退款额度',
  `returnCard` varchar(50) DEFAULT NULL COMMENT '银行卡退款额',
  `returnTianhe` varchar(50) DEFAULT NULL COMMENT '天河余额退款额',
  `oneGetMoney` varchar(50) DEFAULT NULL COMMENT '首次实收金额',
  `twoGetMoney` varchar(50) DEFAULT NULL COMMENT '第二次实收金额(现金和银行卡会放)',
  `batchCode` varchar(30) DEFAULT NULL,
  `postage` varchar(50) DEFAULT NULL,
  `isSendMsg` text COMMENT '发放过模板消息的预约产品ID',
  `logistics` varchar(500) DEFAULT NULL COMMENT '物流公司',
  `logisticsCode` varchar(50) DEFAULT NULL COMMENT '物流单号',
  `isHide` varchar(5) DEFAULT NULL COMMENT '是否隐藏 1:隐藏 2:显示',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_27` (`customer_id`),
  KEY `order_id` (`order_id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `FK_Reference_27` FOREIGN KEY (`customer_id`) REFERENCES `th_customer` (`id`),
  CONSTRAINT `th_order_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `th_order` (`id`),
  CONSTRAINT `th_order_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `th_store` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单';

-- ----------------------------
-- Records of th_order
-- ----------------------------
INSERT INTO `th_order` VALUES ('20180510145642058457353678743162', '20170923163450618324289056610089', '20171020141842757704681968303771', '20170922195030757264333921841291', '20170922182244405544128921993049', null, '2018051014560000', '2', '2018-05-10 14:58:21', '1', null, null, null, null, null, '6', '300.4', '2', null, '300.4', null, '0.0', null, '001', null, null, null, null, null, null, '2018-05-10 14:56:42', '2018-05-10 14:56:42', '20170922192735138176357766606813', '2018-05-10 15:01:31', '20170922192735138176357766606813', null, '300.0', '1', null, '300.0', '0.0', null, null, null, null, null, '0.0', '', null, null, null, null, null, '300', null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180510145642059837352467270808', '20170923163450618324289056610089', '20171020141842757704681968303771', '20170922195030757264333921841291', '20170922182244405544128921993049', '20180510145642058457353678743162', '2018051014560001', '2', '2018-05-10 14:58:21', '1', null, null, null, null, null, '6', '300.0', '1', null, '300.0', null, '0.0', null, '001', null, null, null, null, null, null, '2018-05-10 14:56:42', '2018-05-10 14:56:42', '20170922192735138176357766606813', null, null, 'otherOrder', null, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '300', null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180510145909901618955352110751', '20170923163450618324289056610089', '20171020141842757704681968303771', null, '20170922182244405544128921993049', '20180510145642058457353678743162', '2018051014590000', '6', null, null, null, null, null, null, null, '6', '0.0', '0', null, '0.0', null, '0.0', null, null, null, null, null, null, null, null, '2018-05-10 14:59:09', '2018-05-10 14:59:09', '20170922192735138176357766606813', null, null, null, '0.0', null, null, '0.0', '0.0', null, null, null, null, null, '0.0', null, null, null, null, null, null, null, null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180510150131162099181355688283', '20170923163450618324289056610089', '20171020141842757704681968303771', null, '20170922182244405544128921993049', '20180510145642058457353678743162', '2018051015010000', '6', null, null, null, null, null, null, null, '7', '0.4', '1', null, '0.4', null, '0.0', null, null, null, null, null, null, null, null, '2018-05-10 15:01:31', '2018-05-10 15:01:31', '20170922192735138176357766606813', null, null, null, '0.4', null, null, '0.4', '0.0', null, null, null, null, null, '0.0', null, null, null, null, null, null, null, null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180510152119412055285222497753', '20170923163450618324289056610089', '20171020141842757704681968303771', '20170922195030757264333921841291', '20170922182244405544128921993049', '20180510152119412451684667605426', '2018051015210002', '4', '2018-05-10 15:21:53', null, null, null, null, null, null, '7', '300.0', '1', null, '300.0', null, '0.0', null, '001', null, null, null, null, null, null, '2018-05-10 15:21:19', '2018-05-10 15:21:19', '20170922192735138176357766606813', '2018-05-10 17:44:39', '20170922192735138176357766606813', 'otherOrder', null, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '100', null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180510152119412451684667605426', '20170923163450618324289056610089', '20171020141842757704681968303771', '20170922195030757264333921841291', '20170922182244405544128921993049', null, '2018051015210001', '4', '2018-05-10 15:21:53', null, 'aaa', '13122221111', '2018-05-10 15:21:19', '100', '200.0', '7', '300.00', '1', null, '300.00', null, '0.00', null, '001', null, null, null, null, null, null, '2018-05-10 15:21:19', '2018-05-10 15:21:19', '20170922192735138176357766606813', '2018-05-10 17:44:39', '20170922192735138176357766606813', null, '100', '1', null, '100', '200.0', null, null, null, null, null, '200.0', '', null, null, null, null, null, '100', null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180510152329829077604090601790', '20170923163450618324289056610089', '20171020141842757704681968303771', '20170922195030757264333921841291', '20170922182244405544128921993049', null, '2018051015230001', '4', '2018-05-10 15:23:51', null, 'aaa', '13122221111', '2018-05-10 15:23:29', '100', '800.0', '7', '900.00', '3', null, '900.00', null, '0.00', null, '001', null, null, null, null, null, null, '2018-05-10 15:23:29', '2018-05-10 15:23:29', '20170922192735138176357766606813', '2018-05-10 17:44:43', '20170922192735138176357766606813', null, '100', '1', null, '100', '800.0', null, null, null, null, null, '800.0', '', null, null, null, null, null, '100', null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180510152329830862112975583962', '20170923163450618324289056610089', '20171020141842757704681968303771', '20170922195030757264333921841291', '20170922182244405544128921993049', '20180510152329829077604090601790', '2018051015230002', '4', '2018-05-10 15:23:51', null, null, null, null, null, null, '7', '900.0', '3', null, '900.0', null, '0.0', null, '001', null, null, null, null, null, null, '2018-05-10 15:23:29', '2018-05-10 15:23:29', '20170922192735138176357766606813', '2018-05-10 17:44:43', '20170922192735138176357766606813', 'otherOrder', null, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '100', null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180510172936334362255349072060', '20170923163450618324289056610089', '20170922155301527135602974909688', '20170922195030757264333921841291', null, null, '2018051017290000', '2', '2018-05-10 17:29:48', '1', null, null, null, null, null, '6', '100.00', '0', null, '100.00', '0.0', '0.00', null, '001', null, null, null, null, null, null, '2018-05-10 17:29:36', '2018-05-10 17:29:36', null, null, null, null, '100.0', '1', null, '100.0', '0.0', null, null, null, null, null, '0.0', null, null, null, null, null, null, '100', null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180510172936340980165955823370', '20170923163450618324289056610089', '20170922155301527135602974909688', '20170922195030757264333921841291', null, '20180510172936334362255349072060', '2018051017290001', '2', '2018-05-10 17:29:48', null, null, null, null, null, null, '6', '100', '0', null, '100.00', '0.0', '0.00', null, '001', null, null, null, null, null, null, '2018-05-10 17:29:36', '2018-05-10 17:29:36', null, null, null, 'otherOrder', '100.0', null, null, '100.0', '0.0', null, null, null, null, null, '0.0', null, null, null, null, null, null, '100', null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180510173332525002192484108123', '20170923163450618324289056610089', '20170922155404113485654128116220', '20170922195030757264333921841291', null, null, '2018051017330000', '2', '2018-05-10 17:33:40', '1', null, null, null, null, null, '6', '100.00', '0', null, '100.00', '0.0', '0.00', null, '001', null, null, null, null, null, null, '2018-05-10 17:33:32', '2018-05-10 17:33:32', null, null, null, null, '100.0', '1', null, '100.0', '0.0', null, null, null, null, null, '0.0', null, null, null, null, null, null, '100', null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180510173332533004096938867836', '20170923163450618324289056610089', '20170922155404113485654128116220', '20170922195030757264333921841291', null, '20180510173332525002192484108123', '2018051017330001', '2', '2018-05-10 17:33:40', null, null, null, null, null, null, '6', '100', '0', null, '100.00', '0.0', '0.00', null, '001', null, null, null, null, null, null, '2018-05-10 17:33:32', '2018-05-10 17:33:32', null, null, null, 'otherOrder', '100.0', null, null, '100.0', '0.0', null, null, null, null, null, '0.0', null, null, null, null, null, null, '100', null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180510180331950254784649789821', '20170923163450618324289056610089', '20171020141842757704681968303771', '20170922195030757264333921841291', '20170922182244405544128921993049', null, '2018051018030000', '2', '2018-05-10 18:07:49', '1', null, null, null, null, null, '6', '594.0', '-2', null, '594.0', null, '0.0', null, '001', null, null, null, null, null, null, '2018-05-10 18:03:31', '2018-05-10 18:03:32', '20170922192735138176357766606813', '2018-05-11 11:34:47', '20170925104833839272877986863829', null, '600.0', '1', null, '600.0', '0.0', null, null, null, null, null, '0.0', '', null, null, null, null, null, '600', null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180510180332087912736343141935', '20170923163450618324289056610089', '20171020141842757704681968303771', '20170922195030757264333921841291', '20170922182244405544128921993049', '20180510180331950254784649789821', '2018051018030002', '2', '2018-05-10 18:07:49', '1', null, null, null, null, null, '6', '600.0', '2', null, '600.0', null, '0.0', null, '001', null, null, null, null, null, null, '2018-05-10 18:03:32', '2018-05-10 18:03:32', '20170922192735138176357766606813', null, null, 'storeOrder', null, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '600', null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180511113142390262749122042863', '20170923163450618324289056610089', '20180122101904528474410614949352', null, null, '20180510180331950254784649789821', '2018051111310000', '3', null, null, null, null, null, null, null, '7', '3.0', '2', null, '3.0', null, '0.0', null, null, null, null, null, null, null, null, '2018-05-11 11:31:42', '2018-05-11 11:31:42', '20170925104833839272877986863829', '2018-05-11 11:32:02', '20170925104833839272877986863829', null, '3.0', null, null, '3.0', '0.0', null, null, null, null, null, '0.0', null, null, null, null, null, null, null, null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180511113210991883137754443025', '20170923163450618324289056610089', '20180122101904528474410614949352', null, null, '20180510180331950254784649789821', '2018051111320000', '3', null, null, null, null, null, null, null, '7', '1.0', '1', null, '1.0', null, '0.0', null, null, null, null, null, null, null, null, '2018-05-11 11:32:10', '2018-05-11 11:32:10', '20170925104833839272877986863829', '2018-05-11 11:34:47', '20170925104833839272877986863829', null, '1.0', null, null, '1.0', '0.0', null, null, null, null, null, '0.0', null, null, null, null, null, null, null, null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180511113220385857789569707219', '20170923163450618324289056610089', '20180122101904528474410614949352', null, null, '20180510180331950254784649789821', '2018051111320001', '3', null, null, null, null, null, null, null, '7', '2.0', '1', null, '2.0', null, '0.0', null, null, null, null, null, null, null, null, '2018-05-11 11:32:20', '2018-05-11 11:32:20', '20170925104833839272877986863829', '2018-05-11 11:34:27', '20170925104833839272877986863829', null, '2.0', null, null, '2.0', '0.0', null, null, null, null, null, '0.0', null, null, null, null, null, null, null, null, null, null, null, null, null, '2');
INSERT INTO `th_order` VALUES ('20180511113549842141166448798692', '20170923163450618324289056610089', '20180122101904528474410614949352', null, null, '20180510180331950254784649789821', '2018051111350000', '3', null, null, null, null, null, null, null, '1', '1.0', '1', null, '1.0', null, '0.0', null, null, null, null, null, null, null, null, '2018-05-11 11:35:49', '2018-05-11 11:35:49', '20170925104833839272877986863829', null, null, null, '1.0', null, null, '1.0', '0.0', null, null, null, null, null, '0.0', null, null, null, null, null, null, null, null, null, null, null, null, null, '2');

-- ----------------------------
-- Table structure for th_order_aftersale
-- ----------------------------
DROP TABLE IF EXISTS `th_order_aftersale`;
CREATE TABLE `th_order_aftersale` (
  `id` varchar(32) NOT NULL,
  `orderGoodsQrcode_id` varchar(32) DEFAULT NULL COMMENT '售后商品Id',
  `user_id` varchar(32) DEFAULT NULL COMMENT '主管',
  `sendMoney` varchar(50) DEFAULT NULL COMMENT '售后退款金',
  `remark` text COMMENT '售后备注',
  `isDelete` varchar(10) DEFAULT NULL COMMENT '是否删除（1：否，2：是）',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orderGoodsQrcode_id` (`orderGoodsQrcode_id`),
  CONSTRAINT `th_order_aftersale_ibfk_1` FOREIGN KEY (`orderGoodsQrcode_id`) REFERENCES `th_order_goods_qrcode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of th_order_aftersale
-- ----------------------------

-- ----------------------------
-- Table structure for th_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `th_order_goods`;
CREATE TABLE `th_order_goods` (
  `id` varchar(32) NOT NULL,
  `order_id` varchar(32) DEFAULT NULL,
  `goods_id` varchar(32) DEFAULT NULL,
  `count` varchar(20) DEFAULT NULL,
  `price` varchar(50) DEFAULT NULL,
  `subMoney` varchar(50) DEFAULT NULL COMMENT ' 减免金额',
  `type` varchar(5) DEFAULT NULL COMMENT '类型 （1：卖出，2：退货）',
  `OSM_ID` varchar(32) DEFAULT NULL COMMENT '减免记录ID(换够订单的orderGoods会用到）',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_28` (`order_id`),
  KEY `FK_Reference_29` (`goods_id`),
  CONSTRAINT `FK_Reference_28` FOREIGN KEY (`order_id`) REFERENCES `th_order` (`id`),
  CONSTRAINT `FK_Reference_29` FOREIGN KEY (`goods_id`) REFERENCES `th_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单商品关联';

-- ----------------------------
-- Records of th_order_goods
-- ----------------------------
INSERT INTO `th_order_goods` VALUES ('20180510145642059845041019294030', '20180510145642059837352467270808', '20180309105036174528202992898075', '1', '300', '0.0', '1', null, '2018-05-10 14:56:42', '2018-05-10 14:56:42', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods` VALUES ('20180510145909902011700264026623', '20180510145909901618955352110751', '20180309105036174528202992898075', '1', '300', '0', '1', null, '2018-05-10 14:59:09', '2018-05-10 14:59:10', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods` VALUES ('20180510145909902496676774503094', '20180510145909901618955352110751', '20180309105036174528202992898075', '1', '300', '0.0', '2', null, '2018-05-10 14:59:09', '2018-05-10 14:59:09', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods` VALUES ('20180510150131162324600182486090', '20180510150131162099181355688283', '20180309105036174528202992898075', '1', '300', '0.0', '2', null, '2018-05-10 15:01:31', '2018-05-10 15:01:31', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods` VALUES ('20180510150131162336562335257122', '20180510150131162099181355688283', '20180305101632540354835519511063', '1', '0.4', '0', '1', null, '2018-05-10 15:01:31', '2018-05-10 15:01:31', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods` VALUES ('20180510150131162743416870436210', '20180510150131162099181355688283', '20180309105036174528202992898075', '1', '300', '0', '1', null, '2018-05-10 15:01:31', '2018-05-10 15:01:31', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods` VALUES ('20180510152119426677972592613171', '20180510152119412055285222497753', '20180309105036174528202992898075', '1', '300', '0.0', '1', null, '2018-05-10 15:21:19', '2018-05-10 15:21:19', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods` VALUES ('20180510152329852547985260999452', '20180510152329830862112975583962', '20180309105036174528202992898075', '3', '300', '0.0', '1', null, '2018-05-10 15:23:29', '2018-05-10 15:23:29', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods` VALUES ('20180510180331950309310142923657', '20180510180332087912736343141935', '20180309105036174528202992898075', '2', '300', '0.0', '1', null, '2018-05-10 18:03:31', '2018-05-10 18:03:32', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods` VALUES ('20180511113142391807986250250814', '20180511113142390262749122042863', '20171016094309465163388680954678', '1', '1', '0.0', '1', '20180510180332088479084425087008', '2018-05-11 11:31:42', '2018-05-11 11:31:42', '20170925104833839272877986863829', null, null);
INSERT INTO `th_order_goods` VALUES ('20180511113142392144764970700352', '20180511113142390262749122042863', '20171016094309465163388680954678', '1', '2', '0.0', '1', '20180510180332609923707696356219', '2018-05-11 11:31:42', '2018-05-11 11:31:42', '20170925104833839272877986863829', null, null);
INSERT INTO `th_order_goods` VALUES ('20180511113210992200328590338097', '20180511113210991883137754443025', '20171016094309465163388680954678', '1', '1', '0.0', '1', '20180510180332088479084425087008', '2018-05-11 11:32:10', '2018-05-11 11:32:11', '20170925104833839272877986863829', null, null);
INSERT INTO `th_order_goods` VALUES ('20180511113220386250611630335391', '20180511113220385857789569707219', '20171016094309465163388680954678', '1', '2', '0.0', '1', '20180510180332609923707696356219', '2018-05-11 11:32:20', '2018-05-11 11:32:20', '20170925104833839272877986863829', null, null);
INSERT INTO `th_order_goods` VALUES ('20180511113549842149736236740193', '20180511113549842141166448798692', '20171016094309465163388680954678', '1', '1', '0.0', '1', '20180510180332088479084425087008', '2018-05-11 11:35:49', '2018-05-11 11:35:49', '20170925104833839272877986863829', null, null);

-- ----------------------------
-- Table structure for th_order_goods_qrcode
-- ----------------------------
DROP TABLE IF EXISTS `th_order_goods_qrcode`;
CREATE TABLE `th_order_goods_qrcode` (
  `id` varchar(32) NOT NULL,
  `qrcode_id` varchar(32) DEFAULT NULL COMMENT '二维码ID',
  `order_goods_id` varchar(32) DEFAULT NULL,
  `isJoin` varchar(5) DEFAULT NULL COMMENT '是否参与活动（1：参与，2：不参与）',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `qrcode_id` (`qrcode_id`),
  KEY `order_goods_id` (`order_goods_id`),
  CONSTRAINT `th_order_goods_qrcode_ibfk_1` FOREIGN KEY (`qrcode_id`) REFERENCES `th_qrcode` (`id`),
  CONSTRAINT `th_order_goods_qrcode_ibfk_2` FOREIGN KEY (`order_goods_id`) REFERENCES `th_order_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of th_order_goods_qrcode
-- ----------------------------
INSERT INTO `th_order_goods_qrcode` VALUES ('20180510145642059572948329262505', '20180510145519451918373328682774', '20180510145642059845041019294030', '1', '2018-05-10 14:56:42', '2018-05-10 14:56:42', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods_qrcode` VALUES ('20180510145909902209722969451698', '20180510145519451918373328682774', '20180510145909902496676774503094', '2', '2018-05-10 14:59:09', '2018-05-10 14:59:09', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods_qrcode` VALUES ('20180510145909902643412186765923', '20180510145519658502869713840799', '20180510145909902011700264026623', '2', '2018-05-10 14:59:09', '2018-05-10 14:59:10', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods_qrcode` VALUES ('20180510150131162108174909939371', '20180510150029485810626574554506', '20180510150131162336562335257122', '2', '2018-05-10 15:01:31', '2018-05-10 15:01:31', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods_qrcode` VALUES ('20180510150131162778000006618146', '20180510145519658502869713840799', '20180510150131162324600182486090', '2', '2018-05-10 15:01:31', '2018-05-10 15:01:31', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods_qrcode` VALUES ('20180510150131162995971867401105', '20180510145519685979593622057967', '20180510150131162743416870436210', '2', '2018-05-10 15:01:31', '2018-05-10 15:01:31', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods_qrcode` VALUES ('20180510152226475917314694932469', '20180510145519658502869713840799', '20180510152119426677972592613171', '2', '2018-05-10 15:22:26', null, null, null, null);
INSERT INTO `th_order_goods_qrcode` VALUES ('20180510152428017962321289621261', '20180510145519451918373328682774', '20180510152329852547985260999452', '2', '2018-05-10 15:24:28', null, null, null, null);
INSERT INTO `th_order_goods_qrcode` VALUES ('20180510180331950730349610229241', '20180510145519451918373328682774', '20180510180331950309310142923657', '1', '2018-05-10 18:03:31', '2018-05-10 18:03:32', '20170922192735138176357766606813', null, null);
INSERT INTO `th_order_goods_qrcode` VALUES ('20180510180331951364537158728489', '20180510145519658502869713840799', '20180510180331950309310142923657', '1', '2018-05-10 18:03:31', '2018-05-10 18:03:32', '20170922192735138176357766606813', null, null);

-- ----------------------------
-- Table structure for th_order_subremark
-- ----------------------------
DROP TABLE IF EXISTS `th_order_subremark`;
CREATE TABLE `th_order_subremark` (
  `id` varchar(32) NOT NULL,
  `order_id` varchar(32) DEFAULT NULL COMMENT '所属订单',
  `orderGoods_id` varchar(32) DEFAULT NULL COMMENT '订单商品ID(针对商品的活动才放值）',
  `promotionLadder_id` varchar(32) DEFAULT NULL COMMENT '活动阶梯ID(满足那哪个阶梯使用哪个阶梯优惠）',
  `promotion_id` varchar(32) DEFAULT NULL COMMENT '活动ID，无阶梯活动的使用本字段',
  `isSendLadder` varchar(32) DEFAULT NULL COMMENT '优惠是否发放(1：未发放，2：已发放）',
  `salesMoney` varchar(50) DEFAULT NULL COMMENT '待补交金额',
  `remark` char(10) DEFAULT NULL COMMENT '订单减免备注',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  `putOutGoodsQrcodeString` text COMMENT '赠品发放记录',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_30` (`order_id`),
  KEY `orderGoods_id` (`orderGoods_id`),
  KEY `promotionLadder_id` (`promotionLadder_id`),
  CONSTRAINT `FK_Reference_30` FOREIGN KEY (`order_id`) REFERENCES `th_order` (`id`),
  CONSTRAINT `th_order_subremark_ibfk_1` FOREIGN KEY (`orderGoods_id`) REFERENCES `th_order_goods` (`id`),
  CONSTRAINT `th_order_subremark_ibfk_2` FOREIGN KEY (`promotionLadder_id`) REFERENCES `th_promotion_ladder` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单减免记录';

-- ----------------------------
-- Records of th_order_subremark
-- ----------------------------
INSERT INTO `th_order_subremark` VALUES ('20180510180332088479084425087008', '20180510180332087912736343141935', null, '20180510174652933969140835403856', null, '2', '1', null, '2018-05-10 18:03:32', '2018-05-10 18:03:32', '20170922192735138176357766606813', null, null, null);
INSERT INTO `th_order_subremark` VALUES ('20180510180332609923707696356219', '20180510180331950254784649789821', null, '20180510174733732889949485443269', null, '1', '0.0', null, '2018-05-10 18:03:32', '2018-05-10 18:03:32', '20170922192735138176357766606813', null, null, null);

-- ----------------------------
-- Table structure for th_postage_bonus
-- ----------------------------
DROP TABLE IF EXISTS `th_postage_bonus`;
CREATE TABLE `th_postage_bonus` (
  `id` varchar(32) NOT NULL,
  `startMoney` varchar(50) DEFAULT NULL COMMENT '邮费档位',
  `proportion` varchar(20) DEFAULT NULL COMMENT '邮费',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of th_postage_bonus
-- ----------------------------
INSERT INTO `th_postage_bonus` VALUES ('20180304152237483096449426132695', '8', '4', '2018-03-04 15:22:37', '2018-03-04 15:22:37', '2018-03-10 17:36:58', '20161222113810681189580305593289', '20161222113810681189580305593289');

-- ----------------------------
-- Table structure for th_procurement
-- ----------------------------
DROP TABLE IF EXISTS `th_procurement`;
CREATE TABLE `th_procurement` (
  `id` varchar(32) NOT NULL,
  `type` varchar(5) DEFAULT NULL COMMENT '类型(1：采购订单，2：采购退货单)',
  `store_id` varchar(32) DEFAULT NULL COMMENT '相关门店',
  `vende_id` varchar(32) DEFAULT NULL COMMENT '供应商',
  `procurementCode` varchar(50) DEFAULT NULL COMMENT '采购单号',
  `count` varchar(20) DEFAULT NULL COMMENT '件数总计',
  `sumMoney` varchar(20) DEFAULT NULL COMMENT '金额总计',
  `state` varchar(5) DEFAULT NULL COMMENT '状态(1：待审核，2：未入库，3：已退货，4：完成)',
  `user_id` varchar(32) DEFAULT NULL COMMENT '审核人',
  `procurementDate` timestamp NULL DEFAULT NULL COMMENT '采购、退货日期',
  `remark` text,
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  `isDelete` varchar(5) DEFAULT NULL COMMENT '是否删除（1：否，2：是）',
  `checkRemark` text COMMENT '审核不通过原因',
  `buyCount` varchar(50) DEFAULT NULL COMMENT '实到件数总计 ',
  `buySumMoney` varchar(50) DEFAULT NULL COMMENT '实到金额总计',
  `shipType` varchar(50) DEFAULT NULL COMMENT '发货类型',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_9` (`vende_id`),
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`vende_id`) REFERENCES `th_vende` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购单';

-- ----------------------------
-- Records of th_procurement
-- ----------------------------
INSERT INTO `th_procurement` VALUES ('20180510145458190688892519304554', '1', '20171020141842757704681968303771', '20171020142004453627276165451387', '2018051014540000', '12', '358.56', '4', '20161222113810681189580305593289', '2018-05-10 14:55:09', '', '2018-05-10 14:54:58', '2018-05-10 14:54:58', '20161222113810681189580305593289', '2018-05-10 14:55:20', '20161222113810681189580305593289', '1', null, '12', '358.56', '123');
INSERT INTO `th_procurement` VALUES ('20180510150007147823372969811337', '1', '20171020141842757704681968303771', '20171020142004453627276165451387', '2018051015000000', '2', '60000.00', '4', '20161222113810681189580305593289', '2018-05-10 15:00:17', '', '2018-05-10 15:00:07', '2018-05-10 15:00:07', '20161222113810681189580305593289', '2018-05-10 15:00:29', '20161222113810681189580305593289', '1', null, '2', '60000.00', 'ASD');

-- ----------------------------
-- Table structure for th_procurement_goods
-- ----------------------------
DROP TABLE IF EXISTS `th_procurement_goods`;
CREATE TABLE `th_procurement_goods` (
  `id` varchar(32) NOT NULL,
  `procurement_id` varchar(32) DEFAULT NULL COMMENT '采购单ID',
  `goods_id` varchar(32) DEFAULT NULL COMMENT '产品Id',
  `count` varchar(50) DEFAULT NULL COMMENT '采购数量',
  `buyPrice` varchar(50) DEFAULT NULL COMMENT '采购单价',
  `isPrint` varchar(5) DEFAULT NULL COMMENT '是否打印(1：未打印，2：已打印)',
  `isRecord` varchar(5) DEFAULT NULL COMMENT '是否入库（1：未入库，2：已入库  ps：写到这里的时候再考虑和二维码的关联）',
  `buyAgio` varchar(50) DEFAULT NULL COMMENT '采购折扣',
  `salseMoney` varchar(50) DEFAULT NULL COMMENT '销售单价',
  `salseAgio` varchar(50) DEFAULT NULL,
  `buyCount` varchar(50) DEFAULT NULL COMMENT '采购到货数量',
  `goodsPrice` varchar(50) DEFAULT NULL COMMENT '产品吊牌价',
  `printUserID_string` text COMMENT ' 印刷人ID列表字符串',
  `printCount` varchar(50) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_10` (`procurement_id`),
  KEY `FK_Reference_11` (`goods_id`),
  CONSTRAINT `FK_Reference_10` FOREIGN KEY (`procurement_id`) REFERENCES `th_procurement` (`id`),
  CONSTRAINT `FK_Reference_11` FOREIGN KEY (`goods_id`) REFERENCES `th_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购单-商品';

-- ----------------------------
-- Records of th_procurement_goods
-- ----------------------------
INSERT INTO `th_procurement_goods` VALUES ('20180510145458205163251123526115', '20180510145458190688892519304554', '20180309105036174528202992898075', '12', '29.88', null, null, '12', '300', '', '12', '249', ',20161222113810681189580305593289', '12', null, '2018-05-10 14:54:58', '20161222113810681189580305593289', null, null);
INSERT INTO `th_procurement_goods` VALUES ('20180510150007149239717338032834', '20180510150007147823372969811337', '20180305101632540354835519511063', '2', '30000.00', null, null, '2', '0.4', '', '2', '1500000', ',20161222113810681189580305593289', '2', null, '2018-05-10 15:00:07', '20161222113810681189580305593289', null, null);

-- ----------------------------
-- Table structure for th_procurement_qrcode
-- ----------------------------
DROP TABLE IF EXISTS `th_procurement_qrcode`;
CREATE TABLE `th_procurement_qrcode` (
  `id` varchar(32) NOT NULL,
  `procurement_id` varchar(32) DEFAULT NULL COMMENT '采购单ID',
  `qrcode_id` varchar(32) DEFAULT NULL COMMENT '二维码ID',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `procurement_id` (`procurement_id`),
  KEY `qrcode_id` (`qrcode_id`),
  CONSTRAINT `th_procurement_qrcode_ibfk_1` FOREIGN KEY (`procurement_id`) REFERENCES `th_procurement` (`id`),
  CONSTRAINT `th_procurement_qrcode_ibfk_2` FOREIGN KEY (`qrcode_id`) REFERENCES `th_qrcode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购退货单包含二维码ID';

-- ----------------------------
-- Records of th_procurement_qrcode
-- ----------------------------

-- ----------------------------
-- Table structure for th_promotion
-- ----------------------------
DROP TABLE IF EXISTS `th_promotion`;
CREATE TABLE `th_promotion` (
  `id` varchar(32) NOT NULL,
  `promotionGroup_id` varchar(32) DEFAULT NULL COMMENT '所属活动分组',
  `type` varchar(5) DEFAULT NULL COMMENT '活动类型(1：折扣，2：满减，3：满反，4：特价促销，5：前2件打折，6：前三件打折，7：满送促销，8：买赠促销，9：加钱换够，10：第二件打折）',
  `ownerId` varchar(32) DEFAULT NULL COMMENT '产品Id或者门店ID，针对天河的本字段为空',
  `sorting` varchar(20) DEFAULT NULL COMMENT '优先级',
  `isDelete` varchar(5) DEFAULT NULL COMMENT '是否删除（1：否，2：是）',
  `otherPro1` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `otherPro2` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `otherPro3` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `otherPro4` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `otherPro5` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `otherPro6` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `otherPro7` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `otherPro8` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `otherPro9` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `otherPro10` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `otherPro11` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `otherPro12` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `otherPro13` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `otherPro14` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `otherPro15` varchar(255) DEFAULT NULL COMMENT '其他条件预留字段',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `promotionGroup_id` (`promotionGroup_id`),
  CONSTRAINT `th_promotion_ibfk_1` FOREIGN KEY (`promotionGroup_id`) REFERENCES `th_promotion_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='促销活动';

-- ----------------------------
-- Records of th_promotion
-- ----------------------------
INSERT INTO `th_promotion` VALUES ('20180306161757464492995281869701', '20180306161757458281207742574281', '8', null, '1', '2', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-06 16:17:57', '2018-03-06 16:17:57', '20161222113810681189580305593289', '2018-03-06 17:29:19', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180307153827872831349520821223', '20180307153827871178259409132817', '9', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-07 15:38:27', '2018-03-07 15:38:27', '20161222113810681189580305593289', '2018-03-07 17:24:41', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180307175351538472990994987334', '20180307175351537612456580322397', '8', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-07 17:53:51', '2018-03-07 17:53:51', '20161222113810681189580305593289', '2018-03-09 18:06:23', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180307175854231519475641261584', '20180307175854231092227418613026', '1', null, '2', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-07 17:58:54', '2018-03-07 17:58:54', '20161222113810681189580305593289', '2018-03-09 11:40:40', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180307175854232390354388929897', '20180307175854231092227418613026', '2', null, '3', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-07 17:58:54', '2018-03-07 17:58:54', '20161222113810681189580305593289', '2018-03-09 11:40:40', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180307175854233415283889891877', '20180307175854231092227418613026', '3', null, '4', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-07 17:58:54', '2018-03-07 17:58:54', '20161222113810681189580305593289', '2018-03-09 11:40:40', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180307175854235250782081629313', '20180307175854231092227418613026', '9', null, '5', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-07 17:58:54', '2018-03-07 17:58:54', '20161222113810681189580305593289', '2018-03-09 11:40:40', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180307175854235976503411853833', '20180307175854231092227418613026', '7', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-07 17:58:54', '2018-03-07 17:58:54', '20161222113810681189580305593289', '2018-03-09 11:40:40', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180307181924032299094196239231', '20180307181924031776353993223533', '7', null, '1', '2', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-07 18:19:24', '2018-03-07 18:19:24', '20161222113810681189580305593289', '2018-03-09 16:24:20', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180307182033455356747446034185', '20180307182033455577113371237682', '9', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-07 18:20:33', '2018-03-07 18:20:33', '20161222113810681189580305593289', '2018-03-10 09:48:43', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180309164513536241249523263063', '20180307175351537612456580322397', '2', null, '2', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-09 16:45:13', '2018-03-09 16:45:13', '20161222113810681189580305593289', '2018-03-09 18:06:23', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180310091636733545068629570506', '20180310091636721457428174798127', '1', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-10 09:16:36', '2018-03-10 09:16:36', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion` VALUES ('20180310092521729706254618730884', '20180310092458555599658068125446', '1', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-10 09:25:21', '2018-03-10 09:25:21', '20161222113810681189580305593289', '2018-03-10 09:25:30', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180310092838646961861073882841', '20180307181924031776353993223533', '9', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-10 09:28:38', '2018-03-10 09:28:38', '20161222113810681189580305593289', '2018-03-10 11:49:20', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180310160449469897958416174168', '20180310160449469617242743167977', '8', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-10 16:04:49', '2018-03-10 16:04:49', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion` VALUES ('20180312141148927243773272750999', '20180312141148921396164736513964', '1', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:11:48', '2018-03-12 14:11:48', '20161222113810681189580305593289', '2018-03-14 14:21:58', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141148933198623641907227', '20180312141148921396164736513964', '2', null, '2', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:11:48', '2018-03-12 14:11:48', '20161222113810681189580305593289', '2018-03-14 14:21:58', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141148934270382145136870', '20180312141148921396164736513964', '3', null, '3', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:11:48', '2018-03-12 14:11:48', '20161222113810681189580305593289', '2018-03-14 14:21:58', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141148935684913757606631', '20180312141148921396164736513964', '8', null, '5', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:11:48', '2018-03-12 14:11:48', '20161222113810681189580305593289', '2018-03-14 14:21:58', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141148935891910991595588', '20180312141148921396164736513964', '4', null, '4', '1', '0.4', null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:11:48', '2018-03-12 14:11:48', '20161222113810681189580305593289', '2018-03-14 14:21:58', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141148936997487339502719', '20180312141148921396164736513964', '11', null, '6', '1', '0.5', null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:11:48', '2018-03-12 14:11:48', '20161222113810681189580305593289', '2018-03-14 14:21:58', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141459780437620882421785', '20180312141459780854814376656849', '1', null, '1', '2', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:14:59', '2018-03-12 14:14:59', '20161222113810681189580305593289', '2018-03-13 18:35:21', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141459781596851945039375', '20180312141459780854814376656849', '2', null, '2', '2', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:14:59', '2018-03-12 14:14:59', '20161222113810681189580305593289', '2018-03-13 18:35:21', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141459782015937708272643', '20180312141459780854814376656849', '3', null, '3', '2', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:14:59', '2018-03-12 14:14:59', '20161222113810681189580305593289', '2018-03-13 18:35:21', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141459783235499019030258', '20180312141459780854814376656849', '6', null, '5', '2', '80', '50', '10', null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:14:59', '2018-03-12 14:14:59', '20161222113810681189580305593289', '2018-03-13 18:35:21', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141459783472528275680660', '20180312141459780854814376656849', '5', null, '4', '2', '50', '10', null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:14:59', '2018-03-12 14:14:59', '20161222113810681189580305593289', '2018-03-13 18:35:21', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141459784315968157990360', '20180312141459780854814376656849', '7', null, '6', '2', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:14:59', '2018-03-12 14:14:59', '20161222113810681189580305593289', '2018-03-13 18:35:21', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141459785101733370644336', '20180312141459780854814376656849', '9', null, '7', '2', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:14:59', '2018-03-12 14:14:59', '20161222113810681189580305593289', '2018-03-13 18:35:21', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141459786452240818886636', '20180312141459780854814376656849', '10', null, '8', '1', '50', null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:14:59', '2018-03-12 14:14:59', '20161222113810681189580305593289', '2018-03-14 14:23:22', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141802973265481164496867', '20180312141802972424809785201081', '1', null, '4', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:18:02', '2018-03-12 14:18:02', '20161222113810681189580305593289', '2018-03-14 15:27:29', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141802973777207879417360', '20180312141802972424809785201081', '2', null, '2', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:18:02', '2018-03-12 14:18:02', '20161222113810681189580305593289', '2018-03-14 15:27:29', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141802977144989977540029', '20180312141802972424809785201081', '3', null, '3', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:18:02', '2018-03-12 14:18:02', '20161222113810681189580305593289', '2018-03-14 15:27:29', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141802978106157123767940', '20180312141802972424809785201081', '5', null, '1', '1', '88', '77', null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:18:02', '2018-03-12 14:18:02', '20161222113810681189580305593289', '2018-03-14 15:27:29', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141802978189294754110134', '20180312141802972424809785201081', '6', null, '5', '1', '99', '88', '77', null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:18:02', '2018-03-12 14:18:02', '20161222113810681189580305593289', '2018-03-14 15:27:29', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141802979149625694247309', '20180312141802972424809785201081', '7', null, '6', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:18:02', '2018-03-12 14:18:02', '20161222113810681189580305593289', '2018-03-14 15:27:29', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141802979716258792498578', '20180312141802972424809785201081', '9', null, '7', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:18:02', '2018-03-12 14:18:02', '20161222113810681189580305593289', '2018-03-14 15:27:29', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141802980927052365493908', '20180312141802972424809785201081', '10', null, '8', '1', '10', null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:18:02', '2018-03-12 14:18:02', '20161222113810681189580305593289', '2018-03-14 15:27:29', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180312141916283816504532178488', '20180312141916282984198456194455', '9', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-12 14:19:16', '2018-03-12 14:19:16', '20161222113810681189580305593289', '2018-03-14 14:26:38', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180314142250376347321932665466', '20180314142250375758002327276537', '5', null, '1', '2', '50', '10', null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-14 14:22:50', '2018-03-14 14:22:50', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion` VALUES ('20180314142403031848831610358590', '20180314142403030557536998440876', '6', null, '1', '1', '50', '10', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-14 14:24:03', '2018-03-14 14:24:03', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion` VALUES ('20180320144241964082296790079932', '20180314142250375758002327276537', '9', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-20 14:42:41', '2018-03-20 14:42:41', '20161222113810681189580305593289', '2018-03-20 14:43:30', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180320144320046463567979124163', '20180320144320045283916601869968', '9', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-20 14:43:20', '2018-03-20 14:43:20', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion` VALUES ('20180320144811409254434265379056', '20180320144811408181060456062904', '8', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-20 14:48:11', '2018-03-20 14:48:11', '20161222113810681189580305593289', '2018-03-20 14:51:24', '20161222113810681189580305593289');
INSERT INTO `th_promotion` VALUES ('20180403103852133986952892163264', '20180403103852127158674495053827', '2', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-04-03 10:38:52', '2018-04-03 10:38:52', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion` VALUES ('20180510174652926019404865524471', '20180510174652905622826305899898', '9', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-05-10 17:46:52', '2018-05-10 17:46:52', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion` VALUES ('20180510174733731933026938189295', '20180510174733730101693122784348', '9', null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-05-10 17:47:33', '2018-05-10 17:47:33', '20161222113810681189580305593289', null, null);

-- ----------------------------
-- Table structure for th_promotion_group
-- ----------------------------
DROP TABLE IF EXISTS `th_promotion_group`;
CREATE TABLE `th_promotion_group` (
  `id` varchar(32) NOT NULL,
  `proStartDate` timestamp NULL DEFAULT NULL COMMENT '活动开始时间',
  `proEndDate` timestamp NULL DEFAULT NULL COMMENT '活动结束时间',
  `scope` varchar(5) DEFAULT NULL COMMENT '针对范围：（1：产品，2：门店，3：天河全场，4：全场叠加类）',
  `isOline` varchar(5) DEFAULT NULL COMMENT '是否线上（1：线上，2：线下，3：全部）',
  `payType` varchar(5) DEFAULT NULL COMMENT '支付方式（6：不限制，1：现金，2：刷卡，3：微信，4：支付宝，5：天和会员余额）',
  `isDelete` varchar(5) DEFAULT NULL COMMENT '是否删除（1：否，2：是）',
  `ownerId` text COMMENT '产品Id或者门店ID，针对天河的本字段为空',
  `remark` text COMMENT '备注',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动组';

-- ----------------------------
-- Records of th_promotion_group
-- ----------------------------
INSERT INTO `th_promotion_group` VALUES ('20180306161757458281207742574281', '2018-03-06 16:16:00', '2018-03-10 23:59:00', '1', '3', '1', '2', ',20171020143937478702840762092955', '', '2018-03-06 16:17:57', '2018-03-06 16:17:57', '20161222113810681189580305593289', '2018-03-07 14:33:21', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180307153827871178259409132817', '2018-03-07 15:37:00', '2018-03-07 23:59:00', '2', '3', '6', '2', '20170922155301527135602974909688', '', '2018-03-07 15:38:27', '2018-03-07 15:38:27', '20161222113810681189580305593289', '2018-03-07 17:51:52', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180307175351537612456580322397', '2018-03-07 17:51:00', '2018-03-10 23:59:00', '1', '3', '6', '2', ',20171020143937478702840762092955,20171024172852789370734026677867', '', '2018-03-07 17:53:51', '2018-03-07 17:53:51', '20161222113810681189580305593289', '2018-03-10 09:24:34', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180307175854231092227418613026', '2018-03-07 17:57:00', '2018-03-10 23:59:00', '2', '3', '6', '2', '20180122101904528474410614949352', '', '2018-03-07 17:58:54', '2018-03-07 17:58:54', '20161222113810681189580305593289', '2018-03-10 09:15:16', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180307181924031776353993223533', '2018-03-07 18:18:00', '2018-03-10 23:59:00', '3', '3', '6', '2', null, '', '2018-03-07 18:19:24', '2018-03-07 18:19:24', '20161222113810681189580305593289', '2018-03-10 17:55:51', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180307182033455577113371237682', '2018-03-07 18:20:00', '2018-03-11 00:00:00', '4', '3', '6', '2', null, '', '2018-03-07 18:20:33', '2018-03-07 18:20:33', '20161222113810681189580305593289', '2018-03-10 11:49:25', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180310091636721457428174798127', '2018-03-10 09:15:00', '2018-03-10 09:30:00', '2', '3', '6', '2', '20180122101904528474410614949352', '', '2018-03-10 09:16:36', '2018-03-10 09:16:36', '20161222113810681189580305593289', '2018-03-10 09:24:30', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180310092458555599658068125446', '2018-03-10 09:24:00', '2018-03-10 09:37:00', '2', '3', '6', '2', '20180122101904528474410614949352', '', '2018-03-10 09:24:58', '2018-03-10 09:24:58', '20161222113810681189580305593289', '2018-03-10 09:26:21', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180310160449469617242743167977', '2018-03-10 16:02:00', '2018-03-10 17:00:00', '1', '3', '6', '2', '20171020143937478702840762092955', '', '2018-03-10 16:04:49', '2018-03-10 16:04:49', '20161222113810681189580305593289', '2018-03-10 17:55:53', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180312141148921396164736513964', '2018-03-12 14:09:00', '2018-03-17 23:59:00', '1', '1', '6', '2', ',20171020143937478702840762092955,20180309105036173757940356406536,20170922165937277224378358837932', '', '2018-03-12 14:11:48', '2018-03-12 14:11:48', '20161222113810681189580305593289', '2018-03-17 14:42:08', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180312141459780854814376656849', '2018-03-12 14:11:00', '2018-03-17 23:59:00', '2', '1', '6', '2', '20180122101904528474410614949352', '', '2018-03-12 14:14:59', '2018-03-12 14:14:59', '20161222113810681189580305593289', '2018-03-17 14:42:10', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180312141802972424809785201081', '2018-03-12 14:15:00', '2018-03-17 23:59:00', '3', '1', '6', '2', null, '', '2018-03-12 14:18:02', '2018-03-12 14:18:02', '20161222113810681189580305593289', '2018-03-17 14:42:13', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180312141916282984198456194455', '2018-03-12 14:18:00', '2018-03-17 23:59:00', '4', '1', '1', '2', null, '', '2018-03-12 14:19:16', '2018-03-12 14:19:16', '20161222113810681189580305593289', '2018-03-17 14:42:16', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180314142250375758002327276537', '2018-03-20 14:42:00', '2018-03-24 23:59:00', '2', '3', '6', '1', '20180122101904528474410614949352', '', '2018-03-14 14:22:50', '2018-03-14 14:22:50', '20161222113810681189580305593289', '2018-03-20 14:43:30', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180314142403030557536998440876', '2018-03-14 14:23:00', '2018-03-17 23:59:00', '2', '1', '6', '2', '20170922155758751662910860438310', '', '2018-03-14 14:24:03', '2018-03-14 14:24:03', '20161222113810681189580305593289', '2018-03-20 14:42:54', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180320144320045283916601869968', '2018-03-20 14:43:00', '2018-03-24 23:59:00', '4', '3', '6', '1', null, '', '2018-03-20 14:43:20', '2018-03-20 14:43:20', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_group` VALUES ('20180320144811408181060456062904', '2018-03-20 14:47:00', '2018-03-24 23:59:00', '1', '3', '6', '1', ',20171020143937478702840762092955', '', '2018-03-20 14:48:11', '2018-03-20 14:48:11', '20161222113810681189580305593289', '2018-03-20 14:51:24', '20161222113810681189580305593289');
INSERT INTO `th_promotion_group` VALUES ('20180403103852127158674495053827', '2018-04-03 10:38:00', '2018-04-04 10:37:00', '1', '3', '6', '1', '20180305101632539543262286132950,20180310172311004667310961479080', '', '2018-04-03 10:38:52', '2018-04-03 10:38:52', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_group` VALUES ('20180510174652905622826305899898', '2018-05-10 17:45:00', '2018-05-12 17:00:00', '2', '3', '6', '1', '20171020141842757704681968303771', '', '2018-05-10 17:46:52', '2018-05-10 17:46:52', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_group` VALUES ('20180510174733730101693122784348', '2018-05-10 17:47:00', '2018-05-12 17:00:00', '4', '3', '6', '1', null, '', '2018-05-10 17:47:33', '2018-05-10 17:47:33', '20161222113810681189580305593289', null, null);

-- ----------------------------
-- Table structure for th_promotion_ladder
-- ----------------------------
DROP TABLE IF EXISTS `th_promotion_ladder`;
CREATE TABLE `th_promotion_ladder` (
  `id` varchar(32) NOT NULL,
  `promotion_id` varchar(32) DEFAULT NULL,
  `ladderStart` varchar(50) DEFAULT NULL COMMENT '阶梯起点金额或件数',
  `promotionMoney` varchar(50) DEFAULT NULL COMMENT '减免金额或折扣比例',
  `goods_id` varchar(32) DEFAULT NULL COMMENT '赠送(换够)产品ID',
  `goodsNumber` varchar(50) DEFAULT NULL COMMENT '赠送产品数量',
  `goodsNumberBuy` varchar(50) DEFAULT NULL COMMENT '购买产品数量',
  `goodsPrice` varchar(50) DEFAULT NULL COMMENT '产品换够价',
  `isDelete` varchar(5) DEFAULT NULL COMMENT '是否删除（1：否，2：是）',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `promotion_id` (`promotion_id`),
  CONSTRAINT `th_promotion_ladder_ibfk_1` FOREIGN KEY (`promotion_id`) REFERENCES `th_promotion` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='促销活动阶梯';

-- ----------------------------
-- Records of th_promotion_ladder
-- ----------------------------
INSERT INTO `th_promotion_ladder` VALUES ('20180306161757471332490216820600', '20180306161757464492995281869701', null, null, '20180122115306634026996232910217', '1', '1', null, '1', null, '2018-03-06 16:17:57', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180307153827873928760234419441', '20180307153827872831349520821223', '0.1', null, '20180122115306634026996232910217', null, null, '1', '1', null, '2018-03-07 15:38:27', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180307175351538373464873965978', '20180307175351538472990994987334', null, null, '20171020143937478702840762092955', '1', '1', null, '1', null, '2018-03-07 17:53:51', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180307175854232068419517464479', '20180307175854231519475641261584', '0.01', '10', null, null, null, null, '1', null, '2018-03-07 17:58:54', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180307175854233250062058696342', '20180307175854232390354388929897', '0.01', '20', null, null, null, null, '1', null, '2018-03-07 17:58:54', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180307175854234878726445732808', '20180307175854233415283889891877', '0.01', '30', null, null, null, null, '1', null, '2018-03-07 17:58:54', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180307175854235867739614723467', '20180307175854235976503411853833', '0.01', null, '20170922170523551944134261972825', '1', null, null, '1', null, '2018-03-07 17:58:54', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180307175854236916479746549799', '20180307175854235250782081629313', '0.01', null, '20180122115306634026996232910217', null, null, '1', '1', null, '2018-03-07 17:58:54', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180307181924033350021940015712', '20180307181924032299094196239231', '1', null, '20180122115306634026996232910217', '1', null, null, '1', null, '2018-03-07 18:19:24', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180307182033456243269293447302', '20180307182033455356747446034185', '0.1', null, '20170922170523551944134261972825', null, null, '0.1', '1', null, '2018-03-07 18:20:33', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180309164513536123587824222885', '20180309164513536241249523263063', '0.1', '0.25', null, null, null, null, '1', null, '2018-03-09 16:45:13', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180310091636741801063499370123', '20180310091636733545068629570506', '100', '10', null, null, null, null, '1', null, '2018-03-10 09:16:36', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180310092521730327190966439651', '20180310092521729706254618730884', '1', '1', null, null, null, null, '1', null, '2018-03-10 09:25:21', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180310092838646015530677967598', '20180310092838646961861073882841', '0.1', null, '20180309105036173757940356406536', null, null, '1', '1', null, '2018-03-10 09:28:38', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180310160449470042463688465262', '20180310160449469897958416174168', null, null, '20180305101632539543262286132950', '2', '2', null, '1', null, '2018-03-10 16:04:49', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180310160449470968917454877977', '20180310160449469897958416174168', null, null, '20180309105036173757940356406536', '1', '1', null, '1', null, '2018-03-10 16:04:49', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180310160449482849740038009712', '20180310160449469897958416174168', null, null, '20180208140943733620443495230063', '3', '3', null, '1', null, '2018-03-10 16:04:49', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180310160449483269204848429030', '20180310160449469897958416174168', null, null, '20180122115306634026996232910217', '4', '4', null, '1', null, '2018-03-10 16:04:49', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180310160449484785880617139217', '20180310160449469897958416174168', null, null, '20180122111918337388157036901911', '5', '5', null, '1', null, '2018-03-10 16:04:49', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180310160449484833621093441410', '20180310160449469897958416174168', null, null, '20180122111712018249944953366986', '6', '6', null, '1', null, '2018-03-10 16:04:49', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180310160449485104038446793672', '20180310160449469897958416174168', null, null, '20180122111233478527530066356970', '8', '8', null, '1', null, '2018-03-10 16:04:49', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180310160449485335809449107367', '20180310160449469897958416174168', null, null, '20180122111459870686175221589973', '7', '7', null, '1', null, '2018-03-10 16:04:49', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180310160449486041281741456332', '20180310160449469897958416174168', null, null, '20171027113724031641949791734239', '10', '10', null, '1', null, '2018-03-10 16:04:49', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180310160449486085922252299372', '20180310160449469897958416174168', null, null, '20180122102526497373284138435453', '9', '9', null, '1', null, '2018-03-10 16:04:49', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141148932822459711585642', '20180312141148927243773272750999', '0.1', '10', null, null, null, null, '1', null, '2018-03-12 14:11:48', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141148933829011111454208', '20180312141148933198623641907227', '0.1', '0.2', null, null, null, null, '1', null, '2018-03-12 14:11:48', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141148934371940202793377', '20180312141148934270382145136870', '0.1', '0.3', null, null, null, null, '1', null, '2018-03-12 14:11:48', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141148936948504912347698', '20180312141148935684913757606631', null, null, '20180122115306634026996232910217', '1', '1', null, '1', null, '2018-03-12 14:11:48', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141459781660468509970689', '20180312141459780437620882421785', '1', '10', null, null, null, null, '1', null, '2018-03-12 14:14:59', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141459782345829640766524', '20180312141459781596851945039375', '0.2', '2', null, null, null, null, '1', null, '2018-03-12 14:14:59', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141459782769300791284924', '20180312141459782015937708272643', '0.3', '3', null, null, null, null, '1', null, '2018-03-12 14:14:59', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141459784662656711829486', '20180312141459784315968157990360', '0.1', null, '20170926103923003853017209983477', '1', null, null, '1', null, '2018-03-12 14:14:59', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141459785968253082731257', '20180312141459785101733370644336', '0.1', null, '20170922170523551944134261972825', null, null, '0.1', '1', null, '2018-03-12 14:14:59', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141802973514695762563091', '20180312141802973265481164496867', '1', '10', null, null, null, null, '1', null, '2018-03-12 14:18:02', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141802977208439918588894', '20180312141802973777207879417360', '10', '1', null, null, null, null, '1', null, '2018-03-12 14:18:02', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141802977991906896264132', '20180312141802977144989977540029', '10', '10', null, null, null, null, '1', null, '2018-03-12 14:18:02', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141802979662070586971943', '20180312141802979149625694247309', '0.1', null, '20171016094309465163388680954678', '1', null, null, '1', null, '2018-03-12 14:18:02', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141802980398891986475864', '20180312141802979716258792498578', '0.1', null, '20171014165251008459951743489247', null, null, '1', '1', null, '2018-03-12 14:18:02', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141916283246863277287197', '20180312141916283816504532178488', '0.1', null, '20170922164348366833637124707254', null, null, '1', '1', null, '2018-03-12 14:19:16', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141916284999282900388048', '20180312141916283816504532178488', '0.2', null, '20170922164753384264999000703592', null, null, '2', '1', null, '2018-03-12 14:19:16', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141916286586810973852876', '20180312141916283816504532178488', '1', null, '20170922165751042747443964724774', null, null, '4', '1', null, '2018-03-12 14:19:16', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180312141916286758007287412610', '20180312141916283816504532178488', '0.3', null, '20170922165036441661166265911438', null, null, '3', '1', null, '2018-03-12 14:19:16', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180320144241971425536543803235', '20180320144241964082296790079932', '0.01', null, '20180310172311004667310961479080', null, null, '0.1', '1', null, '2018-03-20 14:42:41', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180320144320047432796555837770', '20180320144320046463567979124163', '0.02', null, '20180309105036173757940356406536', null, null, '0.2', '1', null, '2018-03-20 14:43:20', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180320144811409739790959193834', '20180320144811409254434265379056', null, null, '20180309105036173757940356406536', '1', '1', null, '1', null, '2018-03-20 14:48:11', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180403103852139660164372669095', '20180403103852133986952892163264', '0.1', '0.2', null, null, null, null, '1', null, '2018-04-03 10:38:52', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180510174652933969140835403856', '20180510174652926019404865524471', '100', null, '20171016094309465163388680954678', null, null, '1', '1', null, '2018-05-10 17:46:52', '20161222113810681189580305593289', null, null);
INSERT INTO `th_promotion_ladder` VALUES ('20180510174733732889949485443269', '20180510174733731933026938189295', '100', null, '20171016094309465163388680954678', null, null, '2', '1', null, '2018-05-10 17:47:33', '20161222113810681189580305593289', null, null);

-- ----------------------------
-- Table structure for th_qrcode
-- ----------------------------
DROP TABLE IF EXISTS `th_qrcode`;
CREATE TABLE `th_qrcode` (
  `id` varchar(32) NOT NULL,
  `goods_id` varchar(32) DEFAULT NULL COMMENT '产品Id',
  `qrcodeBatch` varchar(50) DEFAULT NULL COMMENT '批次号',
  `procurementPrice` varchar(50) DEFAULT NULL COMMENT '产品进货价(和采购单里进货价相同)',
  `state` varchar(5) DEFAULT NULL COMMENT '状态(1：正常，2：卖出，3：退还厂家  ps：  只有正常的才可补印)',
  `logistics` text COMMENT '流向(产品的每一次位置的改变都追加进来。eg：供货商-->门店1-->顾客1-->门店1-->大库-->门店1-->顾客2-->门店1-->供货商)',
  `procurement_id` varchar(32) DEFAULT NULL COMMENT '采购单',
  `storage_id` varchar(32) DEFAULT NULL COMMENT '所在库房',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  `procurementBuyCount` varchar(50) DEFAULT NULL COMMENT '产品进货数量',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_13` (`procurement_id`),
  KEY `FK_Reference_14` (`goods_id`),
  KEY `storage_id` (`storage_id`),
  CONSTRAINT `FK_Reference_13` FOREIGN KEY (`procurement_id`) REFERENCES `th_procurement` (`id`),
  CONSTRAINT `FK_Reference_14` FOREIGN KEY (`goods_id`) REFERENCES `th_goods` (`id`),
  CONSTRAINT `th_qrcode_ibfk_1` FOREIGN KEY (`storage_id`) REFERENCES `th_storage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品二维码';

-- ----------------------------
-- Records of th_qrcode
-- ----------------------------
INSERT INTO `th_qrcode` VALUES ('20180510145519451918373328682774', '20180309105036174528202992898075', '2018051014550000', '29.88', '2', '运动仓-卖出-运动仓-卖出', '20180510145458190688892519304554', '20180314141637307619473967715931', '2018-05-10 14:55:19', '2018-05-10 14:55:19', '20161222113810681189580305593289', null, null, '12');
INSERT INTO `th_qrcode` VALUES ('20180510145519658502869713840799', '20180309105036174528202992898075', '2018051014550000', '29.88', '2', '运动仓-卖出-卖出', '20180510145458190688892519304554', '20180314141637307619473967715931', '2018-05-10 14:55:19', '2018-05-10 14:55:19', '20161222113810681189580305593289', null, null, '12');
INSERT INTO `th_qrcode` VALUES ('20180510145519685979593622057967', '20180309105036174528202992898075', '2018051014550000', '29.88', '1', '运动仓', '20180510145458190688892519304554', '20180314141637307619473967715931', '2018-05-10 14:55:19', '2018-05-10 14:55:19', '20161222113810681189580305593289', null, null, '12');
INSERT INTO `th_qrcode` VALUES ('20180510145519700796163456486439', '20180309105036174528202992898075', '2018051014550000', '29.88', '1', '运动仓', '20180510145458190688892519304554', '20180314141637307619473967715931', '2018-05-10 14:55:19', '2018-05-10 14:55:19', '20161222113810681189580305593289', null, null, '12');
INSERT INTO `th_qrcode` VALUES ('20180510145519714427006509212116', '20180309105036174528202992898075', '2018051014550000', '29.88', '1', '运动仓', '20180510145458190688892519304554', '20180314141637307619473967715931', '2018-05-10 14:55:19', '2018-05-10 14:55:19', '20161222113810681189580305593289', null, null, '12');
INSERT INTO `th_qrcode` VALUES ('20180510145519727930445115790855', '20180309105036174528202992898075', '2018051014550000', '29.88', '1', '运动仓', '20180510145458190688892519304554', '20180314141637307619473967715931', '2018-05-10 14:55:19', '2018-05-10 14:55:19', '20161222113810681189580305593289', null, null, '12');
INSERT INTO `th_qrcode` VALUES ('20180510145519741795331312603692', '20180309105036174528202992898075', '2018051014550000', '29.88', '1', '运动仓', '20180510145458190688892519304554', '20180314141637307619473967715931', '2018-05-10 14:55:19', '2018-05-10 14:55:19', '20161222113810681189580305593289', null, null, '12');
INSERT INTO `th_qrcode` VALUES ('20180510145519753212000160807614', '20180309105036174528202992898075', '2018051014550000', '29.88', '1', '运动仓', '20180510145458190688892519304554', '20180314141637307619473967715931', '2018-05-10 14:55:19', '2018-05-10 14:55:19', '20161222113810681189580305593289', null, null, '12');
INSERT INTO `th_qrcode` VALUES ('20180510145519766254806878032307', '20180309105036174528202992898075', '2018051014550000', '29.88', '1', '运动仓', '20180510145458190688892519304554', '20180314141637307619473967715931', '2018-05-10 14:55:19', '2018-05-10 14:55:19', '20161222113810681189580305593289', null, null, '12');
INSERT INTO `th_qrcode` VALUES ('20180510145519779263499063651650', '20180309105036174528202992898075', '2018051014550000', '29.88', '1', '运动仓', '20180510145458190688892519304554', '20180314141637307619473967715931', '2018-05-10 14:55:19', '2018-05-10 14:55:19', '20161222113810681189580305593289', null, null, '12');
INSERT INTO `th_qrcode` VALUES ('20180510145519791426933304619779', '20180309105036174528202992898075', '2018051014550000', '29.88', '1', '运动仓', '20180510145458190688892519304554', '20180314141637307619473967715931', '2018-05-10 14:55:19', '2018-05-10 14:55:19', '20161222113810681189580305593289', null, null, '12');
INSERT INTO `th_qrcode` VALUES ('20180510145519802591696211640498', '20180309105036174528202992898075', '2018051014550000', '29.88', '1', '运动仓', '20180510145458190688892519304554', '20180314141637307619473967715931', '2018-05-10 14:55:19', '2018-05-10 14:55:19', '20161222113810681189580305593289', null, null, '12');
INSERT INTO `th_qrcode` VALUES ('20180510150029485810626574554506', '20180305101632540354835519511063', '2018051015000000', '30000.00', '1', '运动仓', '20180510150007147823372969811337', '20180314141637307619473967715931', '2018-05-10 15:00:29', '2018-05-10 15:00:29', '20161222113810681189580305593289', null, null, '2');
INSERT INTO `th_qrcode` VALUES ('20180510150029497839941093152691', '20180305101632540354835519511063', '2018051015000000', '30000.00', '1', '运动仓', '20180510150007147823372969811337', '20180314141637307619473967715931', '2018-05-10 15:00:29', '2018-05-10 15:00:29', '20161222113810681189580305593289', null, null, '2');

-- ----------------------------
-- Table structure for th_recharge_record
-- ----------------------------
DROP TABLE IF EXISTS `th_recharge_record`;
CREATE TABLE `th_recharge_record` (
  `id` varchar(32) NOT NULL,
  `guideUser_id` varchar(32) DEFAULT NULL COMMENT '导购（ps：auth_user表里的）',
  `customer_id` varchar(50) DEFAULT NULL COMMENT '客户',
  `state` varchar(255) DEFAULT NULL COMMENT '充值状态(1完成,2未支付)',
  `money` varchar(50) DEFAULT NULL COMMENT '充值金额',
  `backCash` varchar(50) DEFAULT NULL COMMENT '返现金额',
  `payType` varchar(255) DEFAULT NULL COMMENT '支付方式（1：现金支付，2：银行pos刷卡支付，3：微信支付，4：支付宝支付，）',
  `payCode` varchar(50) DEFAULT NULL COMMENT '支付单号(微信/支付宝)',
  `payTime` timestamp NULL DEFAULT NULL COMMENT '支付时间',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  `cashierUser_id` varchar(32) DEFAULT NULL COMMENT '收银员',
  `cashierCode` varchar(50) DEFAULT NULL COMMENT '款台号',
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `th_recharge_record_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `th_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值记录';

-- ----------------------------
-- Records of th_recharge_record
-- ----------------------------
INSERT INTO `th_recharge_record` VALUES ('20180307095622520461266912954554', '20171020155533327011935951200187', '20180307095521484289980574167709', '2', '100', '0', '3', null, null, '2018-03-07 09:56:22', '2018-03-07 09:56:22', null, null, null, null, null);
INSERT INTO `th_recharge_record` VALUES ('20180307100101568423356540430391', null, '20180307095521484289980574167709', '1', '1000', '0', '1', null, '2018-03-07 10:01:01', '2018-03-07 10:01:01', '2018-03-07 10:01:01', null, null, null, '20170922195030757264333921841291', '001');
INSERT INTO `th_recharge_record` VALUES ('20180307180914879761568304251206', null, '20180307095521484289980574167709', '1', '100', '100.0', '1', null, '2018-03-07 18:09:14', '2018-03-07 18:09:14', '2018-03-07 18:09:14', null, null, null, '20170922195030757264333921841291', '001');
INSERT INTO `th_recharge_record` VALUES ('20180308142347739171989176635738', null, '20171020161046492169283021443205', '1', '0.1', '0', '2', null, '2018-03-08 14:23:47', '2018-03-08 14:23:47', '2018-03-08 14:23:47', null, null, null, '20170922195030757264333921841291', '001');
INSERT INTO `th_recharge_record` VALUES ('20180308142412236585607990499166', null, '20171020161046492169283021443205', '1', '0.9', '0', '1', null, '2018-03-08 14:24:12', '2018-03-08 14:24:12', '2018-03-08 14:24:12', null, null, null, '20170922195030757264333921841291', '001');
INSERT INTO `th_recharge_record` VALUES ('20180308142618394399126688966915', null, '20171020161046492169283021443205', '1', '0.1', '0', '3', '4200000052201803084828708170', '2018-03-08 14:26:30', '2018-03-08 14:26:18', '2018-03-08 14:26:18', null, null, null, '20170922195030757264333921841291', '001');
INSERT INTO `th_recharge_record` VALUES ('20180308143433949003038272253372', null, '20171020161046492169283021443205', '1', '0.1', '0', '4', '2018030821001004380206450060', '2018-03-08 14:34:35', '2018-03-08 14:34:33', '2018-03-08 14:34:33', null, null, null, '20170922195030757264333921841291', '001');
INSERT INTO `th_recharge_record` VALUES ('20180308144432059656873120154164', '20180308094048129590536181219317', '20171020161046492169283021443205', '2', '0.1', '0', '3', null, null, '2018-03-08 14:44:32', '2018-03-08 14:44:32', null, null, null, null, null);

-- ----------------------------
-- Table structure for th_record
-- ----------------------------
DROP TABLE IF EXISTS `th_record`;
CREATE TABLE `th_record` (
  `id` varchar(32) NOT NULL,
  `qrcode_id` varchar(32) DEFAULT NULL COMMENT '二维码ID',
  `storage_id` varchar(32) DEFAULT NULL COMMENT '库房ID',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_16` (`storage_id`),
  KEY `FK_Reference_17` (`qrcode_id`),
  CONSTRAINT `FK_Reference_16` FOREIGN KEY (`storage_id`) REFERENCES `th_storage` (`id`),
  CONSTRAINT `FK_Reference_17` FOREIGN KEY (`qrcode_id`) REFERENCES `th_qrcode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='入库记录';

-- ----------------------------
-- Records of th_record
-- ----------------------------

-- ----------------------------
-- Table structure for th_register_bonus
-- ----------------------------
DROP TABLE IF EXISTS `th_register_bonus`;
CREATE TABLE `th_register_bonus` (
  `id` varchar(32) NOT NULL,
  `startMoney` varchar(50) DEFAULT NULL COMMENT '注册提成金',
  `remark` text COMMENT '备注',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of th_register_bonus
-- ----------------------------
INSERT INTO `th_register_bonus` VALUES ('20180314150727589806816881879797', '100', null, '2018-03-14 15:07:27', '2018-03-14 15:07:27', null, '20161222113810681189580305593289', null);

-- ----------------------------
-- Table structure for th_register_bonus_detil
-- ----------------------------
DROP TABLE IF EXISTS `th_register_bonus_detil`;
CREATE TABLE `th_register_bonus_detil` (
  `id` varchar(32) NOT NULL,
  `guideUser_id` varchar(32) DEFAULT NULL COMMENT '导购（ps：auth_user表里的）',
  `money` varchar(50) DEFAULT NULL COMMENT '提成金额',
  `month` varchar(50) DEFAULT NULL COMMENT '提成月份(201701)',
  `count` varchar(50) DEFAULT NULL COMMENT '推荐人数',
  `isPayMoney` varchar(5) DEFAULT NULL COMMENT '是否发放(1:是,2:否)',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='推荐注册提成记录';

-- ----------------------------
-- Records of th_register_bonus_detil
-- ----------------------------

-- ----------------------------
-- Table structure for th_shoppingcart
-- ----------------------------
DROP TABLE IF EXISTS `th_shoppingcart`;
CREATE TABLE `th_shoppingcart` (
  `id` char(32) NOT NULL,
  `goods_id` char(32) DEFAULT NULL,
  `customer_id` char(32) DEFAULT NULL,
  `count` varchar(20) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_16` (`customer_id`),
  KEY `FK_Reference_17` (`goods_id`),
  CONSTRAINT `th_shoppingcart_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `th_customer` (`id`),
  CONSTRAINT `th_shoppingcart_ibfk_2` FOREIGN KEY (`goods_id`) REFERENCES `th_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of th_shoppingcart
-- ----------------------------
INSERT INTO `th_shoppingcart` VALUES ('20180314182207761566376865330273', '20170922164440302889210003523496', '20180307095521484289980574167709', '1', '2018-03-14 18:22:07', '2018-03-14 18:22:07', null, null, null);
INSERT INTO `th_shoppingcart` VALUES ('20180314182211624462788756809772', '20170922164753385277306649785468', '20180307095521484289980574167709', '1', '2018-03-14 18:22:11', '2018-03-14 18:22:11', null, null, null);
INSERT INTO `th_shoppingcart` VALUES ('20180314182216017485498556946957', '20180310173943037961334434981896', '20180307095521484289980574167709', '1', '2018-03-14 18:22:16', '2018-03-14 18:22:16', null, null, null);
INSERT INTO `th_shoppingcart` VALUES ('20180314182224861948021931431556', '20171020143937479575128993734718', '20180307095521484289980574167709', '1', '2018-03-14 18:22:24', '2018-03-14 18:22:24', null, null, null);
INSERT INTO `th_shoppingcart` VALUES ('20180314182230280486107116113170', '20171020173028530949970098129978', '20180307095521484289980574167709', '1', '2018-03-14 18:22:30', '2018-03-14 18:22:30', null, null, null);
INSERT INTO `th_shoppingcart` VALUES ('20180314182235463929389598739678', '20171024152040729464623304267490', '20180307095521484289980574167709', '1', '2018-03-14 18:22:35', '2018-03-14 18:22:35', null, null, null);
INSERT INTO `th_shoppingcart` VALUES ('20180314182241394593043845244921', '20171024172548096443358805664103', '20180307095521484289980574167709', '1', '2018-03-14 18:22:41', '2018-03-14 18:22:41', null, null, null);
INSERT INTO `th_shoppingcart` VALUES ('20180314182247422075985219884438', '20171024172852789913173493246725', '20180307095521484289980574167709', '1', '2018-03-14 18:22:47', '2018-03-14 18:22:47', null, null, null);
INSERT INTO `th_shoppingcart` VALUES ('20180314182252818202218549623400', '20171024173129187201031419711933', '20180307095521484289980574167709', '1', '2018-03-14 18:22:52', '2018-03-14 18:22:52', null, null, null);
INSERT INTO `th_shoppingcart` VALUES ('20180314182256670982507447461628', '20171024173323083575956801401152', '20180307095521484289980574167709', '1', '2018-03-14 18:22:56', '2018-03-14 18:22:56', null, null, null);
INSERT INTO `th_shoppingcart` VALUES ('20180314182302604247476558701534', '20171024173746519381324249408155', '20180307095521484289980574167709', '1', '2018-03-14 18:23:02', '2018-03-14 18:23:02', null, null, null);
INSERT INTO `th_shoppingcart` VALUES ('20180314182305950617643681434394', '20171024174001062066068059043941', '20180307095521484289980574167709', '1', '2018-03-14 18:23:05', '2018-03-14 18:23:06', null, null, null);
INSERT INTO `th_shoppingcart` VALUES ('20180314182310466491133779976377', '20171024174201735722489382748556', '20180307095521484289980574167709', '1', '2018-03-14 18:23:10', '2018-03-14 18:23:10', null, null, null);
INSERT INTO `th_shoppingcart` VALUES ('20180314182314074874123052546190', '20171025103239037994571698040619', '20180307095521484289980574167709', '1', '2018-03-14 18:23:14', '2018-03-14 18:23:14', null, null, null);

-- ----------------------------
-- Table structure for th_smsverif
-- ----------------------------
DROP TABLE IF EXISTS `th_smsverif`;
CREATE TABLE `th_smsverif` (
  `id` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL COMMENT '电话号',
  `code` varchar(50) DEFAULT NULL COMMENT '短信验证码',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '生成时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短信验证码';

-- ----------------------------
-- Records of th_smsverif
-- ----------------------------

-- ----------------------------
-- Table structure for th_specification
-- ----------------------------
DROP TABLE IF EXISTS `th_specification`;
CREATE TABLE `th_specification` (
  `id` varchar(32) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '规格名称',
  `isDelete` varchar(5) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT NULL COMMENT '生成时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品单位';

-- ----------------------------
-- Records of th_specification
-- ----------------------------
INSERT INTO `th_specification` VALUES ('20170922160202422264030772480579', '件', '2', '2017-09-22 16:02:02', '2017-09-22 16:02:02', '2017-09-22 16:02:13', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `th_specification` VALUES ('20170922160206729295103754527856', '件', '1', '2017-09-22 16:02:06', '2017-09-22 16:02:06', '2017-09-22 16:02:29', '20161222113810681189580305593289', '20161222113810681189580305593289');
INSERT INTO `th_specification` VALUES ('20170922160219718260550566573824', '双', '1', '2017-09-22 16:02:19', '2017-09-22 16:02:19', null, '20161222113810681189580305593289', null);
INSERT INTO `th_specification` VALUES ('20180122115318931820660508991547', '张', '1', '2018-01-22 11:53:18', '2018-01-22 11:53:18', null, '20161222113810681189580305593289', null);
INSERT INTO `th_specification` VALUES ('20180122115325705057313957201125', '个', '1', '2018-01-22 11:53:25', '2018-01-22 11:53:25', null, '20161222113810681189580305593289', null);

-- ----------------------------
-- Table structure for th_storage
-- ----------------------------
DROP TABLE IF EXISTS `th_storage`;
CREATE TABLE `th_storage` (
  `id` varchar(32) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `chargeName` varchar(50) DEFAULT NULL COMMENT '负责人',
  `chargePhone` varchar(15) DEFAULT NULL COMMENT '负责人联系方式',
  `store_id` varchar(32) DEFAULT NULL COMMENT '所属门店',
  `state` varchar(5) DEFAULT NULL COMMENT '状态（1：启用，2：停用）',
  `acreage` varchar(50) DEFAULT NULL COMMENT '仓库面积',
  `remark` text COMMENT '备注',
  `isDelete` varchar(5) DEFAULT NULL COMMENT '是否删除（1：否，2：是）',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_15` (`store_id`),
  CONSTRAINT `FK_Reference_15` FOREIGN KEY (`store_id`) REFERENCES `th_store` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库房信息';

-- ----------------------------
-- Records of th_storage
-- ----------------------------
INSERT INTO `th_storage` VALUES ('20170922162304513699768746004570', '总仓库', '张三', '13635897412', null, '2', '120', '要', '1', '2017-09-22 16:23:04', '2017-09-22 16:23:04', '20161222113810681189580305593289', '2017-09-22 16:27:59', '20161222113810681189580305593289');
INSERT INTO `th_storage` VALUES ('20170922162328008365745515797496', '森迈特仓库', '张丽', '15987456987', null, '1', '120', '', '1', '2017-09-22 16:23:28', '2017-09-22 16:23:28', '20161222113810681189580305593289', '2018-03-06 11:44:47', '20161222113810681189580305593289');
INSERT INTO `th_storage` VALUES ('20170922162411079613911762625402', '女装仓库', '安娜', '15698745698', null, '1', '120', '', '2', '2017-09-22 16:24:11', '2017-09-22 16:24:11', '20161222113810681189580305593289', '2018-03-06 18:27:09', '20161222113810681189580305593289');
INSERT INTO `th_storage` VALUES ('20170922162504261951103813442716', '小商品仓库', '终于', '15987457896', '20170922155512650796375955980227', '1', '23', '', '1', '2017-09-22 16:25:04', '2017-09-22 16:25:04', '20161222113810681189580305593289', '2017-09-22 16:33:06', '20161222113810681189580305593289');
INSERT INTO `th_storage` VALUES ('20170925104322840307356083417806', '女鞋仓库', '达芙妮', '16603041142', '20180122101904528474410614949352', '2', '26.31', '', '1', '2017-09-25 10:43:22', '2017-09-25 10:43:22', '20161222113810681189580305593289', '2018-03-04 11:42:52', '20161222113810681189580305593289');
INSERT INTO `th_storage` VALUES ('20171020143623644909530581599768', '测试仓库', '艾伦SDASD', '13012340002', '20171020141842757704681968303771', '1', '500', '', '1', '2017-10-20 14:36:23', '2017-10-20 14:36:23', '20161222113810681189580305593289', null, null);
INSERT INTO `th_storage` VALUES ('20171026150907327996420526620307', 'ces', 'es', '13012345354', null, '2', 'ces', '', '2', '2017-10-26 15:09:07', '2017-10-26 15:09:07', '20161222113810681189580305593289', '2018-02-08 17:03:53', '20161222113810681189580305593289');
INSERT INTO `th_storage` VALUES ('20180314141637307619473967715931', '运动仓', '李宁', '19800000002', '20171020141842757704681968303771', '1', '80.55平米', '', '1', '2018-03-14 14:16:37', '2018-03-14 14:16:37', '20161222113810681189580305593289', null, null);

-- ----------------------------
-- Table structure for th_store
-- ----------------------------
DROP TABLE IF EXISTS `th_store`;
CREATE TABLE `th_store` (
  `id` varchar(32) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '门店名称',
  `storeCode` varchar(50) DEFAULT NULL COMMENT '门店编号',
  `chargeName` varchar(50) DEFAULT NULL COMMENT '负责人',
  `chargePhone` varchar(15) DEFAULT NULL COMMENT '负责人联系方式',
  `storePhone` varchar(15) DEFAULT NULL COMMENT '门店电话',
  `acreage` varchar(50) DEFAULT NULL COMMENT '门店面积',
  `address` varchar(200) DEFAULT NULL COMMENT '门店地址',
  `isDelete` varchar(5) DEFAULT NULL COMMENT '是否删除（1：否，2：是）',
  `state` varchar(5) DEFAULT NULL COMMENT '门店状态（1：正常，2：停业）',
  `type` varchar(5) DEFAULT NULL COMMENT '门店类型（1：直营店，2：商家店，3：小商品店）',
  `remark` text COMMENT '备注',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='门店';

-- ----------------------------
-- Records of th_store
-- ----------------------------
INSERT INTO `th_store` VALUES ('20170922154932923123004764987340', '似水年华', 'TH001', '张年华', '15661451698', null, '120平', '包头市固阳县天和商城大街20-23', '2', '1', '1', '该门店', '2017-09-22 15:49:32', '2017-09-22 15:49:32', '20161222113810681189580305593289', '2017-11-23 17:14:48', '20161222113810681189580305593289');
INSERT INTO `th_store` VALUES ('20170922155207290634168580342140', '帛卡袖', 'TH002', '张水星', '13698745698', null, '120平', '包头市固阳县可想而知大街23', '2', '1', '1', '该顶楼', '2017-09-22 15:52:07', '2017-09-22 15:52:07', '20161222113810681189580305593289', '2017-11-23 17:14:32', '20161222113810681189580305593289');
INSERT INTO `th_store` VALUES ('20170922155301527135602974909688', '商家店1', 'S001', '颖商', '15618974562', null, '120', 'QNUSDDDDDD', '1', '1', '2', 'SDS', '2017-09-22 15:53:01', '2017-09-22 15:53:01', '20161222113810681189580305593289', null, null);
INSERT INTO `th_store` VALUES ('20170922155404113485654128116220', '商家店2', 'S002', '张商家', '13159874569', null, '2323', '包头市格栅灯是滴是滴大哥大', '1', '1', '2', '是滴是滴', '2017-09-22 15:54:04', '2017-09-22 15:54:04', '20161222113810681189580305593289', null, null);
INSERT INTO `th_store` VALUES ('20170922155512650796375955980227', '小商品店', 'X001', '张商品', '15698745698', null, '158', '顶楼2压力顶楼2压力顶楼2压力顶楼2压力顶楼2压力顶楼2压力', '1', '1', '3', '椅', '2017-09-22 15:55:12', '2017-09-22 15:55:12', '20161222113810681189580305593289', null, null);
INSERT INTO `th_store` VALUES ('20170922155758751662910860438310', '女鞋店', 'TH003', '弦子', '13698745689', null, '1252', '包对市是滴是滴是滴是滴', '1', '1', '1', '顶323232323232', '2017-09-22 15:57:58', '2017-09-22 15:57:58', '20161222113810681189580305593289', '2017-11-23 17:14:36', '20161222113810681189580305593289');
INSERT INTO `th_store` VALUES ('20171020141842757704681968303771', '运动店', 'ceshi01', '艾伦SDASD', '13012340002', null, '500', '内蒙古包头市青山区包头工商联大厦1000', '1', '1', '1', '测试3', '2017-10-20 14:18:42', '2017-10-20 14:18:42', '20161222113810681189580305593289', '2018-03-14 14:13:20', '20161222113810681189580305593289');
INSERT INTO `th_store` VALUES ('20171027180602022941921000860756', '测试商家', '20171027', '测试商家', '13012341234', null, '水电费收到发', '实打实地方', '1', '1', '2', '', '2017-10-27 18:06:02', '2017-10-27 18:06:02', '20161222113810681189580305593289', null, null);
INSERT INTO `th_store` VALUES ('20171027180713910830717281520944', '测试鞋店2', '201710271806', '测试门店2', '18678945611', null, '测试门店2', '测试门店2', '2', '1', '1', '测试门店2', '2017-10-27 18:07:13', '2017-10-27 18:07:13', '20161222113810681189580305593289', '2018-01-22 10:17:35', '20161222113810681189580305593289');
INSERT INTO `th_store` VALUES ('20180122101904528474410614949352', '森迈特精品女装店', '20180122', '森迈特', '19900000002', null, '100平米', '包头市东河区环城路fkjlasdjflasj1000号', '1', '1', '1', '', '2018-01-22 10:19:04', '2018-01-22 10:19:04', '20161222113810681189580305593289', '2018-03-04 15:24:56', '20161222113810681189580305593289');

-- ----------------------------
-- Table structure for th_store_bonus
-- ----------------------------
DROP TABLE IF EXISTS `th_store_bonus`;
CREATE TABLE `th_store_bonus` (
  `id` varchar(32) NOT NULL,
  `startMoney` varchar(50) DEFAULT NULL COMMENT '商家店销售额',
  `proportion` varchar(20) DEFAULT NULL COMMENT '商家店服务费比例',
  `remark` text COMMENT '备注',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家店提成档位';

-- ----------------------------
-- Records of th_store_bonus
-- ----------------------------
INSERT INTO `th_store_bonus` VALUES ('20171104094624206490905522125901', '100', '0.1', null, '2017-11-04 09:46:24', '2017-11-04 09:46:24', '2018-03-07 15:18:56', '20161222113810681189580305593289', '20161222113810681189580305593289');

-- ----------------------------
-- Table structure for th_store_bonus_detail
-- ----------------------------
DROP TABLE IF EXISTS `th_store_bonus_detail`;
CREATE TABLE `th_store_bonus_detail` (
  `id` varchar(32) NOT NULL,
  `store_id` varchar(32) DEFAULT NULL COMMENT '商家店ID',
  `targetMoney` varchar(50) DEFAULT NULL COMMENT '销售额',
  `money` varchar(50) DEFAULT NULL COMMENT '服务费',
  `month` varchar(50) DEFAULT NULL COMMENT '月份',
  `isPayMoney` varchar(5) DEFAULT NULL COMMENT '是否付款(1:是,2:否)',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `th_store_bonus_detail_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `th_store` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家店服务费记录';

-- ----------------------------
-- Records of th_store_bonus_detail
-- ----------------------------

-- ----------------------------
-- Table structure for th_store_property
-- ----------------------------
DROP TABLE IF EXISTS `th_store_property`;
CREATE TABLE `th_store_property` (
  `id` varchar(32) NOT NULL,
  `name` varchar(100) DEFAULT NULL COMMENT '固定财产名称',
  `number` varchar(15) DEFAULT NULL COMMENT '数量',
  `store_id` varchar(32) DEFAULT NULL COMMENT '所属门店',
  `remark` text COMMENT '备注',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `fu` char(32) DEFAULT NULL,
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_3` (`store_id`),
  CONSTRAINT `FK_Reference_3` FOREIGN KEY (`store_id`) REFERENCES `th_store` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='门店固定资产';

-- ----------------------------
-- Records of th_store_property
-- ----------------------------
INSERT INTO `th_store_property` VALUES ('20170922154933232124605237972603', '电脑', '12', '20170922154932923123004764987340', null, null, '20161222113810681189580305593289', '2017-09-22 15:49:33', null, null);
INSERT INTO `th_store_property` VALUES ('20170922154933237294453669541174', '打印机', '1', '20170922154932923123004764987340', null, null, '20161222113810681189580305593289', '2017-09-22 15:49:33', null, null);
INSERT INTO `th_store_property` VALUES ('20170922155207342153813531973347', '大头针', '23', '20170922155207290634168580342140', null, null, '20161222113810681189580305593289', '2017-09-22 15:52:07', null, null);
INSERT INTO `th_store_property` VALUES ('20170922155207385206476585563317', '笔记本', '10', '20170922155207290634168580342140', null, null, '20161222113810681189580305593289', '2017-09-22 15:52:07', null, null);
INSERT INTO `th_store_property` VALUES ('20170922155301538052593228197604', 'SDS', '1', '20170922155301527135602974909688', null, null, '20161222113810681189580305593289', '2017-09-22 15:53:01', null, null);
INSERT INTO `th_store_property` VALUES ('20170922155404115436577104811169', '是滴是滴', '1', '20170922155404113485654128116220', null, null, '20161222113810681189580305593289', '2017-09-22 15:54:04', null, null);
INSERT INTO `th_store_property` VALUES ('20170922155512660775290407900451', '是滴是滴', '23', '20170922155512650796375955980227', null, null, '20161222113810681189580305593289', '2017-09-22 15:55:12', null, null);
INSERT INTO `th_store_property` VALUES ('20170922155512661438130046885794', '顶经', '2', '20170922155512650796375955980227', null, null, '20161222113810681189580305593289', '2017-09-22 15:55:12', null, null);
INSERT INTO `th_store_property` VALUES ('20170922155819126282450419758329', '是滴是滴', '1', '20170922155758751662910860438310', null, null, '20161222113810681189580305593289', '2017-09-22 15:58:19', '2017-09-22 17:07:43', '20161222113810681189580305593289');
INSERT INTO `th_store_property` VALUES ('20171020141843002197797343680851', '货架', '10', '20171020141842757704681968303771', null, null, '20161222113810681189580305593289', '2017-10-20 14:18:43', null, '20161222113810681189580305593289');

-- ----------------------------
-- Table structure for th_vende
-- ----------------------------
DROP TABLE IF EXISTS `th_vende`;
CREATE TABLE `th_vende` (
  `id` varchar(32) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `chargeName` varchar(50) DEFAULT NULL COMMENT '负责人',
  `chargePhone` varchar(20) DEFAULT NULL COMMENT '联系方式',
  `address` varchar(500) DEFAULT NULL COMMENT '厂家地址',
  `bankName` varchar(200) DEFAULT NULL COMMENT '开户行',
  `bankCardNum` varchar(50) DEFAULT NULL COMMENT '银行账户',
  `brandHttpURI` text COMMENT '官网网址',
  `remark` text COMMENT '备注',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `ft` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  `email` text COMMENT '邮箱',
  `isDelete` varchar(5) DEFAULT NULL COMMENT '是否删除（1：否，2：是）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商';

-- ----------------------------
-- Records of th_vende
-- ----------------------------
INSERT INTO `th_vende` VALUES ('20170922161947310531092766890152', '森迈特供应商', '张三丰', '15987456987', '140000-140100-140105-顶戴大哥大胜多负少胜多负少-山西省太原市小店区顶戴大哥大胜多负少胜多负少', '包头青山支行', '12345678901234567890', 'www.baiduc.com', '胜多负少', '2017-09-22 16:19:47', '2017-09-22 16:19:47', '20161222113810681189580305593289', '2018-03-06 11:43:23', '20161222113810681189580305593289', 'sss@qq.com', '1');
INSERT INTO `th_vende` VALUES ('20170922162102062219703545592626', '帛卡袖供应商', '张回家', '15987456987', '120000-120100-120102-时代复分-天津市天津市河东区时代复分', '包头市是滴是滴是滴是滴佛挡顶需要多福多寿', '12345679891234567899', 'www.baiduc.com', '', '2017-09-22 16:21:02', '2017-09-22 16:21:02', '20161222113810681189580305593289', null, null, '22@qq.com', '1');
INSERT INTO `th_vende` VALUES ('20170922162229791545690368049869', '小商品供应商1', '张大山', '15698745689', '120000-120100-120101-sfgsfgsfsdfsdfsdfsdfsdfsdfds-天津市天津市和平区sfgsfgsfsdfsdfsdfsdfsdfsdfds', 'sssssssssssssssssssssssssssssssss', '1111111111111111', 'www.baiduc.com', '', '2017-09-22 16:22:29', '2017-09-22 16:22:29', '20161222113810681189580305593289', null, null, 'ss@qq.com', '1');
INSERT INTO `th_vende` VALUES ('20170925103518734996624662871711', '女鞋供应商', 'xdtdg', '15661451612', '150000-150200-150204-sdfsfdsfdsfdsfs-内蒙古包头市青山区sdfsfdsfdsfdsfs', 'sdsdsdsd', '00000000000000000000', 'www.baidu.com', '', '2017-09-25 10:35:18', '2017-09-25 10:35:18', '20161222113810681189580305593289', null, null, 'sdsdsdsj@qq.com', '1');
INSERT INTO `th_vende` VALUES ('20171020142004453627276165451387', '测试供应商', '艾伦SDASD', '13012340002', '150000-150200-150204-的沙发斯蒂芬阿斯蒂芬安抚阿斯蒂芬100号-内蒙古包头市青山区的沙发斯蒂芬阿斯蒂芬安抚阿斯蒂芬100号', '内蒙古包头市建设银行包头工商联分行', '6223123412321563', '', '', '2017-10-20 14:20:04', '2017-10-20 14:20:04', '20161222113810681189580305593289', null, null, '', '1');

-- ----------------------------
-- Table structure for th_wechat
-- ----------------------------
DROP TABLE IF EXISTS `th_wechat`;
CREATE TABLE `th_wechat` (
  `id` varchar(32) NOT NULL,
  `wechatnum` varchar(50) DEFAULT NULL COMMENT '公众号原始ID',
  `name` varchar(255) DEFAULT NULL,
  `appid` varchar(255) DEFAULT NULL COMMENT 'appid',
  `appsecret` varchar(255) DEFAULT NULL COMMENT 'appsecret',
  `mchid` varchar(255) DEFAULT NULL COMMENT '微信支付的商户号',
  `apisecret` varchar(255) DEFAULT NULL COMMENT '微信支付的apisecret',
  `accesstoken` varchar(255) DEFAULT NULL COMMENT 'accesstoken',
  `jsapiticket` varchar(255) DEFAULT NULL COMMENT 'jsapiticket',
  `expirestime` varchar(255) DEFAULT NULL COMMENT '有效期',
  `domainName` varchar(255) DEFAULT NULL COMMENT '域名',
  `tel` varchar(255) DEFAULT NULL COMMENT '电话',
  `wishing` varchar(255) DEFAULT NULL COMMENT '红包祝福语',
  `actName` varchar(255) DEFAULT NULL COMMENT '现金红包活动名称',
  `actRemark` varchar(255) DEFAULT NULL COMMENT '现金红包活动描述',
  `ft` char(19) DEFAULT NULL,
  `lt` char(19) DEFAULT NULL,
  `fu` char(32) DEFAULT NULL,
  `lu` char(32) DEFAULT NULL,
  `fatherMchid` varchar(255) DEFAULT NULL,
  `fatherAppid` varchar(255) DEFAULT NULL,
  `fatherApisecret` varchar(255) DEFAULT NULL,
  `aliPayPrivateKey` text COMMENT '支付宝支付应用私钥',
  `aliAppid` varchar(200) DEFAULT NULL COMMENT '支付宝appid',
  `aliPublicKey` text COMMENT '支付宝公钥',
  `aliHttpURL` text COMMENT '支付宝接口调用网关',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信公众号信息表';

-- ----------------------------
-- Records of th_wechat
-- ----------------------------
INSERT INTO `th_wechat` VALUES ('1', 'gh_a734d3bb47bf', '天和商城', 'wx11dc1c44ed7dbd71', '0277aa15744a1926caa740fb8199c243', '1375481302', '', '', '', '1', 'http://www.tianhe.nmgssxn.com', '5198570', null, null, null, null, null, null, null, '1277235501', 'wx7d3163ae41640c60', '10000000000000000000000000000000', 'MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCHAxpM+du7aaqQNQyntmT/7AfKdfjA5tLFmyg+MP2Y0sK3iFY1zBWBbJkAl2F3vtDhzW0j68GLfhvAAs+Cz/0+AkmhZ65SdRAUgnVrkUqQHvY/eL+8+C70EUdRsFXalHsYfE6l/vufJ4aEzw6LtPui9Y8bzhBkKvSeYVGol7DdRY8IcB6svG6NNiIJr2at+my1HS07ftj+ZbEhunqNBFl5+FxcybT3CjWdTUHfWi1+NttNCHn2wjVUfCJZuqM+Yr3/axyKgx5NGbgUwwW1Kp3knK7/sxYWayaeLt82Vnufi8yVHr/BBK8/9WWsJSfS346o+bj5NUFUHpVd5bYxo+qrAgMBAAECggEATHETSRYGtRvkuHVwztxUXxpSZu1YhE+scrmglWXDj+101dlZhmggnQDRuCX9x4DAX7ih3L60/LfQGmz89MGyTpOZAMvlRUaGbjZXKSpAH02IevNxDBsw6nuF99hxI6sB7yEinpW5/aixXyykvbEg8Gk8N6/6U9yGV84eH+iS+RR3iUuvDzBWdeCmbrUpXhkqmJmntZSElSFCcCEdQHRaikuIgvlHz6QtAQyFphVX+/pNVPFeyQqkZStnjNKv6u9l3iFVbEVLN0Mmv43eYqfiFGYryw4dHO2GH1GEJZBSj2dETwtpDTGMbWYQU7P49ydsn1pt4QuirT1Jfkes+5drQQKBgQD5FR96sxvivMJQWUWZ3ZeZSfu8jKZWJifIwX9utBAOxjNYM0QbAIfSTmWzN8dI/yP/OxPByyz/zPuzCQ8zsxCYIX1AJ35iKHeM/rI+YHbQD+XR+pBy2pQvtq0XVs4QJmjrsPmrjvDzWMRTMyyZ/qWitP5BieJAiJ9Et8mJI/mXkQKBgQCKwvwjImCwo/WB20YMUaUYJkL0QVAuxidA/itOgpRfdtX0e9uZ0Y67ovQKNtk8Yep2hRID3Wtc2xRVe61nXUthltiEmszT5mMDbMwlcgysgYzYn61POPOTLZrXmIYIJ6UGrr9Q0jra1RW9Vq4X/1tpZuMowrJrmgDHjUdiMhqYewKBgQCAytJHIJu3psCWyUI66CB+K4oWGWfcvcfuf1cEB+kRqpxb6844ZBLWxKDDhYDvFrYnQAXcO9Fdx0ESdwm8Qse+0fowlPs9iA0hA4VoyXpF5SKBa50LNkhPT5a6rbDJGwM/c3f1pGike26wUpKqYciFlC6v9rrdgYdRAfMcjVR+cQKBgBAOwF7Qe5/1WVPNrC2AxTomM1lQtZa0F5bN0vUi50ik192S97a1KW9NTDBiaIE0U42jmJIZ7XKxZ4j85vQvN6nzatrtjwZ2gr7CuF0c9ZqA42uuDsA8NvOxM1n/rIMFE3PShRE1QtpQDlP60+qzAkEQRvlQjpUlHTH6h2g1pB5BAoGBANmC4g50LJvy4ACbsXdkO18L3nyWL7ExOSm5BslFTwRE/RuNADbp+enXeZEol0yADNMs5K0mgMCuPZ7bKLg5BSNIKHqqZx1K8mNeZAI/CmCy1kayBgR11GPCcCeHPh+yZh0Jtujunv7BpKt+FatS3OFdTgx94xL7TUUwMOlbsy3g', '2017022705918807', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmClpvS7RaGxMKFd3MdZww57a5bv+16/AOg9VXYqGA6CzDiW8x4rUR5T9NvL/hw5SquZ1SSqNyyjnx+Lw6W5HMNsphslR5ylbtNl5CQZaHeb3OdKCuctuqiIHBRZMGLW4uOH6kVQuMtgunmOK1A1dUqr6leFopPD4Ad2dxGva5gnnfeL5CZPLLci9iQBFFB3HoWie56mKMGX4qA8QB1TLbmpYdfANLtch5rD5qRqpz0NZJLm4UOAECyq5fhoayaSA8wU5SrkVFuKHvWMg/V4FOiBO9A/nEH0VrWnBFu9UvwHNmZe/WPdj1JSwleQfzpX5OcpOMTdYCjT0pDaySiQUIQIDAQAB', 'https://openapi.alipay.com/gateway.do');

-- ----------------------------
-- Event structure for close_employee_kefu
-- ----------------------------
DROP EVENT IF EXISTS `close_employee_kefu`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `close_employee_kefu` ON SCHEDULE EVERY 1 DAY STARTS '2017-09-20 00:00:01' ON COMPLETION NOT PRESERVE ENABLE DO update th_employee
		set kefuState='2'
;
;;
DELIMITER ;

-- ----------------------------
-- Event structure for give_up_order_and_unlocked_qrcode
-- ----------------------------
DROP EVENT IF EXISTS `give_up_order_and_unlocked_qrcode`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `give_up_order_and_unlocked_qrcode` ON SCHEDULE EVERY 1 DAY STARTS '2017-09-19 00:00:01' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE th_order as order_,
  th_order order_child,
  th_qrcode qrcode,
  th_order_goods og,
  th_order_goods_qrcode ogq
SET order_.state = '7',
	order_child.state = '7',
  qrcode.state = '1'
WHERE
	order_.createTime < NOW()
AND (order_.cashierCode IS NULL or order_.cashierCode = '')
AND order_.state = '1'
AND qrcode.id = ogq.qrcode_id
AND ogq.order_goods_id = og.id
AND og.order_id = order_child.id
AND order_child.order_id = order_.id
;;
DELIMITER ;

-- ----------------------------
-- Event structure for hideOrder_halfYear
-- ----------------------------
DROP EVENT IF EXISTS `hideOrder_halfYear`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `hideOrder_halfYear` ON SCHEDULE EVERY 1 DAY STARTS '2017-09-19 00:05:01' ON COMPLETION NOT PRESERVE ENABLE COMMENT '半年隐藏订单' DO UPDATE th_order SET
isHide='1' where (order_id is null or order_id='') and (state='6' or state='1' or state='7') 
and DATE_ADD(createTime, INTERVAL 183 DAY)<=NOW()
;
;;
DELIMITER ;

-- ----------------------------
-- Event structure for hide_eticket_outrecord
-- ----------------------------
DROP EVENT IF EXISTS `hide_eticket_outrecord`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `hide_eticket_outrecord` ON SCHEDULE EVERY 1 DAY STARTS '2017-09-19 00:01:01' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE th_eticket_outrecord etiout,th_eticket eti SET
etiout.isHide='1' where etiout.state='3'
and DATE_ADD(etiout.createDate, INTERVAL eti.dateLimit+1 DAY)<=NOW()
;
;;
DELIMITER ;

-- ----------------------------
-- Event structure for init_client_shopping_cart
-- ----------------------------
DROP EVENT IF EXISTS `init_client_shopping_cart`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `init_client_shopping_cart` ON SCHEDULE EVERY 1 DAY STARTS '2017-07-22 02:02:02' ON COMPLETION NOT PRESERVE ENABLE DO delete FROM th_client_shoppingcart
;;
DELIMITER ;
