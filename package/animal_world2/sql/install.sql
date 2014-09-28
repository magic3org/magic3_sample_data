-- *
-- * データ登録スクリプト「フォトギャラリーサイトデモ」
-- *
-- * PHP versions 5
-- *
-- * LICENSE: This source file is licensed under the terms of the GNU General Public License.
-- *
-- * @package    Magic3 Framework
-- * @author     平田直毅(Naoki Hirata) <naoki@aplo.co.jp>
-- * @copyright  Copyright 2006-2014 Magic3 Project.
-- * @license    http://www.gnu.org/copyleft/gpl.html  GPL License
-- * @version    SVN: $Id$
-- * @link       http://www.magic3.org
-- *
-- [フォトギャラリーサイトデモ(作成中)]
-- フォトギャラリー主軸型サイト。用途は会員制の画像閲覧サイトなど。
-- 機能はフォトギャラリー、汎用コンテンツ、会員登録等。
-- 初期インストールデータは必要最小限のみ。

-- システム設定
UPDATE _system_config SET sc_value = 'bootstrap_cerulean_head' WHERE sc_id = 'default_template';

-- サイト定義マスター
DELETE FROM _site_def WHERE sd_id = 'site_name';
INSERT INTO _site_def
(sd_id,                  sd_language_id, sd_value,         sd_name) VALUES
('site_name',            'ja',           '世界の動物',               'サイト名');
DELETE FROM _site_def WHERE sd_id = 'head_title';
INSERT INTO _site_def
(sd_id,                  sd_language_id, sd_value,         sd_name) VALUES
('head_title',           'ja',           '世界の動物',               'HTMLヘッダtitle');

-- 管理画面ページデータ(デフォルトを変更)
UPDATE _page_id SET pg_default_sub_id = 'photo' WHERE pg_id = 'index' AND pg_type = 0;
-- スマートフォン,携帯のアクセスポイントを隠す
UPDATE _page_id SET pg_active = false WHERE pg_id = 's_index' AND pg_type = 0;
UPDATE _page_id SET pg_active = false WHERE pg_id = 'm_index' AND pg_type = 0;

-- 管理画面メニューデータ
DELETE FROM _nav_item;
INSERT INTO _nav_item
(ni_id, ni_parent_id, ni_index, ni_nav_id,    ni_task_id,        ni_view_control, ni_visible, ni_param, ni_name,                ni_help_title,          ni_help_body) VALUES
(100,   0,            0,        'admin_menu', '_page',           0,               true, '',       '画面管理',             '画面管理',             'Webサイトのデザインや機能を管理します。'),
(101,   100,          0,        'admin_menu', 'pagedef',         0,               true, '',       'PC画面',         'PC画面編集',         'PC用Webサイトの画面を作成します。'),
(102,   100,          1,        'admin_menu', 'pagedef_smartphone',  0,           false, '',       'スマートフォン画面', 'スマートフォン画面編集',       'スマートフォン用Webサイトの画面を作成します。'),
(103,   100,          2,        'admin_menu', 'pagedef_mobile',  0,               false, '',       '携帯画面',       '携帯画面編集',       '携帯用Webサイトの画面を作成します。'),
(104,   100,          3,        'admin_menu', '_104',            3,               true, '',       'セパレータ',                 '',                     ''),
(105,   100,          4,        'admin_menu', 'widgetlist',      0,               true, '',       'ウィジェット管理',     'ウィジェット管理',     'ウィジェットの管理を行います。'),
(106,   100,          5,        'admin_menu', 'templist',        0,               true, '',       'テンプレート管理',     'テンプレート管理',     'テンプレートの管理を行います。'),
(107,   100,          6,        'admin_menu', 'smenudef',        0,               true, '',       'メニュー管理', 'メニュー管理', 'メニュー定義を管理します。'),
(199,   0,            1,        'admin_menu', '_199',            1,               true, '',       '改行',                 '',                     ''),
(200,   0,            2,        'admin_menu', '_login',          0,               true, '',       'システム運用',         '',                     ''),
(201,   200,          0,        'admin_menu', 'userlist',        0,               true, '',       'ユーザ一覧',           'ユーザ一覧',           'ログイン可能なユーザを管理します。'),
(202,   200,          1,        'admin_menu', 'accesslog',       0,               true, '',       '運用状況', '運用状況', 'サイトの運用状況を表示します。'),
(299,   0,            3,        'admin_menu', '_299',            1,               true, '',       '改行',                 '',                     ''),
(300,   0,            4,        'admin_menu', '_config',         0,               true, '',       'システム管理',         '',                     ''),
(301,   300,          0,        'admin_menu', 'configsite',      0,               true, '',       '基本情報',             '基本情報',             'サイト運営に必要な情報を設定します。'),
(302,   300,          1,        'admin_menu', 'configsys',       0,               true, '',       'システム情報',         'システム情報',         'システム全体の設定、運用状況を管理します。'),
(303,   300,          2,        'admin_menu', 'mainte',          0,               true, '',       'メンテナンス', 'メンテナンス', 'ファイルやDBなどのメンテナンスを行います。'),
(10100,   0,            0,        'admin_menu.en', '_page',           0,               true, '',       'Edit Page',             'Edit Page',             'Edit page for design and function.'),
(10101,   10100,          0,        'admin_menu.en', 'pagedef',         0,               true, '',       'PC Page',         'PC Page',         'Edit page for PC.'),
(10102,   10100,          1,        'admin_menu.en', 'pagedef_smartphone',  0,           false, '',       'Smartphone Page', 'Smartphone Page',       'Edit page for Smartphone.'),
(10103,   10100,          2,        'admin_menu.en', 'pagedef_mobile',  0,               false, '',       'Mobile Page',       'Mobile Page',       'Edit page for Mobile.'),
(10104,   10100,          3,        'admin_menu.en', '_10104',            3,               true, '',       'Separator',                 '',                     ''),
(10105,   10100,          4,        'admin_menu.en', 'widgetlist',      0,               true, '',       'Widget Administration',     'Widget Administration',     'Administrate widgets with widget config window.'),
(10106,   10100,          5,        'admin_menu.en', 'templist',        0,               true, '',       'Template Administration',     'Template Administration',     'Administrate templates.'),
(10107,   10100,          6,        'admin_menu.en', 'smenudef',        0,               true, '',       'Menu Administration', 'Menu Administration', 'Administrate menu definition.'),
(10199,   0,            1,        'admin_menu.en', '_10199',            1,               true, '',       'Return',                 '',                     ''),
(10200,   0,            2,        'admin_menu.en', '_login',          0,               true, '',       'System Operation',         '',                     ''),
(10201,   10200,          0,        'admin_menu.en', 'userlist',        0,               true, '',       'User List',           'User List',           'Administrate user to login.'),
(10202,   10200,          1,        'admin_menu.en', 'accesslog',     0,               true, '',       'Site Conditions', 'Site Conditions', 'Operation log and access analytics on site.'),
(10299,   0,            3,        'admin_menu.en', '_10299',            1,               true, '',       'Return',                 '',                     ''),
(10300,   0,            4,        'admin_menu.en', '_config',         0,               true, '',       'System Administration',         '',                     ''),
(10301,   10300,          0,        'admin_menu.en', 'configsite',      0,               true, '',       'Site Information',             'Site Information',             'Configure site information.'),
(10302,   10300,          1,        'admin_menu.en', 'configsys',       0,               true, '',       'System Information',         'System Information',         'Configure sytem information.'),
(10303,   10300,          2,        'admin_menu.en', 'mainte',          0,               true, '',       'System Maintenance', 'System Maintenance', 'Maintenance about file system and database.');

