-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.7.19 - MySQL Community Server (GPL)
-- Операционная система:         Win64
-- HeidiSQL Версия:              9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Дамп структуры базы данных pool
CREATE DATABASE IF NOT EXISTS `pool` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `pool`;

-- Дамп структуры для таблица pool.bulks
CREATE TABLE IF NOT EXISTS `bulks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_id` int(11) NOT NULL,
  `type` varchar(300) NOT NULL,
  `line` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bulks_files` (`file_id`),
  CONSTRAINT `FK_bulks_files` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы pool.bulks: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `bulks` DISABLE KEYS */;
INSERT INTO `bulks` (`id`, `file_id`, `type`, `line`) VALUES
	(44, 747, 'com.samsung.health.exercise', 'time_offset,max_rpm,live_data,mean_rpm,distance,max_caloricburn_rate,additional,altitude_gain,deviceuuid,duration,update_time,datauuid,location_data,decline_distance,altitude_loss,mean_caloricburn_rate,incline_distance,max_altitude,max_cadence,create_time,mean_speed,mean_heart_rate,count_type,custom,end_time,count,min_altitude,max_speed,exercise_type,pkg_name,start_time,max_power,mean_power,min_heart_rate,calorie,comment,max_heart_rate,exercise_custom_type,mean_cadence');
/*!40000 ALTER TABLE `bulks` ENABLE KEYS */;

-- Дамп структуры для таблица pool.exercises
CREATE TABLE IF NOT EXISTS `exercises` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bulk_id` int(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `duration` float DEFAULT NULL,
  `distance` float DEFAULT NULL,
  `mean_tempo` float DEFAULT NULL,
  `max_tempo` float DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL,
  `live_data` blob,
  `addl_data` blob,
  `length_type` int(4) DEFAULT NULL,
  `fists` int(1) DEFAULT NULL,
  `scapula` int(1) DEFAULT NULL,
  `flippers` int(1) DEFAULT NULL,
  `hand_w` int(1) DEFAULT NULL,
  `foot_w` int(1) DEFAULT NULL,
  `kolobashka` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_exercise_my_bulk` (`bulk_id`),
  CONSTRAINT `FK_exercise_my_bulk` FOREIGN KEY (`bulk_id`) REFERENCES `bulks` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы pool.exercises: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `exercises` DISABLE KEYS */;
INSERT INTO `exercises` (`id`, `bulk_id`, `start_time`, `end_time`, `duration`, `distance`, `mean_tempo`, `max_tempo`, `comment`, `live_data`, `addl_data`, `length_type`, `fists`, `scapula`, `flippers`, `hand_w`, `foot_w`, `kolobashka`) VALUES
	(1, 44, '2018-03-28 21:26:39', '2018-03-28 21:27:33', 51.02, 0, 0, 0, NULL, _binary 0x1F8B08000000000000008BAE564A4ECCC92FCA4C55B232D033D0514AC92C2E49CC4B8671819CA292F892CC5CA080A1A9919191B991B1A5A599A165AD0E924E53E2749A981A9A9919A1E824D24E1353632303B3DA5800F3F10DCDAF000000, NULL, NULL, 0, 0, 0, 0, 0, 0),
	(2, 44, '2018-03-28 21:38:34', '2018-03-28 21:39:23', 23.449, 25, 93.796, 93.796, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B08000000000000005DCECD0AC2300C07F05709397B51EB418FBE8648095BD0624D469B0A32F6EEB69B287ACC2F1FFF8C8091E562D78C7080138C807D496441A5C166EBDC7E0518C4383D28365BD73A5BD21BFB4E8B5833F7357B0EDC088F8929DBA208139CEBCCA01AFD12389FDFFD9A2F12E67B78E71A88B56B6A147D1FB29174FC597AF3FFAB30BD0079959AA1D1000000, NULL, 0, 0, 0, 0, 0, 0),
	(3, 44, '2018-03-29 16:40:13', '2018-03-29 16:47:30', 430.179, 250, 172.072, 161.84, NULL, _binary 0x1F8B08000000000000007DCD310E80200C40D1AB34CC0C2D2005AF628C6120D1C105BB19EF2EBAA2CC3F2F7F8213D421A9C822DB9E158C408331D691778CDE6A506B7E6A49F2D68070E97FC4EE0BC5D0436C2BE20611DAAE8A0EB95D11C69E0A9190B1555415CC379D2B024D0E010000, _binary 0x1F8B0800000000000000B593CD0A83300C805F25F4ECA1ADFF3BEE35C62845CB26EBDA51E36088EFBEAA07915D4A99C77C49BE844046205A991BDE7B0227B8C008A41D9CC4CE9A19649C574502A433A8DC5BEA99311FF7E8EC4389C60E0617966F103F2F353372764AF6B8520253F2234F694543E4FC48791A2367390F92D3A8CD59983C8BDABC3CF0E6BCC882E42C464EB3E23839ABC26E1E23CF695AA77F92C3D5D7BCACD5627DDBB986E77B2606D32D42F2547E22F159B428B568BB1EA569D4DA4437BEFF1B56D6307D01451F6C8D19040000, NULL, 0, 0, 0, 0, 0, 0),
	(4, 44, '2018-03-29 16:48:13', '2018-03-29 16:51:26', 179.16, 100, 166.782, 155.448, NULL, _binary 0x1F8B08000000000000008B56A856502A2E492C2A892FC9CC4D5552B05230343532323631323432353033D65150CA4805C916259680652D8C156A75706B3235C1A6C9D0C0129F2E23434B43534B4C5D86405D0AB1004E2BA8ADA3000000, _binary 0x1F8B0800000000000000B590410AC2301045AF3264DD451335B61EC04B8884D00E1A8C4949A64229BDBB895D545D29E872DE7CDE1F660466D19DE81C19ECE00023B0B60F9A8C7719ACAA4A8A02987184E1A66D663CCD9182BFA06A7CEF28B37A6134749811DB07C448834DD354BC8BD742C8F203312FBF37CBEA5FE6FA376638A640E7BD55F3EF73406C5E99EA9D79D8D815531D4B5BF2A4AD6A4D24ED1A9C9BCA853F5DCAB73597254C77926F941FDE010000, NULL, 0, 0, 0, 0, 0, 0),
	(5, 44, '2018-03-29 16:52:11', '2018-03-29 17:04:52', 404.309, 150, 164.108, 142.248, NULL, _binary 0x1F8B08000000000000007DD0BD0EC2300C04E057B13277F0C53F49781554A10E95DA81A56443BC3B20C606CFA74FBEF3959E941E7D39FAADEFF735D18560398B6629C65A274ADBFA4D8FA5FFD20C7A4DFF55C3504122A59559F5A46A899001EC7E3EC52D54C59A0D0A7258D0050A0C9446AABA9BCBE0199F5D34BF01964F3D587B010000, _binary 0x1F8B080000000000000095924D0AC3201046AF22AEB35013D39F03F412A58824D24AAD069D1442C8DDABE922A49BEA72DE0C6F3E86991136CADEE111303AA32B9A11EE472F413B9B40CD79CB2A84B505E5DFD22446631DC0BBA7129D1B2DAC8C6C10A64125862F5EA9009389D552FD9A9B86B524C7CC8ACDB43E6699CB339303CB32D36233E379E6F2CC3433F33F33BAC581C13923BE0F930618DF33315ABDDAF04BC5753876C18134A2D701A4ED562BE564E3BBEB363539A1E5034732F17193020000, NULL, 0, 0, 0, 0, 0, 0),
	(6, 44, '2018-03-29 17:05:56', '2018-03-29 17:11:33', 332.19, 150, 215.165, 188.432, NULL, _binary 0x1F8B08000000000000007DCE3B0A80301045D1AD0CA92D329FCC246E45442C042D6C349DB8773F6D34F5E5F05E0707B83D8F5B1EF2B24E0E5AC040C4C268D11B36E0E6E9A9DB98DF1A039CCD2F22454E5A20932A32FB5C4A35C4AC494A84BEFA4F58BD840FC5551595894A45B782FE024709E09543010000, _binary 0x1F8B0800000000000000B592410AC2301045AF3264DD45D234B4BAF41A2221B441436322ED5490D2BB9BB48BAA1B53C1655E86379FCF8C40AC7667BCF404F67084114833740A8D77111425A35506C438D4DD5DD9C85878F7D8F956CBDA0F0E67C657888F9B8E8C1C54DD2E8CC0947DAA0515154D518BED6ACED2D4C50FA9F37FA52E2A4193D4DBBB2E394B537F2D044E61E2E6BD95CBD9C4895CBC33393833EBC855877D24FCA2476565637A54AED64B4174E52F5139CFD98EC2F40480F3C8B199020000, NULL, 0, 0, 0, 0, 0, 0),
	(7, 44, '2018-03-29 17:13:05', '2018-03-29 17:19:12', 363.839, 200, 163.625, 70.68, NULL, _binary 0x1F8B080000000000000095CE3B0A83401485E1AD5CA6B6B8EFB9BA1509C142D0228D992EB8F728964E0652FF7C9C33C207D2BB4C5B7996F5352718808C59542C8C7AEC202DF359B7A95C9502F6EEA7F2ECA85E51DE52190F2577C5DC5461A87A57925B2AD811A3B2D556713CE47F55AF264E1545B0C3E30B3BC39CA17C010000, _binary 0x1F8B0800000000000000B5924D0AC2301046AF12B2EE226DFA170FE02544426983066322C95428A57737A98BAA1B13C1E5BC19DE0C1F3323AC843EC1D961B4430734233C8CB6036974007953372443586A10F6DEA995F9DA813517C17B336A08ACDA184C371110DE5B211C4CCA574BF6292E292D63C479916AA64DDD469949F2CD84FCCB5CB03873721A258BBCF9879C699C394F35578CC4FDC637333AFA819B318A3F7F3C0C14D53BE3A396AB0D5F855F877D170C748A0FD241A7FBD55A10B2F1D70C6ADA52869607CB13017346030000, NULL, 0, 0, 0, 0, 0, 0),
	(8, 44, '2018-03-29 17:20:01', '2018-03-29 17:26:22', 376.05, 200, 179.382, 79.776, NULL, _binary 0x1F8B08000000000000008B56A856502A2E492C2A892FC9CC4D5552B05230343532323631313034363035D05150CA4805C91625968065CD2C156A75706B323336B230C7D064698E4F93A1B93190C2D064686481579785A19121A6FB0C8D8C156A1562017728A6E7D8000000, _binary 0x1F8B0800000000000000B5D2DF0A83201406F0573978DD459666ED72AF314648C9166B1A7A1A8CE8DD6735D89F9B89B04B3F0F3F0F1F4E407AA54F78760476708009483B5A899DD14B40AB8AB10448A751D99BECD7CC9F1D5A73517563468D4BC65E19DE07B544646F9574B8A504E6E4DB66396769804DF318BC6469082E226C9E5741364DA35A298B10BC8CB14511645751858BBFD93C136185D3DF381CFDCC604C5F6FFF7E99C9F867568FBA5B417255FE45E26FD1A0ECEBB6732875B3C2D9BAD2337F5B36F73DF014E60756BAD6055A030000, NULL, 0, 0, 0, 0, 0, 0),
	(9, 44, '2018-03-29 17:27:04', '2018-03-29 17:30:05', 176.85, 100, 158.407, 128.188, NULL, _binary 0x1F8B08000000000000008B56A856502A2E492C2A892FC9CC4D5552B0523034353232360102630353631D05A58C54906C51620958D6D250A15607B7260B530333234C4D16F834991918981B5B626832343151A8558805001E366622A2000000, _binary 0x1F8B0800000000000000AD904B0AC2301086AF3264DD45D2A60F3D80971009A10D1A8C4949A64229BDBB49157CAC5A7039DF0CDFFC331310A3EC192F81C01E8E3001E9062F513B9B4091535E6740B445E5EFD224C6621DD0BBAB12AD1B2C26B67B331C7B95103978A5028E265673F62BE6ACCCE90A31635BCD4553D335E6ED912BC6FF12194E71A077CE88E7EBD3405E7E333158BDD8C84DC5752476D1A134A2D301A56D172B5B0E7DF18FA4ACAE9A92C2FC0090F84F53DD010000, NULL, 0, 0, 0, 0, 0, 0),
	(10, 44, '2018-03-30 16:32:01', '2018-03-30 16:40:10', 238.019, 50, 171.788, 147.336, 'На кулака', _binary 0x1F8B080000000000000085CB3B0E80200C00D0AB34CC0C504A5ABC8A318681440717EC66B8BBD1153FF3CB1BE100B36BAE3AEBBA150303F88848C89182E364C12CE5D29AF55649D0EC7B1274445DF22E7CAD442482FDA29FC522FCB03C34984E8A0E45E8D9000000, _binary 0x1F8B08000000000000008D8F410E82301045AF3299358B42818007F012C6340D34DA585BD24E4D08E1EEB6B810DDE8F2BFF97933B3001A652F740D080738C10238462F493B9B016F3B5E1780DA92F20F69322B530EE4DD4D89C1454B1BDB419A2795191EBD52816693D25A7C9BEB9EB5EC1F33FF6186732A4CCE19F17A2417AAE6938968F566C3BB4AEB304DC9913462D481A41D366BC3DE787768C53B56F6B03E019D2748252A010000, NULL, 0, 0, 0, 0, 0, 0),
	(11, 44, '2018-03-30 16:40:36', '2018-03-30 17:14:54', 715.49, 200, 159.971, 133.608, NULL, _binary 0x1F8B08000000000000007DD23D0EC2300C05E0AB589D3BF8278E63AE822AD4A1120C2C251BEADD29628CF16C7DF2F393AFF086E9D5D7BDDFFAE3B94D700152E6C20DC5C86C86E9BE7DA7FBDA7F533638E6FFCA0D55025532456A5822A5996232B4362A6AA9B2DA3C529829A9674A1A154AAA3C4E889CA9A2A1F2B4C266AEC403B2AC0B97B375AB63BE9AAD7221895576951B1346FF541D0E583E96E699B488020000, _binary 0x1F8B0800000000000000B592D10A832014865F45BCEEC2CA5AED72177B8931444AB698D3D0D320A2779FD6601B0B66175DFA79F8FCF93D03C252A80B5C2D467B744203C2756738345A7990A6942411C28D02611E5C7A16BBB305A36F8255BA53E059F966D0B7C2237C344258E8A53B8DD18FB848080910C764B5B924F936669ABB3642CCF182F96004B730D3C5D834DDA8104AF3B0D8C9EAAAB3C042D6672EF2B04F4CFF578DCE6EA6D55AB279D3FD4C927D33D6A96612E2BB702F62770B1AB864756381AB6A12CF1BFBE21F617771464B82C6276E9FCEAB4C030000, NULL, 0, 0, 0, 0, 0, 0),
	(12, 44, '2018-03-30 17:16:47', '2018-03-30 17:25:18', 505.929, 0, 0, 0, NULL, _binary 0x1F8B080000000000000095D0B10EC2300C04D05FB13277383B71ECF22B08A10E95606029D950FF9DC29A6089F9F4E43B9FE945E9D996AD5DDBFDB1263A11AB48C91071384F946EEB27DD96F64D67A17DFA89B200263DE218F9105988FC40D621E6F05429C3518C7095C2A1DA17F4105547C5BF05EBF1411DCCCAE1330C6CEE0335D34E9737953D5A02E4010000, _binary 0x1F8B080000000000000055C9310A80300C00C0AF84CC0EA5D041BF22528A062DD444DA7412FFAEC5415CEF4EC044BCEA5610061861EA000F91E45F6D68DDDF7CE5A82D7027A58CCFAA68487E894503CFD4CE7C5A73D028DCD419D7DB1EAE1B7E46B1E976000000, NULL, 0, 0, 0, 0, 0, 0),
	(13, 44, '2018-03-30 17:25:34', '2018-03-30 17:29:10', 203.98, 100, 203.979, 186.96, NULL, _binary 0x1F8B08000000000000008B56A856502A2E492C2A892FC9CC4D5552B05230343532323136303731343630D25150CA4805C916259640640DCC146A7570EAB23031313331C5D065815F93A9A981A51986264B737C9A2C0D2D81BA30DD6768A050AB100B00A7BDAD9BD8000000, _binary 0x1F8B0800000000000000B591CF0AC2300C875F25E4BC4357F7A77AF435444AD98A16673BDA4C90B177B7DD0E534F227ACC971F5F42320276DA9EE81C1076708011B01DBC22E36C0225AB589D011A4BDADF5497581EEB40DE5DB46CDC6029B17A6574EF7542B8F75A055A28C294BDBB8BAA2ED8076EF18D5B70FE2F77298A9CFFE626708C99DEB94E2E4F48195EBE32395833FBF0AAE3408C5D72A43AD99A40CA36B338676CE54FBB72B6D90A06D30361483BC1E7010000, NULL, 0, 0, 0, 0, 0, 0),
	(14, 44, '2018-03-31 16:32:20', '2018-03-31 16:59:31', 475.849, 275, 147.253, 98.268, 'В ластах', _binary 0x1F8B08000000000000007DD0310EC3300805D0AB20CF190003C6BD4A15551922254397D45B95BB37ED6A9785E5EBE9EB738737A4575B8EF668FB734D70035266A55C8D056D82B4ADDFF458DA2FF50AE7F40F0992E6AA1DAA1CA2A296BD438412295213A581B24871C66B5BAF28ECCA48C83C501A28257454EC9578A4AEE336F8462970C2FC01072E3196B0010000, _binary 0x1F8B0800000000000000B593CD6A032114465F455C67117FEEA85D769197286590E4D20EB51AF44E2184BC7B9D9945DA52E84CC1E53DCAF1E3F279653C607CA1D7C2D9037B6257C64F63F634A4380105D6C81DE34324CC1F3E4C4CD4B9504E6FD81FD3186962EECEE872C609F143462C740975BAED7E8AA586CE34113BEBDC0AB1DD2A567B2BF72BC4667B6250AAC92A8CD15D0B3118219AAC4259D9A615BA33F2BF3D7ECCE80B2DF4D7D0CE815DE19E57B62DB5D620D698C5DFB1D973BD734E29F4CB7F9F0B02DF593FC66116F277AC2FF27A4A897CE84F43211F8FB8B40AEEFC6B5803563B76FB0417E37F5E52040000, NULL, 0, 0, 0, 0, 0, 0),
	(15, 44, '2018-04-01 15:23:49', '2018-04-01 15:32:26', 303.839, 200, 146.121, 130.696, 'На кулаках', _binary 0x1F8B08000000000000007DCFB10E80200C04D05F69981DDA4241FC15630C03890E2EC866FC77D11564BEBCDCDD0C17A8338794D7BC1F51C10424CCE22D6B241A07505B7CD314F2973A817BF8471E51638588B0A70C5A727515B1EB296B44501A4A775531DC58C8DC538ED078DF50E5172C0FFF28FA3545010000, _binary 0x1F8B0800000000000000B592C10A83300C865FA5F4ECA16D6AD53DC05E620C112D5B59D70E8D0311DF7DAD3BB8EDA4308FF912BEFC848C845AED2E78ED2839901319096DFAB642E35D0420542613428D43DD3E2B1B190F7587ADBFE9B2F6BDC3C88A85E1F0D011D163AB7587830DD594FC8AA504C55688396C3583E490EF1299E59CAF89CCB7474EE54E66A5561D838BCDE6344BC53E660091FDE335C8390C3CBCB7E5FBC5E38048BF59D93B33DBE85D87753474D16365CBC67458B97AB60AC616FE9994410E05995E151FA88E45030000, NULL, 0, 0, 0, 0, 0, 0),
	(17, 44, '2018-04-02 06:27:20', '2018-04-02 06:38:25', 664.757, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(18, 44, '2018-04-02 18:27:50', '2018-04-02 18:41:26', 816.048, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(19, 44, '2018-04-03 07:59:40', '2018-04-03 08:09:40', 600, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(20, 44, '2018-04-03 19:40:00', '2018-04-03 20:10:00', 1800, 0, 0, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0),
	(21, 44, '2018-04-04 09:06:47', '2018-04-04 09:16:47', 600.552, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(23, 44, '2018-04-04 18:11:58', '2018-04-04 18:29:37', 1059.22, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(24, 44, '2018-04-05 05:54:16', '2018-04-05 06:17:05', 1368.85, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(25, 44, '2018-04-05 06:19:16', '2018-04-05 06:30:48', 692.546, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(26, 44, '2018-04-05 06:42:42', '2018-04-05 06:58:52', 969.464, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(27, 44, '2018-04-05 16:46:43', '2018-04-05 17:01:20', 877.576, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(28, 44, '2018-04-06 09:23:22', '2018-04-06 09:38:07', 884.992, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(29, 44, '2018-04-06 11:43:53', '2018-04-06 12:14:06', 1812.91, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(30, 44, '2018-04-07 07:56:04', '2018-04-07 09:18:43', 1264.37, 725, 170.323, 112.24, NULL, _binary 0x1F8B080000000000000095D43B6E03310C04D0AB085BBBE057247395C0085C18B08B34CE7641EE1E39EDD203A4161E341CEEEA7D7C8FED6BBF3CF68FFDFE79DDC6DB6017A58CC8A059A7B1DDAECFD3C765FF3BCD397E4E2F518A331F113321553E43F3A84CA05A28ECA834814A25AFD026A143259CD92464943035D9BC518ADA488FA26C3A2498705AC5A446155221A1DAED0BCEB53E0D2169142395334D9BE6255EAB5AF945BA3650C2A73269F7A548B11BC5FC5F87C5C25AC6CD5C065518CD26A1C0B9746DCB9B2DE33656BE762E7C97AD36ACD91781FFABD859D7BBD1A8D5FC38FF020D1AE2C86F040000, _binary 0x1F8B0800000000000000B596CB6AC33010457F45689D851E238DD56517D9F50B4A312616ADA96B075B290D21FF5EC729F4818847A25EE6C63EBE5C691E27C65BDF3D879791B33BF6C84E8CD787A10A4DDF5D042814161BC69B2EF8E1BD6A2F9A9C7E8F61E85F7DB9EB0F5D9835F52D86E3DE5F347E3FF86A0C5795B3F3E62F5C3BA704052E73E0565A123CCBF9948B5C0B0ECAA023C031C2DE0EDE8FE1D846C1AAB0A4486C04FCD07CF83A0E15D9D09B6E351A8704B04B0583D04A510E4FA45B06B0AB58D612756EA5DCB6ECB4A3DCE464CBBA1086D439D22D5BC4552C83547625CBCE084A4967A4AC35A5FAD2C1888672E38AF4D393865223E9218310A47112CB627954216D54C57AC662C37742521A528E7104B3A2718482028F5D9245E31268F33B6B39708A04CF49DC18248592651C0C8A158FD3C27FAD4CEC697A66DFF76D795D2FE755C1FCD6CA43D7CC40FEE6A72FF2E9DFD087AA2DEB660C55B79BC138BFF5A5FF303BF56AD0D6B1F3270D46E48BC20A0000, NULL, 0, 0, 0, 0, 0, 0),
	(31, 44, '2018-04-07 11:13:10', '2018-04-07 11:28:15', 904.542, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(32, 44, '2018-04-07 14:43:12', '2018-04-07 15:26:12', 2580.29, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(33, 44, '2018-04-07 15:28:12', '2018-04-07 15:48:40', 1228.04, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(34, 44, '2018-04-07 15:50:35', '2018-04-07 16:17:18', 1602.84, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(35, 44, '2018-04-07 16:26:22', '2018-04-07 16:58:25', 1922.89, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(36, 44, '2018-04-08 15:15:30', '2018-04-08 15:24:34', 298.089, 200, 149.043, 137.356, NULL, _binary 0x1F8B08000000000000007DCB310E80200C00C0AF34CC0E2D5868FD8A3186814407176433FCDDE88A325F6E860BCC59622E6BD98F64600262EB2C2233A2D200664B8FE6585E15853AFC274576DA2422DF5B012DABFF58A1B7C40BA3B46B24A8B0DC54BE7A7FD9000000, _binary 0x1F8B0800000000000000B5924B0EC2201086AF425877C1A3F4E101BC84314DD3122522183A35699ADE5DA88BAA1B61D1E57C4C3EFECCCC8CB096E602D701A3033AA119E17E742D286B02C819A32243581990EED9EAC0A8AF0770F6269BCE8E0656C63708D34306868F4ECA0126EDAB25FB35F39216798C99259B85A8A3CC34DD5C9551D348CF5C7146F6C99C735EC79849B2B9C8C55ED3A02C6A83FFAE0E9D7DC3C35ADDBC8F3C3430F1CD9AD1A8D586EFD27F87FD2B586875D3AB015AD3AD5646C8C63F92B2BA22558D9617557AB29A47030000, NULL, 0, 0, 0, 0, 0, 0),
	(37, 44, '2018-04-08 15:30:53', '2018-04-08 15:32:10', 26.439, 25, 105.756, 105.756, 'Спринт', _binary 0x1F8B08000000000000008B56A856502A2E492C2A892FC9CC4D5552B052303435323632303431B7343136D15150CA4805C916259640640D0C146A1562016EB5801F38000000, _binary 0x1F8B08000000000000005DCE5D0AC2300C07F0AB843CFBA24E410FE025444AD9C256ACC968D3C118BBBB6D15451FF3CBC73F0BA027EE75880867B8C202D8A560D50917D81D9BFD6903E858294CD617DBE63A6A903B9956126BB5E68B3A8F540C2F8128EAEC73B5C22D0F8C22DEBCE2EAF1C3AF99C4AE5EC307E538CC5D15B5DE742EAAE5963E4B6FFE7F14D6272BD19D01CF000000, NULL, 0, 0, 0, 0, 0, 0),
	(38, 44, '2018-04-08 15:32:56', '2018-04-08 15:34:03', 39.66, 25, 135.748, 135.748, 'Спринт', _binary 0x1F8B08000000000000008B56A856502A2E492C2A892FC9CC4D5552B05230343532363230343334B23437D75150CA4805C916259680652D4D146A1562018829F5D037000000, _binary 0x1F8B080000000000000055CEDB0AC2300C06E05709B9F642379CCC07F025444AD982166B32DA7430C6DEDD768A87CB7C39FC99013DF1556F11E108679801FB14AC3AE10275DDD6870DA063A5305A5F6C97EBA841EE643A49ACAB555FD469A062780A4451279FAB052E796010F1E6155706AAFDBF99C46EBD860FCA7198BB2A6ABDE95D54CB1D7D96DEFCFB68DB345B589E1DF94717CF000000, NULL, 0, 0, 0, 0, 0, 0),
	(39, 44, '2018-04-08 15:35:20', '2018-04-08 16:21:56', 1405.06, 1000, 140.505, 124.804, 'Полная координация', _binary 0x1F8B080000000000000095943D6A43410C84AFB2BCDA85FE57CA5582092E0C7691C6795DC8DDB326E553060C0B5B2C1FA31949FB3EBEC7F6B55F1EFBC77EFFBC6EE36DB08B0AF134CAA0D3D86ED7E7EBE3B2FFBD128F9FD3FF549294345421AA6C9D7C91122299FCAA962C6C5D0DA5885A6188EB91D28494537853A113A29C6A663594202A664DE523251351E959E9478AA1AFE2CCB28642BE9422391A5F84B454C2BCD12A282519AC4D93190DAFAAF96A5813210A5E9DBDAA8910DBF219968D161C439D5236BB081D51A51ADEAC97215F46ECD6AD7218A25843AC1B43E46BADBF7BF7D930F265B62AEC465E5197CDE6B2D5ACF2B3C271FE051A015AD411050000, _binary 0x1F8B0800000000000000B557D16AC42010FC15F1F91E74D58DF603FA13A58470276D686A8EC4148EE3FEBD2657684B1FBA06F6D155C66532336EAE420E31BDE4D7598A07F124AE429E96A9CBFD98D68231C1E041C83EE5387D74C35AD3653DE7697C8BED715C52DE6AF05DCC97735C6BF2718A71CE97A1AC6E873FC8CE826242463014645D8FEC95E341361A99D840DB589E9EBD099A82ACAA912DD2B451DFB30DDAF3F06CB565EA19956742F600814975BE61728A53346DD4ABCE6BCBE41413024975F53DA3A3A9AE1AD92AEF49EEAE67033050DE94B043CE5C16B4C1929E94FA0F589CC214A268B88C621098E4AC4151D8A8974663987C621C7812193B44E70D306568C3357B159A1B26368026BA1D79E415131BE09029435768AED98B8D8D12494C6CA0A6A8AE3E362CF145D9316C38AEA1AE4883141BFFF52C9ECB81F3380EEDFD0F713D00EE77AD5D52BFA1C9F758AE9365378FB91BDA533FE72E1DE3FDA64D515F1B3F5A2D13B3532E88DB27E796D302860E0000, NULL, 0, 0, 0, 0, 0, 0),
	(40, 44, '2018-04-08 16:24:21', '2018-04-08 16:27:58', 143.78, 100, 143.778, 135.32, NULL, _binary 0x1F8B08000000000000008B56A856502A2E492C2A892FC9CC4D5552B0523034353236323031B330343733D15150CA4805C916259680652D8C146A75706A323732343534C2D064698A4F938589A98925A64D8686960AB50AB100FDDE128CA2000000, _binary 0x1F8B0800000000000000B591C10AC2300C865F25E4BC436BA7DB3CFA1A22A56C458BB595361364ECDD6DB7C3142F227ACC97F0E50F1900AD76473A45842DEC6100ECFAA0C8789781A89A5A1480C6910E376533E3A98E14FC59CBD6F78E26C61648F7ABCE0C7741AB483345188B3779D9F0CD2772FE8DBC6265F3B7E4A216EC47C9E19066AEDE5B393F22CFACD6AF4CF6CE4C42BCE8B41153973C292B3B1349B956CF97B0853F85E5A5A86A06E30360CC0961EB010000, NULL, 0, 0, 0, 0, 0, 0),
	(41, 44, '2018-04-08 16:43:06', '2018-04-08 17:02:02', 599.63, 400, 149.905, 132.296, 'Колобашка', _binary 0x1F8B08000000000000007DCF3D0EC3300886E1AB20CF190003C6BD4A15551922B54397D45BD5BBF7673565FEF48897333CA13CC6768CCBB8DDF7022720E5CAA88E6CAE0B94EBFE5D8F6DFC5627782DFF9118914C889033D50D9123A5893242EA9D6745982966A2560395FD65EC64181456C9949009F75971AAD4CCBD05AA67CA9AB845B752E52A352AB44F21AC6FE6D51F081D020000, _binary 0x1F8B0800000000000000B5944D6AC3301085AF22B4CE62C6A31FAB07E8254A312611ADA92A057B5C082177AFEC2C12E846826AA94FC3D3E3E9315721838F1FFCB948F122DEC455C8D33A8F3CA5B801EA49AB839053643FFF8C616398CF0BCFE9CB0FC7B446DE59F7807C39FB8DC9D7D9FB852F219F6E873FCA1A8C2E51C65A658558E6B95A997A706D3C93B1B62F5186EA34001DB6F941A7AD69E2990C2A6A93B35665ADABCF193BDBA875D6826B93736F3434EAB36E94331194E55CDF67A3BA12CFAEBE7408FF6259BCE781734A61B8EFEC6D60B7FCC486354EBB9AFCF6F939996F39F11886D3B4F0188FFEBE14E0C19F9C6AE70C81B8FD02E8502E3216060000, NULL, 0, 0, 0, 0, 0, 1),
	(42, 44, '2018-04-09 16:47:13', '2018-04-09 17:55:13', 3703.79, 0, 0, 0, NULL, _binary 0x1F8B08000000000000008DCE4B0A80201485E1BD3896B8DE87585B8908B106420F3067D1DE7312E4CCE17FE08333DE2AF8ED4C71550374A0D512AFEC8FF0658994E71CF7321841C21E9988C53EFA2751DAA815768815354D92801C59A82443DB612B0641B8B2CD92C4C133BD6B9D401F26010000, NULL, NULL, 0, 0, 0, 0, 0, 0),
	(43, 44, '2018-04-09 12:22:32', '2018-04-09 12:37:32', 899.453, NULL, 0, 0, NULL, _binary 0x1F8B08000000000000008B56880500A811F61F03000000, _binary 0x1F8B0800000000000000AB5650CA49CD4B2FC9285652B052885688D551502AC8CFCF89878882040D5085E24BF3324B40E24A4A408992FC92C49CF894CCE292C4BCE4549872A86869516249667E1E5854A11600E2DFDB036B000000, NULL, 0, 0, 0, 0, 0, 0),
	(44, 44, '2018-04-10 07:10:39', '2018-04-10 07:46:14', 1006.71, 275, 275.885, 195.64, 'Одной рукой.', _binary 0x1F8B080000000000000095D0BB0AC2401085E15719B64E71E6BA595F45445204B4B089DB49DE5DC432EB80F5E1E31FE64C2F2ACFBE6CFDDAEF8FB5D089D845D54C82E198A8DCD6CFBA2DFDBB42699F7E2A05A075A05AAA02A87C549CB64CAA430EAAA5299BC1D606A99A2937C074A0D25608C3FCDF1746C0AB0D5A48948B5595382AC92E7465730C5A3ED34E97372233890B1D020000, _binary 0x1F8B08000000000000009D94416EC3201045AF32629D056020D065F739415559C8462D8A0B913DAE5A45B97BB1B388A25AE994250F787C7D10676043486FF83E317882173803EBE7D163CC69019A2B6776C062C2307EFA6161A28C271CF331B45D9E13AE4CDF207E9FC2C2D8F318FC8457CAE0B2FB2D379653E44D85DC2AAB287253E156D60952705ED38AA6B5E236DC87F815FA2DA9B1DAD427F6DDF1415E25B5A3A865451946977B24C8E5A6FC616E6B05A967F9FF4A04378E93EAB6552FBB690425B8F85B0EAF65CD29E7A1BDFE02EB3E7DCFDA39C555C83E4239919559CCE887B68F13FAD4AD62B9D7377E5705377BEEE0F2035A13CA6C69040000, NULL, 0, 0, 0, 0, 0, 0),
	(45, 44, '2018-04-10 07:46:32', '2018-04-10 07:57:45', 220.37, 150, 146.913, 138.16, NULL, _binary 0x1F8B08000000000000007DCB3B0E80201045D1ADBC505B303340C4AD18632848B4B0C1E90C7BF7D312B9EDCD9971C19C9A8AAEBA1FD96002791671C1B1B58107982DBFB724FDEE28A8C33FF242B645917BC89344270D22A29E7AA2105AC51115CB0DF5DC6437D8000000, _binary 0x1F8B0800000000000000B592CB0AC23010457F659875176DD287BAF43744426883066322C95490D27F37691755DC14A1CB397339731733001A652F740D080738C100D8F55E927636015EEF39CF00B525E59FD22456C439907737255AD75B9A185B20BD1E2A313C7A2503CD1461CC7EE5459D6F26DFD55BCA7951AF91F37FE455B361F3B22A57C957348773CC3C9C33627EA19461D53713BDD59310EF2A5EC4B82547D2884E0792B69DC445952FFCA32C63396F7218DF11A4209EA5020000, NULL, 0, 0, 0, 0, 0, 0);
/*!40000 ALTER TABLE `exercises` ENABLE KEYS */;

-- Дамп структуры для таблица pool.files
CREATE TABLE IF NOT EXISTS `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(250) NOT NULL,
  `stor_name` varchar(250) NOT NULL,
  `ext` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=748 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы pool.files: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` (`id`, `filename`, `stor_name`, `ext`) VALUES
	(658, 'additional.7.blob', 'uploads/018MMpVlH4OAmPpkEAr6yAClvTgZOALZMTJdgyLI.gz', 'gz'),
	(659, 'additional.10.blob', 'uploads/NBAhauPkXURnfcdKlUo4at7Kbala1LPb8pV5dJ3H.gz', 'gz'),
	(660, 'additional.13.blob', 'uploads/kHlU5xEFd6YohAWmDoCBaeRO236yc5g2WI1Vep6s.gz', 'gz'),
	(661, 'additional.16.blob', 'uploads/YnT31kHYLR5HG9hsieyKcdQEQDSGDUJBTi4EOtq5.gz', 'gz'),
	(662, 'additional.19.blob', 'uploads/ISur9agDrKJjohl2tQs5bF8Yg5vTJZddYn8DNyQr.gz', 'gz'),
	(663, 'additional.22.blob', 'uploads/JjzlAJfJoK5Kvh8OVS9AycoUG9HBD1Bpoa9F6BAO.gz', 'gz'),
	(664, 'additional.25.blob', 'uploads/ZMMreWdwyhNEeQcs4v4OYky4SlYiZJtM5dawDrld.gz', 'gz'),
	(665, 'additional.28.blob', 'uploads/gsICbQf51bjEND8f79nIgUp2e1uOo7yQSNsZPTr8.gz', 'gz'),
	(666, 'additional.31.blob', 'uploads/Lq9QdDRU4waReIlXaizb8Mok9aSMVYO0TNsOhfNd.gz', 'gz'),
	(667, 'additional.34.blob', 'uploads/2nC9SlCNsX2neQ60GZcPLRY4oiDlM8997TMlKvqr.gz', 'gz'),
	(668, 'additional.37.blob', 'uploads/qgYRvBu6zpWDhINDzf4XWbsg2pNCt55oGWhxjcgO.gz', 'gz'),
	(669, 'additional.40.blob', 'uploads/6qkPdy3Q3qjJkp781Pdbn4exdXb04sVRhKDTpOjj.gz', 'gz'),
	(670, 'additional.43.blob', 'uploads/6vy51SYAVjd13NkMQsLe8SfgcZlJqx7FcfgC3LKB.gz', 'gz'),
	(671, 'additional.46.blob', 'uploads/Zegy4PFXNIdrGBYGgEEaUFPdjOd5wGMTQZPKNYQY.gz', 'gz'),
	(672, 'additional.49.blob', 'uploads/tn4n01WukQ0waWPgTAXS9oG4EzUordLN2rg399ZL.gz', 'gz'),
	(673, 'additional.52.blob', 'uploads/2rJVw3DTUJAvssmxzyhqdW25Cj2WBCK7yLXPouyL.gz', 'gz'),
	(674, 'additional.55.blob', 'uploads/yS9QRxkHbAn5jE80dfIMKDs40kRuo83rG5pGgzsN.gz', 'gz'),
	(675, 'additional.58.blob', 'uploads/qhxvr4TfJzEEjqsAdOkftWFGYS6ezosBEPUPF0ss.gz', 'gz'),
	(676, 'additional.61.blob', 'uploads/hlpusG2aJG5fCzIzrbDmObS4JlMawNXnB0QoNVia.gz', 'gz'),
	(677, 'additional.64.blob', 'uploads/CTULx4ql8DNEhDjjmRawjKdSel1BfRKEgnNW5qqA.gz', 'gz'),
	(678, 'additional.67.blob', 'uploads/vLA3XrjNGQ9lUID7iucBx9l7ijnMptNAlGugBolJ.gz', 'gz'),
	(679, 'additional.70.blob', 'uploads/QJShK6oDHVEr29ZuMFpmxIZdouxgRhFvEor9pfpy.gz', 'gz'),
	(680, 'additional.73.blob', 'uploads/KHpJJW0FFyD6IoPJBOSPVVGecYDxLJSQzBpbxJb5.gz', 'gz'),
	(681, 'additional.76.blob', 'uploads/OAYNnbSnxxYTRSgET3SPcuTnmhA07SI7OPrMT51c.gz', 'gz'),
	(682, 'additional.79.blob', 'uploads/uqiJEmgDLG9bqShsu4eOl6Qz8VUrIlxDTk6yVQZl.gz', 'gz'),
	(683, 'additional.82.blob', 'uploads/JQNbLKlL0mYCaAPsCGFTCi697p6Wue1nMG7HbIRK.gz', 'gz'),
	(684, 'additional.85.blob', 'uploads/3NPF5rIKO8wMLicQ42tR0arcCIWRLSV47pwG9086.gz', 'gz'),
	(685, 'additional.88.blob', 'uploads/NNmMGjx7AUVU7a42ZbZToDXOgco1VQns4rM4jmgR.gz', 'gz'),
	(686, 'additional.91.blob', 'uploads/JJkZprbAV1m0WFRkKDyjVAHqBg3ntxm78IyIH9E2.gz', 'gz'),
	(687, 'additional.94.blob', 'uploads/iJDRC2vj7biNb84c8c84X26TNNEwh9i8EiwEHKOk.gz', 'gz'),
	(688, 'additional.97.blob', 'uploads/4B6M06B2GUpA2k6mhuPfdX7pAqn5AZgaJjRWnyFk.gz', 'gz'),
	(689, 'additional.100.blob', 'uploads/2FFNE0SNXvY7iJ6ZR2BZnPNanBgWy7Iz0s2cxmSa.gz', 'gz'),
	(690, 'additional.103.blob', 'uploads/HQEDuwuyfjpg3GbkpIn0h5sUuaMBa49e5P9epXJL.gz', 'gz'),
	(691, 'additional.106.blob', 'uploads/5DWlQR0z4rhwG5nQpv9cQ6CPru3Oadod3mQ9P5HH.gz', 'gz'),
	(692, 'additional.109.blob', 'uploads/FqnX1hcRPhYv5qS2KtMwhaLogGUKyxlsrLA56Nqq.gz', 'gz'),
	(693, 'additional.112.blob', 'uploads/k89h7FLMfxwV06vqxaKaU39z3wLfJgjRVkN20BbQ.gz', 'gz'),
	(694, 'additional.115.blob', 'uploads/4WakyWpfBb8FDKh3qHrHOtgZsZO82tN95RLGysWq.gz', 'gz'),
	(695, 'additional.118.blob', 'uploads/P5sTiM3fjxBpyAYEjyBBmB8uE0H32wg3ZpcW9qPm.gz', 'gz'),
	(696, 'additional.121.blob', 'uploads/owVNgpHQLoxPBaGZID5XmtMV9W64PiCMSbk52ZRR.gz', 'gz'),
	(697, 'additional.125.blob', 'uploads/zJxEyud5MMTAWuxs0JpBDdqrnWpOkfzPOanCHT4m.gz', 'gz'),
	(698, 'additional.128.blob', 'uploads/i2GWmbCSH4GmgtCBdson6962kBPmxPKa2HFDK9nE.gz', 'gz'),
	(699, 'additional.131.blob', 'uploads/H4nCVAgTMUIvW80TP0CAZYilbBCA2TbwRc1dPaWu.gz', 'gz'),
	(700, 'additional.134.blob', 'uploads/m8ULZIzhQj6zVPI5uLFlxCoFzgCEuYTBWSvmqeX5.gz', 'gz'),
	(701, 'additional.137.blob', 'uploads/1zXRP4cDWy9y9IgFZ675JWwp18VIgRc03I8KqTEU.gz', 'gz'),
	(702, 'additional.140.blob', 'uploads/07yJdCxHDfBOfI4ZO7m5F96OpKiLvjGwovQP74eV.gz', 'gz'),
	(703, 'live_data.5.blob', 'uploads/eICNwAYxToG4QbWdq8DnOWMvCJOoWsp220d8Owfu.gz', 'gz'),
	(704, 'live_data.6.blob', 'uploads/4FfkRbe430xZIHxGtNUE5oF6TZ01oXF7lv8u7kQg.gz', 'gz'),
	(705, 'live_data.9.blob', 'uploads/hvvuftttWA2nvhUmGwhRPnYE8yJj5Dc4csoDPX6O.gz', 'gz'),
	(706, 'live_data.12.blob', 'uploads/mgiBm3iCiDaNgXZ4H091UuyyPbRsKSbUK2Kqsufd.gz', 'gz'),
	(707, 'live_data.15.blob', 'uploads/whx4JypR6YB9d5BPBnDF9MfzcTLcNNUnQnCAqQuJ.gz', 'gz'),
	(708, 'live_data.18.blob', 'uploads/wENs3oRfUICeqDh3cZIZGsFyPqma0oOSuoId5w4I.gz', 'gz'),
	(709, 'live_data.21.blob', 'uploads/JGKSL396OzXjiImuXDP8vN8DXIDVlnD3izcybn8K.gz', 'gz'),
	(710, 'live_data.24.blob', 'uploads/2uRe8jx6aQ1TOIsmPsFYAshV5UvARz55kOGZZlF2.gz', 'gz'),
	(711, 'live_data.27.blob', 'uploads/k1Yc1b367l2MNmSDJseq6cWWLLWXS9s0SADRve74.gz', 'gz'),
	(712, 'live_data.30.blob', 'uploads/JXqFnC9wQtAQqIsKFvrqGw8aXcwCrKNlOfpqrHSm.gz', 'gz'),
	(713, 'live_data.33.blob', 'uploads/kxI3OzLKUeYj9qZ3mhvcPiElQaSP9j6W8Zsq3pab.gz', 'gz'),
	(714, 'live_data.36.blob', 'uploads/DJlLcspVxAJQZIQ4p2gEVquOD741Wkls0qx5ZKyz.gz', 'gz'),
	(715, 'live_data.39.blob', 'uploads/LtaQRBvylGsNzVtcpUmIyDc5QzKN5hGdRS7XMfgx.gz', 'gz'),
	(716, 'live_data.42.blob', 'uploads/r4qbys7pibs3cfpzBVK8P2eKSt5oBjLj6xc1h5nz.gz', 'gz'),
	(717, 'live_data.45.blob', 'uploads/yohqjLnSM3siXxmnCgE5IzygByiaWombR6HfSIa1.gz', 'gz'),
	(718, 'live_data.48.blob', 'uploads/trFRx6eJTnqBuVrnR4dQggOd3TGTapG5Yo5qmS5a.gz', 'gz'),
	(719, 'live_data.51.blob', 'uploads/W6A6XaqhCIymAFyuLxDCP43PyvOOhsaMegoNtNSZ.gz', 'gz'),
	(720, 'live_data.54.blob', 'uploads/Gc4Kx9sQbd0Nyk3RtmZcmkDnDLd3I7hh88UzflG1.gz', 'gz'),
	(721, 'live_data.57.blob', 'uploads/xIpf1bqqWZ5fC6st8hcJhaIWU5uyzBbq1LRwfKlH.gz', 'gz'),
	(722, 'live_data.60.blob', 'uploads/tGl0aIUkRExZXJxOobJPhEFDFQf64vz2N0rz12jO.gz', 'gz'),
	(723, 'live_data.63.blob', 'uploads/mg524H37QS2q9GlDbDRDtHX06Rbcn8TGni6gxrrP.gz', 'gz'),
	(724, 'live_data.66.blob', 'uploads/8CZ5amHHBY3MwUvnyIRKSFGCkdddBQtrxLl6KJoV.gz', 'gz'),
	(725, 'live_data.69.blob', 'uploads/rI11OvnWc2ImQkJP4c9XPZKeUo67GklM9LfGS2jg.gz', 'gz'),
	(726, 'live_data.72.blob', 'uploads/U7MgcDm6P1A8pnrvLrM1HRhvAWCLKAMsvtvB9LsE.gz', 'gz'),
	(727, 'live_data.75.blob', 'uploads/azkH6uRsPoYjP5zKkuIroYdFlWfP3DEwbZamgw5w.gz', 'gz'),
	(728, 'live_data.78.blob', 'uploads/CbpGZrPhWBEXp2LXJPiiMSi044cJOtN04YlnmtiY.gz', 'gz'),
	(729, 'live_data.81.blob', 'uploads/R2IcXAyVYnA5bv4gWbpsw2VWPQwhTF5OnvIHzaZc.gz', 'gz'),
	(730, 'live_data.84.blob', 'uploads/HfDRnXRXQyGHDlFWt9pfHn8wfvzFiKM9dMK7kXT7.gz', 'gz'),
	(731, 'live_data.87.blob', 'uploads/a3LTPmkPy3EHIveIPkE094q3T1Gw5dHtORbJgjub.gz', 'gz'),
	(732, 'live_data.90.blob', 'uploads/wnnLr8Gwqt5oxlSyineYIpjTjx3OrXmUy7qr0UNZ.gz', 'gz'),
	(733, 'live_data.93.blob', 'uploads/cSuzDRQFZCDjUDWXcb65DG1YIY1ek6ZV5yyPYoZy.gz', 'gz'),
	(734, 'live_data.96.blob', 'uploads/MWNLs57rsEssxCBYMMjlCnDWTHvvpFwwQjJcxNt1.gz', 'gz'),
	(735, 'live_data.99.blob', 'uploads/WoRJUow5IeX5J6ZCDIul3qPRcQJi5GDS0Hg4TmCI.gz', 'gz'),
	(736, 'live_data.102.blob', 'uploads/8DKQqyuwaLzByfeyBCjIkS0WiVxibr1ZSjjEN7wU.gz', 'gz'),
	(737, 'live_data.105.blob', 'uploads/GWy6ZotvgUW1rXPEfLBQZibPydRQyG0zIZxyMDuH.gz', 'gz'),
	(738, 'live_data.108.blob', 'uploads/nvJWVek9jh8Xfbsnf19bW232IvXlecvtFmvE6bp2.gz', 'gz'),
	(739, 'live_data.111.blob', 'uploads/QyzZ4x17uP01nBkUC70xQNnO8QHgwz0yw1F7gbJa.gz', 'gz'),
	(740, 'live_data.114.blob', 'uploads/xjEg4oK2oAYgNCtV2XC9cNKDNI5tm7qGw0Cc8UBE.gz', 'gz'),
	(741, 'live_data.117.blob', 'uploads/0ogNXfSrvyzeKYnQdy7bvouBfu6lvY5EeOheRZBP.gz', 'gz'),
	(742, 'live_data.120.blob', 'uploads/9JYyjFuUoyBMYbFwkEeojgRdiA2Z9DBY3nWtTC3Z.gz', 'gz'),
	(743, 'live_data.123.blob', 'uploads/vvxgtxXQLhJy4oNH9ljpJJLDG7QyntQfitSpDL2M.gz', 'gz'),
	(744, 'live_data.124.blob', 'uploads/GVngBguHn3NcnImZQwvn4awtNnS683hyemlIf4Kz.gz', 'gz'),
	(745, 'live_data.127.blob', 'uploads/OgIVZqA4b2nZiq8V2tURI9qaoEnyqbtWr3H9LX2l.gz', 'gz'),
	(746, 'live_data.130.blob', 'uploads/gwoO3VqXnVzrVrfubnISkC4oKEBBRcDcz9S8TGd6.gz', 'gz'),
	(747, 'com.samsung.health.exercise.201904261622.csv', 'uploads/5r5CX7TBZD5PEhqBPHNXEueVw8w91miURsbzaZLC.txt', 'txt');
/*!40000 ALTER TABLE `files` ENABLE KEYS */;

-- Дамп структуры для таблица pool.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы pool.users: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Alex', 'iliechev2003@gmail.com', '$2y$10$onpqYmGUGsDE/aJlRy4YKugYSMPWJAzTgHQVjsoP7XnYCAVbjOoDy', 'jYK6liiqhoipCXCSsbm7XXQjaoasWAoPpeli3KM8xHI59adizWAi3OhbdpGm', '2019-11-14 13:20:46', '2019-11-14 13:20:46');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
