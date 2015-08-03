# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(full_name: '董理',
            gender: '男',
            position: '',
            email: 'dongli@lasg.iap.ac.cn',
            password: '12345678',
            password_confirmation: '12345678')

User.create(full_name: '张三',
            gender: '男',
            position: '',
            email: 'zhangsan@lasg.iap.ac.cn',
            password: '12345678',
            password_confirmation: '12345678')

ResearchRecord.create(user_id: 1,
                      title: '云滴谱的数值求解',
                      content: '\\\\[ \\frac{\\partial n}{\\partial t} = - \\frac{\\partial}{\\partial r} \\frac{d r}{d t} n \\\\]',
                      tag_draft: false)

Organization.create(name: '中国科学院大气物理研究所LASG实验室',
                    short_name: 'CAS-IAP-LASG',
                    description: '中国科学院大气物理研究所大气科学和地球流体力学数值模拟国家重点实验室（英文缩写LASG）成立于1985年，同年9月正式对外开放，1989年晋升为国家重点实验室。在前三任主任曾庆存院士、吴国雄院士、王斌研究员的领导下，LASG成为蜚声国内外的大气科学和地球流体力学研究机构，并在1988、1992、1996、2000、2005、2010年的国家评估中，连续六次获得优秀（其中2005年为免评获优），是地学领域两个获此殊荣的实验室之一。LASG于1990年被国家计委和中科院授予先进集体称号，1994年获国家计委金牛奖，2004年获科技部“国家重点实验室计划先进集体”（金牛奖），2011年获科技部“十一五”国家科技计划执行优秀团队奖。李崇银院士为现任学术委员会主任，陆日宇为实验室主任。',
                    locale: 'zh-CN')

ResearchTeam.create(name: '地球系统模式研究组',
                    short_name: '模式组',
                    organization_id: 1,
                    description: '该研究组主要围绕由LASG自主研发的气候系统模式FGOALS展开工作。')

CoupledModel.create(name: 'Flexible Global Ocean-Atmosphere-Land System',
                    short_name: 'FGOALS',
                    description: '',
                    organization_id: 1)

AtmosphereModel.create(coupled_model_id: 1,
                       name: "Grid-point Atmosphere Model IAP/LASG",
                       short_name: "GAMIL",
                       affiliation: "",
                       license: -1,
                       references: "",
                       description: "GAMIL是由LASG王斌课题组研发的格点大气环流模式。",
                       simulation_region: 0,
                       simulation_type: 0,
                       is_hydrostatic: 1,
                       is_shallow: 1,
                       horizontal_mesh: 0,
                       vertical_coordinate: 0,
                       vertical_mesh: -1,
                       dynamical_core: "Explicit Quadratic Conservation Finite Difference Dynamical Core",
                       advection_scheme: "TSPAS")

OceanModel.create(coupled_model_id: 1,
                  name: "LASG/IAP Climate system Ocean Model",
                  short_name: "LICOM",
                  affiliation: "",
                  license: -1,
                  references: "",
                  description: "",
                  simulation_region: 0,
                  simulation_type: 0,
                  horizontal_mesh: 1,
                  vertical_coordinate: 0,
                  vertical_mesh: -1,
                  dynamical_core: "",
                  advection_scheme: "")