-- 画面定義
DELETE FROM _page_def WHERE pd_id = 'index';
INSERT INTO _page_def
(pd_id,   pd_sub_id, pd_position_id,   pd_index, pd_widget_id,         pd_config_id, pd_config_name,       pd_menu_id,  pd_title,  pd_title_visible, pd_view_control_type, pd_update_dt) VALUES
('index', '',        'user3',           2,       'default_menu',       1,            'メインメニュー設定', 'main_menu', '',        false,            0,                    now()),
('index', '',        'footer',          2,       'default_footer',     0,            '',                   '',          '',        false,            0,                    now()),
('index', '',        'footer',          10,      'gotop',              0,            '',                   '',          '',        false,            0,                    now()),
('index', 'photo',   'header-pre-hide', 2,       'slogan',             1,            '',                   '',          '',        false,            0,                    now()),
('index', 'photo',   'header',          2,       'slide_image',        1,            '',                   '',          '',        false,            0,                    now()),
('index', 'photo',   'main',            2,       'static_content',     1,            '',                   '',          '',        true,             2,                    now()),
('index', 'photo',   'main',            3,       'pretty_photo',       1,            '',                   '',          '',        false,            2,                    now()),
('index', 'photo',    'main',            5,       'photo_main',          0,            '',                   '',        '',        false,            1,                    now()),
('index', 'photo',    'left',            5,       'photo_new',          0,            '',                   '',         '最新画像', true,            1,                    now()),
('index', 'content', 'main',            6,       'default_content',    0,            '',                   '',          '',        true,            0,                    now()),
('index', 'member',  'main',            6,       'reg_user',           0,            '',                   '',          '',        true,             0,                    now()),
('index', 'search',  'main',            5,       'custom_search',      1,            '',                   '',          '',        false,            0,                    now()),
('index', 'contact', 'main',            5,       'contactus',          0,            '',                   '',          'お問い合わせ',        true,            0,                    now());

-- 新メニュー対応
TRUNCATE TABLE _menu_def;
INSERT INTO _menu_def
(md_id, md_index, md_menu_id,  md_name,        md_link_url,                                         md_update_dt) VALUES
(1,     1,        'main_menu', 'ホーム',       '[#M3_ROOT_URL#]/',                                   now()),
(2,     2,        'main_menu', '運営',     '[#M3_ROOT_URL#]/index.php?contentid=1', now()),
(3,     3,        'main_menu', 'お問い合わせ', '[#M3_ROOT_URL#]/index.php?sub=contact',             now());

