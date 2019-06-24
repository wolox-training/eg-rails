require 'rails_helper'

RSpec.describe ExpiredRentWorker do
  context 'perform' do
    let(:rent) { create(:rent_with_user_and_book) }

    before do
      Sidekiq::Queue.new.clear

      ExpiredRentWorker.any_instance.stub(:rent_ids).and_return([rent.id])
    end

    it 'job is created' do
      ExpiredRentWorker.perform_async
      expect(Sidekiq::Queue.new.size).to eq(1)
    end

    it 'set a mailer on queue' do
      ActiveJob::Base.queue_adapter = :test
      expect { ExpiredRentWorker.new.perform }
        .to have_enqueued_job.on_queue('mailers')
    end
  end
end
