require 'spec_helper'

describe Chatitude::UserRepo do

  def User_count
    repo.all(db).count
  end

  let(:repo) { Chatitude::UserRepo }
  let(:db) { Chatitude.create_db_connection('chatitude_test') }

  before(:each) do
    Chatitude.clear_db(db)
    @User1 = Chatitude::UserRepo.save(db, { 'username' => "Giovanni", 'password' => 'Swordfish' })['id']
    @User2 = Chatitude::UserRepo.save(db, { 'username' => "Leonardo", 'password' => 'Swordfish' })['id']
  end

  it "gets all Users" do

    Users = repo.all(db)
    expect(Users).to be_a Array
    expect(Users.count).to eq 2

    usernames = Users.map {|u| u['username'] }
    expect(usernames).to include "Leonardo", "Giovanni"
  end

  xit "creates Users" do
    expect(User_count).to eq 2

    User = repo.save(db, { 'username' => "Brian", 'password' => 'puppyfan102' })
    expect(User['id']).to_not be_nil
    expect(User['username']).to eq "Brian"
    expect(User['password']).to eq "puppyfan102"

    # Check for persistence
    expect(User_count).to eq 3

    User = repo.all(db).first
    expect(User['id']).to_not be_nil
    expect(User['username']).to eq "Giovanni"
    expect(User['password']).to eq "Swordfish"

  end

  xit "checks API Token" do
    User = repo.save(db, { 'username' => "Brian", 'password' => 'puppyfan102' })
    expect(User['id']).to_not be_nil
    expect(User['apiToken']).to_not be_nil

    # expect(User['apiToken']).to_eq # Decrypt Bcrypt Password
  end

  xit "requires a username" do
    expect { repo.save(db, {}) }.to raise_error {|e|
      expect(e.message).to match /username/
    }
  end

  xit "requires an User id that exists" do
    expect {
      repo.save(db, { 'id' => 999, 'username' => "Mr FunGuy" })
    }
    .to raise_error {|e|
      expect(e.message).to match /User id/
    }
  end

  xit "finds Users" do
    retrieved_User = repo.find(db, @User1)
    expect(retrieved_User['username']).to eq "Giovanni"
  end

  xit "updates Users" do
    User1 = repo.save(db, { 'id' => @User1, 'username' => "Billy Boy" })
    User2 = repo.save(db, { 'id' => @User2, 'password' => "bigDogsRCool14" })
    User3 = repo.save(db, { 'id' => @User2, 'apiToken' => "1239847jglkj85jg" })
    expect(User2['id']).to eq(User1['id'])
    expect(User2['password']).to eq "bigDogsRCool14"
    expect(User3['apiToken']).to_not eq "1239847jglkj85jg"

    # Check for persistence
    User4 = repo.find(db, User1['id'])
    expect(User4['username']).to eq "Billy Boy"
  end

end
