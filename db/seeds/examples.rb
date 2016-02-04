Reference.create(
  creator_id: 1,
  cite_key: 'Dong:2012ab',
  title: 'Trajectory-tracking scheme in Lagrangian form for solving linear advection problems: preliminary tests',
  authors: ['Li Dong', 'Bin Wang'],
  reference_type: 'article',
  publisher_id: 1,
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
  slug: 'dongli',
  password: '12345678',
  password_confirmation: '12345678',
)

Profile.create(
  user_id: 1,
  gender: 'male',
  title: 'associate_researcher'
)

User.create(
  name: '田鲁',
  role: 'admin',
  email: 'tianlu1677@gmail.com',
  slug: 'tianlu',
  password: '12345678',
  password_confirmation: '12345678',
)

Profile.create(
  user_id: 2,
  gender: 'male',
  title: 'freeman'
)

Article.create(
  user_id: 1,
  title: '云滴谱的数值求解',
  content: '\\[ \\frac{\\partial n}{\\partial t} = - \\frac{\\partial}{\\partial r} \\frac{d r}{d t} n \\]',
  status: 'public'
)

User.create(
  name: '张三',
  role: 'user',
  email: 'zhangsan@lasg.iap.ac.cn',
  slug: 'zhangsan',
  password: '12345678',
  password_confirmation: '12345678',
)

Profile.create(
  user_id: 3,
  gender: 'male',
  title: 'associate_researcher'
)

Group.create(
  name: '测试群组',
  short_name: '测试群组',
  slug: 'test_group',
  admin_id: 1,
  status: 'public'
)

Membership.create(
  host_type: 'Group',
  host_id: 1,
  user_id: 1,
  role: 'admin',
  status: 'approved',
  expired_at: 'never'
)
