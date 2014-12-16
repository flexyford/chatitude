require 'spec_helper'

describe Chatitude::MessageRepo do

  def message_count
    repo.all(db).count
  end

  let(:repo) { Chatitude::MessageRepo }
  let(:db) { Chatitude.create_db_connection('chatitude_test') }

  before(:each) do
    Chatitude.clear_db(db)
    @userId = Chatitude::ShopRepo.save(db, { 'message' => "SuperShop" })['id']
  end

  it "gets all messages" do
    message = repo.save(db, {'message' => "Hello World",    'userId' => @userId })
    message = repo.save(db, {'message' => "Hello There",    'userId' => @userId })
    message = repo.save(db, {'message' => "Goodbye People", 'userId' => @userId })
    message = repo.save(db, {'message' => "Say Whaaaa?",    'userId' => @userId })

    expect(message['id']).to_not be_nil

    messages = repo.all(db)
    expect(messages).to be_a Array
    expect(messages.count).to eq 4

    messages = messages.map {|m| m['message'] }
    expect(messages).to include "Hello World", "Hello There", "Goodbye People", "Say Whaaaa?"
  end

  it "creates messages" do
    expect(message_count).to eq 0

    message = repo.save(db, {'message' => "Barnaby", 'userId' => @userId, 'imageurl' => 'dummy', 'adopted' => 'false' })
    expect(message['id']).to_not be_nil
    expect(message['userId']).to_not be_nil
    expect(message['message']).to eq "Barnaby"

    # Check for persistence
    expect(message_count).to eq 1

    message_count_by_store = repo.find_all_by_shop(db, @userId).count
    expect(message_count_by_store).to eq 1

    message = repo.all(db).first
    expect(message['id']).to_not be_nil
    expect(message['userId']).to_not be_nil
    expect(message['message']).to eq "Barnaby"

  end

  it "requires a message" do
    expect { repo.save(db, {}) }.to raise_error {|e|
      expect(e.message).to match /message/
    }
  end

  it "requires an shop id" do
    expect {
      repo.save(db, { 'message' => "Barnaby" })
    }
    .to raise_error {|e|
      expect(e.message).to match /userId/
    }
  end

  it "requires an imageurl" do
    expect {
      repo.save(db, { 'message' => "Barnaby", 'userId' => @userId })
    }
    .to raise_error {|e|
      expect(e.message).to match /imageurl/
    }
  end

  it "finds messages" do
    message = repo.save(db, {'message' => "Barnaby", 'userId' => @userId, 'imageurl' => 'dummy', 'adopted' => 'false' })
    retrieved_message = repo.find(db, message['id'])
    expect(retrieved_message['message']).to eq "Barnaby"
  end

  it "updates messages" do
    message = repo.save(db, {'message' => "Barnaby", 'userId' => @userId, 'imageurl' => 'dummy', 'adopted' => 'false' })
    message2 = repo.save(db, { 'id' => message['id'], 'message' => "Funky" })
    expect(message2['id']).to eq(message['id'])
    expect(message2['message']).to eq "Funky"

    # Check for persistence
    message3 = repo.find(db, message['id'])
    expect(message3['message']).to eq "Funky"
  end

end
