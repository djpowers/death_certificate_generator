require 'sinatra'
require 'prawn'

class DeathCertificateGenerator < Sinatra::Base
  configure :development do
    require 'pry'
  end

  get '/' do
    erb :index
  end

  post '/certificate' do
    content_type 'application/pdf'

    pdf = Prawn::Document.new
    pdf.text "Name of Deceased: #{params[:certificate][:name]}"
    pdf.text "Place of Death: #{params[:certificate][:place_of_death]}"
    pdf.text "Sex: #{params[:certificate][:sex]}"
    pdf.text "Color or Race: #{params[:certificate][:race]}"
    pdf.text "Marital Status: #{params[:certificate][:marital_stats]}"
    pdf.text "Date of Birth: #{params[:certificate][:date_of_birth]}"
    pdf.text "Occupation: #{params[:certificate][:occupation]}"
    pdf.text "Birthplace: #{params[:certificate][:birthplace]}"
    pdf.text "Date of Death: #{params[:certificate][:date_of_death]}"
    pdf.text "Place of Burial: #{params[:certificate][:place_of_burial]}"
    pdf.text "Undertaker: #{params[:certificate][:undertaker]}"
    pdf.render
  end
end