-- ウィジェットパラメータ
DELETE FROM _widget_param WHERE wp_id = 'default_menu';
INSERT INTO _widget_param
(wp_id,          wp_config_id, wp_param,                                                                                                wp_create_dt) VALUES 
('default_menu', 1,            'O:8:"stdClass":10:{s:6:"menuId";s:9:"main_menu";s:4:"name";s:27:"メインメニュー設定";s:9:"limitUser";s:1:"0";s:10:"isHierMenu";s:1:"0";s:15:"useVerticalMenu";s:1:"0";s:12:"showSitename";s:1:"0";s:10:"showSearch";s:1:"1";s:12:"anotherColor";s:1:"1";s:9:"showLogin";s:1:"1";s:10:"showRegist";s:1:"1";}', now());
DELETE FROM _widget_param WHERE wp_id = 'custom_search';
INSERT INTO _widget_param
(wp_id,          wp_config_id, wp_param,                                                                                                wp_create_dt) VALUES 
('custom_search', 1,            'O:8:"stdClass":16:{s:4:"name";s:16:"名称未設定1";s:11:"resultCount";s:2:"20";s:14:"searchTemplate";s:241:"<input id="custom_search_1_text" maxlength="40" size="10" type="text" /> <input class="button" id="custom_search_1_button" type="button" value="検索" /> <input class="button" id="custom_search_1_reset" type="button" value="リセット" />";s:12:"searchTextId";s:20:"custom_search_1_text";s:14:"searchButtonId";s:22:"custom_search_1_button";s:13:"searchResetId";s:21:"custom_search_1_reset";s:15:"isTargetContent";i:1;s:12:"isTargetUser";i:0;s:12:"isTargetBlog";i:0;s:9:"fieldInfo";a:0:{}s:15:"isTargetProduct";i:0;s:13:"isTargetEvent";i:0;s:11:"isTargetBbs";i:0;s:13:"isTargetPhoto";i:1;s:12:"isTargetWiki";i:0;s:12:"resultLength";s:3:"200";}', now());
DELETE FROM _widget_param WHERE wp_id = 'slogan';
INSERT INTO _widget_param
(wp_id,          wp_config_id, wp_param,                                                                                                wp_create_dt) VALUES 
('slogan', 1,            'O:8:"stdClass":7:{s:4:"name";s:16:"名称未設定1";s:7:"message";s:15:"世界の動物";s:4:"size";s:3:"2.5";s:5:"cssId";s:8:"slogan_1";s:3:"css";s:129:"#slogan_1 {\r\n    position:relative;\r\n    color:#FFF;\r\n    z-index:200;\r\n    top:1.0em;\r\n    padding-left:3em;\r\n    height:0;\r\n}\r\n";s:7:"minSize";s:2:"20";s:7:"maxSize";s:2:"50";}', now());
DELETE FROM _widget_param WHERE wp_id = 'slide_image';
INSERT INTO _widget_param
(wp_id,          wp_config_id, wp_param,                                                                                                wp_create_dt) VALUES 
('slide_image', 1,            'O:8:"stdClass":8:{s:4:"name";s:16:"名称未設定1";s:9:"imageInfo";a:4:{i:0;O:8:"stdClass":2:{s:4:"name";s:0:"";s:3:"url";s:59:"[#M3_ROOT_URL#]/resource/image/sample/header/rhinoceros.jpg";}i:1;O:8:"stdClass":2:{s:4:"name";s:0:"";s:3:"url";s:56:"[#M3_ROOT_URL#]/resource/image/sample/header/buffalo.jpg";}i:2;O:8:"stdClass":2:{s:4:"name";s:0:"";s:3:"url";s:57:"[#M3_ROOT_URL#]/resource/image/sample/header/elephant.jpg";}i:3;O:8:"stdClass":2:{s:4:"name";s:0:"";s:3:"url";s:53:"[#M3_ROOT_URL#]/resource/image/sample/header/lion.jpg";}}s:5:"cssId";s:13:"slide_image_1";s:3:"css";s:286:"#slide_image_1 .bx-wrapper img {\r\n	margin: 0 auto;\r\n	width:100%;\r\n}\r\n#slide_image_1 .bx-wrapper .bx-viewport {\r\n	-moz-box-shadow: none;\r\n	-webkit-box-shadow: none;\r\n	box-shadow: none;\r\n	border:none;\r\n	background-color:transparent;\r\n	left:0;\r\n}\r\n#slide_image_1 {\r\n	overflow: hidden;\r\n}\r\n";s:9:"showTitle";s:1:"0";s:9:"showPager";s:1:"0";s:11:"showControl";s:1:"1";s:4:"auto";s:1:"0";}', now());
DELETE FROM _widget_param WHERE wp_id = 'static_content';
INSERT INTO _widget_param
(wp_id,          wp_config_id, wp_param,                                                                                                wp_create_dt) VALUES 
('static_content', 1,            'O:8:"stdClass":4:{s:4:"name";s:16:"名称未設定1";s:9:"contentId";s:1:"2";s:12:"showReadMore";i:0;s:13:"readMoreTitle";s:0:"";}', now());
DELETE FROM _widget_param WHERE wp_id = 'pretty_photo';
INSERT INTO _widget_param
(wp_id,          wp_config_id, wp_param,                                                                                                wp_create_dt) VALUES 
('pretty_photo', 1,            'O:8:"stdClass":9:{s:4:"name";s:16:"名称未設定1";s:4:"size";s:3:"120";s:7:"opacity";s:4:"0.80";s:9:"imageInfo";a:8:{i:0;O:8:"stdClass":3:{s:4:"name";s:0:"";s:4:"desc";s:0:"";s:3:"url";s:54:"[#M3_ROOT_URL#]/resource/image/sample/animal/top01.jpg";}i:1;O:8:"stdClass":3:{s:4:"name";s:0:"";s:4:"desc";s:0:"";s:3:"url";s:54:"[#M3_ROOT_URL#]/resource/image/sample/animal/top02.jpg";}i:2;O:8:"stdClass":3:{s:4:"name";s:0:"";s:4:"desc";s:0:"";s:3:"url";s:54:"[#M3_ROOT_URL#]/resource/image/sample/animal/top03.jpg";}i:3;O:8:"stdClass":3:{s:4:"name";s:0:"";s:4:"desc";s:0:"";s:3:"url";s:54:"[#M3_ROOT_URL#]/resource/image/sample/animal/top04.jpg";}i:4;O:8:"stdClass":3:{s:4:"name";s:0:"";s:4:"desc";s:0:"";s:3:"url";s:54:"[#M3_ROOT_URL#]/resource/image/sample/animal/top05.jpg";}i:5;O:8:"stdClass":3:{s:4:"name";s:0:"";s:4:"desc";s:0:"";s:3:"url";s:54:"[#M3_ROOT_URL#]/resource/image/sample/animal/top06.jpg";}i:6;O:8:"stdClass":3:{s:4:"name";s:0:"";s:4:"desc";s:0:"";s:3:"url";s:54:"[#M3_ROOT_URL#]/resource/image/sample/animal/top07.jpg";}i:7;O:8:"stdClass":3:{s:4:"name";s:0:"";s:4:"desc";s:0:"";s:3:"url";s:54:"[#M3_ROOT_URL#]/resource/image/sample/animal/top08.jpg";}}s:5:"cssId";s:14:"pretty_photo_1";s:3:"css";s:870:"#pretty_photo_1.gallery {\r\n	list-style: none;\r\n	/*margin: 0 0 10px 0;*/\r\n	margin: 0;\r\n	padding: 0;\r\n	border: 0;\r\n}\r\n#pretty_photo_1.gallery li {\r\n	display: block;\r\n	float: left;\r\n	margin: 0 5px 5px 0;\r\n}\r\n#pretty_photo_1.gallery li:before {	/* remove list mark */\r\n	display:none;\r\n}\r\n#pretty_photo_1.gallery li a {\r\n	padding: 2px;\r\n	display: block;\r\n	border: 2px #9db2b9 solid;\r\n	-moz-border-radius: 5px;\r\n	-webkit-border-radius: 5px;\r\n	line-height: 0;\r\n	text-decoration: none;\r\n}\r\n#pretty_photo_1.gallery li a:hover {\r\n	border: 2px #313739 solid;\r\n}\r\n#pretty_photo_1.gallery li a:focus {\r\n	outline: none;\r\n}\r\n#pretty_photo_1.gallery li a img {\r\n	margin: 0;\r\n	padding: 0;\r\n	border: 0;\r\n}\r\n#pretty_photo_1.clearfix:after {\r\n	content: "."; \r\n	display: block; \r\n	height: 0; \r\n	clear: both; \r\n	visibility: hidden;\r\n}\r\n#pretty_photo_1.clearfix {\r\n	display: inline-block;\r\n}\r\n";s:5:"theme";s:13:"light_rounded";s:9:"showTitle";s:1:"0";s:16:"showSocialButton";s:1:"0";}', now());
DELETE FROM _widget_param WHERE wp_id = 'reg_user';
INSERT INTO _widget_param
(wp_id,      wp_config_id, wp_param,                                                                                                wp_create_dt) VALUES 
('reg_user', 0,            'O:8:"stdClass":1:{s:8:"authType";s:4:"auto";}', now());

