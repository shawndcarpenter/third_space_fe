require "rails_helper"

RSpec.describe PasswordMailer, type: :mailer do

  describe "reset" do
    let(:user) do
      User.create(
        first_name: "Testing",
        last_name: "Dude",
        email: "to@example.org",
        password: "password123",
        password_confirmation: "password123"
      )
    end

    let(:mail) { PasswordMailer.with(user: user).reset }

    it "renders the headers" do
      expect(mail.subject).to eq("Reset Your Password")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["thirdspace2308@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
