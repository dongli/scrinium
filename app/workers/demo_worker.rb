class DemoWorker
  include Sidekiq::Worker

  def perform(name, count)

    p name
  end
end

## how to use
# rails c andDemoWorker.perform_async("good", 0)