-- コンテンツ
TRUNCATE TABLE content;
INSERT INTO content
(cn_type, cn_id, cn_language_id, cn_name,              cn_html,                        cn_default, cn_key, cn_create_user_id, cn_create_dt) VALUES 
('', 1,     'ja',           '運営会社', '<table class="table">\r\n	<tbody>\r\n		<tr>\r\n			<th>社　名</th>\r\n			<td>\r\n			<p>株式会社サファリ</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<th>所在地</th>\r\n			<td>\r\n			<p></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<th>設　立</th>\r\n			<td>\r\n			<p></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<th>代表者</th>\r\n			<td>\r\n			<p></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<th>事業内容</th>\r\n			<td>\r\n			<p>●サファリパークの運営</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<th>主要取引銀行</th>\r\n			<td>\r\n			<p></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<th>主要取引先</th>\r\n			<td>\r\n			<p></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<th></th>\r\n			<td></td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<div class="googlemaps" id="gmap201472916954" style="width:100%;height:300px;display:none;margin:0 auto;">\r\n<script type="text/javascript">\r\n//<![CDATA[\r\n// Magic3 googlemaps v1.00 mapid:201472916954\r\n$(function(){\r\n	var mapStyle = [{"featureType":"water","stylers":[{"visibility":"on"},{"color":"#acbcc9"}]},{"featureType":"landscape","stylers":[{"color":"#f2e5d4"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#c5c6c6"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#e4d7c6"}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#fbfaf7"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#c5dac6"}]},{"featureType":"administrative","stylers":[{"visibility":"on"},{"lightness":33}]},{"featureType":"road"},{"featureType":"poi.park","elementType":"labels","stylers":[{"visibility":"on"},{"lightness":20}]},{},{"featureType":"road","stylers":[{"lightness":20}]}];\r\n	var allMapTypes = [	"original",\r\n						google.maps.MapTypeId.SATELLITE,\r\n						google.maps.MapTypeId.HYBRID,\r\n						google.maps.MapTypeId.TERRAIN	];\r\n	var opts = {	mapTypeControlOptions: {	mapTypeIds: allMapTypes } };\r\n	var mapDiv = document.getElementById("gmap201472916954");\r\n	var map = new google.maps.Map(mapDiv, opts);\r\n	var originalMapType = new google.maps.StyledMapType(mapStyle, { name: "地図" });\r\n	map.mapTypes.set("original", originalMapType);\r\n	map.setMapTypeId("original");\r\n	map.setMapTypeId(allMapTypes[0]);\r\n	map.setCenter(new google.maps.LatLng(34.69116, 135.52506));\r\n	map.setZoom(11);\r\n	mapDiv.style.display = "";\r\n	m3GooglemapsAddMarkers(map, [{lat:34.68732, lon:135.5262, text:''場所はここ''}]);\r\n});\r\n//]]></script>\r\n</div>\r\n',              false, '',                0, now()),
('', 2,     'ja',           'ようこそ「世界の動物」へ',   '<p>このサイトはＰＣ、スマートフォン、タブレットなどマルチデバイスに対応した会員制の画像ライブラリサイトです。<br />\r\n会員登録を行ってからログインすると画像が閲覧できます。</p>\r\n\r\n<p><a class="button" href="[#M3_ROOT_URL#]/index.php?sub=member&task=regist">会員登録へ</a></p>\r\n',              false, '',                0, now());


