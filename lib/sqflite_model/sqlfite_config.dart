//是否开启调试
const bool SQL_DEBUG = false;
//数据库名称
const String SQL_FILE_NAME = "gl_sqflite_db.sql";
//数据库版本
const int SQL_VERSION = 7;

//数据库config表名称
const String CONFIG_TABLE_NAME = "gl_config";
//创建config表sql语句
const String CREATE_CONFIG_TABLE_SQL_CODE = '''create table $CONFIG_TABLE_NAME (
id INTEGER primary key AUTOINCREMENT not null,
config_key varchar(100) not null,
config_value text(0) not null)''';

//用户表名称
const String USER_TABLE_NAME = "gl_user";
//创建用户表sql语句
const String CREATE_USER_TABLE_SQL_CODE = '''
  create table $USER_TABLE_NAME (
  id INTEGER primary key AUTOINCREMENT not null,
  user_id int(10),
  user_token int(10),
  user_name varchar(32),
  user_img text(0),
  add_time int(10),
  name varchar(32),
  email varchar(60),
  phone varchar(20),
  integral int(10))''';

//首页广告表
const String INDEX_AD_TABLE_NAME = 'gl_index_ad';
//创建首页广告表sql语句
const String CREATE_INDEX_AD_TABLE_SQL_CODE = '''
    create table $INDEX_AD_TABLE_NAME (
  id mediumint(8) primary key not null,
  into_type varchar(100),
  click_count int(10),
  position_type varchar(100),
  is_on_sale int(1),
  position_type2 varchar(100),
  position_type_name varchar(255),
  father_position_name varchar(100),
  sort_order smallint(5),
  ad_type varchar(100),
  ad_img text(0),
  goods_id mediumint(8),
  cat_id mediumint(8),
  url text(0),
  text text(0),
  goods_name varchar(255),
  goods_price varchar(10),
  origin_goods_price varchar(10))''';

//商品表
const String GOODS_TABLE_NAME = 'gl_goods';
//创建商品表sql语句
const String CREATE_GOODS_TABLE_SQL_CODE = '''
    create table $GOODS_TABLE_NAME (
  goods_id mediumint(8) primary key not null,
  cat_id integer(8),
  goods_sn varchar(60),
  goods_name varchar(120),
  goods_head_name varchar(255),
  market_price varchar(10),
  shop_price varchar(10),
  keywords varchar(255),
  goods_brief varchar(255),
  goods_desc text(0),
  goods_stock smallint(5),
  goods_img text(0),
  original_img text(0),
  sort_order smallint(4),
  goods_sales_volume int(10),
  evaluate_count int(10),
  attribute text(0),
  is_promote tinyint(1),
  promote_number smallint(5),
  promote_start_date int(11),
  promote_end_date int(11),
  supplier_id mediumint(8),
  supplier_name varchar(30),
  add_time int(10),
  cat_name varchar(90))''';

//分类表
const String CLASSIFY_TABLE_NAME = 'gl_classify';
//创建分类表sql语句
const String CREATE_CLASSIFY_TABLE_SQL_CODE = '''
    create table $CLASSIFY_TABLE_NAME (
  id mediumint(8) primary key not null,
  classify_name varchar(90),
  into_type varchar(20),
  click_type varchar(20),
  parent_id mediumint(8),
  sort_order smallint(5),
  key_word varchar(10),
  goods_id mediumint(8),
  logo_img text(0),
  bar_img text(0))''';

//购物车表
const String CART_TABLE_NAME = 'gl_cart';
//创建物车表sql语句
const String CREATE_CART_TABLE_SQL_CODE = '''
  create table $CART_TABLE_NAME (
  id INTEGER primary key AUTOINCREMENT not null,
  goodsNumber int(10),
  goodsSn varchar(60),
  goodsName varchar(120),
  goodsId mediumint(8),
  catId mediumint(8),
  goodsHeadName varchar(120),
  goodsPrice decimal(12),
  oneGoodsPrice decimal(12),
  marketPrice decimal(12),
  goodsStock int(10),
  goodsSalesVolume int(10),
  goodsAttributeImg text(0),
  skuId mediumint(8),
  attrDesc varchar(255),
  isPromote int(1),
  promoteNumber int(10),
  promoteStartDate int(10),
  promoteEndDate int(10),
  giveIntegral int(10),
  integral int(10),
  oneGiveIntegral int(10),
  oneIntegral int(10),
  integralDesc text(0),
  byStagesNumber int(5),
  isValid int(1),
  isChoice int(1))''';

//创建表语句集合
const List<String> CREATE_SQL_CODE_LIST = [
  CREATE_CONFIG_TABLE_SQL_CODE,
  CREATE_USER_TABLE_SQL_CODE,
  CREATE_INDEX_AD_TABLE_SQL_CODE,
  CREATE_GOODS_TABLE_SQL_CODE,
  CREATE_CLASSIFY_TABLE_SQL_CODE,
  CREATE_CART_TABLE_SQL_CODE,
];

//表名合集
const List<String> SQL_TABLE_NAME_LIST = [
  CONFIG_TABLE_NAME,
  USER_TABLE_NAME,
  INDEX_AD_TABLE_NAME,
  GOODS_TABLE_NAME,
  CLASSIFY_TABLE_NAME,
  CART_TABLE_NAME,
];
