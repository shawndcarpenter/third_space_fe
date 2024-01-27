require "rails_helper"

RSpec.describe PasswordMailer, type: :mailer do
  # describe '#reset' do
  #   let(:user) { create(:user, email: 'user@example.com') } # Ensure your user setup is correct
  #   let(:sendgrid_client_mock) { instance_double(SendGrid::API) }
  #   let(:sendgrid_response_mock) { double('Response', status_code: 202, body: 'email sent', headers: {}) }

  #   before do
  #     allow(SendGrid::API).to receive(:new).and_return(sendgrid_client_mock)
  #     allow(sendgrid_client_mock).to receive_message_chain(:client, :mail, :_, :post).and_return(sendgrid_response_mock)

  #     # Simulate params being available as they would be in a controller action
  #     allow_any_instance_of(ActionMailer::Parameterized::Mailer).to receive(:params).and_return(user: user)
  #   end

  #   it 'sends a password reset email with SendGrid' do
  #     PasswordMailer.with(user: user).reset.deliver_now

  #     expect(SendGrid::API).to have_received(:new).with(api_key: Rails.application.credentials.dig(:sendgrid, :key))
  #     expect(sendgrid_client_mock).to have_received(:client).with(anything)
  #   end
  # end


# These no longer work with sendgrid
#   describe "reset" do
#     let(:user) do
#       User.create(
#         first_name: "Testing",
#         last_name: "Dude",
#         email: "to@example.org",
#         password: "password123",
#         password_confirmation: "password123"
#       )
#     end

#     let(:mail) { PasswordMailer.with(user: user).reset }

#     it "renders the headers" do
#       expect(mail.subject).to eq("Reset Your Password")
#       expect(mail.to).to eq(["to@example.org"])
#       expect(mail.from).to eq(["thirdspace2308@gmail.com"])
#     end

#     it "renders the body" do
#       expect(mail.body.encoded).to match("Hi")
#     end
#   end


end
