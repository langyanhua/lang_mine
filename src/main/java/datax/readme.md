
# 阿里开源数据同步组件
- 项目地址:https://github.com/alibaba/DataX
- 下载地址:http://datax-opensource.oss-cn-hangzhou.aliyuncs.com/datax.tar.gz
- 快速使用:https://github.com/alibaba/DataX/wiki/Quick-Start

# mysqlread文档
- https://github.com/alibaba/DataX/blob/master/mysqlreader/doc/mysqlreader.md

# hdfswrite文档
- https://github.com/alibaba/DataX/blob/master/hdfswriter/doc/hdfswriter.md

# job任务示例
- 运行命令:python ${datax_home}/bin/datax.py ${datax_home}/job/job-mysql-hdfs-user.json
- JOB路径:/data/juxin/com.juxin.etl/datax/job
- python /data/juxin/com.juxin.etl/datax/bin/datax.py /data/juxin/com.juxin.etl/datax/job/job-hbase-local.json

```json
{
    "job": {
        "setting": {            
            "speed": {
                "channel": 3
            },
            "errorLimit": {
                "record": 0,
                "percentage": 0.02
            }
        },
        "content": [
            {
                "reader": {
                    "name": "mysqlreader",
                    "parameter": {
                        "username": "root",
                        "password": "***",
                        "column"  : [ "*" ],
                        "splitPk" : "uid",
                        "connection": [
                            {
                                "table": [
                                    "user"
                                ],
                                "jdbcUrl": ["jdbc:mysql://192.168.2.83:3306/yuanfenba_www?characterEncoding=utf-8"]
                            }
                        ]
                    }
                },
                "writer": {
                    "name": "hdfswriter",
                    "parameter": {
                        "defaultFS": "hdfs://192.168.1.7:8020",
                        "fileType": "orc",
                        "path": "/user/hive/warehouse/juxin_ods_mysql.db/www_user",
                        "fileName": "user",
                        "column": [
                            {"name": "uid", "type": "BIGINT"},
                            {"name": "username", "type": "char"},
                            {"name": "cell_phone", "type": "bigint"},
                            {"name": "password", "type": "char"},
                            {"name": "password_m", "type": "char"},
                            {"name": "kf_id", "type": "BIGINT"},
                            {"name": "group", "type": "tinyint"},
                            {"name": "reg_time", "type": "BIGINT"},
                            {"name": "login_time", "type": "BIGINT"},
                            {"name": "login_count", "type": "BIGINT"},
                            {"name": "online_time", "type": "BIGINT"},
                            {"name": "offline_ts", "type": "BIGINT"},
                            {"name": "reg_ip", "type": "char"},
                            {"name": "login_ip", "type": "char"},
                            {"name": "upgrade_start", "type": "BIGINT"},
                            {"name": "upgrade_end", "type": "BIGINT"},
                            {"name": "credit", "type": "BIGINT"},
                            {"name": "money", "type": "float"},
                            {"name": "charge_count", "type": "BIGINT"},
                            {"name": "channel_uid", "type": "BIGINT"},
                            {"name": "channel_sid", "type": "BIGINT"},
                            {"name": "openid", "type": "char"},
                            {"name": "token", "type": "char"},
                            {"name": "user_client_type", "type": "tinyint"},
                            {"name": "recommended", "type": "tinyint"},
                            {"name": "say_hi_recommended", "type": "tinyint"},
                            {"name": "isvip", "type": "tinyint"},
                            {"name": "vip_start", "type": "BIGINT"},
                            {"name": "vip_end", "type": "BIGINT"},
                            {"name": "ycoin", "type": "BIGINT"},
                            {"name": "real_reg_time", "type": "Date"},
                            {"name": "create_time", "type": "Date"},
                            {"name": "status", "type": "tinyint"},
                            {"name": "is_bind_roes", "type": "tinyint"}
                        ],
                        "writeMode": "nonConflict",
                        "fieldDelimiter": "\1",
                        "compress":"NONE"
                    }
                }
            }
        ]
    }
}
```

# hive建表示例

```sql

-- 数据库路径:/user/hive/warehouse/juxin_ods_mysql.db
create database IF NOT EXISTS juxin_ods_mysql;

use juxin_ods_mysql;

-- 表路径:/user/hive/warehouse/juxin_ods_mysql.db/www_user
create table www_user(
    uid BIGINT,
    username char(50),
    cell_phone bigint,
    password char(40),
    password_m char(6),
    kf_id BIGINT,
    group tinyint,
    reg_time BIGINT,
    login_time BIGINT,
    login_count BIGINT,
    online_time BIGINT,
    offline_ts BIGINT,
    reg_ip char(20),
    login_ip char(20),
    upgrade_start BIGINT,
    upgrade_end BIGINT,
    credit BIGINT,
    money float,
    charge_count BIGINT,
    channel_uid BIGINT,
    channel_sid BIGINT,
    openid char(32),
    token char(32),
    user_client_type tinyint,
    recommended tinyint,
    say_hi_recommended tinyint,
    isvip tinyint,
    vip_start BIGINT,
    vip_end BIGINT,
    ycoin BIGINT,
    real_reg_time Date,
    create_time Date,
    status tinyint,
    is_bind_roes tinyint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\1'
STORED AS ORC;
```

