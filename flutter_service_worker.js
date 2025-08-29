'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"manifest.json": "4511ff840d531cc33b5b80e98ea3c6be",
"screenshots/09_tablet_en_play_page.png": "ca62fcdb40e2a3b65043e702d42120a5",
"screenshots/08_tablet_en_choose_game_pace.png": "8fc30308092858ca63b5583d5e9a9ac1",
"screenshots/06_tablet_en_play_deck_choice.png": "be4e9cc8bb2a5184f769768c5aed4598",
"screenshots/02_en_choose_game_type.png": "6e4fb5120b278448004357dcb40f346c",
"screenshots/03_tablet_en_choose_players_sex.png": "b5e0dd9c5672ba33ae63734d13a1f1f3",
"screenshots/08_en_choose_game_pace.png": "a9eefda84fbbd9d90215369db29d5bb8",
"screenshots/09_en_play_page.png": "0d6971ed6c965007aea3f762a27b72dd",
"screenshots/06_en_play_deck_choice.png": "bcaf3eaa43970c337e3c0bc14942ce8b",
"screenshots/02_tablet_en_choose_game_type.png": "23cddf42d47ce84b955c37a1d6bc76f9",
"screenshots/03_en_choose_players_sex.png": "8be7fe78f6b383a82ceb04da6938890b",
"icons/Icon-192.png": "ef87baae931cad205957c2374b617438",
"icons/Icon-maskable-512.png": "580f741bcd584a39374405676a6168e1",
"icons/Icon-maskable-192.png": "ef87baae931cad205957c2374b617438",
"icons/Icon-512.png": "580f741bcd584a39374405676a6168e1",
"main.dart.js": "a9d57401fb75545b6dc93728b216cf9e",
"version.json": "9e898f37ff06dea70690a7264d7422a7",
"assets/NOTICES": "cd2cf234fffe40d1ef34e0a6502d6644",
"assets/fonts/MaterialIcons-Regular.otf": "e1745764bbc8748b16cbdf5451f6f1ea",
"assets/AssetManifest.json": "5dc1c2de58081a3722850461589acdc0",
"assets/assets/fonts/README.txt": "3ffa129a97ef4e6614e51eae219207d5",
"assets/assets/fonts/Roboto-Italic-Variable.ttf": "5b03341126c5c0b1d4db52bca7f45599",
"assets/assets/fonts/OFL.txt": "3e5df346fd8c0867bac65e8a215771dd",
"assets/assets/fonts/Roboto-Variable.ttf": "3aa911d4a1e76c8946952fe744ce7434",
"assets/assets/audio/timer_alarm.mp3": "767acdb7ea7bf4b8a4dad459001a8f92",
"assets/assets/images/lesbian_couple_icon.png": "1ecfd4768321288aeffcdc9de89435ec",
"assets/assets/images/balance.svg": "9839ca932af387286f9ad320e209e5fc",
"assets/assets/images/webapp.svg": "c5ed4219aa948790a0634f2642c3a4a7",
"assets/assets/images/hetero_couple_icon.svg": "60f0b51aa07011cda071bac56170dd61",
"assets/assets/images/improvement.png": "6d5896c9e217d5405f512ee64095eae2",
"assets/assets/images/improvement.svg": "7875b89d8c1fc20ff28a4feac99f862a",
"assets/assets/images/player_selection_icon.png": "e790d306253450f48d878e4089d68fde",
"assets/assets/images/cronometer.png": "4c4d3f1b8e72fbe42c7d158b97311236",
"assets/assets/images/compass.png": "797696a804b00bba5a9a115bf9cbd66f",
"assets/assets/images/male_player_icon_alt.svg": "f2a41ba68e157bc33a6ebf7f42549581",
"assets/assets/images/custom_decks_icon.png": "4a6e2616f0373c024290cf0b30d0ea81",
"assets/assets/images/error_icon.svg": "d72414978ca599b03b3abab13779e3ff",
"assets/assets/images/deck_choice_icon.svg": "ac20aaed0c2ff98afd4b552872047981",
"assets/assets/images/privacy_2.svg": "86fdb2b53da4b1280f8b1ddd95837c0b",
"assets/assets/images/wallet.png": "f0e252cd9c4453516d83586f5344925c",
"assets/assets/images/download.svg": "a83419ea39ce571dd2dbcd0589477443",
"assets/assets/images/app_icon.png": "93d412be7ab96910e796b71adea5e8a2",
"assets/assets/images/ads.svg": "bb1a023777e6210f47aabaac7eb21840",
"assets/assets/images/donation.png": "6c01c5582d080c5f0c1f7a9caf7a9057",
"assets/assets/images/app_icon_x512.png": "d7ed50e25e147fe6dc079feb12214715",
"assets/assets/images/male_player_icon.png": "d92429f91bb52be866858d86ef9b2f0b",
"assets/assets/images/floppy.png": "b593df7bc241c762105f3f7919e0612d",
"assets/assets/images/smartphone.svg": "8699c86df37a9d85e35ff6bcfb880a4a",
"assets/assets/images/default_decks_icon.png": "3da8705a35bfc75a8a24276e3f57ab08",
"assets/assets/images/lgbt.svg": "2205e5eed4a5b649e68468121c613f03",
"assets/assets/images/github.svg": "b6112742c2fa3b0ce68c087c7d04e279",
"assets/assets/images/compass.svg": "9b948cfc4bb3b4d8dcbbfe07a004d34a",
"assets/assets/images/lock.svg": "7a3c66c3d01f6c4766d53c6ca8441968",
"assets/assets/images/stars.png": "03ef1823d8222e8ce4f383469ff277be",
"assets/assets/images/hetero_couple_icon.png": "133671eea64915e210bc596e214a615b",
"assets/assets/images/heart.svg": "7e81ea201b0e23dd8173d368a1a657a4",
"assets/assets/images/cards.png": "5094199eae3824c6141de908d9d479fe",
"assets/assets/images/floppy.svg": "90d1f33a39367c2a31a0da7e30c659f9",
"assets/assets/images/cronometer.svg": "33a94454b4d50a06a531ec1e3aaf529d",
"assets/assets/images/shuffle_icon.svg": "da00e449bfd503b4a6b0f1790f046b9c",
"assets/assets/images/cards.svg": "be5bf11640bfb7fe519635f031ca7700",
"assets/assets/images/settings_icon.png": "ef69197b84d3f8e3eeec579bf36b5546",
"assets/assets/images/speed_3.svg": "021d1c8370889047bb7e68afb8b7f44d",
"assets/assets/images/coin_flip_icon.svg": "66c470a2e7ec023f7156fe81335c6a73",
"assets/assets/images/privacy_2.png": "6dfb923bf9707b08509513f7a71e8c0d",
"assets/assets/images/select_game_mode_icon.png": "e7f40915b0b0876f42dd7ab0682472d1",
"assets/assets/images/interface.svg": "42124258657fb73615989f07f5253874",
"assets/assets/images/tools.png": "79951a9289dc4ede51310d3000aaec8b",
"assets/assets/images/signal.png": "000acb1f838ffca2ae24b72802f9334f",
"assets/assets/images/female_player_icon.png": "9c0d6f99cc67f0219185c98f4d77a92b",
"assets/assets/images/warning.png": "4924628c16be328a57fac1338dd8592c",
"assets/assets/images/bulb.png": "588414472b0ae0e7bec6450afbcd7e7a",
"assets/assets/images/lgbt.png": "045e9ccf21c8ef95224b0aff838b1029",
"assets/assets/images/main_icon.png": "680080cc47c9904d691dba2dfb433998",
"assets/assets/images/lesbian_couple_icon.svg": "64ed4a977dca3d4e92e2c4d1235eef1f",
"assets/assets/images/toy.svg": "479ad1e3d100a0ff31af45d63bcbc013",
"assets/assets/images/speed_2.svg": "e628e70668feb3ab5d619fd15ace3c15",
"assets/assets/images/github.png": "79ebf0da8be60866ca1572abd74b8829",
"assets/assets/images/play_presence_icon.png": "bc8af77e27b745f1d04b0ed4085f6c0c",
"assets/assets/images/privacy.svg": "b85dd1b6562e219661cefac51f78d33c",
"assets/assets/images/app_icon.svg": "0cb3b2ea5c5bd6dc68f4c407d6152389",
"assets/assets/images/user.svg": "6f7bae7c736ba4c1dc5969ba15bda581",
"assets/assets/images/gay_couple_icon.svg": "6a820899ceeb315807f80f9d3e9c33fb",
"assets/assets/images/toy.png": "7d98c924f75a41f955fbd934961f407f",
"assets/assets/images/lock.png": "3683701a0fbc2232a29c258ff322f2bf",
"assets/assets/images/stars.svg": "cb96d19766378749666b6da1df2040c8",
"assets/assets/images/speed_4.png": "3ccb20493ecd972f48d31c1b0633dd9f",
"assets/assets/images/chat.svg": "91ca77984dc6df99b038e649b0caf821",
"assets/assets/images/deck_choice_icon.png": "6dad47f1a1ce7df049a05d752cbd0ffb",
"assets/assets/images/speed_3.png": "e18cf134a24f743771e5db980ebe2247",
"assets/assets/images/chair.png": "fa68017da5b217585e3444aacd0c0e4e",
"assets/assets/images/private.svg": "f56c0cf10d8106ec394cf77b3ec414b5",
"assets/assets/images/webapp.png": "ee1517949519e203f23cd972e1255916",
"assets/assets/images/offline.png": "a9c64a628604f588e7e41d5aae540c7f",
"assets/assets/images/smartphone.png": "83e38b10a9bb92ed9210259a58783633",
"assets/assets/images/private.png": "596cad3f0751bad4e69b5883e672af99",
"assets/assets/images/female_player_icon_alt.svg": "b31e0f62c879f2d5993866010e9168b9",
"assets/assets/images/play_presence_icon.svg": "dfee494bc0d04b3ed7587265611d61f1",
"assets/assets/images/wallet.svg": "55becec4d28901e94b99ca8aa239846a",
"assets/assets/images/bulb.svg": "7594008aeb569ea3b945f4727dd78cda",
"assets/assets/images/personalization.png": "75ad1706db09874d03ab556f238d0453",
"assets/assets/images/heart.png": "02f47ab3261d45a1640283cc63755184",
"assets/assets/images/select_game_mode_icon.svg": "16db06dc16302e4fb6f496c206e68013",
"assets/assets/images/custom_decks_icon.svg": "e8b64fbdc2b7993806aa0ab06e793d53",
"assets/assets/images/gamepad.svg": "9d6d5f01a0b5473f1645c9eb199e05de",
"assets/assets/images/define_players_names_icon.png": "a4ab4ece42840a28c7a2bfb28a0ddc3d",
"assets/assets/images/code.svg": "970bbc127cc51bc9461d5c74705211f3",
"assets/assets/images/pencil.png": "1cde2ec6164fc5b977e4e9493e27cd6e",
"assets/assets/images/speed_1.png": "1434665006cf912a3e22f176b7154dd5",
"assets/assets/images/play_distance_icon.png": "baa664ef54fd20abc758d529f5e513c7",
"assets/assets/images/ads.png": "57b4a85627121792ea2ebef2eca8a366",
"assets/assets/images/gay_couple_icon.png": "20af136272ed598df8c2ff15ec8ed20c",
"assets/assets/images/interface.png": "3e86fc2f49edf499ccd80603de9e101b",
"assets/assets/images/male_icon.svg": "a18fbb469884df0310ac82f0ee95a2bf",
"assets/assets/images/pencil.svg": "4390dd58ce0f90e6cd156bb6d976487c",
"assets/assets/images/settings_icon.svg": "6684e7cafeb2588ed63c6a19d1da8868",
"assets/assets/images/info.png": "82812a78debc40361161eb321927eb29",
"assets/assets/images/personalization.svg": "f85cc22ce855495589a284db1b59e64f",
"assets/assets/images/speed_1.svg": "8977bdc58d11937302cff255933aac4e",
"assets/assets/images/hourglass.svg": "671e68c2dd136fbeaf3ed807b16ff48a",
"assets/assets/images/deck_editor_icon.png": "4bc5f59a5ecef94e9b68d73822057677",
"assets/assets/images/male_player_icon.svg": "9207530dd29bba465a232a2516de5814",
"assets/assets/images/download.png": "892f0e5f7371aace52f57a8ca4983de2",
"assets/assets/images/deck_info_icon.png": "53038dfa0f0fb531cf6f6b19a8a33492",
"assets/assets/images/tools.svg": "cf1da78630c17c5604a38c5920a40fc3",
"assets/assets/images/info.svg": "f2255524c19e3de56279846146570f76",
"assets/assets/images/privacy.png": "7ad47a3c2501af3d2ec2ec304ca09cd0",
"assets/assets/images/play_distance_icon.svg": "ca26cb1d50fe25269748da1098cf1886",
"assets/assets/images/female_icon.svg": "6a3d302718375b5f147a34baa791ca40",
"assets/assets/images/player_selection_icon.svg": "2afbc8d972d1127c36a204db41d9671c",
"assets/assets/images/female_player_icon_alt.png": "ad0cfcb880ad0dd52801050247c7f9da",
"assets/assets/images/deck_editor_icon.svg": "2f75d87bc09c1b9230f4933f28de99b5",
"assets/assets/images/user.png": "d955e6af233fb8a0d0528fb12f14d2e6",
"assets/assets/images/support.svg": "92f6487638cf882c0e4f4d464d9d7155",
"assets/assets/images/avatar.png": "9d598a7feba5e84b57ceed1e56c73029",
"assets/assets/images/define_players_names_icon.svg": "a858153b32995d0bc7caf6b6f879b3fa",
"assets/assets/images/main_icon.svg": "010f6c79e67eab9f8ed823ada9a527e6",
"assets/assets/images/balance.png": "5540796429ae093505cabd47be04e819",
"assets/assets/images/hourglass.png": "dd635cf82d573526ffc4ac65acdc2354",
"assets/assets/images/support.png": "6511ed9b53864bbc6f0e2b9cae025a49",
"assets/assets/images/donation.svg": "052240c6ab5865528ec48303604179ce",
"assets/assets/images/speed_2.png": "3a78cdb38dec64189a8e5ae10da5d1d9",
"assets/assets/images/app_icon_x192.png": "1b20fc0950d13c43dcb8eb1155997db9",
"assets/assets/images/warning.svg": "79120b8ff13b028eb1e162a9b8c66e6b",
"assets/assets/images/shuffle_icon.png": "eec44674bc058b077b2147cf3a3aa542",
"assets/assets/images/male_player_icon_alt.png": "ac94d6a7e5a56979f6079704e087fc5e",
"assets/assets/images/code.png": "b4a6c568429e4070bd6d956fa3a05d9d",
"assets/assets/images/deck_info_icon.svg": "0ea04d0b06bf8f4a416775d5bd9e6cb4",
"assets/assets/images/avatar.svg": "199fde63cd1fc13a82bd2e2241f143c3",
"assets/assets/images/signal.svg": "7fab8b343392448f0cf9731967cc954a",
"assets/assets/images/female_player_icon.svg": "26c75b7e49e7b2c0800dd0569ad12034",
"assets/assets/images/gamepad.png": "fa9a2a1a3b9f2d43539b03765d467b7d",
"assets/assets/images/default_decks_icon.svg": "0a186e60250f8bcad9d01ef4b076ff01",
"assets/assets/images/offline.svg": "cd9d0529b2ccb76c30a40536dc8fb07a",
"assets/assets/images/chat.png": "e58047b42380b0430ad1e942530fabd8",
"assets/assets/images/coin_flip_icon.png": "056154261082e21fded928ce8f52319e",
"assets/assets/images/speed_4.svg": "c781b7f6175ad4196613f908ae2c7e19",
"assets/assets/images/error_icon.png": "5885c3c13c6aa66fc7e8fcb27eda4dbd",
"assets/assets/default_decks/presence/zh/hetero/zh_04_presence_hetero_deck_hard_no_tools.json": "2aa19ff0731cf511698e1dbab5163153",
"assets/assets/default_decks/presence/zh/hetero/zh_02_presence_hetero_deck_medium_no_tools.json": "5db51c59ef46097d45be7da3ed1e4e91",
"assets/assets/default_decks/presence/zh/hetero/zh_01_presence_hetero_deck_easy_no_tools.json": "fd5f4c25c69c333b93b7330be8d0afb9",
"assets/assets/default_decks/presence/zh/hetero/zh_03_presence_hetero_deck_medium_with_tools.json": "9e1e1517ba57f7d375ebd675bafe2a69",
"assets/assets/default_decks/presence/zh/hetero/zh_07_presence_hetero_deck_super_hard_with_tools.json": "9b998685d613422bf53c962b9942d32b",
"assets/assets/default_decks/presence/zh/hetero/zh_05_presence_hetero_deck_hard_with_tools.json": "607bbc03171813655c0c501ca0bba94c",
"assets/assets/default_decks/presence/zh/hetero/zh_06_presence_hetero_deck_super_hard_no_tools.json": "0db7541311aed6be98fb11b5b4b73365",
"assets/assets/default_decks/presence/zh/lesbian/zh_05_presence_lesbian_deck_hard_with_tools.json": "b167e5403eee2169c4f47efb64f225b5",
"assets/assets/default_decks/presence/zh/lesbian/zh_04_presence_lesbian_deck_hard_no_tools.json": "cad0563ee59baf3ab271c8aced42a6bc",
"assets/assets/default_decks/presence/zh/lesbian/zh_03_presence_lesbian_deck_medium_with_tools.json": "8c0783a8ef9dde1cc4febbe0554c14a3",
"assets/assets/default_decks/presence/zh/lesbian/zh_01_presence_lesbian_deck_easy_no_tools.json": "f843587c9f48ae4477714e598225ca57",
"assets/assets/default_decks/presence/zh/lesbian/zh_02_presence_lesbian_deck_medium_no_tools.json": "27a8a5bb0fdc320bc1008e8616069d16",
"assets/assets/default_decks/presence/zh/lesbian/zh_06_presence_lesbian_deck_super_hard_no_tools.json": "b806bfbadb939411b49a7457ebe42597",
"assets/assets/default_decks/presence/zh/lesbian/zh_07_presence_lesbian_deck_super_hard_with_tools.json": "5bc44c56b043e0e8643ef4b1775309a4",
"assets/assets/default_decks/presence/zh/gay/zh_05_presence_gay_deck_hard_with_tools.json": "d6ea4eac5954f90cf7e4cbdcddabf876",
"assets/assets/default_decks/presence/zh/gay/zh_01_presence_gay_deck_easy_no_tools.json": "fb5271c9c2a9cc65126946bdee1314d1",
"assets/assets/default_decks/presence/zh/gay/zh_04_presence_gay_deck_hard_no_tools.json": "f1c97533adb16c1539c77c4249a011ce",
"assets/assets/default_decks/presence/zh/gay/zh_06_presence_gay_deck_super_hard_no_tools.json": "c5805ad22086ef21838ba11a5c69cfb1",
"assets/assets/default_decks/presence/zh/gay/zh_07_presence_gay_deck_super_hard_with_tools.json": "8960950065f00a2775b8f6b9573a5ac9",
"assets/assets/default_decks/presence/zh/gay/zh_03_presence_gay_deck_medium_with_tools.json": "3fa98a657291464b9c7cd526a961341a",
"assets/assets/default_decks/presence/zh/gay/zh_02_presence_gay_deck_medium_no_tools.json": "57d4e641a8522dab15ab35b3854d1c53",
"assets/assets/default_decks/presence/de/hetero/de_05_presence_hetero_deck_hard_with_tools.json": "a9f42218e5f93bb81f77b638b6aa2bd4",
"assets/assets/default_decks/presence/de/hetero/de_02_presence_hetero_deck_medium_no_tools.json": "8b0a73f196c7b74ba78fcb8683be61a8",
"assets/assets/default_decks/presence/de/hetero/de_01_presence_hetero_deck_easy_no_tools.json": "aabb8161e58d1af93ca0704ce2aa2619",
"assets/assets/default_decks/presence/de/hetero/de_06_presence_hetero_deck_super_hard_no_tools.json": "6b1ba3cca5d4c4768cec5026f0c0245d",
"assets/assets/default_decks/presence/de/hetero/de_03_presence_hetero_deck_medium_with_tools.json": "262dfc39994156db46f1fcc5e1dc836d",
"assets/assets/default_decks/presence/de/hetero/de_04_presence_hetero_deck_hard_no_tools.json": "1a90ced50f6dedc5a169a1386846389c",
"assets/assets/default_decks/presence/de/hetero/de_07_presence_hetero_deck_super_hard_with_tools.json": "92c9a85a32d7400ea926258527708d06",
"assets/assets/default_decks/presence/de/lesbian/de_03_presence_lesbian_deck_medium_with_tools.json": "9e2a424fc3710284a75e4cd053b4b9c3",
"assets/assets/default_decks/presence/de/lesbian/de_06_presence_lesbian_deck_super_hard_no_tools.json": "5bb067955f8c74ccf8a99541cad043f2",
"assets/assets/default_decks/presence/de/lesbian/de_05_presence_lesbian_deck_hard_with_tools.json": "ebef73bd3eae3fa02ac6e659bae8460e",
"assets/assets/default_decks/presence/de/lesbian/de_07_presence_lesbian_deck_super_hard_with_tools.json": "a15fb5f7868ee2f7a54fce8d86446534",
"assets/assets/default_decks/presence/de/lesbian/de_02_presence_lesbian_deck_medium_no_tools.json": "cfc8e2211d267d202df836dd862cb20c",
"assets/assets/default_decks/presence/de/lesbian/de_04_presence_lesbian_deck_hard_no_tools.json": "b8fe1aebc284f3695693ccaa48c78fbc",
"assets/assets/default_decks/presence/de/lesbian/de_01_presence_lesbian_deck_easy_no_tools.json": "b12e267234f4e94aa415daff47b0b328",
"assets/assets/default_decks/presence/de/gay/de_06_presence_gay_deck_super_hard_no_tools.json": "407a99a5670af3e3f150b84e1ba8a11d",
"assets/assets/default_decks/presence/de/gay/de_03_presence_gay_deck_medium_with_tools.json": "377383a39c317b46b37a7f55c05ebf24",
"assets/assets/default_decks/presence/de/gay/de_01_presence_gay_deck_easy_no_tools.json": "04123121a31cede08e6b72c519b650cd",
"assets/assets/default_decks/presence/de/gay/de_05_presence_gay_deck_hard_with_tools.json": "33575601b0708e951d24c1f88bcfcfbc",
"assets/assets/default_decks/presence/de/gay/de_04_presence_gay_deck_hard_no_tools.json": "c0e9942cf734ab4b33d08fee1aa2b7ae",
"assets/assets/default_decks/presence/de/gay/de_07_presence_gay_deck_super_hard_with_tools.json": "8d3b0260a46cc9023072241b9098d64c",
"assets/assets/default_decks/presence/de/gay/de_02_presence_gay_deck_medium_no_tools.json": "682671c88454c209670ab974dffc8870",
"assets/assets/default_decks/presence/es/hetero/es_03_presence_hetero_deck_medium_with_tools.json": "6db9c47aa7304c56d02c224b9f0fcd5b",
"assets/assets/default_decks/presence/es/hetero/es_06_presence_hetero_deck_super_hard_no_tools.json": "af0d130e71fd2bc683c52d6b8e32a48b",
"assets/assets/default_decks/presence/es/hetero/es_04_presence_hetero_deck_hard_no_tools.json": "a21f31c7a944a1c5ed8dfe1bebf50ef7",
"assets/assets/default_decks/presence/es/hetero/es_02_presence_hetero_deck_medium_no_tools.json": "e3ac802a5ccebb460cff6f560d3047b1",
"assets/assets/default_decks/presence/es/hetero/es_07_presence_hetero_deck_super_hard_with_tools.json": "71304fed3b29ca4ff7caf0d67a26d2e7",
"assets/assets/default_decks/presence/es/hetero/es_05_presence_hetero_deck_hard_with_tools.json": "9f059743bcbfa65fa53e511804ad2794",
"assets/assets/default_decks/presence/es/hetero/es_01_presence_hetero_deck_easy_no_tools.json": "2d5fb8533ee524d5f5f306fe066a0202",
"assets/assets/default_decks/presence/es/lesbian/es_05_presence_lesbian_deck_hard_with_tools.json": "8db1ef80626e2daeadb48306c9d3e994",
"assets/assets/default_decks/presence/es/lesbian/es_01_presence_lesbian_deck_easy_no_tools.json": "6b0c2cd383503dd5f0cd7490aae6cf7b",
"assets/assets/default_decks/presence/es/lesbian/es_04_presence_lesbian_deck_hard_no_tools.json": "7871dec5de57af63c4872828d6f73692",
"assets/assets/default_decks/presence/es/lesbian/es_02_presence_lesbian_deck_medium_no_tools.json": "19bef5eb2b9b1efb4fc6e55ab5bd8c18",
"assets/assets/default_decks/presence/es/lesbian/es_06_presence_lesbian_deck_super_hard_no_tools.json": "1f78895d361b9578c489c1bd4ada124f",
"assets/assets/default_decks/presence/es/lesbian/es_03_presence_lesbian_deck_medium_with_tools.json": "8ac6139bcbff9e8f07a9674aa9c8acbf",
"assets/assets/default_decks/presence/es/lesbian/es_07_presence_lesbian_deck_super_hard_with_tools.json": "9aa119a4607b5059b91a34fad1a6e449",
"assets/assets/default_decks/presence/es/gay/es_06_presence_gay_deck_super_hard_no_tools.json": "b2fe6eae462088be1346390e4af0b25f",
"assets/assets/default_decks/presence/es/gay/es_03_presence_gay_deck_medium_with_tools.json": "8736550e03f98703589e30d820f75af9",
"assets/assets/default_decks/presence/es/gay/es_07_presence_gay_deck_super_hard_with_tools.json": "e384ce448b157f4c704e29c7978340d1",
"assets/assets/default_decks/presence/es/gay/es_02_presence_gay_deck_medium_no_tools.json": "03e6b062c4d94ee7e87d0241175cb4df",
"assets/assets/default_decks/presence/es/gay/es_04_presence_gay_deck_hard_no_tools.json": "afcf2780063ba15de9d28b6c1ff9663f",
"assets/assets/default_decks/presence/es/gay/es_01_presence_gay_deck_easy_no_tools.json": "f7201a30f1343bb1091c6815b7839c8e",
"assets/assets/default_decks/presence/es/gay/es_05_presence_gay_deck_hard_with_tools.json": "1a2023db565dcd1f2042c38ba1c85bc7",
"assets/assets/default_decks/presence/nl/hetero/nl_01_presence_hetero_deck_easy_no_tools.json": "b9c0f6cbb11ef23ba82f0314cfb6a5ca",
"assets/assets/default_decks/presence/nl/hetero/nl_02_presence_hetero_deck_medium_no_tools.json": "a302970f2b5391850ceeee5a560ce835",
"assets/assets/default_decks/presence/nl/hetero/nl_03_presence_hetero_deck_medium_with_tools.json": "2282be3034fa5712b3349e96e55327c8",
"assets/assets/default_decks/presence/nl/hetero/nl_07_presence_hetero_deck_super_hard_with_tools.json": "0abfd241eee529541ff3e468ec3da8a4",
"assets/assets/default_decks/presence/nl/hetero/nl_04_presence_hetero_deck_hard_no_tools.json": "a816d31560be97ede2fb02ef52f255ec",
"assets/assets/default_decks/presence/nl/hetero/nl_05_presence_hetero_deck_hard_with_tools.json": "24d22d9d8e82c771ce511c4bc45b8f02",
"assets/assets/default_decks/presence/nl/hetero/nl_06_presence_hetero_deck_super_hard_no_tools.json": "6d6b7c95ffe8d1f503e9aebc9e35fddf",
"assets/assets/default_decks/presence/nl/lesbian/nl_04_presence_lesbian_deck_hard_no_tools.json": "39d984844ecefb107b71e6837ddc3921",
"assets/assets/default_decks/presence/nl/lesbian/nl_03_presence_lesbian_deck_medium_with_tools.json": "ced38fd9c81aa013d0930ea82c1a25e6",
"assets/assets/default_decks/presence/nl/lesbian/nl_07_presence_lesbian_deck_super_hard_with_tools.json": "1390a161046e6bf981bede53a166c921",
"assets/assets/default_decks/presence/nl/lesbian/nl_05_presence_lesbian_deck_hard_with_tools.json": "60967ac13f1bde13d1a10c0785ad6e0d",
"assets/assets/default_decks/presence/nl/lesbian/nl_02_presence_lesbian_deck_medium_no_tools.json": "0f00a447179d7d3585b70201cf303f0d",
"assets/assets/default_decks/presence/nl/lesbian/nl_06_presence_lesbian_deck_super_hard_no_tools.json": "7cc09be7628cf943edaa51a2b27b52f4",
"assets/assets/default_decks/presence/nl/lesbian/nl_01_presence_lesbian_deck_easy_no_tools.json": "417abeb72c658bb5e342fcb7bd189c0a",
"assets/assets/default_decks/presence/nl/gay/nl_05_presence_gay_deck_hard_with_tools.json": "db27c90779a7b2e7573d764f243102c2",
"assets/assets/default_decks/presence/nl/gay/nl_06_presence_gay_deck_super_hard_no_tools.json": "5b69ff712d3875f4f5036052a104a887",
"assets/assets/default_decks/presence/nl/gay/nl_03_presence_gay_deck_medium_with_tools.json": "89ad410fd781c60f2f4ffe692bc83cf5",
"assets/assets/default_decks/presence/nl/gay/nl_07_presence_gay_deck_super_hard_with_tools.json": "7646201d68f6eb1f7a7489172ede52d9",
"assets/assets/default_decks/presence/nl/gay/nl_01_presence_gay_deck_easy_no_tools.json": "ded2b88d2b1f9bc6cdd0c65a6965adcc",
"assets/assets/default_decks/presence/nl/gay/nl_04_presence_gay_deck_hard_no_tools.json": "ed0ab95efa22739490959989ce392608",
"assets/assets/default_decks/presence/nl/gay/nl_02_presence_gay_deck_medium_no_tools.json": "30ef85fd0c3ff6e0f139cc2df22aa512",
"assets/assets/default_decks/presence/fr/hetero/fr_05_presence_hetero_deck_hard_with_tools.json": "6752cf4a04baef9282fb3289251f2c15",
"assets/assets/default_decks/presence/fr/hetero/fr_06_presence_hetero_deck_super_hard_no_tools.json": "543197c360eb05096dc9599cd2c55ba8",
"assets/assets/default_decks/presence/fr/hetero/fr_07_presence_hetero_deck_super_hard_with_tools.json": "8d0b2664e20b2c98ca4af4b7a9728f9c",
"assets/assets/default_decks/presence/fr/hetero/fr_04_presence_hetero_deck_hard_no_tools.json": "f0b1373221e7ba0affe31ae9da4c2bf4",
"assets/assets/default_decks/presence/fr/hetero/fr_01_presence_hetero_deck_easy_no_tools.json": "19829b22171dca45e34994d60756e236",
"assets/assets/default_decks/presence/fr/hetero/fr_02_presence_hetero_deck_medium_no_tools.json": "a97af382e8614035407389331fe88426",
"assets/assets/default_decks/presence/fr/hetero/fr_03_presence_hetero_deck_medium_with_tools.json": "0b29e7102bdb024bb9b948e0379387bd",
"assets/assets/default_decks/presence/fr/lesbian/fr_04_presence_lesbian_deck_hard_no_tools.json": "1cb3d797b3d7e8abe9cd002baa5bdb93",
"assets/assets/default_decks/presence/fr/lesbian/fr_05_presence_lesbian_deck_hard_with_tools.json": "77622e9ce96f2bd1b73b864208264fbb",
"assets/assets/default_decks/presence/fr/lesbian/fr_01_presence_lesbian_deck_easy_no_tools.json": "6c99f7f9e84c3adba4b8e296a576c0dd",
"assets/assets/default_decks/presence/fr/lesbian/fr_02_presence_lesbian_deck_medium_no_tools.json": "9654a71f48a92e832c39a1c6460edf45",
"assets/assets/default_decks/presence/fr/lesbian/fr_07_presence_lesbian_deck_super_hard_with_tools.json": "eee3d8e0477a8d55c1d8e11ffe46ca7a",
"assets/assets/default_decks/presence/fr/lesbian/fr_03_presence_lesbian_deck_medium_with_tools.json": "870dcb74cc56e25f37cd4e0303709e1f",
"assets/assets/default_decks/presence/fr/lesbian/fr_06_presence_lesbian_deck_super_hard_no_tools.json": "86733462dab5ba61d61f156e45ee1f18",
"assets/assets/default_decks/presence/fr/gay/fr_01_presence_gay_deck_easy_no_tools.json": "e41062de2e65b39fd08f115224af4f05",
"assets/assets/default_decks/presence/fr/gay/fr_02_presence_gay_deck_medium_no_tools.json": "fbfb4f4374a5d1aad868988bdbce64e7",
"assets/assets/default_decks/presence/fr/gay/fr_05_presence_gay_deck_hard_with_tools.json": "3d92d987ede37291edd31e164b127ad4",
"assets/assets/default_decks/presence/fr/gay/fr_03_presence_gay_deck_medium_with_tools.json": "b464455efa9977bda7581e612ee0c479",
"assets/assets/default_decks/presence/fr/gay/fr_04_presence_gay_deck_hard_no_tools.json": "aa9a9b53a254c2f12f77db142c847a9f",
"assets/assets/default_decks/presence/fr/gay/fr_07_presence_gay_deck_super_hard_with_tools.json": "bf75b7f40eefffbbf386766c100e7994",
"assets/assets/default_decks/presence/fr/gay/fr_06_presence_gay_deck_super_hard_no_tools.json": "aa5ade7cac23f19d4e240a5ae98e6136",
"assets/assets/default_decks/presence/it/hetero/it_05_presence_hetero_deck_hard_with_tools.json": "a619b1d3495f166514fb764ab9cc71d7",
"assets/assets/default_decks/presence/it/hetero/it_01_presence_hetero_deck_easy_no_tools.json": "0711cfcc2bab781440ca04b4c1bc988c",
"assets/assets/default_decks/presence/it/hetero/it_06_presence_hetero_deck_super_hard_no_tools.json": "c64a0670a2846c0c02838f4e7590ac94",
"assets/assets/default_decks/presence/it/hetero/it_02_presence_hetero_deck_medium_no_tools.json": "057e5f0c87e2f7495ab069a230584b47",
"assets/assets/default_decks/presence/it/hetero/it_03_presence_hetero_deck_medium_with_tools.json": "82adf9d842ffad9c5e2288b313e69046",
"assets/assets/default_decks/presence/it/hetero/it_07_presence_hetero_deck_super_hard_with_tools.json": "36c8447c22bb0824a1e2cada70a6e1b5",
"assets/assets/default_decks/presence/it/hetero/it_04_presence_hetero_deck_hard_no_tools.json": "d20c0398d47c5880a7bcfa7008f4c646",
"assets/assets/default_decks/presence/it/lesbian/it_05_presence_lesbian_deck_hard_with_tools.json": "f25ed2a6007b9a1f8a49b46b68ec4e88",
"assets/assets/default_decks/presence/it/lesbian/it_01_presence_lesbian_deck_easy_no_tools.json": "5175d2f8b71373b8a542a6955a76cf92",
"assets/assets/default_decks/presence/it/lesbian/it_07_presence_lesbian_deck_super_hard_with_tools.json": "aeba054cb691658a135e2b27963d5054",
"assets/assets/default_decks/presence/it/lesbian/it_06_presence_lesbian_deck_super_hard_no_tools.json": "9db68bd47d6b5daa43431a5e19f58e3b",
"assets/assets/default_decks/presence/it/lesbian/it_03_presence_lesbian_deck_medium_with_tools.json": "e4f77bcf96eeaf5b3578aab1b85aea1c",
"assets/assets/default_decks/presence/it/lesbian/it_02_presence_lesbian_deck_medium_no_tools.json": "7a988814d6090c8c02a382b34d789d87",
"assets/assets/default_decks/presence/it/lesbian/it_04_presence_lesbian_deck_hard_no_tools.json": "4b1f7a8947bf724b8d3a1786f328c48a",
"assets/assets/default_decks/presence/it/gay/it_06_presence_gay_deck_super_hard_no_tools.json": "cbd8c089fbc3a1b8973df5c1a0bf988a",
"assets/assets/default_decks/presence/it/gay/it_01_presence_gay_deck_easy_no_tools.json": "4eb3f8ed396dc5d4a55d32c02344e8b0",
"assets/assets/default_decks/presence/it/gay/it_03_presence_gay_deck_medium_with_tools.json": "53a56c54c4d8b15b6e66a25fa10bc197",
"assets/assets/default_decks/presence/it/gay/it_02_presence_gay_deck_medium_no_tools.json": "3977fdf2657f9593477c796be6f27d10",
"assets/assets/default_decks/presence/it/gay/it_05_presence_gay_deck_hard_with_tools.json": "d5e4b51d235adcd39ae4a6de40a7bd3b",
"assets/assets/default_decks/presence/it/gay/it_07_presence_gay_deck_super_hard_with_tools.json": "d4d3f3c6599fc679392ab2b38286d391",
"assets/assets/default_decks/presence/it/gay/it_04_presence_gay_deck_hard_no_tools.json": "37396e3a8db70c6c0d5445e8f0d91744",
"assets/assets/default_decks/presence/en/hetero/en_06_presence_hetero_deck_super_hard_no_tools.json": "12f9421218b2f8390b423e8ec6fb5ece",
"assets/assets/default_decks/presence/en/hetero/en_04_presence_hetero_deck_hard_no_tools.json": "27f62c75fb344473b8b40325c253ea00",
"assets/assets/default_decks/presence/en/hetero/en_05_presence_hetero_deck_hard_with_tools.json": "37badb00df5f9bac1af7894955b8481b",
"assets/assets/default_decks/presence/en/hetero/en_01_presence_hetero_deck_easy_no_tools.json": "c28099b156c71040990a1385891050d5",
"assets/assets/default_decks/presence/en/hetero/en_07_presence_hetero_deck_super_hard_with_tools.json": "ef83d56f588c7a9f1dace243d024d37e",
"assets/assets/default_decks/presence/en/hetero/en_02_presence_hetero_deck_medium_no_tools.json": "c431c358d41f8919cc925186eabe3af7",
"assets/assets/default_decks/presence/en/hetero/en_03_presence_hetero_deck_medium_with_tools.json": "8e2566decd659c0931d7243bfeee2587",
"assets/assets/default_decks/presence/en/lesbian/en_03_presence_lesbian_deck_medium_with_tools.json": "35e97bb35430d98a8ca3bf8764c002a4",
"assets/assets/default_decks/presence/en/lesbian/en_06_presence_lesbian_deck_super_hard_no_tools.json": "750b8fc4ea5473a16187e89065602771",
"assets/assets/default_decks/presence/en/lesbian/en_02_presence_lesbian_deck_medium_no_tools.json": "72c5d5490f6636f249b04560259dd045",
"assets/assets/default_decks/presence/en/lesbian/en_04_presence_lesbian_deck_hard_no_tools.json": "16cd38b32d5c04a431245a8718adbc22",
"assets/assets/default_decks/presence/en/lesbian/en_01_presence_lesbian_deck_easy_no_tools.json": "35dd02d69feea232955c0bb3f79715e6",
"assets/assets/default_decks/presence/en/lesbian/en_05_presence_lesbian_deck_hard_with_tools.json": "58d1750359042210d3db3fd238838c1c",
"assets/assets/default_decks/presence/en/lesbian/en_07_presence_lesbian_deck_super_hard_with_tools.json": "ec9511b19cd34408f14722e1b6af0e22",
"assets/assets/default_decks/presence/en/gay/en_02_presence_gay_deck_medium_no_tools.json": "00c08a96d9934830ec2a332ac2a12643",
"assets/assets/default_decks/presence/en/gay/en_07_presence_gay_deck_super_hard_with_tools.json": "0b86252e42123384969e7683eaa69cef",
"assets/assets/default_decks/presence/en/gay/en_03_presence_gay_deck_medium_with_tools.json": "211070d8b5e752996f8be7e030eeedc2",
"assets/assets/default_decks/presence/en/gay/en_05_presence_gay_deck_hard_with_tools.json": "6f99ec6330bb8bbb80f948bc1ffc78c4",
"assets/assets/default_decks/presence/en/gay/en_04_presence_gay_deck_hard_no_tools.json": "e2a6121807fd51cc2b6852ad0504ea72",
"assets/assets/default_decks/presence/en/gay/en_06_presence_gay_deck_super_hard_no_tools.json": "bf8a29a22c5cda55fe2ec52a9eddc002",
"assets/assets/default_decks/presence/en/gay/en_01_presence_gay_deck_easy_no_tools.json": "116cef1bd8fb6bb94e9023ec2dcfc493",
"assets/assets/default_decks/distance/zh/hetero/zh_04_online_hetero_deck_super_hard_no_tools.json": "8ac0fbb966397e7c381f1ec62a667ca2",
"assets/assets/default_decks/distance/zh/hetero/zh_03_online_hetero_deck_hard_no_tools.json": "0f1afabf06fd418f68d66243a04d9591",
"assets/assets/default_decks/distance/zh/hetero/zh_01_online_hetero_deck_easy_no_tools.json": "8928264c9d995944080a93cdc4597aea",
"assets/assets/default_decks/distance/zh/hetero/zh_02_online_hetero_deck_medium_no_tools.json": "28d86c1b5e1a37c730f40398232517a1",
"assets/assets/default_decks/distance/zh/lesbian/zh_02_online_lesbian_deck_medium_no_tools.json": "947e255302024fd5d2bd1d12c532e19e",
"assets/assets/default_decks/distance/zh/lesbian/zh_03_online_lesbian_deck_hard_no_tools.json": "9b5b2c1c8d41bfc83023fad0ac4de731",
"assets/assets/default_decks/distance/zh/lesbian/zh_01_online_lesbian_deck_easy_no_tools.json": "4a4dc2d20ac98516d06d38caa6e94f21",
"assets/assets/default_decks/distance/zh/lesbian/zh_04_online_lesbian_deck_super_hard_no_tools.json": "4287940a4ee03de2cff542cd28f74f9c",
"assets/assets/default_decks/distance/zh/gay/zh_04_online_gay_deck_super_hard_no_tools.json": "4b8957b2f6265e125f0a68d6429bc973",
"assets/assets/default_decks/distance/zh/gay/zh_02_online_gay_deck_medium_no_tools.json": "84f5d927bf8ee5a72f09f0ddd76abc15",
"assets/assets/default_decks/distance/zh/gay/zh_03_online_gay_deck_hard_no_tools.json": "b655e723598adf426cfba4ce5acfa1c8",
"assets/assets/default_decks/distance/zh/gay/zh_01_online_gay_deck_easy_no_tools.json": "00f21539d036ccc81c17266549325889",
"assets/assets/default_decks/distance/de/hetero/de_04_online_hetero_deck_super_hard_no_tools.json": "e123f044faec50c85add76fae51cc30e",
"assets/assets/default_decks/distance/de/hetero/de_01_online_hetero_deck_easy_no_tools.json": "b1b47512b6ec2c171302114c381dea27",
"assets/assets/default_decks/distance/de/hetero/de_03_online_hetero_deck_hard_no_tools.json": "af7046b6a3abe0403c128848bab2cd5d",
"assets/assets/default_decks/distance/de/hetero/de_02_online_hetero_deck_medium_no_tools.json": "057e0d5581392c531cbd14d494d8cada",
"assets/assets/default_decks/distance/de/lesbian/de_03_online_lesbian_deck_hard_no_tools.json": "8965b034292b86ad8ce7ce9e0c51c046",
"assets/assets/default_decks/distance/de/lesbian/de_02_online_lesbian_deck_medium_no_tools.json": "b877232172c29309c5fb96a259509f1a",
"assets/assets/default_decks/distance/de/lesbian/de_04_online_lesbian_deck_super_hard_no_tools.json": "c99f9b94e87a301fef50e913df14cee3",
"assets/assets/default_decks/distance/de/lesbian/de_01_online_lesbian_deck_easy_no_tools.json": "b16929b44aa6b9ba82a8b56f7fc03865",
"assets/assets/default_decks/distance/de/gay/de_03_online_gay_deck_hard_no_tools.json": "add4f71c8dc526ae0ef88d7965574299",
"assets/assets/default_decks/distance/de/gay/de_02_online_gay_deck_medium_no_tools.json": "eda3ad378a2d1c880098827e6c811109",
"assets/assets/default_decks/distance/de/gay/de_04_online_gay_deck_super_hard_no_tools.json": "d6c68c886fb905e2ccbda97a9928463a",
"assets/assets/default_decks/distance/de/gay/de_01_online_gay_deck_easy_no_tools.json": "569787623dd30e07ac4f80ee475a842c",
"assets/assets/default_decks/distance/es/hetero/es_01_online_hetero_deck_easy_no_tools.json": "4a4c34f4e5c76fae80be70a96318b7c5",
"assets/assets/default_decks/distance/es/hetero/es_03_online_hetero_deck_hard_no_tools.json": "3d07dd107a7ea097b537f2490f158ba8",
"assets/assets/default_decks/distance/es/hetero/es_02_online_hetero_deck_medium_no_tools.json": "6033f75c096268dbbd52a0e27ab8011f",
"assets/assets/default_decks/distance/es/hetero/es_04_online_hetero_deck_super_hard_no_tools.json": "0a3cbee6867158daeea1324126cb2d2e",
"assets/assets/default_decks/distance/es/lesbian/es_01_online_lesbian_deck_easy_no_tools.json": "c5c492b7b5e9ca8df52eafdd8b999d17",
"assets/assets/default_decks/distance/es/lesbian/es_03_online_lesbian_deck_hard_no_tools.json": "b820a9606623c9c7d60e9f32e307cc63",
"assets/assets/default_decks/distance/es/lesbian/es_04_online_lesbian_deck_super_hard_no_tools.json": "9605984c9acca11274e624828934c96a",
"assets/assets/default_decks/distance/es/lesbian/es_02_online_lesbian_deck_medium_no_tools.json": "64ee399f1fbd91a3b68ee5edb86065d0",
"assets/assets/default_decks/distance/es/gay/es_03_online_gay_deck_hard_no_tools.json": "c8872604810a8a970e1bdadeb1757c4e",
"assets/assets/default_decks/distance/es/gay/es_02_online_gay_deck_medium_no_tools.json": "c262644f04dc30beaa05e03606929696",
"assets/assets/default_decks/distance/es/gay/es_01_online_gay_deck_easy_no_tools.json": "aa2a5c2c52a09818c0dd1f074eeb45fc",
"assets/assets/default_decks/distance/es/gay/es_04_online_gay_deck_super_hard_no_tools.json": "f5f2f4ada5fbb0fa9c2128df65c38d0f",
"assets/assets/default_decks/distance/nl/hetero/nl_04_online_hetero_deck_super_hard_no_tools.json": "b5c4e05f2f0eacefed9b5acd357c3a86",
"assets/assets/default_decks/distance/nl/hetero/nl_03_online_hetero_deck_hard_no_tools.json": "73876b47ac3b66919df85cb6b318ab68",
"assets/assets/default_decks/distance/nl/hetero/nl_02_online_hetero_deck_medium_no_tools.json": "2fc194f7c2ce162e9983f2b9ef8515e4",
"assets/assets/default_decks/distance/nl/hetero/nl_01_online_hetero_deck_easy_no_tools.json": "bfcee345e13fdb38c932ae2a5591c10e",
"assets/assets/default_decks/distance/nl/lesbian/nl_04_online_lesbian_deck_super_hard_no_tools.json": "9ea90bc86efb107ef8c5b4712968f7c9",
"assets/assets/default_decks/distance/nl/lesbian/nl_01_online_lesbian_deck_easy_no_tools.json": "7bdf4eabf1951a854b7ec88069f8c2ea",
"assets/assets/default_decks/distance/nl/lesbian/nl_02_online_lesbian_deck_medium_no_tools.json": "f1ea6a4fc5ad27b99287b0547103ec5c",
"assets/assets/default_decks/distance/nl/lesbian/nl_03_online_lesbian_deck_hard_no_tools.json": "ff706cc7b233a840c011b3a75ede36e7",
"assets/assets/default_decks/distance/nl/gay/nl_01_online_gay_deck_easy_no_tools.json": "f7f4a5daca3ae2bf57e3022a6701725b",
"assets/assets/default_decks/distance/nl/gay/nl_02_online_gay_deck_medium_no_tools.json": "61d77a2408fc5a42b3cd0a593efa39f7",
"assets/assets/default_decks/distance/nl/gay/nl_03_online_gay_deck_hard_no_tools.json": "7b8c74e14d823a6e51cd635893b58edb",
"assets/assets/default_decks/distance/nl/gay/nl_04_online_gay_deck_super_hard_no_tools.json": "ef01811a557ea0689943d89bdf8feca3",
"assets/assets/default_decks/distance/fr/hetero/fr_01_online_hetero_deck_easy_no_tools.json": "02c0b6e1b9c0ad1160bca9bb5d3cc8e8",
"assets/assets/default_decks/distance/fr/hetero/fr_02_online_hetero_deck_medium_no_tools.json": "0e280f817fd2f8168eefa87735f51df9",
"assets/assets/default_decks/distance/fr/hetero/fr_03_online_hetero_deck_hard_no_tools.json": "9d34f99fa233b843473f9b8459e74894",
"assets/assets/default_decks/distance/fr/hetero/fr_04_online_hetero_deck_super_hard_no_tools.json": "3a6e387e957056097b0659bc3c661249",
"assets/assets/default_decks/distance/fr/lesbian/fr_03_online_lesbian_deck_hard_no_tools.json": "54d0ee5fc0d91799007f532db8e61cb2",
"assets/assets/default_decks/distance/fr/lesbian/fr_02_online_lesbian_deck_medium_no_tools.json": "a22dd59b62ce880fe04df62fed4758d8",
"assets/assets/default_decks/distance/fr/lesbian/fr_01_online_lesbian_deck_easy_no_tools.json": "34c475c181e3638467e29f7c7f10f244",
"assets/assets/default_decks/distance/fr/lesbian/fr_04_online_lesbian_deck_super_hard_no_tools.json": "d4c5e2fac61dcca684b5d7192760a1b8",
"assets/assets/default_decks/distance/fr/gay/fr_01_online_gay_deck_easy_no_tools.json": "ebcce28dceb6ff3dc9d0f1dfb84cfeb7",
"assets/assets/default_decks/distance/fr/gay/fr_02_online_gay_deck_medium_no_tools.json": "bee4d8479d874f4710f37d8c1c725e80",
"assets/assets/default_decks/distance/fr/gay/fr_03_online_gay_deck_hard_no_tools.json": "bb2a36ff01d53b6afaea0aacce4a6a22",
"assets/assets/default_decks/distance/fr/gay/fr_04_online_gay_deck_super_hard_no_tools.json": "82da74ecdefcb017cb366c420e939f5a",
"assets/assets/default_decks/distance/it/hetero/it_03_online_hetero_deck_hard_no_tools.json": "015d5df1715afd98cd1353051d3a3125",
"assets/assets/default_decks/distance/it/hetero/it_02_online_hetero_deck_medium_no_tools.json": "edf5f70029694230fd2a9d611e4dddfe",
"assets/assets/default_decks/distance/it/hetero/it_01_online_hetero_deck_easy_no_tools.json": "61ecca954266751c150703d63c924768",
"assets/assets/default_decks/distance/it/hetero/it_04_online_hetero_deck_super_hard_no_tools.json": "cfbf826ae01c2c5b87d3330fa9b7ce9f",
"assets/assets/default_decks/distance/it/lesbian/it_01_online_lesbian_deck_easy_no_tools.json": "3fefe3e92ad80bfdde955109d82efc6c",
"assets/assets/default_decks/distance/it/lesbian/it_03_online_lesbian_deck_hard_no_tools.json": "5436c655de4002b1f7347a1594d80ebd",
"assets/assets/default_decks/distance/it/lesbian/it_04_online_lesbian_deck_super_hard_no_tools.json": "351f271995d38c1143c87d72c48cd640",
"assets/assets/default_decks/distance/it/lesbian/it_02_online_lesbian_deck_medium_no_tools.json": "77eb6d7fa30062902cf1e0ed02503be5",
"assets/assets/default_decks/distance/it/gay/it_04_online_gay_deck_super_hard_no_tools.json": "126bfbc18c258fee3b86573e8e7d1767",
"assets/assets/default_decks/distance/it/gay/it_03_online_gay_deck_hard_no_tools.json": "73324701be6872bb9d159e4e3f45c36f",
"assets/assets/default_decks/distance/it/gay/it_01_online_gay_deck_easy_no_tools.json": "93a2888ffca55136624ca55bb4b88b46",
"assets/assets/default_decks/distance/it/gay/it_02_online_gay_deck_medium_no_tools.json": "618248bb279d1c7911c7972a6777d15a",
"assets/assets/default_decks/distance/en/hetero/en_01_online_hetero_deck_easy_no_tools.json": "6a6c4a70c1281ac4b8840321b1b64ffc",
"assets/assets/default_decks/distance/en/hetero/en_02_online_hetero_deck_medium_no_tools.json": "ff914ede0b932c127ebd7481143200f2",
"assets/assets/default_decks/distance/en/hetero/en_04_online_hetero_deck_super_hard_no_tools.json": "bddbc031a5ca19130a9ff52b461dccc8",
"assets/assets/default_decks/distance/en/hetero/en_03_online_hetero_deck_hard_no_tools.json": "a03a22de3e30b710b8d42a2025f97bdc",
"assets/assets/default_decks/distance/en/lesbian/en_01_online_lesbian_deck_easy_no_tools.json": "8a247085803c309303f4b3aa2f7bb71a",
"assets/assets/default_decks/distance/en/lesbian/en_04_online_lesbian_deck_super_hard_no_tools.json": "94a3429a07dce708f4c236a652a30d89",
"assets/assets/default_decks/distance/en/lesbian/en_02_online_lesbian_deck_medium_no_tools.json": "c69f2686583fd327d0e202c24b5f93d9",
"assets/assets/default_decks/distance/en/lesbian/en_03_online_lesbian_deck_hard_no_tools.json": "abf012009221bc4a7abbe821cb72122c",
"assets/assets/default_decks/distance/en/gay/en_02_online_gay_deck_medium_no_tools.json": "cf1567d729a087ca257efcd1c43ef8d7",
"assets/assets/default_decks/distance/en/gay/en_01_online_gay_deck_easy_no_tools.json": "b0bffd984ed17d6dc627a2b2649870b8",
"assets/assets/default_decks/distance/en/gay/en_03_online_gay_deck_hard_no_tools.json": "1fb5197cd8cd75e88f9fceb03efceddd",
"assets/assets/default_decks/distance/en/gay/en_04_online_gay_deck_super_hard_no_tools.json": "48c74c3a97bb684406c8c7b6d9c60fae",
"assets/FontManifest.json": "5986b9d23b728b62e8392e1e328d91e0",
"assets/AssetManifest.bin.json": "7e677d2d0798a4362fad1b87db321b9c",
"assets/AssetManifest.bin": "f103ea92bede2b280ebcf5c4cefe0440",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"flutter_bootstrap.js": "c0ecbd5f7cad3076f5dcc227ef30005e",
"pwa_icons/Icon-192.png": "bb3e57563b94ad7d1b8d88de7724c0f3",
"pwa_icons/Icon-maskable-512.png": "66ba1254a595a04d7e1dcaf334ac0ebc",
"pwa_icons/Icon-maskable-192.png": "bb3e57563b94ad7d1b8d88de7724c0f3",
"pwa_icons/Icon-512.png": "66ba1254a595a04d7e1dcaf334ac0ebc",
"favicon.png": "2f5a657934d294f765537fbf11717337",
"index.html": "2673db22ca629f17142aae7bf445ac50",
"/": "2673db22ca629f17142aae7bf445ac50"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
