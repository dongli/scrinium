Reference.create(
  creator_id: 1,
  cite_key: 'Dong:2012ab',
  title: 'Trajectory-tracking scheme in Lagrangian form for solving linear advection problems: preliminary tests',
  authors: ['Li Dong', 'Bin Wang'],
  reference_type: 'article',
  publicable_type: 'Journal',
  publicable_id: 1,
  doi: '10.1175/MWR-D-10-05026.1',
  year: '2012',
  volume: '140',
  pages: '650-663',
  abstract: 'A Lagrangian linear advection scheme, which is called the trajectory-tracking scheme, is proposed in this paper. The continuous tracer field has been discretized as finite tracer parcels that are points moving with the velocity field. By using the inverse distance weighted interpolation, the density carried by parcels is mapped onto the fixed Eulerian mesh (e.g., regular latitude–longitude mesh on the sphere) where the result is rendered. A renormalization technique has been adopted to accomplish mass conservation on the grids. The major advantage of this scheme is the ability to preserve discontinuity very well. Several standard tests have been carried out, including 1D and 2D Cartesian cases, and 2D spherical cases. The results show that the spurious numerical diffusion has been eliminated, which is a potential merit for the atmospheric modeling.'
)

User.create(
  name: '董理',
  role: 'admin',
  email: 'dongli@lasg.iap.ac.cn',
  password: '12345678',
  password_confirmation: '12345678'
)

Organization.create(name: '中国科学院大气物理研究所',
                    logo: open("#{Rails.root}/app/assets/images/logos/iap_logo.png"),
                    short_name: 'CAS-IAP',
                    description: '',
                    admin_id: 1,
                    locale: 'zh-CN')

Organization.create(name: '大气科学和地球流体力学数值模拟国家重点实验室',
                    logo: open("#{Rails.root}/app/assets/images/logos/lasg_logo.png"),
                    short_name: 'LASG',
                    description: '中国科学院大气物理研究所大气科学和地球流体力学数值模拟国家重点实验室（英文缩写LASG）成立于1985年，同年9月正式对外开放，1989年晋升为国家重点实验室。在前三任主任曾庆存院士、吴国雄院士、王斌研究员的领导下，LASG成为蜚声国内外的大气科学和地球流体力学研究机构，并在1988、1992、1996、2000、2005、2010年的国家评估中，连续六次获得优秀（其中2005年为免评获优），是地学领域两个获此殊荣的实验室之一。LASG于1990年被国家计委和中科院授予先进集体称号，1994年获国家计委金牛奖，2004年获科技部“国家重点实验室计划先进集体”（金牛奖），2011年获科技部“十一五”国家科技计划执行优秀群组奖。李崇银院士为现任学术委员会主任，陆日宇为实验室主任。',
                    admin_id: 1,
                    parent_id: 1,
                    locale: 'zh-CN')

Membership.create(
  host_type: 'Organization',
  host_id: 1,
  user_id: 1,
  role: 'admin',
  status: 'approved',
  expired_at: 'never'
)

Membership.create(
  host_type: 'Organization',
  host_id: 2,
  user_id: 1,
  role: 'admin',
  status: 'approved',
  expired_at: 'never'
)

Article.create(
  user_id: 1,
  title: '云滴谱的数值求解',
  content: '\\[ \\frac{\\partial n}{\\partial t} = - \\frac{\\partial}{\\partial r} \\frac{d r}{d t} n \\]',
  privacy: 'public'
)

User.create(
  name: '张三',
  role: 'user',
  email: 'zhangsan@lasg.iap.ac.cn',
  password: '12345678',
  password_confirmation: '12345678'
)
