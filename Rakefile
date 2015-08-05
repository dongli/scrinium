# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

# Copied from 'https://gist.github.com/oivoodoo/5089237'.
namespace :grape do
  desc "Grape API Routes"
  task :routes => :environment do
    mapped_prefix = '' # where mounted API in routes.rb
    params_str = ' params:'
    desc_limit = 45
    route_info = API.routes.map {|r| [r, r.instance_variable_get(:@options)] }
    max_desc_size     = route_info.map{|_,info| (info[:description] || '')[0..desc_limit].size }.max
    max_method_size   = route_info.map{|_,info| info[:method].size }.max
    max_version_size  = route_info.map{|_,info| info[:version].size }.max
    max_path_size     = route_info.map{|_,info| info[:path].sub(':version', info[:version]).size }.max
    max_params_digits = route_info.map{|_,info| info[:params].size.to_s.size }.max
    format_str = format(
      '%%%ds  %%%ds %%%ds %%%ds%%-%ds | %%%ds%%%ds  %%s',
      max_desc_size + 1,
      max_version_size,
      max_method_size,
      mapped_prefix.size,
      max_path_size,
      max_params_digits,
      params_str.size)

    route_info.each do |_,info|
      fields = [
        info[:description] ? info[:description][0..desc_limit] : '',
        info[:version],
        info[:method],
        mapped_prefix,
        info[:path].sub(':version', info[:version]),
        info[:params].size.to_s,
        params_str,
        info[:params].first.inspect,
      ]
      puts format(format_str, *fields)

      info[:params].drop(1).each do |param|
        puts format(format_str, *([''] * (fields.size-1)) + [param.inspect])
      end
    end
  end
end
