## how to use
# rails c and DemoWorker.perform_async("good", 0)

class DemoWorker
  include Sidekiq::Worker

  def perform(name, count)
    p name
  end
end
