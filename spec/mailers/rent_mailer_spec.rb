require 'rails_helper'

describe RentMailer do
  include ActiveJob::TestHelper

  let(:rent) { create(:rent_with_user_and_book) }

  it 'job is created' do
    ActiveJob::Base.queue_adapter = :test
    expect { RentMailer.new_rent(rent: rent).deliver_later }
      .to have_enqueued_job.on_queue('mailers')
  end

  it 'new_rent is sent' do
    expect { perform_enqueued_jobs { RentMailer.new_rent(rent: rent).deliver_later } }
      .to change { ActionMailer::Base.deliveries.size }.by(1)
  end

  it 'new_rent is csent to the right user' do
    perform_enqueued_jobs do
      RentMailer.new_rent(rent: rent).deliver_later
    end

    mail = ActionMailer::Base.deliveries.last
    expect(mail.to[0]).to eq rent.user.email
  end
end
