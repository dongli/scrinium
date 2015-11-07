###主要是Livereload + guard。
##使用方法
1.下载chrome浏览器的
[Livereload](http://feedback.livereload.com/knowledgebase/articles/86242-how-do-i-install-and-use-the-browser-extensions)，点击他会提示服务未连接

2.在Gemfile里面加上
```ruby
  #自动刷新浏览器，
  group :development do
   gem 'guard-livereload'
   gem 'rack-livereload'
 end
```
3.然后 `bundle install`，接着执行 `guard init`，会发现项目目录下多了一个 `Guardfile` 文件，内容如下
```ruby
# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)/assets/\w+/(.+\.(css|js|html)).*})  { |m| "/assets/#{m[2]}" }
end
```
这是 guard-livereload 默认的监控规则，它监控了 Rails 项目里面所有影响页面显示的文件，当这些文件有更改时就会通知浏览器刷新。

4.接下来在 `config/environments/development.rb` 还要添加一处配置，让 Rails 服务启动以后给每个页面加上浏览器端的 livereload 扩展。
非必须
```ruby
config.middleware.insert_before(Rack::Lock, Rack::LiveReload)
```
5.如果有启动的app，先关掉。然后在app目录先启动一个 guard 监控进程,不要关闭他
```ruby
guard start
```
6.然后启动app
```ruby
 rails s
```
7. 先点击浏览器拓展 Livereload，是否能连接上服务器，变成黑色小圆点。

8.试试是不是成功，先修改目录下的文件，看浏览器是不是自动刷新，如果不能，查看浏览器上的livereload扩展的图标是不是黑色的(表示已经连接服务器)