-- フォト情報マスター
TRUNCATE TABLE photo;
INSERT INTO photo
(ht_id, ht_language_id, ht_public_id, ht_code, ht_sort_order, ht_mime_type, ht_image_size, ht_original_filename, ht_thumb_filename, ht_file_size, ht_name, ht_owner_id, ht_regist_dt) VALUES
(1, 'ja', 'de0830eb84000361138eee23fa0056d4', 'admin-1', 2, 'image/jpeg', '500x335', 'photo1.jpg', 'de0830eb84000361138eee23fa0056d4_72c.jpg;de0830eb84000361138eee23fa0056d4_200c.jpg', 31358, 'photo1', 1, '2014-09-06 04:19:41'),
(2, 'ja', '4bdbefb1164b0a47521b6dd01468c3fe', 'admin-2', 4, 'image/jpeg', '500x375', 'photo4.jpg', '4bdbefb1164b0a47521b6dd01468c3fe_72c.jpg;4bdbefb1164b0a47521b6dd01468c3fe_200c.jpg', 176364, 'photo4', 1, '2014-09-06 04:19:41'),
(3, 'ja', 'ed6f384616b6100ee274e9d8192bd417', 'admin-3', 6, 'image/jpeg', '500x332', 'photo2.jpg', 'ed6f384616b6100ee274e9d8192bd417_72c.jpg;ed6f384616b6100ee274e9d8192bd417_200c.jpg', 114627, 'photo2', 1, '2014-09-06 04:19:41'),
(4, 'ja', 'e493ac1f543a58eaf9c32f2b32bf1744', 'admin-4', 8, 'image/jpeg', '500x375', 'photo3.jpg', 'e493ac1f543a58eaf9c32f2b32bf1744_72c.jpg;e493ac1f543a58eaf9c32f2b32bf1744_200c.jpg', 24636, 'photo3', 1, '2014-09-07 04:19:41'),
(5, 'ja', '44573b26ae8433ace381e1e40655aafb', 'admin-5', 10, 'image/jpeg', '500x375', 'photo32.jpg', '44573b26ae8433ace381e1e40655aafb_72c.jpg;44573b26ae8433ace381e1e40655aafb_200c.jpg', 144548, 'photo32', 1, '2014-09-07 04:19:41'),
(6, 'ja', '7bafcd7b880dc628b7617903a97d3c29', 'admin-6', 12, 'image/jpeg', '500x375', 'photo5.jpg', '7bafcd7b880dc628b7617903a97d3c29_72c.jpg;7bafcd7b880dc628b7617903a97d3c29_200c.jpg', 126648, 'photo5', 1, '2014-09-07 04:19:41'),
(7, 'ja', 'c44cb2b873c8c23406e15ca7fc5ba4aa', 'admin-7', 14, 'image/jpeg', '500x375', 'photo6.jpg', 'c44cb2b873c8c23406e15ca7fc5ba4aa_72c.jpg;c44cb2b873c8c23406e15ca7fc5ba4aa_200c.jpg', 62260, 'photo6', 1, '2014-09-07 04:19:41'),
(8, 'ja', '306271a5eb25dd6f111bc10a97a30fe6', 'admin-8', 16, 'image/jpeg', '500x333', 'photo7.jpg', '306271a5eb25dd6f111bc10a97a30fe6_72c.jpg;306271a5eb25dd6f111bc10a97a30fe6_200c.jpg', 60018, 'photo7', 1, '2014-09-07 04:19:41'),
(9, 'ja', '96aae09327a0358e03eebba3ed61f5fe', 'admin-9', 18, 'image/jpeg', '423x500', 'photo8.jpg', '96aae09327a0358e03eebba3ed61f5fe_72c.jpg;96aae09327a0358e03eebba3ed61f5fe_200c.jpg', 252215, 'photo8', 1, '2014-09-07 04:19:41'),
(10, 'ja', '78d044252061e1d9206ee43bcec87bfa', 'admin-10', 20, 'image/jpeg', '500x334', 'photo9.jpg', '78d044252061e1d9206ee43bcec87bfa_72c.jpg;78d044252061e1d9206ee43bcec87bfa_200c.jpg', 34684, 'photo9', 1, '2014-09-07 04:19:41'),
(11, 'ja', '424bc3e6801f42336f830e3a837621d0', 'admin-11', 22, 'image/jpeg', '500x281', 'photo10.jpg', '424bc3e6801f42336f830e3a837621d0_72c.jpg;424bc3e6801f42336f830e3a837621d0_200c.jpg', 59375, 'photo10', 1, '2014-09-07 04:19:41'),
(12, 'ja', 'e0242b40545f33eb1fb52bff37618c55', 'admin-12', 24, 'image/jpeg', '500x316', 'photo11.jpg', 'e0242b40545f33eb1fb52bff37618c55_72c.jpg;e0242b40545f33eb1fb52bff37618c55_200c.jpg', 100309, 'photo11', 1, '2014-09-07 04:19:41'),
(13, 'ja', '20a7beff0212523a4b35ea8dbc4b1b14', 'admin-13', 26, 'image/jpeg', '500x333', 'photo12.jpg', '20a7beff0212523a4b35ea8dbc4b1b14_72c.jpg;20a7beff0212523a4b35ea8dbc4b1b14_200c.jpg', 67322, 'photo12', 1, '2014-09-07 04:19:41'),
(14, 'ja', 'c81e3bc88f562632b9e201d0b521839b', 'admin-14', 28, 'image/jpeg', '500x334', 'photo13.jpg', 'c81e3bc88f562632b9e201d0b521839b_72c.jpg;c81e3bc88f562632b9e201d0b521839b_200c.jpg', 152155, 'photo13', 1, '2014-09-07 04:19:41'),
(15, 'ja', '2e028636585ae76f261f9647aa727211', 'admin-15', 30, 'image/jpeg', '500x333', 'photo14.jpg', '2e028636585ae76f261f9647aa727211_72c.jpg;2e028636585ae76f261f9647aa727211_200c.jpg', 94097, 'photo14', 1, '2014-09-07 04:19:41'),
(16, 'ja', '04c85f70f7b1803c2bf126512a91603e', 'admin-16', 32, 'image/jpeg', '500x335', 'photo15.jpg', '04c85f70f7b1803c2bf126512a91603e_72c.jpg;04c85f70f7b1803c2bf126512a91603e_200c.jpg', 77028, 'photo15', 1, '2014-09-07 04:19:41'),
(17, 'ja', '9647585c4c5100d944a3f313f9e26302', 'admin-17', 34, 'image/jpeg', '469x500', 'photo16.jpg', '9647585c4c5100d944a3f313f9e26302_72c.jpg;9647585c4c5100d944a3f313f9e26302_200c.jpg', 85154, 'photo16', 1, '2014-09-07 04:19:41'),
(18, 'ja', '2079366f4f45e3d8dabada2be4e16790', 'admin-18', 36, 'image/jpeg', '500x331', 'photo17.jpg', '2079366f4f45e3d8dabada2be4e16790_72c.jpg;2079366f4f45e3d8dabada2be4e16790_200c.jpg', 100902, 'photo17', 1, '2014-09-07 04:19:41'),
(19, 'ja', '2c9b11a97e4f0f8fff1a158e9f6a80a0', 'admin-19', 38, 'image/jpeg', '500x375', 'photo18.jpg', '2c9b11a97e4f0f8fff1a158e9f6a80a0_72c.jpg;2c9b11a97e4f0f8fff1a158e9f6a80a0_200c.jpg', 182109, 'photo18', 1, '2014-09-07 04:19:41'),
(20, 'ja', '26cf1eb0daa0051ba996647ef720d664', 'admin-20', 40, 'image/jpeg', '500x333', 'photo19.jpg', '26cf1eb0daa0051ba996647ef720d664_72c.jpg;26cf1eb0daa0051ba996647ef720d664_200c.jpg', 67722, 'photo19', 1, '2014-09-07 04:19:41'),
(21, 'ja', 'c3853594e88fa99ea07803279bacde35', 'admin-21', 42, 'image/jpeg', '500x357', 'photo20.jpg', 'c3853594e88fa99ea07803279bacde35_72c.jpg;c3853594e88fa99ea07803279bacde35_200c.jpg', 125392, 'photo20', 1, '2014-09-07 04:19:41'),
(22, 'ja', 'ff9d67ca49c52747ce33cbece4833256', 'admin-22', 44, 'image/jpeg', '500x333', 'photo21.jpg', 'ff9d67ca49c52747ce33cbece4833256_72c.jpg;ff9d67ca49c52747ce33cbece4833256_200c.jpg', 78057, 'photo21', 1, '2014-09-07 04:19:41'),
(23, 'ja', '1439108bb004b5b21914a63f421dadd3', 'admin-23', 46, 'image/jpeg', '500x334', 'photo22.jpg', '1439108bb004b5b21914a63f421dadd3_72c.jpg;1439108bb004b5b21914a63f421dadd3_200c.jpg', 97927, 'photo22', 1, '2014-09-07 04:19:41'),
(24, 'ja', 'd811023e08a36a61d22329a9dd8b5944', 'admin-24', 48, 'image/jpeg', '404x500', 'photo23.jpg', 'd811023e08a36a61d22329a9dd8b5944_72c.jpg;d811023e08a36a61d22329a9dd8b5944_200c.jpg', 84459, 'photo23', 1, '2014-09-08 04:19:41'),
(25, 'ja', 'e6cf10eaf23c7443061cb4333a38dcbb', 'admin-25', 50, 'image/jpeg', '500x423', 'photo24.jpg', 'e6cf10eaf23c7443061cb4333a38dcbb_72c.jpg;e6cf10eaf23c7443061cb4333a38dcbb_200c.jpg', 122249, 'photo24', 1, '2014-09-08 04:19:41'),
(26, 'ja', 'e2426af21b3421843e19f75a02d652a3', 'admin-26', 52, 'image/jpeg', '500x455', 'photo25.jpg', 'e2426af21b3421843e19f75a02d652a3_72c.jpg;e2426af21b3421843e19f75a02d652a3_200c.jpg', 48106, 'photo25', 1, '2014-09-08 04:19:41'),
(27, 'ja', 'ca576401c06bef2714c087c7a9a59b51', 'admin-27', 54, 'image/jpeg', '333x500', 'photo26.jpg', 'ca576401c06bef2714c087c7a9a59b51_72c.jpg;ca576401c06bef2714c087c7a9a59b51_200c.jpg', 76663, 'photo26', 1, '2014-09-08 04:19:41'),
(28, 'ja', '2ec5470ed844423fd69b5cc538ecb8de', 'admin-28', 56, 'image/jpeg', '362x500', 'photo27.jpg', '2ec5470ed844423fd69b5cc538ecb8de_72c.jpg;2ec5470ed844423fd69b5cc538ecb8de_200c.jpg', 73978, 'photo27', 1, '2014-09-08 04:19:41'),
(29, 'ja', 'a1364dfb48c1dc3b7a58b0594b39e39c', 'admin-29', 58, 'image/jpeg', '500x333', 'photo28.jpg', 'a1364dfb48c1dc3b7a58b0594b39e39c_72c.jpg;a1364dfb48c1dc3b7a58b0594b39e39c_200c.jpg', 68743, 'photo28', 1, '2014-09-08 04:19:41'),
(30, 'ja', '71158a0b7bd4804be14f09b0ee34883a', 'admin-30', 60, 'image/jpeg', '500x323', 'photo29.jpg', '71158a0b7bd4804be14f09b0ee34883a_72c.jpg;71158a0b7bd4804be14f09b0ee34883a_200c.jpg', 52001, 'photo29', 1, '2014-09-08 04:19:41'),
(31, 'ja', '9e46d5fac07613c7f9b8e50c960f66c4', 'admin-31', 62, 'image/jpeg', '500x334', 'photo30.jpg', '9e46d5fac07613c7f9b8e50c960f66c4_72c.jpg;9e46d5fac07613c7f9b8e50c960f66c4_200c.jpg', 73248, 'photo30', 1, '2014-09-08 04:19:41'),
(32, 'ja', 'b9367e2742e88e332c15d58dbc493653', 'admin-32', 64, 'image/jpeg', '500x375', 'photo31.jpg', 'b9367e2742e88e332c15d58dbc493653_72c.jpg;b9367e2742e88e332c15d58dbc493653_200c.jpg', 62752, 'photo31', 1, '2014-09-08 04:19:41');