# MYSQL导出数据库表结构
```
mysqldump -h hostname --user=root --password=123456 --skip-lock-tables -d yuanfenba_www > yuanfenba_www.sql
```

# 从库全部表名
```text
table_name
activity
activity_detail
activity_user_list
adview_bid
adview_bid_data
adview_bid_price
an_custom_pkg
an_custom_pkg_log
api_spread
app_active
app_list
app_new_ver
app_new_ver_channel
app_new_ver_uid
app_ping
app_user_active
app_ver
app_version
app_ver_channel
app_ver_new
area
article_info
back_domain
back_domain_history
baidu_bid
baidu_bid_data
baidu_bid_price
baidu_login
behavior
belle_group
belle_group_report
belle_group_to_user
belle_report
block
block_item
channel_filter
charge_angelpay_user
charge_log
charge_log_order
charge_log_second
charge_sp_log
charge_user_first
charge_user_log
charge_user_second
city
city_map
code
columns_priv
complain
complain_item
constellation
constellation_luck
db
deduction_money
dev_user_wechat_list
diamand_log
down_count
event
feedback
film
forbid_user_mac
func
games
game_fruit_redbag
game_fruit_withdraw
game_prize_data
game_prize_win_log
game_share_data
game_share_log
game_task_data
game_user_data
general_log
gift
gpay_charge_log
h5_click_time
h5_login_tpl
help_category
help_keyword
help_relation
help_topic
horoscopes
host
iccid_list
image_md5
importData_log
integral_app
integral_app_log
integral_new_app
ios_custom_pkg
ios_custom_pkg_log
ip_address_lib
joke
keep_url
kf
live_anchor
live_banner
live_key_value
login_equipment_log
lucky
lucky_log
lucky_user
manager
manager_action_log
manager_group
manager_login_log
manager_operate_log
money_tree_cheater
mpay_charge_log
mpay_charge_log_1
mp_company
mp_domain
mp_options
mp_options_child
msg_tpl
msg_tpl_new
msg_tpl_new_cp
msg_tpl_new_en
msg_tpl_show_date
msg_tpl_show_date_type
msg_tpl_user
msg_tpl_user_
msg_tpl_user_copy
msg_tpl_user_cp
msg_tpl_user_cp_copy
msg_tpl_user_en
msg_tpl_wy
mumu_user
myapp_keyword
ndb_binlog_index
novel
novel_charge_log
novel_wechat_user
phone_info
plugin
position
precious
precious_day
prize
prize_log
prize_new
prize_new_log
proc
procs_priv
province
proxies_priv
push_ad
push_ad_config
push_ad_data
push_user_list
redbag_moneytree
redbag_ranking
reply_keyword
reply_keyword_tpl
report
report_activity
report_amount
report_app_user_action
report_app_ver
report_girl
report_msg_10_user
report_shangxian_user
report_user_abnormal
report_user_action
report_user_free
report_ver
resume
robots_tpl_charge_log
root_data
rose
sdk_active_data
sdk_hejupay
servers
sessions
setting
share
single_wechat_qrcode
slow_log
sms
sms_verify
sp_channel
sp_channel_config
sp_click_data
sp_click_log
sp_click_log_new
sp_click_sdk_log
sp_dongman
sp_dongman_all_log
sp_dongman_dx
sp_dongman_dx_new
sp_dongman_imsi
sp_dongman_log
sp_get_data
sp_heju
sp_receive
sp_receive_ido
sp_send_data
sp_test_data
sp_upay360
sp_user_info
sp_view_log
sp_view_region_log
sys_notice
sys_session
tables_priv
talent
talent_new
test_info
test_info_data
tg_domain
tg_peizhi
tg_user
tg_user_acount
tg_user_income
tg_user_withdraw
time_zone
time_zone_leap_second
time_zone_name
time_zone_transition
time_zone_transition_type
tree_url
union_ad
union_ad_config
union_ad_report
union_ad_report_all
union_check_uid
union_desk
union_notice
union_report
union_report_tmp
union_settlement
union_sid_content
union_uid_manage
union_user
union_user_table
union_user_xx
user
user
user_address
user_auth
user_avatar_verify
user_avatar_verify_status
user_bribery
user_bribery_receive
user_broadcast
user_complain
user_credit
user_detail
user_follow
user_gamekf_os
user_group
user_heart
user_help_list
user_help_new_list
user_ip_ban
user_kuplay
user_lang
user_login_log
user_men_avatar
user_message
user_message_count
user_message_fail
user_message_failed
user_message_female
user_msg_support
user_nickname
user_nickname_modify
user_online
user_online_client
user_online_wechat
user_orders
user_os
user_photo_album
user_photo_album_verify
user_pkgname
user_precious_log
user_require
user_rose
user_sayHi
user_sayHi_config
user_smspush_list
user_test
user_test_20170606
user_three
user_validation
user_video
user_visitors
user_wechat
user_wechat_list
user_wechat_os
user_wechat_scan
user_wish
user_yan_tmp
user_ycoin_log
video
video_formal
video_push
vote
wechat_count
weixin
weixin_report
wish_address
wish_charge_log
wish_credit
word_filter
word_filter_gift
word_filter_msg
wy_active_imei
wy_active_imei_enter
wy_active_imei_sp
wy_active_list
wy_active_report
yht_settlement_list
```
