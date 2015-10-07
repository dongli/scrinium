Reference.create(
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
  avatar: open('/Users/dongli/Dropbox/Docs/Materials/me.jpg'),
  gender: 'male',
  role: 'admin',
  email: 'dongli@lasg.iap.ac.cn',
  password: '12345678',
  password_confirmation: '12345678'
)

Article.create(
  user_id: 1,
  title: '云滴谱的数值求解',
  content: '\\\\[ \\frac{\\partial n}{\\partial t} = - \\frac{\\partial}{\\partial r} \\frac{d r}{d t} n \\\\]',
  draft: false,
  privacy: 0
)

User.create(
  name: '张三',
  avatar: open('/Users/dongli/Dropbox/Docs/Materials/张三.png'),
  gender: 'female',
  role: 'user',
  email: 'zhangsan@lasg.iap.ac.cn',
  password: '12345678',
  password_confirmation: '12345678'
)