TRUNCATE TABLE photo_config;
INSERT INTO photo_config
(hg_id,                     hg_value,           hg_name,                                  hg_index) VALUES
('image_protect_copyright',       '1',                '画像著作権保護',                             1),
('upload_image_max_size',   '500K',             'アップロード画像の最大サイズ(バイト数)', 2),
('watermark_filename',      'default_mark.jpg', 'セキュリティ保護画像ファイル名',         3),
('default_image_size',      '450',              '公開画像デフォルトサイズ',               4),
('default_thumbnail_size',  '128',              'サムネール画像デフォルトサイズ',         5),
('thumbnail_bg_color',      '#FFFFFF',              'サムネール画像背景色',         6),
('thumbnail_type',          '0',              'サムネールタイプ',         7),
('image_category_count',  '2',                '画像カテゴリー数',         8),
('photo_list_item_count',  '24',                '画像一覧表示項目数',         9),
('photo_list_order',        '0',         '画像一覧表示順',                         10),
('photo_title_short_length',  '10',                '画像タイトル(略式)文字数',         11),
('photo_category_password', '0',                '画像カテゴリーのパスワード制限',             12),
('thumbnail_crop',      '1',                'サムネール画像切り取り',         13),
('image_size',          '450',              '公開画像サイズ',               14),
('thumbnail_size',      '128',              'サムネール画像サイズ',         15),
('image_quality',       '100',              '画像の品質',                   16),
('photo_list_sort_key', 'index',            '画像一覧のソートキー',         17),
('s:photo_list_item_count',  '24',                '画像一覧表示項目数',         200),
('s:photo_list_order',        '1',         '画像一覧表示順',                         201),
('s:photo_title_short_length',  '7',                '画像タイトル(略式)文字数',         202),
('s:photo_list_sort_key', 'index',            '画像一覧のソートキー',         203),
('s:default_image_size',      '320',              '公開画像デフォルトサイズ',               204),
('s:default_thumbnail_size',  '128',              'サムネール画像デフォルトサイズ',         205),
('html_photo_description',  '0',                'HTML形式の画像情報(説明)',         0),
('use_photo_date',        '1',                '画像情報(撮影日)を使用',         0),
('use_photo_location',       '1',                '画像情報(撮影場所)を使用',         0),
('use_photo_camera',      '1',                '画像情報(カメラ)を使用',         0),
('use_photo_description', '1',                '画像情報(説明)を使用',         0),
('use_photo_keyword',     '1',                '画像情報(検索キーワード)を使用',         0),
('use_photo_category',    '1',                '画像情報(カテゴリー)を使用',         0),
('use_photo_rate',    '1',                '画像情報(評価)を使用',         0),
('layout_view_detail',   '<table class="photo_info table"><caption>画像情報</caption><tbody><tr><th>ID</th><td>[#CT_ID#]</td></tr><tr><th>タイトル</th><td>[#CT_TITLE#]&nbsp;[#PERMALINK#]</td></tr><tr><th>撮影者</th><td>[#CT_AUTHOR#]</td></tr><tr><th>撮影日</th><td>[#CT_DATE#]</td></tr><tr><th>場所</th><td>[#CT_LOCATION#]</td></tr><tr><th>カメラ</th><td>[#CT_CAMERA#]</td></tr><tr><th>説明</th><td>[#CT_DESCRIPTION#]</td></tr><tr><th>カテゴリー</th><td>[#CT_CATEGORY#]</td></tr><tr><th>キーワード</th><td>[#CT_KEYWORD#]</td></tr><tr><th>評価</th><td>[#RATE#]</td></tr></tbody></table>', 'レイアウト(詳細表示)',               0),
('output_head',      '0', 'HTMLヘッダ出力', 0),
('head_view_detail',   '<meta property="og:type" content="article" /><meta property="og:title" content="[#CT_TITLE#]" /><meta property="og:url" content="[#CT_URL#]" /><meta property="og:image" content="[#CT_IMAGE#]" /><meta property="og:description" content="[#CT_SUMMARY#]" /><meta property="og:site_name" content="[#SITE_NAME#]" />', 'ヘッダ出力(詳細表示)',               0);

