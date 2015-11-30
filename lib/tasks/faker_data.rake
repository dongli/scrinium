require 'ffaker'

#https://github.com/ffaker/ffaker/blob/master/REFERENCE.md
# rake faker_data:clean 清除指定model数据
# rake faker_data:small 生成指定model 50 数据
# 批量产生假数据
class Fakeout

  # 所有用到的models

  MODELS = %w(User Group Organization Profile Membership Article)
  BUIDL_METHODS = %w(user group organization membership article)

  attr_accessor :size
  def initialize(size, prompt=true)
    self.size = size
  end

  def fakeout
    ActiveRecord::Base.transaction do
      puts "init users"
      init_specify_users

      puts "Faking it ... (#{size})"
      Fakeout.disable_mailers

      BUIDL_METHODS.each do |model|
        puts "model #{model}"
        1.upto(send(size)) do
          send("build_#{model.downcase}")
        end
      end
      MODELS.each do |model|
        puts "  * #{model.pluralize}: #{model.constantize.count(:all)}"
      end
      puts "Done, I Faked it!"
    end
  end


  def init_specify_users
    User.create(
      name: '田鲁',
      role: 'admin',
      email: 'tianlu1677@gmail.com',
      password: '12345678',
      password_confirmation: '12345678',
      confirmed_at: DateTime.now,
      profile_attributes: {
          avatar:     FFaker::Avatar.image,
          gender:     'male',
          title:      'freeman',
          city:       FFaker::Address.city,
          country:    FFaker::Address.city,
          qq:         '32132323232',
          weibo:      FFaker::Internet.http_url,
          wechat:     FFaker::Internet.user_name
      }
    )
    User.create(
        name: '董理',
        role: 'admin',
        email: 'dongli@lasg.iap.ac.cn',
        password: '12345678',
        password_confirmation: '12345678',
        confirmed_at: DateTime.now,
        profile_attributes: {
            avatar:     FFaker::Avatar.image,
            gender:     'male',
            title:      'associate_researcher',
            city:       FFaker::Address.city,
            country:    FFaker::Address.city,
            qq:         '32132323232',
            weibo:      FFaker::Internet.http_url,
            wechat:     FFaker::Internet.user_name
        }
    )


  end

  def build_user
    User.create!(
        name: "#{FFaker::Internet.user_name}",
        email: FFaker::Internet.email,
        password: '123456',
        password_confirmation:  '123456',
        confirmed_at:           DateTime.now,
        profile_attributes: {
          avatar:     FFaker::Avatar.image,
          gender:     'male',
          title:      'freeman',
          city:       FFaker::Address.city,
          country:    FFaker::Address.city,
          qq:         '32132323232',
          weibo:      FFaker::Internet.http_url,
          wechat:     FFaker::Internet.user_name
        }
    )
  end

  def build_group
    Group.create!(
      name: "#{FFaker::LoremCN.word}小组",
      logo: FFaker::Avatar.image,
      short_name: FFaker::Lorem.word,
      description: (rand(2) == 0 ? FFaker::Lorem.paragraphs : FFaker::LoremCN.paragraphs),
      admin_id: pick_random(User, true),
      locale: 'zh-CN',
      privacy: :public
    )
  end

  def build_organization
    Organization.create!(
        name:       "#{FFaker::LoremCN.word}-#{SecureRandom.base64}机构",
        logo:       FFaker::Avatar.image,
        short_name:  "#{FFaker::Lorem.word}-#{SecureRandom.base64}",
        description: (rand(2) == 0 ? FFaker::Lorem.paragraphs : FFaker::LoremCN.paragraphs),
        admin_id: pick_random(User, true),
        parent_id: 1,
        locale: 'zh-CN'
    )

  end

  def build_membership
    if rand(2) == 0
      host_type = "Group"
      host_id = pick_random(Group, true)
    else
      host_type = "Organization"
      host_id = pick_random(Organization, true)
    end

    Membership.create!(
      host_type: host_type,
      host_id:   host_id,
      user_id: pick_random(User, true),
      role: 'member',
      expired_at: 'never',
      status: 'approved',
      description: '请求加入',
      last_user_id: pick_random(User, true),
      joined_at: DateTime.now
    )

  end

  def build_article
    Article.create!(
      user_id: pick_random(User, true),
      title: FFaker::LoremCN.paragraph,
      content: FFaker::HTMLIpsum.body,
      privacy: 'public'
    )
  end

  def small
    50
  end

  def medium
    200
  end

  def large
    1000
  end



  private

  def pick_random(model, optional = false)
    return nil if false
    ids = ActiveRecord::Base.connection.select_all("SELECT id FROM #{model.to_s.tableize}")
    ids[rand(ids.length)]["id"].to_i unless ids.blank?
  end

  def self.disable_mailers
    ActionMailer::Base.perform_deliveries = false
  end

  def self.clean(prompt = true)
    self.prompt if prompt
    puts "Cleaning all data..."
    Fakeout.disable_mailers
    MODELS.each do |model|
      model.constantize.delete_all
      puts "delete #{model}"
    end
    puts "Done. delete all #{MODELS}"
  end

  def self.prompt
    puts "Really? This will clean all #{MODELS.map(&:pluralize).join(', ')} from your  database y/n? "
    STDOUT.flush
    (STDIN.gets =~ /^y|^Y/) ? true : exit(0)
  end

  def random_tag_list(tags, max_tags = 5, seperator = ',')
    start = rand(tags.length)
    return '' if start < 1
    tags[start..(start+rand(max_tags))].join(seperator)
  end

  def random_letters(length = 2)
    Array.new(length) { (rand(122-97) + 97).chr }.join
  end
end

namespace :faker_data do

  desc "clean away all data"
  task :clean, [:no_prompt] => :environment do |t, args|
    Fakeout.clean(args.no_prompt.nil?)
  end

  desc "fake out a small dataset(50)"
  task small: :environment  do
    Fakeout.new(:small).fakeout
  end

  desc "fake out a medium dataset(200)"
  task medium: :environment  do
    Fakeout.new(:medium).fakeout
  end

  desc "fake out a large dataset(100)"
  task large: :environment  do
    Fakeout.new(:large).fakeout
  end
end