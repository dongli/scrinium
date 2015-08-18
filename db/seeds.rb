# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: '董理',
            avatar: open('/Users/dongli/Dropbox/Docs/Materials/me.jpg'),
            gender: 1,
            email: 'dongli@lasg.iap.ac.cn',
            password: '12345678',
            password_confirmation: '12345678')

Article.create(user_id: 1,
                      title: '云滴谱的数值求解',
                      content: '\\\\[ \\frac{\\partial n}{\\partial t} = - \\frac{\\partial}{\\partial r} \\frac{d r}{d t} n \\\\]',
                      draft: false,
                      privacy: 0)

Organization.create(name: '中国科学院大气物理研究所',
                    short_name: 'CAS-IAP',
                    description: '',
                    locale: 'zh-CN')

Organization.create(name: '大气科学和地球流体力学数值模拟国家重点实验室',
                    short_name: 'LASG',
                    description: '中国科学院大气物理研究所大气科学和地球流体力学数值模拟国家重点实验室（英文缩写LASG）成立于1985年，同年9月正式对外开放，1989年晋升为国家重点实验室。在前三任主任曾庆存院士、吴国雄院士、王斌研究员的领导下，LASG成为蜚声国内外的大气科学和地球流体力学研究机构，并在1988、1992、1996、2000、2005、2010年的国家评估中，连续六次获得优秀（其中2005年为免评获优），是地学领域两个获此殊荣的实验室之一。LASG于1990年被国家计委和中科院授予先进集体称号，1994年获国家计委金牛奖，2004年获科技部“国家重点实验室计划先进集体”（金牛奖），2011年获科技部“十一五”国家科技计划执行优秀群组奖。李崇银院士为现任学术委员会主任，陆日宇为实验室主任。',
                    locale: 'zh-CN')

Organizationship.create(organization_id: 1,
                        suborganization_id: 2)

Organization.create(name: '暂无所属科研单位',
                    short_name: 'void')
